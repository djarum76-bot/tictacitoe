import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/features/game/repositories/game_repository.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({required this.gameRepository}) : super(const GameState()) {
    on<TileInitial>(_onTileInitial);
    on<TileTapped>(_onTileTapped);
  }

  final GameRepository gameRepository;

  void _onTileInitial(TileInitial event, Emitter<GameState> emit){
    emit(state.copyWith(
      status: GameStatus.initial,
      isXTurn: true,
      message: "Tap one tile to play",
      tiles: <List<String>>[["","",""],["","",""],["","",""]],
      filled: 0
    ));
  }

  void _onTileTapped(TileTapped event, Emitter<GameState> emit){
    if(state.tiles![event.row][event.col] == "" && state.status != GameStatus.finished){
      final tiles = state.tiles;
      String player = state.isXTurn ? "X" : "O";
      tiles![event.row][event.col] = player;

      emit(state.copyWith(
        tiles: tiles,
        isXTurn: !state.isXTurn,
        message: "",
        status: GameStatus.progressed,
        filled: state.filled + 1
      ));

      final isGameWin = gameRepository.checkGameWin(tiles: tiles, player: player);

      if(isGameWin){
        emit(state.copyWith(
          message: "Player ${!state.isXTurn ? "X" : "O"} Win",
          status: GameStatus.finished
        ));
        return;
      }

      if(state.filled == 9){
        emit(state.copyWith(
          message: "No one win\nGame draw",
          status: GameStatus.finished
        ));
      }
    }
  }
}
