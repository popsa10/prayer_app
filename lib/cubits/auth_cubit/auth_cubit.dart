import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_app/cubits/auth_cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialAuthStates());
  static AuthCubit get(context) => BlocProvider.of(context);

  void signIn() async {
    try {
      emit(SignInLoadingState());
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      print(userCredential.user.email);
      emit(SignInSuccessState());
    } catch (error) {
      print("error is  $error");
      emit(SignInErrorState());
    }
  }
}
