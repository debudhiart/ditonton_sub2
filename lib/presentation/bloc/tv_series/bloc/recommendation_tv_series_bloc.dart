import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tv_series_event.dart';
part 'recommendation_tv_series_state.dart';

class RecommendationTVSeriesBloc
    extends Bloc<RecommendationTVSeriesEvent, RecommendationTVSeriesState> {
  final GetTVSeriesRecommendations _getTVSeriesRecommendations;

  RecommendationTVSeriesBloc(this._getTVSeriesRecommendations)
      : super(RecommendationTVSeriesEmpty()) {
    on<RecommendationTVSeriesAppellation>(
      (event, emit) async {
        final id = event.id;
        emit(RecommendationTVSeriesLoading());

        final result = await _getTVSeriesRecommendations.execute(id);

        result.fold(
          (failure) {
            emit(RecommendationTVSeriesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(RecommendationTVSeriesHasData(data));
            } else {
              emit(RecommendationTVSeriesEmpty());
            }
          },
        );
      },
    );
  }
}
