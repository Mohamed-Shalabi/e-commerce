part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesFetched extends CategoriesState {}

class CategoriesFetchError extends CategoriesState {
  final String message;

  CategoriesFetchError(this.message);
}
