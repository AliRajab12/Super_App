/// Class for configuring paging parameters
abstract class PageParams {
  const PageParams();

  void appendParams(Map<String, dynamic> params);

  static const PageParams none = NoPageParams();
}

class NoPageParams extends PageParams {
  const NoPageParams();

  @override
  void appendParams(Map<String, dynamic> params) {}
}

class CountSkip extends PageParams {
  final int count;
  final int skip;

  const CountSkip(this.count, this.skip);

  @override
  void appendParams(Map<String, dynamic> params) {
    if (count > 0) params['count'] = count;
    if (skip > 0) params['skip'] = skip * count;
  }
}

class TakeSkip extends PageParams {
  final int take;
  final int skip;

  const TakeSkip(this.take, this.skip);

  @override
  void appendParams(Map<String, dynamic> params) {
    params['take'] = take;
    params['skip'] = skip * take;
  }
}

class CountDate extends PageParams {
  final int count;
  final String? date;

  const CountDate(this.count, this.date);

  @override
  void appendParams(Map<String, dynamic> params) {
    params['count'] = count;
    if (date != null) params['sinceDateUtc'] = date;
  }
}
