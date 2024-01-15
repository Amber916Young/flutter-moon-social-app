abstract class Failure {
  final String errorMessage;
  final String? errorCode;

  const Failure({required this.errorMessage, this.errorCode});
}

class ServerFailure extends Failure {
  ServerFailure({required String errorMessage, required String errorCode})
      : super(errorMessage: errorMessage, errorCode: errorCode);
}

class ConnectionFailure extends Failure {
  ConnectionFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class CacheFailure extends Failure {
  CacheFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}
