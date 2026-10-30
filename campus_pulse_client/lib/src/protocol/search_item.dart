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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class SearchItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SearchItem._({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    this.description,
    this.category,
  });

  factory SearchItem({
    required String id,
    required String type,
    required String title,
    required String subtitle,
    String? description,
    String? category,
  }) = _SearchItemImpl;

  factory SearchItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return SearchItem(
      id: jsonSerialization['id'] as String,
      type: jsonSerialization['type'] as String,
      title: jsonSerialization['title'] as String,
      subtitle: jsonSerialization['subtitle'] as String,
      description: jsonSerialization['description'] as String?,
      category: jsonSerialization['category'] as String?,
    );
  }

  String type;

  String id;

  String title;

  String subtitle;

  String? description;

  String? category;

  /// Returns a shallow copy of this [SearchItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SearchItem copyWith({
    String? id,
    String? type,
    String? title,
    String? subtitle,
    String? description,
    String? category,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SearchItem',
      'id': id,
      'type': type,
      'title': title,
      'subtitle': subtitle,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SearchItem',
      'id': id,
      'type': type,
      'title': title,
      'subtitle': subtitle,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SearchItemImpl extends SearchItem {
  _SearchItemImpl({
    required String id,
    required String type,
    required String title,
    required String subtitle,
    String? description,
    String? category,
  }) : super._(
         id: id,
         type: type,
         title: title,
         subtitle: subtitle,
         description: description,
         category: category,
       );

  /// Returns a shallow copy of this [SearchItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SearchItem copyWith({
    String? id,
    String? type,
    String? title,
    String? subtitle,
    Object? description = _Undefined,
    Object? category = _Undefined,
  }) {
    return SearchItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description is String? ? description : this.description,
      category: category is String? ? category : this.category,
    );
  }
}
