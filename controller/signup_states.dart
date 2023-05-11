

abstract class SignUpStates{}
class signUpInitial extends SignUpStates{}
class signUpSuccess extends SignUpStates{}
class signUpLoading extends SignUpStates{}
class signUpError extends SignUpStates{
  final String error;

   signUpError({required this.error});
}
class vesibilitySuccess extends SignUpStates{}
