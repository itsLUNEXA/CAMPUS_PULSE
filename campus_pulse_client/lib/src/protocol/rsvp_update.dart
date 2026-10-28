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

abstract class RsvpUpdate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RsvpUpdate._({
    required this.eventId,
    required this.rsvpCount,
  });

  factory RsvpUpdate({
    required int eventId,
    required int rsvpCount,
  }) = _RsvpUpdateImpl;

  factory RsvpUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return RsvpUpdate(
      eventId: jsonSerialization['eventId'] as int,
      rsvpCount: jsonSerialization['rsvpCount'] as int,
    );
  }

  int eventId;

  int rsvpCount;

  /// Returns a shallow copy of this [RsvpUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RsvpUpdate copyWith({
    int? eventId,
    int? rsvpCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RsvpUpdate',
      'eventId': eventId,
      'rsvpCount': rsvpCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RsvpUpdate',
      'eventId': eventId,
      'rsvpCount': rsvpCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _RsvpUpdateImpl extends RsvpUpdate {
  _RsvpUpdateImpl({
    required int eventId,
    required int rsvpCount,
  }) : super._(
          eventId: eventId,
          rsvpCount: rsvpCount,
        );

  /// Returns a shallow copy of this [RsvpUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RsvpUpdate copyWith({
    int? eventId,
    int? rsvpCount,
  }) {
    return RsvpUpdate(
      eventId: eventId ?? this.eventId,
      rsvpCount: rsvpCount ?? this.rsvpCount,
    );
  }
}
