import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit()
      : super(
          const RootState(
            user: null,
            isLoading: false,
            isCreatingAccount: false,
            errorMessage: '',
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> start() async {
    emit(
      const RootState(
        isLoading: true,
        errorMessage: '',
        user: null,
        isCreatingAccount: false,
      ),
    );

    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      emit(
        RootState(
          user: user,
          isLoading: false,
          errorMessage: '',
          isCreatingAccount: false,
        ),
      );
    })
          ..onError((error) {
            emit(
              RootState(
                isLoading: false,
                errorMessage: error.toString(),
                user: null,
                isCreatingAccount: false,
              ),
            );
          });
  }

  Future<void> createAccountButtonPressed() async {
    emit(
      const RootState(
        user: null,
        isLoading: false,
        errorMessage: '',
        isCreatingAccount: true,
      ),
    );
  }


  Future<void> signInButtonPressed() async {
    emit(
      const RootState(
        isLoading: false,
        errorMessage: '',
        user: null,
        isCreatingAccount: false,
      ),
    );
  }

  Future<void> register(
    String emailController,
    String passwordController,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
    } on FirebaseAuthException catch (error) {
      {
        emit(
          RootState(errorMessage: error.toString(), isLoading: false, user: null, isCreatingAccount: false),
        );
      }
    }
  }

  Future<void> signIn(
    String emailController,
    String passwordController,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
    } on FirebaseAuthException catch (error) {
      {
        emit(
          RootState(errorMessage: error.toString(), isLoading: false, user: null, isCreatingAccount: false),
        );
      }
    }
  }


  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}


