import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum PaymentFilter { all, paid, pending }

class PaymentFilterBar extends StatelessWidget {
  final PaymentFilter selected;
  final ValueChanged<PaymentFilter> onChanged;

  const PaymentFilterBar({super.key, required this.selected, required this.onChanged});

  String _label(PaymentFilter filter) {
    switch (filter) {
      case PaymentFilter.all:
        return 'All';
      case PaymentFilter.paid:
        return 'Paid';
      case PaymentFilter.pending:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Wrap(
      spacing: AppTheme.spacingSm,
      children: [
        for (final filter in PaymentFilter.values)
          ChoiceChip(
            label: Text(_label(filter)),
            selected: filter == selected,
            onSelected: (_) => onChanged(filter),
            selectedColor: colors.primaryContainer,
            labelStyle: theme.textTheme.labelLarge?.copyWith(
              color: filter == selected ? colors.onPrimaryContainer : colors.onSurfaceVariant,
            ),
            side: BorderSide(
              color: filter == selected ? colors.primary : colors.outline,
              width: filter == selected ? AppTheme.borderSelected : AppTheme.borderDefault,
            ),
          ),
      ],
    );
  }
}
