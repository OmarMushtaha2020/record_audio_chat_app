abstract class UserState {}
class InitialState extends UserState {}


class GetAllUserSucceed extends UserState {}
class GetAllUserFailed extends UserState {
  final String error;

  GetAllUserFailed(this.error);
}
class GetUserDataSucceed extends UserState {}
class GetUserDataFailed extends UserState {
  final String error;

  GetUserDataFailed(this.error);
}