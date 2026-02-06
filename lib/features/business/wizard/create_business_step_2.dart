import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/category_selection_widget.dart';

class CreateBusinessStep2 extends StatefulWidget {
  final String? initialCategory;
  final Function(String)? onCategorySelected;

  const CreateBusinessStep2({
    super.key,
    this.initialCategory,
    this.onCategorySelected,
  });

  @override
  State<CreateBusinessStep2> createState() => _CreateBusinessStep2State();
}

class _CreateBusinessStep2State extends State<CreateBusinessStep2> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  void _handleCategorySelected(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
    widget.onCategorySelected?.call(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categoría del Negocio',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: CategorySelectionWidget(
        selectedCategoryId: _selectedCategory,
        onCategorySelected: _handleCategorySelected,
      ),
      bottomNavigationBar: _selectedCategory != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to next step or save
                    Navigator.pop(context, _selectedCategory);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F87C9),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Continuar',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
