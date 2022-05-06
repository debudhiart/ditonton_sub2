import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTVSeriesBloc
    extends Bloc<DetailTVSeriesEvent, DetailTVSeriesState> {
  final GetTVSeriesDetail _getTVSeriesDetail;

  DetailTVSeriesBloc(this._getTVSeriesDetail) : super(DetailTVSeriesEmpty()) {
    on<DetailTVSeriesAppellation>(
      (event, emit) async {
        final id = event.id;

        emit(DetailTVSeriesLoading());
        final result = await _getTVSeriesDetail.execute(id);

        result.fold(
          (failure) {
            emit(DetailTVSeriesError(failure.message));
          },
          (data) {
            emit(DetailTVSeriesHasData(data));
          },
        );
      },
    );
  }
}
