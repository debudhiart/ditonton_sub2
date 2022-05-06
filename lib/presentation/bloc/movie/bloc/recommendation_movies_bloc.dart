import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_movies_event.dart';
part 'recommendation_movies_state.dart';

class RecommendationMoviesBloc
    extends Bloc<RecommendationMoviesEvent, RecommendationMoviesState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMoviesBloc(this._getMovieRecommendations)
      : super(RecommendationMoviesEmpty()) {
    on<RecommendationMoviesAppellation>(
      (event, emit) async {
        final id = event.id;
        emit(RecommendationMoviesLoading());

        final result = await _getMovieRecommendations.execute(id);

        result.fold(
          (failure) {
            emit(RecommendationMoviesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(RecommendationMoviesHasData(data));
            } else {
              emit(RecommendationMoviesEmpty());
            }
          },
        );
      },
    );
  }
}
