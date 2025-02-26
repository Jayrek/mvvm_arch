abstract class Failure {
  const Failure(this.message);
  final String message;

  @override
  String toString() {
    return 'Failure(message: $message)';
  }
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network Failure'])
      : super('Network Failure: $message');
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server Failure'])
      : super('Server Failure: $message');
}

class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'Unknown Failure'])
      : super('Unknown Failure: $message');
}
