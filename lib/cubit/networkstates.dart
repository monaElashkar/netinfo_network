abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class ConnectedState extends NetworkState {
  final String message;
  ConnectedState({required this.message});
}

class firstConnectedState extends NetworkState {
  final String message;
  firstConnectedState({required this.message});
}

class NotConnectedState extends NetworkState {
  final String message;
  NotConnectedState({required this.message});
}
class StartLoading_For_getlist_state extends NetworkState {}
class GetDataListFromApi extends NetworkState {}
class EndLoading_For_getlist_state extends NetworkState {}


