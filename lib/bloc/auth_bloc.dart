import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_near_by/services/google_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseServices _firebaseServices;

  AuthBloc(this._firebaseServices) : super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthLoggedOut>(_onAuthLoggedOut);
  }

  Future<void> _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthFailure());
    }
  }

  Future<void> _onAuthLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _firebaseServices.signInWithGoogle();
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthError('Unable to login'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthLoggedOut(AuthLoggedOut event, Emitter<AuthState> emit) async {
    await _firebaseServices.signOut();
    emit(AuthFailure());
  }
}
