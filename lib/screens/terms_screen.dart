import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primio_app/widget/terms/term_tile.dart';

import '../models/term_item.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';


class TermsScreen extends StatefulWidget {
  final List<TermItem> terms;

  const TermsScreen({super.key, required this.terms});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Housing Policies', style: theme.textTheme.titleLarge),
                const SizedBox(height: AppTheme.spacingXs),
                Text(
                  'Please read the code of conduct below.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: appColors.subtleText),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                for (final term in widget.terms) TermTile(term: term),
                if (widget.terms.isEmpty)
                  Text('No housing policies recorded yet.', style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppTheme.spacingSm),
                CheckboxListTile(
                  value: _accepted,
                  onChanged: (value) => setState(() => _accepted = value ?? false),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('I agree to the terms and conditions', style: theme.textTheme.bodyMedium),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _accepted ? () => context.pop() : null,
                    child: const Text('Continue'),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
