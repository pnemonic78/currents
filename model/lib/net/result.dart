/// A network result.
sealed class TikalResult<T> {}

/// A network request is busy.
class TikalResultLoading<T> extends TikalResult<T> {}

/// A network result that holds a value.
class TikalResultSuccess<T> extends TikalResult<T> {
  final T? data;

  TikalResultSuccess(this.data);
}

/// A network error.
class TikalResultError<T> extends TikalResult<T> {
  final Exception exception;
  final int code;

  //FIXME exception.message;
  final String message;

  TikalResultError(this.exception, [this.code = 0, this.message = ""]);

  static TikalResultError<T> copy<T>(TikalResultError other) =>
      TikalResultError(other.exception, other.code, other.message);

  static TikalResultError<T> withMessage<T>(String message, {int code = 0}) =>
      TikalResultError(Exception(message), code, message);
}
