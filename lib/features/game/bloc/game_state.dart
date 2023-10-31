part of 'game_bloc.dart';

enum GameStatus { initial, progressed, finished }

class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.initial,
    this.tiles,
    this.isXTurn = true,
    this.message = "Tap one tile to play",
    this.filled = 0
  });

  final GameStatus status;
  final List<List<String>>? tiles;
  final bool isXTurn;
  final String message;
  final int filled;

  @override
  List<Object?> get props => [status, tiles, isXTurn, message, filled];

  GameState copyWith({
    GameStatus? status,
    List<List<String>>? tiles,
    bool? isXTurn,
    String? message,
    int? filled
  }) {
    return GameState(
      status: status ?? this.status,
      tiles: tiles ?? this.tiles,
      isXTurn: isXTurn ?? this.isXTurn,
      message: message ?? this.message,
      filled: filled ?? this.filled
    );
  }
}
