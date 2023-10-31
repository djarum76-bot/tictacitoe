import 'package:flutter/material.dart';
import 'package:tictactoe/features/game/views/game_screen.dart';
import 'package:tictactoe/features/introduction/views/introduction_screen.dart';
import 'package:tictactoe/utils/screen_argument.dart';

class AppRoutes{
  static const introduction = '/introduction';
  static const game = '/game';

  static Route<dynamic>? onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case introduction:
        return _pageRouteBuilder(page: const IntroductionScreen());
      case game:
        final args = settings.arguments as ScreenArgument<bool>;
        return _pageRouteBuilder(page: GameScreen(isBot: args.data));
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          );
        });
    }
  }

  static PageRouteBuilder<dynamic> _pageRouteBuilder({required Widget page}){
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
    );
  }
}