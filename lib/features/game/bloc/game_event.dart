part of 'game_bloc.dart';

abstract class GameEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class TileInitial extends GameEvent{}

class TileTapped extends GameEvent{
  final int row;
  final int col;

  TileTapped({required this.row, required this.col});
}