/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:campus_pulse_client/src/protocol/protocol.dart' as _il98xzab;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'search_item.dart' as _imxb4b9a;

abstract class SearchResponse
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SearchResponse._({
    required this.query,
    required this.items,
    required this.totalCount,
  });

  factory SearchResponse({
    required String query,
    required List<_imxb4b9a.SearchItem> items,
    required int totalCount,
  }) = _SearchResponseImpl;

  factory SearchResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return SearchResponse(
      query: jsonSerialization['query'] as String,
      items: _il98xzab.Protocol().deserialize<List<_imxb4b9a.SearchItem>>(
        jsonSerialization['items'],
      ),
      totalCount: jsonSerialization['totalCount'] as int,
    );
  }

  String query;

  List<_imxb4b9a.SearchItem> items;

  int totalCount;

  /// Returns a shallow copy of this [SearchResponse]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SearchResponse copyWith({
    String? query,
    List<_imxb4b9a.SearchItem>? items,
    int? totalCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SearchResponse',
      'query': query,
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'totalCount': totalCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SearchResponse',
      'query': query,
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalCount': totalCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _SearchResponseImpl extends SearchResponse {
  _SearchResponseImpl({
    required String query,
    required List<_imxb4b9a.SearchItem> items,
    required int totalCount,
  }) : super._(
         query: query,
         items: items,
         totalCount: totalCount,
       );

  /// Returns a shallow copy of this [SearchResponse]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SearchResponse copyWith({
    String? query,
    List<_imxb4b9a.SearchItem>? items,
    int? totalCount,
  }) {
    return SearchResponse(
      query: query ?? this.query,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
