/// Use this class to send data between repositories and view models.
/// [D] is the type of passed type and [E] is the error
class DataProvider<D, E> {
  final D? data;
  final E? error;

  DataProvider.success({required this.data}) : error = null;

  DataProvider.error({required this.error}) : data = null;

  bool get isSuccessful => error == null;

  bool get isError => data == null;
}
