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

abstract class CampusEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CampusEvent._({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.venue,
    required this.startTime,
    required this.createdBy,
    int? rsvpCount,
  }) : rsvpCount = rsvpCount ?? 0;

  factory CampusEvent({
    int? id,
    required String title,
    required String description,
    required String category,
    required String venue,
    required DateTime startTime,
    required String createdBy,
    int? rsvpCount,
  }) = _CampusEventImpl;

  factory CampusEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusEvent(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: jsonSerialization['category'] as String,
      venue: jsonSerialization['venue'] as String,
      startTime:
          _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startTime']),
      createdBy: jsonSerialization['createdBy'] as String,
      rsvpCount: jsonSerialization['rsvpCount'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String description;

  String category;

  String venue;

  DateTime startTime;

  String createdBy;

  int rsvpCount;

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CampusEvent copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? venue,
    DateTime? startTime,
    String? createdBy,
    int? rsvpCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusEvent',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'category': category,
      'venue': venue,
      'startTime': startTime.toJson(),
      'createdBy': createdBy,
      'rsvpCount': rsvpCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusEvent',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'category': category,
      'venue': venue,
      'startTime': startTime.toJson(),
      'createdBy': createdBy,
      'rsvpCount': rsvpCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusEventImpl extends CampusEvent {
  _CampusEventImpl({
    int? id,
    required String title,
    required String description,
    required String category,
    required String venue,
    required DateTime startTime,
    required String createdBy,
    int? rsvpCount,
  }) : super._(
          id: id,
          title: title,
          description: description,
          category: category,
          venue: venue,
          startTime: startTime,
          createdBy: createdBy,
          rsvpCount: rsvpCount,
        );

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CampusEvent copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    String? category,
    String? venue,
    DateTime? startTime,
    String? createdBy,
    int? rsvpCount,
  }) {
    return CampusEvent(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      venue: venue ?? this.venue,
      startTime: startTime ?? this.startTime,
      createdBy: createdBy ?? this.createdBy,
      rsvpCount: rsvpCount ?? this.rsvpCount,
    );
  }
}
