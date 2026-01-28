import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/providers/locale_provider.dart';

class ClientDashboardSupport extends ConsumerWidget {
  const ClientDashboardSupport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 120,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              t['client_support_title'] ?? 'Soporte y Ayuda',
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t['client_support_subtitle'] ?? '¿Como podemos ayudarte hoy?',
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // Quick Actions Grid
            Text(
              t['client_support_quick_actions'] ?? 'Acciones Rápidas',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _SupportActionCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'Chat de Soporte',
                  color: const Color(0xFF4285F4),
                  isDark: isDark,
                  onTap: () {
                    // Navigate to chat or show dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Iniciando chat de soporte...'),
                      ),
                    );
                  },
                ),
                _SupportActionCard(
                  icon: Icons.phone_outlined,
                  title: 'Llámanos',
                  color: const Color(0xFF34A853),
                  isDark: isDark,
                  onTap: () async {
                    final Uri launchUri = Uri(
                      scheme: 'tel',
                      path: '+1234567890',
                    );
                    if (await canLaunchUrl(launchUri)) {
                      await launchUrl(launchUri);
                    }
                  },
                ),
                _SupportActionCard(
                  icon: Icons.email_outlined,
                  title: 'Correo',
                  color: const Color(0xFFEA4335),
                  isDark: isDark,
                  onTap: () async {
                    final Uri launchUri = Uri(
                      scheme: 'mailto',
                      path: 'support@connek.com',
                      query: 'subject=Consulta de Soporte',
                    );
                    if (await canLaunchUrl(launchUri)) {
                      await launchUrl(launchUri);
                    }
                  },
                ),
                _SupportActionCard(
                  icon: Icons.report_problem_outlined,
                  title: 'Reportar Problema',
                  color: const Color(0xFFFBBC05),
                  isDark: isDark,
                  onTap: () {
                    // Show report dialog similar to reviews
                    _showReportDialog(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 32),

            // FAQ Section
            Text(
              t['client_support_faq'] ?? 'Preguntas Frecuentes',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _FAQTile(
                    question: '¿Cómo solicito un reembolso?',
                    answer:
                        'Puedes solicitar un reembolso desde la sección de historial de pedidos seleccionando la orden específica y haciendo clic en "Solicitar Reembolso".',
                    isDark: isDark,
                  ),
                  const Divider(height: 1),
                  _FAQTile(
                    question: '¿Cuáles son los métodos de pago aceptados?',
                    answer:
                        'Aceptamos tarjetas de crédito/débito, transferencias bancarias y pagos en efectivo a través de nuestros socios.',
                    isDark: isDark,
                  ),
                  const Divider(height: 1),
                  _FAQTile(
                    question: '¿Como cambio mi contraseña?',
                    answer:
                        'Ve a tu perfil > Configuración > Seguridad para actualizar tu contraseña.',
                    isDark: isDark,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Legal Links
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Términos de Servicio',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Text('|', style: TextStyle(color: Colors.grey[600])),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Política de Privacidad',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80), // Bottom padding
          ],
        ),
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reportar un Problema'),
        content: const TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Describe el problema que estás experimentando...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reporte enviado. Gracias.')),
              );
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}

class _SupportActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _SupportActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _FAQTile extends StatelessWidget {
  final String question;
  final String answer;
  final bool isDark;

  const _FAQTile({
    required this.question,
    required this.answer,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Text(
            answer,
            style: GoogleFonts.inter(
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
