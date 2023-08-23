class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class InternetExceptions extends AppExceptions {
  InternetExceptions([String? message]) : super(message, 'No Internet');
}

class RequestTimeOutExceptions extends AppExceptions {
  RequestTimeOutExceptions([String? message])
      : super(message, 'Request timeOut');
}

class FetchDataExceptions extends AppExceptions {
  FetchDataExceptions([String? message]) : super(message, 'No Internet');
}
class ClientException extends AppExceptions {
  ClientException([String? message]) : super(message, 'Client Exceptions');
}