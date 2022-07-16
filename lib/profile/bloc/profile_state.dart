part of 'profile_bloc.dart';

enum ProfileStatus {loading, success}

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.loading,
  });
  
  final ProfileStatus status;
  
  @override
  List<Object> get props => [status];
}
