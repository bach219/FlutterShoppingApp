import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/authentication/authentication.dart';
import 'package:fluttercommerce/home/home.dart';
import 'package:fluttercommerce/login/login.dart';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
import 'package:fluttercommerce/splash/splash.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dividerColor: Color(0xFFECEDF1),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColor: Color(0xFFDBCC8F),
        accentColor: Colors.cyan[600],
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          subtitle: TextStyle(fontSize: 16),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
          display1: TextStyle(
              fontSize: 14.0, fontFamily: 'Montserrat1', color: Colors.white),
          display2: TextStyle(
              fontSize: 14.0, fontFamily: 'Montserrat', color: Colors.black54),
        ),
      ),
      title: 'Bach\'s Shop',
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                // UserRepository _userRepository;
                // User user = await _userRepository.getUser();
                // if (user != User.empty)
                //   _navigator.pushAndRemoveUntil<void>(
                //     HomePage.route(),
                //     (route) => false,
                //   );
                // else
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
