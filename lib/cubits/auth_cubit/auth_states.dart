abstract class AuthStates {}

class InitialAuthStates extends AuthStates {}

class SignInLoadingState extends AuthStates {}

class SignInSuccessState extends AuthStates {}

class SignInErrorState extends AuthStates {}
