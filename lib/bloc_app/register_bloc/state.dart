abstract class RegisterState {}
class InitialState extends RegisterState {}

class RegisterLoad extends RegisterState {}

class RegisterSucceed extends RegisterState {}
class RegisterFailed extends RegisterState {
  final String error;

  RegisterFailed(this.error);
}

