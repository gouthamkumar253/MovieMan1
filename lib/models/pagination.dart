/**
 * Created By: Hemanth Raj V
 */

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pagination.g.dart';

abstract class Pagination implements Built<Pagination, PaginationBuilder> {
  factory Pagination([PaginationBuilder updates(PaginationBuilder builder)]) =
      _$Pagination;

  Pagination._();

  int get page;

  int get limit;

  @BuiltValueField(wireName: 'total_pages')
  int get totalPages;

  @BuiltValueField(wireName: 'total_count')
  int get totalCount;

  PageLinks get links;

  static Serializer<Pagination> get serializer => _$paginationSerializer;
}

abstract class PageLinks implements Built<PageLinks, PageLinksBuilder> {
  factory PageLinks([PageLinksBuilder updates(PageLinksBuilder builder)]) =
      _$PageLinks;

  PageLinks._();

  String get current;

  @nullable
  String get previous;

  @nullable
  String get next;

  String get first;

  String get last;

  static Serializer<PageLinks> get serializer => _$pageLinksSerializer;
}
