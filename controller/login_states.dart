

abstract class LoginStates {}
class loginInitial extends LoginStates{}
class loginLoadig extends LoginStates{}
class loginSuccess extends LoginStates{

}
class loginError extends LoginStates{
  final String error;
  loginError(this. error);
}