import 'package:fpdart/fpdart.dart';

class GameException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const GameException(this.message, [this.stackTrace]);

  static Left<GameException, T> left<T>(String message, [StackTrace? stackTrace]) {
    return Left(GameException(message, stackTrace));
  }

  @override
  String toString() {
    return message;
  }
}
