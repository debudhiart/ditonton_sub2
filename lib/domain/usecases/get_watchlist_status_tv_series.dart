import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetDataTVSeriesWatchListStatus {
  final TVSeriesRepository repository;

  GetDataTVSeriesWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isInsertTVSeriesToWatchlist(id);
  }
}
