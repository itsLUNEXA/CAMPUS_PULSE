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

abstract class Rsvp
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Rsvp._({
    this.id,
    required this.studentId,
    required this.eventId,
  });

  factory Rsvp({
    int? id,
    required int studentId,
    required int eventId,
  }) = _RsvpImpl;

  factory Rsvp.fromJson(Map<String, dynamic> jsonSerialization) {
    return Rsvp(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      eventId: jsonSerialization['eventId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int studentId;

  int eventId;

  /// Returns a shallow copy of this [Rsvp]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Rsvp copyWith({
    int? id,
    int? studentId,
    int? eventId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Rsvp',
      if (id != null) 'id': id,
      'studentId': studentId,
      'eventId': eventId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Rsvp',
      if (id != null) 'id': id,
      'studentId': studentId,
      'eventId': eventId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RsvpImpl extends Rsvp {
  _RsvpImpl({
    int? id,
    required int studentId,
    required int eventId,
  }) : super._(
          id: id,
          studentId: studentId,
          eventId: eventId,
        );

  /// Returns a shallow copy of this [Rsvp]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Rsvp copyWith({
    Object? id = _Undefined,
    int? studentId,
    int? eventId,
  }) {
    return Rsvp(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      eventId: eventId ?? this.eventId,
    );
  }
}
