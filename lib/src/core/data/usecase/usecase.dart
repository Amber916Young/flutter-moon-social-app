import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/exception/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class SingleUseCaseAsync<Type, Params> {
  Future<Type> call(Params params);
}

abstract class SingleUseCase<Type, Params> {
  Type call(Params params);
}

class Params<T> {
  final T data;

  Params(this.data);
}

abstract class EmptyParams {}

class NoParams extends EmptyParams {}
