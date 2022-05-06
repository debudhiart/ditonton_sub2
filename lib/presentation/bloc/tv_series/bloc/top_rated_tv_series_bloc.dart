import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTVSeriesBloc
    extends Bloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState> {
  final GetTopRatedTVSeries _getTopRatedTVSeries;

  TopRatedTVSeriesBloc(this._getTopRatedTVSeries)
      : super(TopRatedTVSeriesEmpty()) {
    on<TopRatedTVSeriesAppellation>(
      (event, emit) async {
        emit(TopRatedTVSeriesLoading());

        final result = await _getTopRatedTVSeries.execute();

        result.fold(
          (failure) {
            emit(TopRatedTVSeriesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(TopRatedTVSeriesHasData(data));
            } else {
              emit(TopRatedTVSeriesEmpty());
            }
          },
        );
      },
    );
  }
}
