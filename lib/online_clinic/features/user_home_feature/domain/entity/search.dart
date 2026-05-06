import 'package:equatable/equatable.dart';

enum SearchTypeEnum {
  doctor,
  other,
}

class Search extends Equatable {
  Search({
    required this.title,
    required this.suggestions,
    required this.searchType,
    required this.isExpanded,
  });


  final String title;
  final List<String> suggestions;
  final SearchTypeEnum searchType;
  bool isExpanded;


  @override
  List<Object?> get props => [
        title,
        suggestions,
        searchType,
        isExpanded,
      ];
}
