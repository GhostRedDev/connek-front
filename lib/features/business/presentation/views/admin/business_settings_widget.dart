import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessSettingsWidget extends StatefulWidget {
  const BusinessSettingsWidget({super.key});

  @override
  State<BusinessSettingsWidget> createState() => _BusinessSettingsWidgetState();
}

class _BusinessSettingsWidgetState extends State<BusinessSettingsWidget> {
  bool _directDeposits = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // UI Colors based on image/theme
    final cardColor = isDark
        ? const Color(0xFF1E1E1E)
        : const Color(0xFFF5F5F7);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Ajustes',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Realiza cambios internos de tu empresa.',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 30),

          // Section: Finanzas
          Text(
            'Finanzas',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.account_balance,
                  title: 'Cuenta bancaria',
                  subtitle: 'Maneja donde recibir tus depósitos',
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 60, endIndent: 20),
                _buildMenuItem(
                  context,
                  icon: Icons.cached,
                  title: 'Depositos directos',
                  subtitle: 'Recibe pagos de forma automática',
                  isSwitch: true,
                  switchValue: _directDeposits,
                  onChanged: (val) {
                    setState(() {
                      _directDeposits = val;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Section: Verificación de empresa
          Text(
            'Verificación de empresa',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.assignment,
                  title: 'Identidad',
                  subtitle: 'No verificado',
                  trailingWidget: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4285F4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      minimumSize: const Size(0, 32),
                    ),
                    child: Text(
                      'Verificar',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1, indent: 60, endIndent: 20),
                _buildMenuItem(
                  context,
                  icon: Icons.description,
                  title: 'Información fiscal',
                  subtitle: 'Actualizar informacion de la empresa',
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Delete Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFF5252)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Eliminar empresa',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFF5252),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    bool isSwitch = false,
    bool switchValue = false,
    ValueChanged<bool>? onChanged,
    Widget? trailingWidget,
  }) {
    // Custom Icon Style
    final iconWidget = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4285F4), Color(0xFF3B78E7)], // Blue gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4285F4).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isSwitch
            ? null
            : onTap, // Switch handles its own tap usually, but mainly row tap is fine if not switch
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              iconWidget,
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (isSwitch)
                Switch.adaptive(
                  value: switchValue,
                  onChanged: onChanged,
                  activeColor: const Color(0xFF4285F4),
                )
              else if (trailingWidget != null)
                trailingWidget
              else
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
