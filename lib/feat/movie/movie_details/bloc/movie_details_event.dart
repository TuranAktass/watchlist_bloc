part of 'movie_details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class GetDetails extends DetailsEvent {
  final String id;
  const GetDetails({required this.id});

  @override
  List<Object> get props => [id];
}
