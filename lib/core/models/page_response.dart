class PageResponse<T> {
  final List<T> items;
  final bool hasMoreItems;

  PageResponse(this.items, this.hasMoreItems);
}
