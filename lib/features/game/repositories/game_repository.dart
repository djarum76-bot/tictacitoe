import 'dart:math';

class GameRepository{
  bool checkGameWin({
    required List<List<String>> tiles,
    required String player
  }){
    for (var i = 0; i < 3; i++) {
      if (tiles[i][0] == player && tiles[i][1] == player && tiles[i][2] == player) {
        return true;
      }
    }
    
    for (var i = 0; i < 3; i++) {
      if (tiles[0][i] == player && tiles[1][i] == player && tiles[2][i] == player) {
        return true;
      }
    }

    if(tiles[0][0] == player && tiles[1][1] == player && tiles[2][2] == player){
      return true;
    }

    if(tiles[0][2] == player && tiles[1][1] == player && tiles[2][0] == player){
      return true;
    }

    return false;
  }

  int evaluate(List<List<String>> tiles) {
    int score = 0;
    score += evaluateLine(tiles, 0, 0, 0, 1, 0, 2); // Check rows
    score += evaluateLine(tiles, 1, 0, 1, 1, 1, 2); // Check columns
    score += evaluateLine(tiles, 0, 0, 1, 0, 2, 0); // Check diagonals
    score += evaluateLine(tiles, 0, 1, 1, 1, 2, 1); // Check middle column
    score += evaluateLine(tiles, 0, 2, 1, 2, 2, 2); // Check right column
    score += evaluateLine(tiles, 2, 0, 2, 1, 2, 2); // Check bottom row
    score += evaluateLine(tiles, 0, 0, 1, 1, 2, 2); // Check main diagonal
    score += evaluateLine(tiles, 0, 2, 1, 1, 2, 0); // Check anti diagonal
    return score;
  }

  int evaluateLine(List<List<String>> tiles, int row1, int col1, int row2, int col2, int row3, int col3) {
    int score = 0;
    // First cell
    if (tiles[row1][col1] == 'X') {
      score = 1;
    } else if (tiles[row1][col1] == 'O') {
      score = -1;
    }
    // Second cell
    if (tiles[row2][col2] == 'X') {
      if (score == 1) {
        score = 10;
      } else if (score == -1) {
        return 0;
      } else {
        score = 1;
      }
    } else if (tiles[row2][col2] == 'O') {
      if (score == -1) {
        score = -10;
      } else if (score == 1) {
        return 0;
      } else {
        score = -1;
      }
    }
    // Third cell
    if (tiles[row3][col3] == 'X') {
      if (score > 0) {
        score *= 10;
      } else if (score < 0) {
        return 0;
      } else {
        score = 1;
      }
    } else if (tiles[row3][col3] == 'O') {
      if (score < 0) {
        score *= 10;
      } else if (score > 1) {
        return 0;
      } else {
        score = -1;
      }
    }
    return score;
  }

  int minimaxAlgorithm({
    required List<List<String>> tiles,
    required int depth,
    required bool isMaximizingPlayer,
    required int alpha,
    required int beta,
    required int filled,
  }){
    if (checkGameWin(tiles: tiles, player: "X")) {
      return -10;
    } else if (checkGameWin(tiles: tiles, player: "O")) {
      return 10;
    } else if (filled == 9) {
      return 0;
    }

    if (isMaximizingPlayer) {
      int maxEval = -1000;
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          if (tiles[i][j] == '') {
            tiles[i][j] = 'O';
            int eval = minimaxAlgorithm(tiles: tiles, depth: depth + 1, isMaximizingPlayer: false, alpha: alpha, beta: beta, filled: filled);
            tiles[i][j] = '';
            maxEval = max(maxEval, eval);
            alpha = max(alpha, eval);
            if (beta <= alpha) {
              break;
            }
          }
        }
      }
      return maxEval;
    } else {
      int minEval = 1000;
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          if (tiles[i][j] == '') {
            tiles[i][j] = 'X';
            int eval = minimaxAlgorithm(tiles: tiles, depth: depth + 1, isMaximizingPlayer: true, alpha: alpha, beta: beta, filled: filled);
            tiles[i][j] = '';
            minEval = min(minEval, eval);
            beta = min(beta, eval);
            if (beta <= alpha) {
              break;
            }
          }
        }
      }
      return minEval;
    }
  }

  List<int> findBestMove({required List<List<String>> tiles, required int filled}) {
    int bestScore = -1000;
    List<int> bestMove = [-1, -1];
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (tiles[i][j] == '') {
          tiles[i][j] = 'O';
          int score = minimaxAlgorithm(tiles: tiles, depth: 0, isMaximizingPlayer: false, alpha: -1000, beta: -1000, filled: filled);
          tiles[i][j] = '';
          if (score > bestScore) {
            bestScore = score;
            bestMove = [i, j];
          }
        }
      }
    }
    return bestMove;
  }
}