import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'on_the_air_now_tv_series_event.dart';
part 'on_the_air_now_tv_series_state.dart';

class OnTheAirNowTVSeriesBloc
    extends Bloc<OnTheAirNowTVSeriesEvent, OnTheAirNowTVSeriesState> {
  final GetOnTheAirTVSeries _getOnTheAirTVSeries;

  OnTheAirNowTVSeriesBloc(this._getOnTheAirTVSeries)
      : super(OnTheAirNowTVSeriesEmpty()) {
    on<OnTheAirNowTVSeriesAppellation>(
      (event, emit) async {
        emit(OnTheAirNowTVSeriesLoading());

        final result = await _getOnTheAirTVSeries.execute();

        result.fold(
          (failure) {
            emit(OnTheAirNowTVSeriesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(OnTheAirNowTVSeriesHasData(data));
            } else {
              emit(OnTheAirNowTVSeriesEmpty());
            }
          },
        );
      },
    );
  }
}
