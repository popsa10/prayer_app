import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:prayer_app/cubits/auth_cubit/auth_states.dart';
import 'package:prayer_app/screens/home_page_screen.dart';

import 'components/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageScreen(),
                ));
          } else if (state is SignInErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please,TryAgain Later")));
          }
        },
        builder: (context, state) {
          if (state is! SignInLoadingState) {
            return Center(
                child: buildCustomButton(
                    context: context,
                    onTap: () {
                      AuthCubit.get(context).signIn();
                    }));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
