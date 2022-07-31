part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.valid = false,
  });

  final Email email;
  final FormzStatus status;
  final bool valid;

  @override
  List<Object> get props => [email, status, valid];

  LoginState copyWith({
    Email? email,
    FormzStatus? status,
    bool? valid,
  }) {
    return LoginState(
      email: email ?? this.email,
      status: status ?? this.status,
      valid: valid ?? this.valid,
    );
  }
}
