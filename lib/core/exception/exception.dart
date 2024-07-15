class ServerException implements Exception {
  final String errorMessage;
  final String errorCode;

  ServerException({
    required this.errorMessage,
    required this.errorCode,
  });

  get message => "";

  get code => 0;

  @override
  String toString() =>
      'ServerExseption(errorMessage: $errorMessage, errorCode: $errorCode)';
}
