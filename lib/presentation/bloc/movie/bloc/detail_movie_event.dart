part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

class DetailMovieAppellation extends DetailMovieEvent {
  final int id;

  DetailMovieAppellation(this.id);

  @override
  List<Object> get props => [];
}
