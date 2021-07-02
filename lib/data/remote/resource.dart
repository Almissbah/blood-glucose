 
abstract class Resource<T> {
  final T payload;
  Resource(this.payload);
}
 

class SuccessResource<T> extends Resource<T> {
  SuccessResource(T payload) : super(payload);
}
 
class FailureResource<T, E extends ErrorPayload> extends Resource<T> {
  final String msg;
  final E optionalErrorPayload;
  FailureResource(this.optionalErrorPayload, this.msg) : super(null);
}

abstract class ErrorPayload {}

enum APIErrorType { ConnectionError, HttpError,}

class APIError extends ErrorPayload {
  APIErrorType errorType; 
  int statusCode;
  APIError(this.errorType,this.statusCode);
 
}

 
