import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../theme/design_tokens.dart';

enum ContentStatus { loading, empty, error, success, unauthorized }

class StatePanel extends StatelessWidget {
  const StatePanel({
    required this.status,
    this.title,
    this.message,
    this.icon,
    this.onRetry,
    this.successContent,
    super.key,
  });

  final ContentStatus status;
  final String? title;
  final String? message;
  final IconData? icon;
  final VoidCallback? onRetry;
  final Widget? successContent;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;

    switch (status) {
      case ContentStatus.loading:
        return Semantics(
          label: strings.loadingLabel,
          liveRegion: true,
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(WathbSpacing.x6),
              child: CircularProgressIndicator(),
            ),
          ),
        );
      case ContentStatus.success:
        return successContent ?? const SizedBox.shrink();
      case ContentStatus.empty:
      case ContentStatus.error:
      case ContentStatus.unauthorized:
        final isError = status == ContentStatus.error;
        final isUnauthorized = status == ContentStatus.unauthorized;
        final defaultTitle = switch (status) {
          ContentStatus.empty => strings.emptyTitle,
          ContentStatus.error => strings.errorTitle,
          ContentStatus.unauthorized => strings.unauthorizedTitle,
          _ => '',
        };
        final defaultMessage = switch (status) {
          ContentStatus.empty => strings.emptyMessage,
          ContentStatus.error => strings.errorMessage,
          ContentStatus.unauthorized => strings.unauthorizedMessage,
          _ => '',
        };
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(WathbSpacing.x6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon ??
                      (isError
                          ? Icons.error_outline_rounded
                          : isUnauthorized
                          ? Icons.lock_outline_rounded
                          : Icons.inbox_rounded),
                  size: 32,
                  color: isError ? colors.error : colors.primary,
                  semanticLabel: title,
                ),
                const SizedBox(height: WathbSpacing.x3),
                Text(
                  title ?? defaultTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if ((message ?? defaultMessage).isNotEmpty) ...[
                  const SizedBox(height: WathbSpacing.x2),
                  Text(message ?? defaultMessage, textAlign: TextAlign.center),
                ],
                if (isError && onRetry != null) ...[
                  const SizedBox(height: WathbSpacing.x4),
                  FilledButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(strings.retry),
                  ),
                ],
              ],
            ),
          ),
        );
    }
  }
}
