import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import 'components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late StreamSubscription<bool> isLoadingSubscription;
  late StreamSubscription<String?> mainErrorSubscription;

  void _hideKeyboard() {
    final currenteFocus = FocusScope.of(context);
    if (!currenteFocus.hasPrimaryFocus) {
      currenteFocus.unfocus();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Gerenciando a inscrição nos streams de isLoading e mainError
    isLoadingSubscription =
        widget.presenter.isLoadingStream.listen((isLoading) {
      if (isLoading) {
        showLoading(context);
      } else {
        hideLoading(context);
      }
    });

    mainErrorSubscription = widget.presenter.mainErrorStream.listen((error) {
      if (error != null) {
        showErrorMessage(context, error);
      }
    });
  }

  @override
  void dispose() {
    isLoadingSubscription.cancel();
    mainErrorSubscription.cancel();
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _hideKeyboard,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LoginHeader(),
              Headline1('Bullet Journal'),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Provider(
                  create: (_) => widget.presenter,
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          EmailInput(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 32),
                            child: PasswordInput(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LoginButton(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: Text('Ainda não tem sua conta?'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Cadastre-se!'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
