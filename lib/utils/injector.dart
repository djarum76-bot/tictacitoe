import 'package:get_it/get_it.dart';
import 'package:tictactoe/features/game/bloc/game_bloc.dart';
import 'package:tictactoe/features/game/repositories/game_repository.dart';

final injector = GetIt.instance;

void injectorSetup() {
  // Register datasource
  injector.registerSingleton<GameRepository>(GameRepository());

  /// Register singleton for NfcScannerBloc
  injector.registerSingleton<GameBloc>(GameBloc(
      gameRepository: injector<GameRepository>()
  ));
}