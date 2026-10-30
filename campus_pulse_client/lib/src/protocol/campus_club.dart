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

abstract class CampusClub
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CampusClub._({
    this.id,
    required this.name,
    required this.tagline,
    required this.category,
    required this.description,
    this.logoUrl,
    required this.leadName,
    required this.leadEmail,
    required this.techTeamLead,
    required this.techTeamEmail,
    required this.managementLead,
    required this.managementEmail,
    int? membersCount,
    bool? recruitmentOpen,
    this.meetingSchedule,
    DateTime? createdAt,
  }) : membersCount = membersCount ?? 0,
       recruitmentOpen = recruitmentOpen ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory CampusClub({
    int? id,
    required String name,
    required String tagline,
    required String category,
    required String description,
    String? logoUrl,
    required String leadName,
    required String leadEmail,
    required String techTeamLead,
    required String techTeamEmail,
    required String managementLead,
    required String managementEmail,
    int? membersCount,
    bool? recruitmentOpen,
    String? meetingSchedule,
    DateTime? createdAt,
  }) = _CampusClubImpl;

  factory CampusClub.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusClub(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      tagline: jsonSerialization['tagline'] as String,
      category: jsonSerialization['category'] as String,
      description: jsonSerialization['description'] as String,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      leadName: jsonSerialization['leadName'] as String,
      leadEmail: jsonSerialization['leadEmail'] as String,
      techTeamLead: jsonSerialization['techTeamLead'] as String,
      techTeamEmail: jsonSerialization['techTeamEmail'] as String,
      managementLead: jsonSerialization['managementLead'] as String,
      managementEmail: jsonSerialization['managementEmail'] as String,
      membersCount: jsonSerialization['membersCount'] as int?,
      recruitmentOpen: jsonSerialization['recruitmentOpen'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['recruitmentOpen'],
            ),
      meetingSchedule: jsonSerialization['meetingSchedule'] as String?,
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

  String tagline;

  String category;

  String description;

  String? logoUrl;

  String leadName;

  String leadEmail;

  String techTeamLead;

  String techTeamEmail;

  String managementLead;

  String managementEmail;

  int membersCount;

  bool recruitmentOpen;

  String? meetingSchedule;

  DateTime createdAt;

  /// Returns a shallow copy of this [CampusClub]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CampusClub copyWith({
    int? id,
    String? name,
    String? tagline,
    String? category,
    String? description,
    String? logoUrl,
    String? leadName,
    String? leadEmail,
    String? techTeamLead,
    String? techTeamEmail,
    String? managementLead,
    String? managementEmail,
    int? membersCount,
    bool? recruitmentOpen,
    String? meetingSchedule,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusClub',
      if (id != null) 'id': id,
      'name': name,
      'tagline': tagline,
      'category': category,
      'description': description,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'leadName': leadName,
      'leadEmail': leadEmail,
      'techTeamLead': techTeamLead,
      'techTeamEmail': techTeamEmail,
      'managementLead': managementLead,
      'managementEmail': managementEmail,
      'membersCount': membersCount,
      'recruitmentOpen': recruitmentOpen,
      if (meetingSchedule != null) 'meetingSchedule': meetingSchedule,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusClub',
      if (id != null) 'id': id,
      'name': name,
      'tagline': tagline,
      'category': category,
      'description': description,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'leadName': leadName,
      'leadEmail': leadEmail,
      'techTeamLead': techTeamLead,
      'techTeamEmail': techTeamEmail,
      'managementLead': managementLead,
      'managementEmail': managementEmail,
      'membersCount': membersCount,
      'recruitmentOpen': recruitmentOpen,
      if (meetingSchedule != null) 'meetingSchedule': meetingSchedule,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusClubImpl extends CampusClub {
  _CampusClubImpl({
    int? id,
    required String name,
    required String tagline,
    required String category,
    required String description,
    String? logoUrl,
    required String leadName,
    required String leadEmail,
    required String techTeamLead,
    required String techTeamEmail,
    required String managementLead,
    required String managementEmail,
    int? membersCount,
    bool? recruitmentOpen,
    String? meetingSchedule,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         tagline: tagline,
         category: category,
         description: description,
         logoUrl: logoUrl,
         leadName: leadName,
         leadEmail: leadEmail,
         techTeamLead: techTeamLead,
         techTeamEmail: techTeamEmail,
         managementLead: managementLead,
         managementEmail: managementEmail,
         membersCount: membersCount,
         recruitmentOpen: recruitmentOpen,
         meetingSchedule: meetingSchedule,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CampusClub]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CampusClub copyWith({
    Object? id = _Undefined,
    String? name,
    String? tagline,
    String? category,
    String? description,
    Object? logoUrl = _Undefined,
    String? leadName,
    String? leadEmail,
    String? techTeamLead,
    String? techTeamEmail,
    String? managementLead,
    String? managementEmail,
    int? membersCount,
    bool? recruitmentOpen,
    Object? meetingSchedule = _Undefined,
    DateTime? createdAt,
  }) {
    return CampusClub(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      category: category ?? this.category,
      description: description ?? this.description,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      leadName: leadName ?? this.leadName,
      leadEmail: leadEmail ?? this.leadEmail,
      techTeamLead: techTeamLead ?? this.techTeamLead,
      techTeamEmail: techTeamEmail ?? this.techTeamEmail,
      managementLead: managementLead ?? this.managementLead,
      managementEmail: managementEmail ?? this.managementEmail,
      membersCount: membersCount ?? this.membersCount,
      recruitmentOpen: recruitmentOpen ?? this.recruitmentOpen,
      meetingSchedule: meetingSchedule is String?
          ? meetingSchedule
          : this.meetingSchedule,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
