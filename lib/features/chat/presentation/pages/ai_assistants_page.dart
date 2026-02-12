import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../models/ai_assistant_model.dart';
import '../../services/ai_assistants_service.dart';

class AIAssistantsPage extends StatelessWidget {
  const AIAssistantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final allAIs = AIAssistantsService.getAllAIAssistants();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF131619) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E2329) : Colors.white,
        elevation: 0,
        title: Text(
          'Asistentes IA',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allAIs.length,
        itemBuilder: (context, index) {
          final ai = allAIs[index];
          return _buildAICard(context, ai, isDark);
        },
      ),
    );
  }

  Widget _buildAICard(BuildContext context, AIAssistantModel ai, bool isDark) {
    final isComingSoon = ai.metadata?['status'] == 'coming_soon';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(ai.primaryColor).withOpacity(isComingSoon ? 0.3 : 0.8),
            Color(
              ai.metadata?['color_secondary'] ?? ai.primaryColor,
            ).withOpacity(isComingSoon ? 0.2 : 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(ai.primaryColor).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isComingSoon
              ? null
              : () {
                  if (ai.type == 'greg') {
                    context.push('/greg-chat');
                  } else if (ai.type == 'marketing') {
                    context.push('/marketing-chat');
                  } else {
                    _showAIDetails(context, ai, isDark);
                  }
                },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with avatar and status
                Row(
                  children: [
                    // Avatar
                    _buildAvatar(ai, isComingSoon),
                    const SizedBox(width: 16),
                    // Name and subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  ai.name,
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (isComingSoon)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Próximamente',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ai.metadata?['subtitle'] ?? ai.description,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Description
                Text(
                  ai.description,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.95),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                // Capabilities
                Text(
                  'Capacidades:',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ai.capabilities.take(4).map((capability) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        capability,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (ai.capabilities.length > 4) ...[
                  const SizedBox(height: 8),
                  Text(
                    '+${ai.capabilities.length - 4} más',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                // Model info
                if (ai.metadata?['model'] != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        size: 16,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Modelo: ${ai.metadata!['model']}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(AIAssistantModel ai, bool isComingSoon) {
    if (ai.image != null) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            ai.image!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildIconAvatar(ai, isComingSoon);
            },
          ),
        ),
      );
    }
    return _buildIconAvatar(ai, isComingSoon);
  }

  Widget _buildIconAvatar(AIAssistantModel ai, bool isComingSoon) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(isComingSoon ? 0.1 : 0.2),
      ),
      child: Icon(_getIconData(ai.iconName), color: Colors.white, size: 32),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'smart_toy':
        return Icons.smart_toy;
      case 'visibility':
        return Icons.visibility;
      case 'analytics':
        return Icons.analytics;
      case 'psychology':
        return Icons.psychology;
      default:
        return Icons.assistant;
    }
  }

  void _showAIDetails(BuildContext context, AIAssistantModel ai, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2329) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar and name
                    Row(
                      children: [
                        _buildAvatar(ai, false),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ai.name,
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                ai.metadata?['subtitle'] ?? '',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Description
                    Text(
                      'Descripción',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ai.description,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: isDark ? Colors.white70 : Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // All capabilities
                    Text(
                      'Todas las Capacidades',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...ai.capabilities.map(
                      (capability) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 20,
                              color: Color(ai.primaryColor),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                capability,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
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
