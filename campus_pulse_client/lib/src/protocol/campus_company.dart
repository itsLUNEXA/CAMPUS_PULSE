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

abstract class CampusCompany
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CampusCompany._({
    this.id,
    required this.name,
    required this.tier,
    required this.avgPackageLpa,
    required this.eligibleBranches,
    required this.cgpaCutoff,
    required this.hiringRounds,
    required this.keyFocusAreas,
    required this.description,
    this.logoUrl,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CampusCompany({
    int? id,
    required String name,
    required String tier,
    required double avgPackageLpa,
    required List<String> eligibleBranches,
    required double cgpaCutoff,
    required List<String> hiringRounds,
    required List<String> keyFocusAreas,
    required String description,
    String? logoUrl,
    DateTime? createdAt,
  }) = _CampusCompanyImpl;

  factory CampusCompany.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusCompany(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      tier: jsonSerialization['tier'] as String,
      avgPackageLpa: (jsonSerialization['avgPackageLpa'] as num).toDouble(),
      eligibleBranches: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['eligibleBranches'],
      ),
      cgpaCutoff: (jsonSerialization['cgpaCutoff'] as num).toDouble(),
      hiringRounds: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['hiringRounds'],
      ),
      keyFocusAreas: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['keyFocusAreas'],
      ),
      description: jsonSerialization['description'] as String,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String tier;

  double avgPackageLpa;

  List<String> eligibleBranches;

  double cgpaCutoff;

  List<String> hiringRounds;

  List<String> keyFocusAreas;

  String description;

  String? logoUrl;

  DateTime createdAt;

  /// Returns a shallow copy of this [CampusCompany]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CampusCompany copyWith({
    int? id,
    String? name,
    String? tier,
    double? avgPackageLpa,
    List<String>? eligibleBranches,
    double? cgpaCutoff,
    List<String>? hiringRounds,
    List<String>? keyFocusAreas,
    String? description,
    String? logoUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusCompany',
      if (id != null) 'id': id,
      'name': name,
      'tier': tier,
      'avgPackageLpa': avgPackageLpa,
      'eligibleBranches': eligibleBranches.toJson(),
      'cgpaCutoff': cgpaCutoff,
      'hiringRounds': hiringRounds.toJson(),
      'keyFocusAreas': keyFocusAreas.toJson(),
      'description': description,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusCompany',
      if (id != null) 'id': id,
      'name': name,
      'tier': tier,
      'avgPackageLpa': avgPackageLpa,
      'eligibleBranches': eligibleBranches.toJson(),
      'cgpaCutoff': cgpaCutoff,
      'hiringRounds': hiringRounds.toJson(),
      'keyFocusAreas': keyFocusAreas.toJson(),
      'description': description,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusCompanyImpl extends CampusCompany {
  _CampusCompanyImpl({
    int? id,
    required String name,
    required String tier,
    required double avgPackageLpa,
    required List<String> eligibleBranches,
    required double cgpaCutoff,
    required List<String> hiringRounds,
    required List<String> keyFocusAreas,
    required String description,
    String? logoUrl,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         tier: tier,
         avgPackageLpa: avgPackageLpa,
         eligibleBranches: eligibleBranches,
         cgpaCutoff: cgpaCutoff,
         hiringRounds: hiringRounds,
         keyFocusAreas: keyFocusAreas,
         description: description,
         logoUrl: logoUrl,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CampusCompany]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CampusCompany copyWith({
    Object? id = _Undefined,
    String? name,
    String? tier,
    double? avgPackageLpa,
    List<String>? eligibleBranches,
    double? cgpaCutoff,
    List<String>? hiringRounds,
    List<String>? keyFocusAreas,
    String? description,
    Object? logoUrl = _Undefined,
    DateTime? createdAt,
  }) {
    return CampusCompany(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      tier: tier ?? this.tier,
      avgPackageLpa: avgPackageLpa ?? this.avgPackageLpa,
      eligibleBranches:
          eligibleBranches ?? this.eligibleBranches.map((e0) => e0).toList(),
      cgpaCutoff: cgpaCutoff ?? this.cgpaCutoff,
      hiringRounds: hiringRounds ?? this.hiringRounds.map((e0) => e0).toList(),
      keyFocusAreas:
          keyFocusAreas ?? this.keyFocusAreas.map((e0) => e0).toList(),
      description: description ?? this.description,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
