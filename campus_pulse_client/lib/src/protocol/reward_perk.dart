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

abstract class RewardPerk
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardPerk._({
    this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.costPoints,
    required this.stockRemaining,
    this.imageUrl,
    bool? isActive,
    DateTime? createdAt,
  }) : isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory RewardPerk({
    int? id,
    required String title,
    required String category,
    required String description,
    required int costPoints,
    required int stockRemaining,
    String? imageUrl,
    bool? isActive,
    DateTime? createdAt,
  }) = _RewardPerkImpl;

  factory RewardPerk.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardPerk(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      category: jsonSerialization['category'] as String,
      description: jsonSerialization['description'] as String,
      costPoints: jsonSerialization['costPoints'] as int,
      stockRemaining: jsonSerialization['stockRemaining'] as int,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String category;

  String description;

  int costPoints;

  int stockRemaining;

  String? imageUrl;

  bool isActive;

  DateTime createdAt;

  /// Returns a shallow copy of this [RewardPerk]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardPerk copyWith({
    int? id,
    String? title,
    String? category,
    String? description,
    int? costPoints,
    int? stockRemaining,
    String? imageUrl,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardPerk',
      if (id != null) 'id': id,
      'title': title,
      'category': category,
      'description': description,
      'costPoints': costPoints,
      'stockRemaining': stockRemaining,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardPerk',
      if (id != null) 'id': id,
      'title': title,
      'category': category,
      'description': description,
      'costPoints': costPoints,
      'stockRemaining': stockRemaining,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardPerkImpl extends RewardPerk {
  _RewardPerkImpl({
    int? id,
    required String title,
    required String category,
    required String description,
    required int costPoints,
    required int stockRemaining,
    String? imageUrl,
    bool? isActive,
    DateTime? createdAt,
  }) : super._(
         id: id,
         title: title,
         category: category,
         description: description,
         costPoints: costPoints,
         stockRemaining: stockRemaining,
         imageUrl: imageUrl,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardPerk]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardPerk copyWith({
    Object? id = _Undefined,
    String? title,
    String? category,
    String? description,
    int? costPoints,
    int? stockRemaining,
    Object? imageUrl = _Undefined,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return RewardPerk(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      costPoints: costPoints ?? this.costPoints,
      stockRemaining: stockRemaining ?? this.stockRemaining,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
