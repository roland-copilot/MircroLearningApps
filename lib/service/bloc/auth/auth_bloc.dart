import 'package:bloc/bloc.dart';
import 'package:elearning/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseService firebaseService;
  AuthBloc(this.firebaseService) : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(_Loading());
      try {
        await firebaseService.signIn(event.email, event.password);
        emit(_Success());
      } catch (e) {
        emit(_Error(_mapAuthError(e)));
      }
    });

    on<_Logout>((event, emit) async {
      emit(_Loading());
      try {
        await Future<void>.delayed(const Duration(milliseconds: 900));
        await firebaseService.logout();
        emit(_Success());
      } catch (e) {
        emit(_Error(_mapAuthError(e)));
      }
    });
  }

  String _mapAuthError(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          return 'Format email tidak valid.';
        case 'invalid-credential':
        case 'wrong-password':
        case 'user-not-found':
          return 'Email atau password salah.';
        case 'user-disabled':
          return 'Akun ini telah dinonaktifkan.';
        case 'too-many-requests':
          return 'Terlalu banyak percobaan. Coba lagi beberapa saat.';
        case 'network-request-failed':
          return 'Koneksi internet bermasalah. Periksa jaringan Anda.';
      }
    }

    return 'Terjadi kesalahan saat autentikasi. Silakan coba lagi.';
  }
}
