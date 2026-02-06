import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/business_provider.dart';
import '../../../../../core/providers/locale_provider.dart';
import 'business_employee_sheet.dart';
import '../services/business_resource_sheet.dart';

class BusinessEmployeesWidget extends ConsumerStatefulWidget {
  const BusinessEmployeesWidget({super.key});

  @override
  ConsumerState<BusinessEmployeesWidget> createState() =>
      _BusinessEmployeesWidgetState();
}

class _BusinessEmployeesWidgetState
    extends ConsumerState<BusinessEmployeesWidget> {
  String _copilotFilter = 'Todos';

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final businessData = ref.watch(businessProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);

    // Mock/Real Data separation
    final allEmployees = businessData.maybeWhen(
      data: (data) => data.employees,
      orElse: () => <Map<String, dynamic>>[],
    );

    // Separate Copilots (Bots) and Staff (Humans)
    final copilots = allEmployees.where((e) => e['type'] != 'human').toList();
    final staff = allEmployees.where((e) => e['type'] == 'human').toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              t['business_employees_title'] ?? 'Empleados',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              t['business_employees_subtitle'] ??
                  'Ve y maneja a los empleados de tu negocio.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),

            // 1. Copilotos Section
            _buildSectionHeader(
              context,
              t['business_employees_copilots'] ?? 'Copilotos',
              showFilter: true,
            ),
            const SizedBox(height: 16),
            if (copilots.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    t['business_employees_empty_copilots'] ??
                        'No hay copilotos activos',
                  ),
                ),
              )
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: copilots.map((bot) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: _buildCopilotCard(
                        context,
                        name: bot['name'] ?? 'Greg',
                        role: bot['role'] ?? 'Finanzas',
                        image:
                            bot['image'] ??
                            'assets/images/GREG_CARD_1.png', // Fallback to asset if remote null
                        isActive: bot['status'] == 'Activo',
                        id: bot['id'], // Pass ID if needed for navigation
                      ),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 24),

            // 2. Promo Card
            _buildPromoCard(context, t),
            const SizedBox(height: 24),

            // 3. Staff Section
            _buildSectionHeader(
              context,
              t['business_employees_staff'] ?? 'Staff',
              onAdd: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const BusinessEmployeeSheet(),
                );
              },
            ),
            const SizedBox(height: 12),
            if (staff.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  t['business_employees_coming_soon'] ??
                      'Próximamente', // Placeholder for Staff
                  style: GoogleFonts.inter(color: Colors.grey),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: staff.length,
                itemBuilder: (context, index) {
                  final e = staff[index];
                  return _buildStaffCard(
                    context,
                    name: e['name'] ?? 'Staff',
                    role: e['role'] ?? 'Empleado',
                    image:
                        e['image'] ??
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80',
                    isActive: e['status'] == 'Activo',
                    id: e['id'], // Pass ID
                  );
                },
              ),
            const SizedBox(height: 24),

            // 4. Resources Section
            _buildSectionHeader(
              context,
              t['business_employees_resources'] ?? 'Recursos',
              onAdd: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const BusinessResourceSheet(),
                );
              },
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: ref
                  .read(businessRepositoryProvider)
                  .getResources(
                    businessData.maybeWhen(
                      data: (data) => data.businessProfile?['id'] ?? 0,
                      orElse: () => 0,
                    ),
                  ),
              builder: (context, snapshot) {
                final resources = snapshot.data ?? [];

                if (resources.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        t['business_employees_empty_resources'] ??
                            'No hay recursos registrados',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: resources.length,
                  itemBuilder: (context, index) {
                    final r = resources[index];
                    return _buildResourceCard(
                      context,
                      name: r['name'] ?? 'Recurso',
                      image:
                          r['profile_image'] ??
                          'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80',
                      type: r['resource_type'] ?? 'Sala',
                      isActive: r['active'] ?? true,
                      id: r['id'],
                      resource: r,
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    bool showFilter = false,
    VoidCallback? onAdd,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            if (onAdd != null)
              InkWell(
                onTap: onAdd,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Icon(Icons.add, size: 16, color: Colors.grey[600]),
                ),
              ),
          ],
        ),
        if (showFilter) ...[
          const SizedBox(height: 12),
          const SizedBox(height: 12),
          // We need t here, but it's not passed.
          // Option 1: Pass t to _buildSectionHeader.
          // Option 2: Get ref again? No, not widget.
          // Let's modify _buildSectionHeader to accept 't' or use ConsumerWidget logic?
          // Easier: Pass t.
          // CHECK: I didn't pass t in the call sites above. This will probably break or I need to handle it.
          // Wait, I can't easily change the signature in this tool call without changing call sites in the same tool call if I change specific lines.
          // I will use `ref.watch` inside if I convert to widget or just pass it.
          // Actually, this method is inside State<ConsumerStatefulWidget>, so I can access `ref`.
          // Ah, I can just use `ref.read(translationProvider).value` or access `t` if I define it locally.
          // Accessing `ref` is possible.
          Consumer(
            builder: (context, ref, child) {
              final t = ref.watch(translationProvider).value ?? {};
              return Row(
                children: [
                  _buildFilterChip(t['business_filter_all'] ?? 'Todos'),
                  const SizedBox(width: 8),
                  _buildFilterChip(t['business_filter_active'] ?? 'Activos'),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    t['business_filter_inactive'] ?? 'Inactivos',
                  ),
                ],
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _copilotFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _copilotFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4285F4) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildCopilotCard(
    BuildContext context, {
    required String name,
    required String role,
    required String image,
    required bool isActive,
    dynamic id,
  }) {
    ImageProvider imageProvider;
    if (image.startsWith('http')) {
      imageProvider = CachedNetworkImageProvider(image);
    } else {
      imageProvider = AssetImage(image) as ImageProvider;
    }

    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(0.9),
                ],
                stops: const [0.4, 0.9],
              ),
            ),
          ),

          // Top Labels
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF23262F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.money_off,
                    color: Colors.amber,
                    size: 10,
                  ), // Mock icon
                  const SizedBox(width: 4),
                  Text(
                    role,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF00C853), // Green for Active
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Activo',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Bottom Content
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Entrenar',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.settings_outlined,
                        size: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffCard(
    BuildContext context, {
    required String name,
    required String role,
    required String image,
    required bool isActive,
    dynamic id,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Staff',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C853),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Activo',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          role, // e.g., Plomero
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context, {
    required String name,
    required String image,
    required String type,
    required bool isActive,
    required int id,
    required Map<String, dynamic> resource,
  }) {
    // 1. Resolve ImageProvider
    ImageProvider imageProvider;
    if (image.startsWith('http')) {
      imageProvider = CachedNetworkImageProvider(image);
    } else {
      imageProvider = AssetImage(image) as ImageProvider;
    }

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => BusinessResourceSheet(resourceToEdit: resource),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            // Gradient
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),

            // Label
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Recurso',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Content using Stack for overlay button
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCard(BuildContext context, Map<String, dynamic> t) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFF0F2650), // Dark blue
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1557804506-669a67965ba0?auto=format&fit=crop&q=80',
          ), // Abstract/Tech bg
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      // To match the exact design with the phone mockup, we would need a custom asset.
      // Using a text-based approximation for now.
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['business_promo_title'] ?? '¡Expandimos tu\nexperiencia!',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 200,
                  child: Text(
                    t['business_promo_subtitle'] ??
                        'Ahora puedes controlar a tus bots con mas opciones en la oficina Connek.',
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Office
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4285F4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 0,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    t['business_promo_button'] ?? 'Ir a tu oficina',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          // Phone mockup placeholder (would be an image asset ideally)
        ],
      ),
    );
  }
}
