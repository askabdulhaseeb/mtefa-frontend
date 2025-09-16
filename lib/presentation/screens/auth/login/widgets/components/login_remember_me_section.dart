import 'package:flutter/material.dart';

import '../../../providers/login_provider.dart';

/// Remember me and forgot password section component
/// Reusable component for authentication forms
class LoginRememberMeSection extends StatelessWidget {
  const LoginRememberMeSection({
    required this.provider,
    super.key,
  });

  final LoginProvider provider;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Checkbox(
              value: provider.rememberMe,
              onChanged: (bool? _) => provider.toggleRememberMe(),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const Flexible(
              child: Text('Remember me', overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        TextButton(
          onPressed: provider.forgotPassword,
          child: const Text('Forgot password?'),
        ),
      ],
    );
  }
}