abstract class LoginScreenStates {}

class InitialState extends LoginScreenStates {}

class LoginLoad extends LoginScreenStates {}

class SignInSucceed extends LoginScreenStates {}
class SignInFailed extends LoginScreenStates {
  final String error;

  SignInFailed(this.error);
}
