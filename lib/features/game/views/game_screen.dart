import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tictactoe/features/game/bloc/game_bloc.dart';
import 'package:tictactoe/features/game/repositories/game_repository.dart';
import 'package:tictactoe/utils/injector.dart';

class GameScreen extends StatelessWidget{
  const GameScreen({super.key, required this.isBot});
  final bool isBot;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: injector<GameBloc>()..add(TileInitial()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isBot ? "VS Bot" : "VS Player"),
        ),
        body: _gameBody(context),
      ),
    );
  }

  Widget _gameBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(3.w, 0, 3.w, 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _gameTurn(),
            _gameTiles(context),
            _gameMessage(),
            _gameButton(context)
          ],
        ),
      ),
    );
  }

  Widget _gameTurn(){
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state){
        return Visibility(
          visible: state.status != GameStatus.finished,
          child: Text(
            "Player turn : ${state.isXTurn ? "X" : "O"}",
            style: GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Widget _gameTiles(BuildContext context){
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state){
        return Visibility(
          visible: state.tiles != null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _gameTilesItem(context, state, row: 0, col: 0),
                  _gameTilesItem(context, state, row: 0, col: 1),
                  _gameTilesItem(context, state, row: 0, col: 2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _gameTilesItem(context, state, row: 1, col: 0),
                  _gameTilesItem(context, state, row: 1, col: 1),
                  _gameTilesItem(context, state, row: 1, col: 2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _gameTilesItem(context, state, row: 2, col: 0),
                  _gameTilesItem(context, state, row: 2, col: 1),
                  _gameTilesItem(context, state, row: 2, col: 2),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _gameTilesItem(BuildContext context, GameState state, {required int row, required int col}){
    return GestureDetector(
      onTap: ()async{
        injector<GameBloc>().add(TileTapped(row: row, col: col));

        if(isBot){
          await Future.delayed(const Duration(milliseconds: 200));
          List<int> botMoves = injector<GameRepository>().findBestMove(tiles: state.tiles!, filled: state.filled);
          injector<GameBloc>().add(TileTapped(row: botMoves[0], col: botMoves[1]));
        }
      },
      child: Container(
        width: 30.w,
        height: 15.h,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
        ),
        child: Center(
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state){
              return Text(
                state.tiles![row][col],
                style: GoogleFonts.poppins(fontSize: 24.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _gameMessage(){
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state){
        return Text(
          state.message,
          style: GoogleFonts.poppins(fontSize: 19.sp),
          textAlign: TextAlign.center,
        );
      },
    );
  }

  Widget _gameButton(BuildContext context){
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state){
        return Visibility(
          visible: state.status != GameStatus.initial,
          child: ElevatedButton(
              onPressed: () => injector<GameBloc>().add(TileInitial()),
              child: Text(
                "Restart Game",
                style: GoogleFonts.poppins(fontSize: 18.sp),
                textAlign: TextAlign.center,
              )
          ),
        );
      },
    );
  }
}