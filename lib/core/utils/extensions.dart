import 'dart:developer';

import 'package:somi/core/models/page_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringUtils on String {
  bool get isBlank => trim().isEmpty;
}

extension SerializationUtils on Response<dynamic> {
  List<T> deserializeList<T>(T Function(Map<String, dynamic> json) fromJson,
      [String? deserializePropertyName]) {
    List<dynamic> list;
    if (deserializePropertyName != null) {
      if (data is String && (data as String).isEmpty) {
        log('Unable to deserialize list from empty response for ${requestOptions.path}. Returning empty list.');
        list = [];
      } else if (data[deserializePropertyName] != null) {
        list = data[deserializePropertyName] as List<dynamic>;
      } else {
        log('Unable to deserialize list "$deserializePropertyName" from response. Returning empty list.');
        list = [];
      }
    } else {
      list = data;
    }
    return List.from(list.map((value) => fromJson(value)).toList());
  }

  PageResponse<T> deserializePage<T>(
    T Function(Map<String, dynamic> json) fromJson, [
    String? deserializePropertyName = 'Items',
  ]) {
    if (data == null || data is String && (data as String).isEmpty) {
      log('Unable to deserialize page from empty response for ${requestOptions.path}. Returning empty list.');
      return PageResponse([], false);
    }
    return PageResponse(
      deserializeList(fromJson, deserializePropertyName),
      data['HasMoreItems'] ?? false,
    );
  }
}

extension SetUtils<T> on Set<T> {
  Set<T> copyAndRemove(T item) => Set.from(this)..remove(item);

  Set<T> copyAndAdd(T item) => Set.from(this)..add(item);
}

extension ListUtils<T> on List<T> {
  List<T> copyAndRemove(T item) => List.from(this)..remove(item);

  List<T> copyAndAdd(T item, {bool addToStart = false}) =>
      List.from(this)..insert(addToStart ? 0 : length, item);

  List<T> copyAndReplace(T originalItem, T newItem) {
    return map((item) => item == originalItem ? newItem : item).toList();
  }

  List<R> whereInstance<R extends T>() {
    List<R> list = [];
    for (T item in this) {
      if (item is R) list.add(item);
    }
    return list;
  }

  /// Returns a pair of lists, the first containing the items that satisfy the
  /// predicate, the second containing the items that don't.
  (List<T>, List<T>) partition(bool Function(T) predicate) {
    final a = <T>[];
    final b = <T>[];

    for (final item in this) {
      (predicate(item) ? a : b).add(item);
    }

    return (a, b);
  }

  /// Returns a copy of the original list, but with the first
  /// item that matches the given [predicate] replaced with [replacement].
  ///
  /// If no item matches the [predicate], the [replacement] will be appended to the
  /// end of the new list if [appendIfNotFound] is set to `true`.
  ///
  /// - Parameters:
  ///   - [predicate]: A function that takes an item of type `T` and returns a boolean.
  ///   If this function returns `true` for an item, that item is replaced by [replacement].
  ///
  ///   - [replacement]: The item that will replace the first item in the list
  ///   for which the [predicate] returns `true`.
  ///
  ///   - [appendIfNotFound]: An optional boolean that, when `true`, will append
  ///   the [replacement] to the end of the list if no item satisfies the [predicate].
  ///   Defaults to `false`.
  ///
  /// Example:
  /// ```
  /// List<int> list = [1, 2, 3, 4, 5];
  /// var updated = list.copyAndReplaceFirstWhere((x) => x == 3, 10);
  /// print(updated); // [1, 2, 10, 4, 5]
  /// ```
  List<T> copyAndReplaceFirstWhere(bool Function(T) predicate, T replacement,
      {bool appendIfNotFound = false}) {
    List<T> copy = List.from(this);
    for (int i = 0; i < copy.length; i++) {
      if (predicate(copy[i])) {
        copy[i] = replacement;
        return copy;
      }
    }
    if (appendIfNotFound) {
      copy.add(replacement);
    }
    return copy;
  }
}

extension ContextExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension StateExtensions on State {
  TextTheme get textTheme => Theme.of(context).textTheme;

  ColorScheme get colorScheme => Theme.of(context).colorScheme;
}

///Extension to convert ISO 8601 format to dd MMM yyyy
extension DateFormatter on String {
  String getFormattedDateddMMMYYYY(String? localeId) {
    try {
      // Parse the input string into a DateTime object
      DateTime dateTime = DateTime.parse(this);

      // Format the DateTime object into dd MMM yyyy format using intl package
      String formattedDate =
          DateFormat('dd MMM yyyy', localeId ?? 'en_US').format(dateTime);

      return formattedDate;
    } catch (e) {
      // Handle parsing errors
      debugPrint('Error parsing date: $e');
      return '--';
    }
  }
}
