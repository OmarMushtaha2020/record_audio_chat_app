abstract class LoginState {}

  class InitialState extends LoginState{}
class LoginLoad extends LoginState {}
class SignInSucceed extends LoginState {}
class SignInFailed extends LoginState {
  final String error;

  SignInFailed(this.error);
}


