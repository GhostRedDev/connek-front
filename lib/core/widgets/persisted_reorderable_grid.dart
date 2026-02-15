import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistedReorderableGrid extends StatefulWidget {
  const PersistedReorderableGrid({
    super.key,
    required this.prefsKey,
    required this.defaultOrder,
    required this.crossAxisCount,
    required this.itemBuilder,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
    this.childAspectRatio = 1.0,
    this.padding,
  });

  final String prefsKey;
  final List<String> defaultOrder;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext context, String id) itemBuilder;

  @override
  State<PersistedReorderableGrid> createState() =>
      _PersistedReorderableGridState();
}

class _PersistedReorderableGridState extends State<PersistedReorderableGrid> {
  late List<String> _order;

  @override
  void initState() {
    super.initState();
    _order = List<String>.from(widget.defaultOrder);
    _load();
  }

  @override
  void didUpdateWidget(covariant PersistedReorderableGrid oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.prefsKey != widget.prefsKey ||
        oldWidget.defaultOrder != widget.defaultOrder) {
      _order = List<String>.from(widget.defaultOrder);
      _load();
      return;
    }

    // If the default list changed (new cards added), append missing ids.
    final missing = widget.defaultOrder.where((id) => !_order.contains(id));
    if (missing.isNotEmpty) {
      setState(() {
        _order.addAll(missing);
      });
      _save();
    }
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList(widget.prefsKey);
      if (!mounted) return;

      if (saved == null || saved.isEmpty) {
        return;
      }

      // Keep only known ids, and keep new defaults appended.
      final known = saved.where(widget.defaultOrder.contains).toList();
      final appended = widget.defaultOrder.where((id) => !known.contains(id));

      setState(() {
        _order = [...known, ...appended];
      });
    } catch (_) {
      // Ignore persistence failures.
    }
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(widget.prefsKey, _order);
    } catch (_) {
      // Ignore persistence failures.
    }
  }

  void _moveItem({required String fromId, required String toId}) {
    final fromIndex = _order.indexOf(fromId);
    final toIndex = _order.indexOf(toId);
    if (fromIndex == -1 || toIndex == -1 || fromIndex == toIndex) {
      return;
    }

    setState(() {
      _order.removeAt(fromIndex);
      _order.insert(toIndex, fromId);
    });
    _save();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: widget.crossAxisSpacing,
        mainAxisSpacing: widget.mainAxisSpacing,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemCount: _order.length,
      itemBuilder: (context, index) {
        final id = _order[index];
        final child = widget.itemBuilder(context, id);

        return LayoutBuilder(
          builder: (context, constraints) {
            final feedback = Material(
              type: MaterialType.transparency,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
                child: Opacity(opacity: 0.95, child: child),
              ),
            );

            return DragTarget<String>(
              onWillAccept: (fromId) => fromId != null && fromId != id,
              onAccept: (fromId) => _moveItem(fromId: fromId, toId: id),
              builder: (context, candidates, _) {
                final isReceiving = candidates.isNotEmpty;

                final decoratedChild = Container(
                  foregroundDecoration: isReceiving
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        )
                      : null,
                  child: child,
                );

                return LongPressDraggable<String>(
                  data: id,
                  feedback: feedback,
                  childWhenDragging: Opacity(opacity: 0.45, child: child),
                  child: decoratedChild,
                );
              },
            );
          },
        );
      },
    );
  }
}
