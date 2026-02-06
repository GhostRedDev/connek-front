import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:connek_frontend/features/business/presentation/sheets/business_service_sheet.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BusinessServicesGrid extends StatelessWidget {
  final List<dynamic> services;
  final bool isDesktop;

  const BusinessServicesGrid({
    super.key,
    required this.services,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Icon(Icons.spa_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              AppText.h4('No hay servicios'),
              AppText.p(
                'Añade servicios para que aparezcan aquí.',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _ServiceCard(service: service);
      },
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final image = service['image'] as String?;
    final name = service['name'] ?? 'Servicio';
    final price = service['price']?.toString() ?? '0';
    final duration = service['duration']?.toString() ?? '60 min';

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BusinessServiceSheet(serviceToEdit: service),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.colorScheme.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  image: image != null
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(image),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: image == null
                    ? Icon(
                        Icons.spa,
                        color: theme.colorScheme.mutedForeground,
                        size: 40,
                      )
                    : null,
              ),
            ),
            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: theme.colorScheme.mutedForeground,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              duration,
                              style: TextStyle(
                                color: theme.colorScheme.mutedForeground,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '\$$price',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
