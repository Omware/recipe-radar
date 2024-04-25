class NoInternetException implements Exception {
  final String message = 'No internet connection found';

  @override
  String toString() => message;
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}