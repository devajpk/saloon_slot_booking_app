import 'package:either_dart/either.dart';

typedef EitherResponse<T> = Future<Either<String, T>>;
