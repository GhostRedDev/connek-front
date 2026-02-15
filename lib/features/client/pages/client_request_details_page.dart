import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_request_model.dart';
import 'package:go_router/go_router.dart';
import '../providers/client_requests_provider.dart';
import '../services/client_requests_service.dart';
import '../services/client_wallet_service.dart';
import '../../settings/providers/profile_provider.dart';
import '../providers/wallet_provider.dart';

final _clientRequestDetailsProvider =
    FutureProvider.family<ServiceRequest?, int>((ref, requestId) async {
      final service = ref.read(clientRequestsServiceProvider);
      return service.fetchRequestDetails(requestId);
    });

class ClientRequestDetailsPage extends ConsumerStatefulWidget {
  final ServiceRequest request;

  const ClientRequestDetailsPage({super.key, required this.request});

  @override
  ConsumerState<ClientRequestDetailsPage> createState() =>
      _ClientRequestDetailsPageState();
}

class _ClientRequestDetailsPageState
    extends ConsumerState<ClientRequestDetailsPage> {
  bool _isActing = false;

  Future<void> _accept(Quote q) async {
    setState(() => _isActing = true);
    try {
      final service = ref.read(clientRequestsServiceProvider);
      final ok = await service.acceptProposal(q.id, q.leadId);
      if (!mounted) return;
      if (ok) {
        // If we can identify the business, attempt payment right away.
        try {
          final profileState = ref.read(profileProvider);
          final clientId = profileState.value?.id;
          if (clientId != null && q.businessId != null) {
            final walletService = ref.read(clientWalletServiceProvider);
            final methods = await walletService.getPaymentMethods(
              clientId: clientId,
            );

            final typedMethods = methods
                .whereType<Map>()
                .map((m) => Map<String, dynamic>.from(m))
                .toList();

            final defaultMethod = typedMethods.firstWhere(
              (m) => m['default_method'] == true,
              orElse: () => typedMethods.isNotEmpty ? typedMethods.first : {},
            );

            final paymentMethodId = defaultMethod['id'] as int?;

            if (paymentMethodId != null) {
              await walletService.chargePurchase(
                clientId: clientId,
                businessId: q.businessId!,
                serviceId: q.serviceId,
                amountCents: (q.amount * 100).round(),
                paymentMethodId: paymentMethodId,
                description: q.description.isNotEmpty
                    ? q.description
                    : 'Compra de servicio',
              );

              // Refresh wallet state so transactions/balance update.
              ref.invalidate(walletProvider);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Oferta aceptada, pero no se encontró un método de pago. Agrega uno en tu Wallet.',
                  ),
                ),
              );
            }
          }
        } catch (e) {
          // Keep acceptance, but surface payment error.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Oferta aceptada, pero el pago falló: $e')),
          );
        }

        ref.invalidate(clientRequestsProvider);
        ref.invalidate(_clientRequestDetailsProvider(widget.request.id));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Oferta aceptada.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo aceptar la oferta.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  Future<void> _decline(Quote q) async {
    setState(() => _isActing = true);
    try {
      final service = ref.read(clientRequestsServiceProvider);
      final ok = await service.declineProposal(q.id, q.leadId);
      if (!mounted) return;
      if (ok) {
        ref.invalidate(clientRequestsProvider);
        ref.invalidate(_clientRequestDetailsProvider(widget.request.id));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Oferta rechazada.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo rechazar la oferta.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final detailsAsync = ref.watch(
      _clientRequestDetailsProvider(widget.request.id),
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Detalle de solicitud'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: detailsAsync.when(
          data: (req) {
            final request = req ?? widget.request;
            final offers = request.proposals;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.withOpacity(0.12)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trabajo',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        request.title.isNotEmpty
                            ? request.title
                            : request.message,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _pill(
                            text: request.status,
                            color: Colors.blue.withOpacity(0.12),
                            textColor: Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          _pill(
                            text: request.amount > 0
                                ? 'Presupuesto máx: \$${request.amount.toStringAsFixed(0)}'
                                : 'Sin presupuesto',
                            color: Colors.green.withOpacity(0.12),
                            textColor: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Ofertas',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                if (offers.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900] : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: const Text(
                      'Aún no tienes ofertas para este trabajo.',
                    ),
                  )
                else
                  ...offers.map((q) => _offerTile(theme, q)).toList(),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _offerTile(ThemeData theme, Quote quote) {
    final isPending = quote.status.toLowerCase() == 'pending';
    final isAccepted = quote.status.toLowerCase() == 'accepted';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  quote.businessName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '\$${quote.amount.toStringAsFixed(0)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          if (quote.description.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(quote.description),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              _pill(
                text: quote.status,
                color: isAccepted
                    ? Colors.green.withOpacity(0.12)
                    : Colors.grey.withOpacity(0.15),
                textColor: isAccepted ? Colors.green : Colors.grey[700]!,
              ),
              const Spacer(),
              if (isPending) ...[
                TextButton(
                  onPressed: _isActing ? null : () => _decline(quote),
                  child: const Text('Rechazar'),
                ),
                const SizedBox(width: 6),
                ElevatedButton(
                  onPressed: _isActing ? null : () => _accept(quote),
                  child: _isActing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Aceptar'),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill({
    required String text,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
