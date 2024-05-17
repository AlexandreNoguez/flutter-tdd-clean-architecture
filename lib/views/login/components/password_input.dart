import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:treinamento_flutter/views/views.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
              labelText: 'Senha',
              icon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColorDark,
              ),
              errorText: ''),
          obscureText: true,
          onChanged: presenter.validatePassword,
        );
      },
    );
  }
}
