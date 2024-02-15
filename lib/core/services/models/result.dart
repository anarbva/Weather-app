
sealed class Result<T>{
  const Result();
}

class Success<T>extends Result{
  final Map<String, dynamic> data;

  Success({required this.data});
}

class Failure<T>extends Result{
  final String error;
  final int statusCode;
  Failure({
    required this.error,
    required this.statusCode
    });
}