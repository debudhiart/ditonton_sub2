part of 'detail_tv_series_bloc.dart';

abstract class DetailTVSeriesEvent extends Equatable {
  const DetailTVSeriesEvent();
}

class DetailTVSeriesAppellation extends DetailTVSeriesEvent {
  final int id;

  DetailTVSeriesAppellation(this.id);

  @override
  List<Object> get props => [];
}
