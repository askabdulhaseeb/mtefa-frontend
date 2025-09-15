import 'data_state.dart';

abstract class UseCase<T, P> {
  Future<DataState<T>> call({P? params});
}

class NoParams {
  const NoParams();
}