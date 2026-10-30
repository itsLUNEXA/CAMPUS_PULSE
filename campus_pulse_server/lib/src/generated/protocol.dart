/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:campus_pulse_server/src/generated/academic_resource.dart'
    as _ifhojxs8;
import 'package:campus_pulse_server/src/generated/admin_audit_log.dart'
    as _i60whm80;
import 'package:campus_pulse_server/src/generated/attendance_record.dart'
    as _i4oe753t;
import 'package:campus_pulse_server/src/generated/campus_event.dart'
    as _iw7ccsb7;
import 'package:campus_pulse_server/src/generated/chat_message.dart'
    as _iit1n394;
import 'package:campus_pulse_server/src/generated/chat_room.dart' as _i787pbkv;
import 'package:campus_pulse_server/src/generated/event_certificate.dart'
    as _iii6sj61;
import 'package:campus_pulse_server/src/generated/leaderboard_entry.dart'
    as _izc9hvlj;
import 'package:campus_pulse_server/src/generated/minutes_of_meeting.dart'
    as _iecchb3j;
import 'package:campus_pulse_server/src/generated/quiz_attempt.dart'
    as _ii6cu1i5;
import 'package:campus_pulse_server/src/generated/quiz_question_view.dart'
    as _izqbs8j4;
import 'package:campus_pulse_server/src/generated/reward_perk.dart'
    as _i5apij9o;
import 'package:campus_pulse_server/src/generated/section_timetable.dart'
    as _i6o9odyo;
import 'package:campus_pulse_server/src/generated/student_free_slot.dart'
    as _iegmdz27;
import 'package:campus_pulse_server/src/generated/student_profile.dart'
    as _iyr83ylc;
import 'package:campus_pulse_server/src/generated/study_request.dart'
    as _i7nx4e5a;
import 'package:campus_pulse_server/src/generated/syllabus_node.dart'
    as _i2fq24ew;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'academic_resource.dart' as _if13xk5x;
import 'admin_audit_log.dart' as _ihc3ja42;
import 'attendance_record.dart' as _ixvdsmvt;
import 'campus_event.dart' as _ieh998j0;
import 'campus_notification.dart' as _ik9ino7k;
import 'chat_message.dart' as _ivuncx2e;
import 'chat_room.dart' as _i860mpd8;
import 'contact_message.dart' as _itkhxrdg;
import 'event_certificate.dart' as _i18h4dy9;
import 'event_rsvp.dart' as _it1gnu2n;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'leaderboard_entry.dart' as _ikawkn1p;
import 'leaderboard_update.dart' as _ivs2wzhx;
import 'minutes_of_meeting.dart' as _i25xzg8r;
import 'points_ledger.dart' as _ihcqna09;
import 'quiz_answer_submission.dart' as _icbmbpey;
import 'quiz_attempt.dart' as _ibhufrza;
import 'quiz_question.dart' as _i6b38qpb;
import 'quiz_question_view.dart' as _iuqiaozg;
import 'quiz_result_item.dart' as _i1u2fv9w;
import 'quiz_result_summary.dart' as _i9iv9tss;
import 'quiz_submission.dart' as _i689tsk4;
import 'reward_perk.dart' as _izr2b0i4;
import 'rsvp_update.dart' as _i9l2hi6q;
import 'search_item.dart' as _imxb4b9a;
import 'search_response.dart' as _iz2tuvmq;
import 'section_timetable.dart' as _iyrk4e0o;
import 'student_free_slot.dart' as _i76e3tnf;
import 'student_profile.dart' as _iovtxv26;
import 'study_request.dart' as _i2p0wucy;
import 'syllabus_node.dart' as _ihtod3tm;
import 'user_role.dart' as _ir0y0iu6;
export 'academic_resource.dart';
export 'admin_audit_log.dart';
export 'attendance_record.dart';
export 'campus_event.dart';
export 'campus_notification.dart';
export 'chat_message.dart';
export 'chat_room.dart';
export 'contact_message.dart';
export 'event_certificate.dart';
export 'event_rsvp.dart';
export 'greetings/greeting.dart';
export 'leaderboard_entry.dart';
export 'leaderboard_update.dart';
export 'minutes_of_meeting.dart';
export 'points_ledger.dart';
export 'quiz_answer_submission.dart';
export 'quiz_attempt.dart';
export 'quiz_question.dart';
export 'quiz_question_view.dart';
export 'quiz_result_item.dart';
export 'quiz_result_summary.dart';
export 'quiz_submission.dart';
export 'reward_perk.dart';
export 'rsvp_update.dart';
export 'search_item.dart';
export 'search_response.dart';
export 'section_timetable.dart';
export 'student_free_slot.dart';
export 'student_profile.dart';
export 'study_request.dart';
export 'syllabus_node.dart';
export 'user_role.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'academic_resource',
      dartName: 'AcademicResource',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'university',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'course',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'branch',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'academicYear',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'semester',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'subjectCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'subjectName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'unitNumber',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'resourceType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'fileUrl',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'fileSize',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'uploadedByUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'uploaderName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isApproved',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'approvedByUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'downloadCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'resource_filter_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'university',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'course',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'branch',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'semester',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'subjectCode',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'resource_approval_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'isApproved',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'admin_audit_log',
      dartName: 'AdminAuditLog',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'actorUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'actorName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'actionType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetEntity',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'details',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'timestamp',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'audit_time_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'timestamp',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'attendance_record',
      dartName: 'AttendanceRecord',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'studentName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'checkInCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'markedByUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'markedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'attendance_record_fk_0',
          columns: ['eventId'],
          referenceTable: 'campus_event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'event_attendance_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'attendance_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'campus_event',
      dartName: 'CampusEvent',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'startTime',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'endTime',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'venue',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'bannerUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'organizerAuthUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'organizerName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'rsvpCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'event_category_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'category',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'event_start_time_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'startTime',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'chat_message',
      dartName: 'ChatMessage',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'senderUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'senderName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'content',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'attachmentUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'attachmentType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'isRead',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'isEdited',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'chat_message_fk_0',
          columns: ['roomId'],
          referenceTable: 'chat_room',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'msg_room_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'roomId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'chat_room',
      dartName: 'ChatRoom',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'referenceId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'participantIds',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<UuidValue>',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'lastMessageText',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'lastMessageAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'room_type_ref_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'roomType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'contact_message',
      dartName: 'ContactMessage',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'subject',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'contact_message_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'event_certificate',
      dartName: 'EventCertificate',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'certificateId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'studentName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'eventName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'eventDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'issuedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'issuedByUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'verificationUrl',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'signatureTitle',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'event_certificate_fk_0',
          columns: ['eventId'],
          referenceTable: 'campus_event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'event_certificate__certificateId__unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'certificateId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'cert_unique_id_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'certificateId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'cert_event_student_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'cert_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'event_rsvp',
      dartName: 'EventRsvp',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'studentName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'event_rsvp_fk_0',
          columns: ['eventId'],
          referenceTable: 'campus_event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'event_student_rsvp_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'rsvp_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'minutes_of_meeting',
      dartName: 'MinutesOfMeeting',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'meetingDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'organizerUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'organizerName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'attendeeNames',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'agenda',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'discussionPoints',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'decisions',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'actionItems',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'mom_date_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'meetingDate',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'points_ledger',
      dartName: 'PointsLedger',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'studentName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'points',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'timestamp',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'ledger_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'timestamp',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'quiz_attempt',
      dartName: 'QuizAttempt',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'studentName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'studentBranch',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'subject',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'score',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'totalQuestions',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'percentage',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'durationSeconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'completedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'quiz_attempt_subject_score_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'subject',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'score',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'quiz_attempt_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'quiz_question',
      dartName: 'QuizQuestion',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'subject',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'question',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'options',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'correctOptionIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'explanation',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'difficulty',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'quiz_question_subject_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'subject',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'reward_perks',
      dartName: 'RewardPerk',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'costPoints',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'stockRemaining',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'imageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'isActive',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'reward_active_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'section_timetables',
      dartName: 'SectionTimetable',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'branch',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'academicYear',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'semester',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'section',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'dayOfWeek',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'startTime',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'endTime',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'subject',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'room',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'section_schedule_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'branch',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'semester',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'section',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'dayOfWeek',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'student_free_slots',
      dartName: 'StudentFreeSlot',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'dayOfWeek',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'slotLabel',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'startTime',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'endTime',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isFree',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'student_slot_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'dayOfWeek',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'slotLabel',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_free_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'student_profile',
      dartName: 'StudentProfile',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'fullName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'branch',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'academicYear',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'hostelOrArea',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'bio',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'subjectInterests',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'student_profile__authUserId__unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_profile__email__unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_branch_year_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'branch',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'academicYear',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'study_request',
      dartName: 'StudyRequest',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'senderAuthUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'senderName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'senderBranch',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'senderYear',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'recipientAuthUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'recipientName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'subject',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'urgency',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'study_request_sender_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'senderAuthUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'study_request_recipient_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'recipientAuthUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'study_request_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'syllabus_node',
      dartName: 'SyllabusNode',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'university',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'course',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'branch',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'semester',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'subjectCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'subjectName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'unitNumber',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'unitTitle',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'topics',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'academicYear',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'syllabus_hierarchy_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'university',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'course',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'branch',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'semester',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'subjectCode',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'unitNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'user_role',
      dartName: 'UserRole',
      schema: 'public',
      module: 'campus_pulse',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'assignedScope',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'user_role_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'role',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _if13xk5x.AcademicResource) {
      return _if13xk5x.AcademicResource.fromJson(data) as T;
    }
    if (t == _ihc3ja42.AdminAuditLog) {
      return _ihc3ja42.AdminAuditLog.fromJson(data) as T;
    }
    if (t == _ixvdsmvt.AttendanceRecord) {
      return _ixvdsmvt.AttendanceRecord.fromJson(data) as T;
    }
    if (t == _ieh998j0.CampusEvent) {
      return _ieh998j0.CampusEvent.fromJson(data) as T;
    }
    if (t == _ik9ino7k.CampusNotification) {
      return _ik9ino7k.CampusNotification.fromJson(data) as T;
    }
    if (t == _ivuncx2e.ChatMessage) {
      return _ivuncx2e.ChatMessage.fromJson(data) as T;
    }
    if (t == _i860mpd8.ChatRoom) {
      return _i860mpd8.ChatRoom.fromJson(data) as T;
    }
    if (t == _itkhxrdg.ContactMessage) {
      return _itkhxrdg.ContactMessage.fromJson(data) as T;
    }
    if (t == _i18h4dy9.EventCertificate) {
      return _i18h4dy9.EventCertificate.fromJson(data) as T;
    }
    if (t == _it1gnu2n.EventRsvp) {
      return _it1gnu2n.EventRsvp.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _ikawkn1p.LeaderboardEntry) {
      return _ikawkn1p.LeaderboardEntry.fromJson(data) as T;
    }
    if (t == _ivs2wzhx.LeaderboardUpdate) {
      return _ivs2wzhx.LeaderboardUpdate.fromJson(data) as T;
    }
    if (t == _i25xzg8r.MinutesOfMeeting) {
      return _i25xzg8r.MinutesOfMeeting.fromJson(data) as T;
    }
    if (t == _ihcqna09.PointsLedger) {
      return _ihcqna09.PointsLedger.fromJson(data) as T;
    }
    if (t == _icbmbpey.QuizAnswerSubmission) {
      return _icbmbpey.QuizAnswerSubmission.fromJson(data) as T;
    }
    if (t == _ibhufrza.QuizAttempt) {
      return _ibhufrza.QuizAttempt.fromJson(data) as T;
    }
    if (t == _i6b38qpb.QuizQuestion) {
      return _i6b38qpb.QuizQuestion.fromJson(data) as T;
    }
    if (t == _iuqiaozg.QuizQuestionView) {
      return _iuqiaozg.QuizQuestionView.fromJson(data) as T;
    }
    if (t == _i1u2fv9w.QuizResultItem) {
      return _i1u2fv9w.QuizResultItem.fromJson(data) as T;
    }
    if (t == _i9iv9tss.QuizResultSummary) {
      return _i9iv9tss.QuizResultSummary.fromJson(data) as T;
    }
    if (t == _i689tsk4.QuizSubmission) {
      return _i689tsk4.QuizSubmission.fromJson(data) as T;
    }
    if (t == _izr2b0i4.RewardPerk) {
      return _izr2b0i4.RewardPerk.fromJson(data) as T;
    }
    if (t == _i9l2hi6q.RsvpUpdate) {
      return _i9l2hi6q.RsvpUpdate.fromJson(data) as T;
    }
    if (t == _imxb4b9a.SearchItem) {
      return _imxb4b9a.SearchItem.fromJson(data) as T;
    }
    if (t == _iz2tuvmq.SearchResponse) {
      return _iz2tuvmq.SearchResponse.fromJson(data) as T;
    }
    if (t == _iyrk4e0o.SectionTimetable) {
      return _iyrk4e0o.SectionTimetable.fromJson(data) as T;
    }
    if (t == _i76e3tnf.StudentFreeSlot) {
      return _i76e3tnf.StudentFreeSlot.fromJson(data) as T;
    }
    if (t == _iovtxv26.StudentProfile) {
      return _iovtxv26.StudentProfile.fromJson(data) as T;
    }
    if (t == _i2p0wucy.StudyRequest) {
      return _i2p0wucy.StudyRequest.fromJson(data) as T;
    }
    if (t == _ihtod3tm.SyllabusNode) {
      return _ihtod3tm.SyllabusNode.fromJson(data) as T;
    }
    if (t == _ir0y0iu6.UserRole) {
      return _ir0y0iu6.UserRole.fromJson(data) as T;
    }
    if (t == _is.getType<_if13xk5x.AcademicResource?>()) {
      return (data != null ? _if13xk5x.AcademicResource.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihc3ja42.AdminAuditLog?>()) {
      return (data != null ? _ihc3ja42.AdminAuditLog.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixvdsmvt.AttendanceRecord?>()) {
      return (data != null ? _ixvdsmvt.AttendanceRecord.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ieh998j0.CampusEvent?>()) {
      return (data != null ? _ieh998j0.CampusEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ik9ino7k.CampusNotification?>()) {
      return (data != null ? _ik9ino7k.CampusNotification.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivuncx2e.ChatMessage?>()) {
      return (data != null ? _ivuncx2e.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i860mpd8.ChatRoom?>()) {
      return (data != null ? _i860mpd8.ChatRoom.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itkhxrdg.ContactMessage?>()) {
      return (data != null ? _itkhxrdg.ContactMessage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i18h4dy9.EventCertificate?>()) {
      return (data != null ? _i18h4dy9.EventCertificate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_it1gnu2n.EventRsvp?>()) {
      return (data != null ? _it1gnu2n.EventRsvp.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikawkn1p.LeaderboardEntry?>()) {
      return (data != null ? _ikawkn1p.LeaderboardEntry.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivs2wzhx.LeaderboardUpdate?>()) {
      return (data != null ? _ivs2wzhx.LeaderboardUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i25xzg8r.MinutesOfMeeting?>()) {
      return (data != null ? _i25xzg8r.MinutesOfMeeting.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihcqna09.PointsLedger?>()) {
      return (data != null ? _ihcqna09.PointsLedger.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_icbmbpey.QuizAnswerSubmission?>()) {
      return (data != null
              ? _icbmbpey.QuizAnswerSubmission.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ibhufrza.QuizAttempt?>()) {
      return (data != null ? _ibhufrza.QuizAttempt.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i6b38qpb.QuizQuestion?>()) {
      return (data != null ? _i6b38qpb.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iuqiaozg.QuizQuestionView?>()) {
      return (data != null ? _iuqiaozg.QuizQuestionView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i1u2fv9w.QuizResultItem?>()) {
      return (data != null ? _i1u2fv9w.QuizResultItem.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9iv9tss.QuizResultSummary?>()) {
      return (data != null ? _i9iv9tss.QuizResultSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i689tsk4.QuizSubmission?>()) {
      return (data != null ? _i689tsk4.QuizSubmission.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izr2b0i4.RewardPerk?>()) {
      return (data != null ? _izr2b0i4.RewardPerk.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i9l2hi6q.RsvpUpdate?>()) {
      return (data != null ? _i9l2hi6q.RsvpUpdate.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_imxb4b9a.SearchItem?>()) {
      return (data != null ? _imxb4b9a.SearchItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iz2tuvmq.SearchResponse?>()) {
      return (data != null ? _iz2tuvmq.SearchResponse.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iyrk4e0o.SectionTimetable?>()) {
      return (data != null ? _iyrk4e0o.SectionTimetable.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i76e3tnf.StudentFreeSlot?>()) {
      return (data != null ? _i76e3tnf.StudentFreeSlot.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iovtxv26.StudentProfile?>()) {
      return (data != null ? _iovtxv26.StudentProfile.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i2p0wucy.StudyRequest?>()) {
      return (data != null ? _i2p0wucy.StudyRequest.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ihtod3tm.SyllabusNode?>()) {
      return (data != null ? _ihtod3tm.SyllabusNode.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ir0y0iu6.UserRole?>()) {
      return (data != null ? _ir0y0iu6.UserRole.fromJson(data) : null) as T;
    }
    if (t == List<_is.UuidValue>) {
      return (data as List).map((e) => deserialize<_is.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i1u2fv9w.QuizResultItem>) {
      return (data as List)
              .map((e) => deserialize<_i1u2fv9w.QuizResultItem>(e))
              .toList()
          as T;
    }
    if (t == List<_icbmbpey.QuizAnswerSubmission>) {
      return (data as List)
              .map((e) => deserialize<_icbmbpey.QuizAnswerSubmission>(e))
              .toList()
          as T;
    }
    if (t == List<_imxb4b9a.SearchItem>) {
      return (data as List)
              .map((e) => deserialize<_imxb4b9a.SearchItem>(e))
              .toList()
          as T;
    }
    if (t == List<_ifhojxs8.AcademicResource>) {
      return (data as List)
              .map((e) => deserialize<_ifhojxs8.AcademicResource>(e))
              .toList()
          as T;
    }
    if (t == List<_i2fq24ew.SyllabusNode>) {
      return (data as List)
              .map((e) => deserialize<_i2fq24ew.SyllabusNode>(e))
              .toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i60whm80.AdminAuditLog>) {
      return (data as List)
              .map((e) => deserialize<_i60whm80.AdminAuditLog>(e))
              .toList()
          as T;
    }
    if (t == List<_i4oe753t.AttendanceRecord>) {
      return (data as List)
              .map((e) => deserialize<_i4oe753t.AttendanceRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_iii6sj61.EventCertificate>) {
      return (data as List)
              .map((e) => deserialize<_iii6sj61.EventCertificate>(e))
              .toList()
          as T;
    }
    if (t == List<_is.UuidValue>) {
      return (data as List).map((e) => deserialize<_is.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_iit1n394.ChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_iit1n394.ChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i787pbkv.ChatRoom>) {
      return (data as List)
              .map((e) => deserialize<_i787pbkv.ChatRoom>(e))
              .toList()
          as T;
    }
    if (t == List<_iw7ccsb7.CampusEvent>) {
      return (data as List)
              .map((e) => deserialize<_iw7ccsb7.CampusEvent>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_izc9hvlj.LeaderboardEntry>) {
      return (data as List)
              .map((e) => deserialize<_izc9hvlj.LeaderboardEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_iecchb3j.MinutesOfMeeting>) {
      return (data as List)
              .map((e) => deserialize<_iecchb3j.MinutesOfMeeting>(e))
              .toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == dynamic) {
      return deserializeDynamicFieldValue(data) as T;
    }
    if (t == List<_i5apij9o.RewardPerk>) {
      return (data as List)
              .map((e) => deserialize<_i5apij9o.RewardPerk>(e))
              .toList()
          as T;
    }
    if (t == List<_izqbs8j4.QuizQuestionView>) {
      return (data as List)
              .map((e) => deserialize<_izqbs8j4.QuizQuestionView>(e))
              .toList()
          as T;
    }
    if (t == List<_ii6cu1i5.QuizAttempt>) {
      return (data as List)
              .map((e) => deserialize<_ii6cu1i5.QuizAttempt>(e))
              .toList()
          as T;
    }
    if (t == List<_iyr83ylc.StudentProfile>) {
      return (data as List)
              .map((e) => deserialize<_iyr83ylc.StudentProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i7nx4e5a.StudyRequest>) {
      return (data as List)
              .map((e) => deserialize<_i7nx4e5a.StudyRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i6o9odyo.SectionTimetable>) {
      return (data as List)
              .map((e) => deserialize<_i6o9odyo.SectionTimetable>(e))
              .toList()
          as T;
    }
    if (t == List<_iegmdz27.StudentFreeSlot>) {
      return (data as List)
              .map((e) => deserialize<_iegmdz27.StudentFreeSlot>(e))
              .toList()
          as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, dynamic>>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _if13xk5x.AcademicResource => 'AcademicResource',
      _ihc3ja42.AdminAuditLog => 'AdminAuditLog',
      _ixvdsmvt.AttendanceRecord => 'AttendanceRecord',
      _ieh998j0.CampusEvent => 'CampusEvent',
      _ik9ino7k.CampusNotification => 'CampusNotification',
      _ivuncx2e.ChatMessage => 'ChatMessage',
      _i860mpd8.ChatRoom => 'ChatRoom',
      _itkhxrdg.ContactMessage => 'ContactMessage',
      _i18h4dy9.EventCertificate => 'EventCertificate',
      _it1gnu2n.EventRsvp => 'EventRsvp',
      _izw8z7ou.Greeting => 'Greeting',
      _ikawkn1p.LeaderboardEntry => 'LeaderboardEntry',
      _ivs2wzhx.LeaderboardUpdate => 'LeaderboardUpdate',
      _i25xzg8r.MinutesOfMeeting => 'MinutesOfMeeting',
      _ihcqna09.PointsLedger => 'PointsLedger',
      _icbmbpey.QuizAnswerSubmission => 'QuizAnswerSubmission',
      _ibhufrza.QuizAttempt => 'QuizAttempt',
      _i6b38qpb.QuizQuestion => 'QuizQuestion',
      _iuqiaozg.QuizQuestionView => 'QuizQuestionView',
      _i1u2fv9w.QuizResultItem => 'QuizResultItem',
      _i9iv9tss.QuizResultSummary => 'QuizResultSummary',
      _i689tsk4.QuizSubmission => 'QuizSubmission',
      _izr2b0i4.RewardPerk => 'RewardPerk',
      _i9l2hi6q.RsvpUpdate => 'RsvpUpdate',
      _imxb4b9a.SearchItem => 'SearchItem',
      _iz2tuvmq.SearchResponse => 'SearchResponse',
      _iyrk4e0o.SectionTimetable => 'SectionTimetable',
      _i76e3tnf.StudentFreeSlot => 'StudentFreeSlot',
      _iovtxv26.StudentProfile => 'StudentProfile',
      _i2p0wucy.StudyRequest => 'StudyRequest',
      _ihtod3tm.SyllabusNode => 'SyllabusNode',
      _ir0y0iu6.UserRole => 'UserRole',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'campus_pulse.',
        '',
      );
    }

    switch (data) {
      case _if13xk5x.AcademicResource():
        return 'AcademicResource';
      case _ihc3ja42.AdminAuditLog():
        return 'AdminAuditLog';
      case _ixvdsmvt.AttendanceRecord():
        return 'AttendanceRecord';
      case _ieh998j0.CampusEvent():
        return 'CampusEvent';
      case _ik9ino7k.CampusNotification():
        return 'CampusNotification';
      case _ivuncx2e.ChatMessage():
        return 'ChatMessage';
      case _i860mpd8.ChatRoom():
        return 'ChatRoom';
      case _itkhxrdg.ContactMessage():
        return 'ContactMessage';
      case _i18h4dy9.EventCertificate():
        return 'EventCertificate';
      case _it1gnu2n.EventRsvp():
        return 'EventRsvp';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _ikawkn1p.LeaderboardEntry():
        return 'LeaderboardEntry';
      case _ivs2wzhx.LeaderboardUpdate():
        return 'LeaderboardUpdate';
      case _i25xzg8r.MinutesOfMeeting():
        return 'MinutesOfMeeting';
      case _ihcqna09.PointsLedger():
        return 'PointsLedger';
      case _icbmbpey.QuizAnswerSubmission():
        return 'QuizAnswerSubmission';
      case _ibhufrza.QuizAttempt():
        return 'QuizAttempt';
      case _i6b38qpb.QuizQuestion():
        return 'QuizQuestion';
      case _iuqiaozg.QuizQuestionView():
        return 'QuizQuestionView';
      case _i1u2fv9w.QuizResultItem():
        return 'QuizResultItem';
      case _i9iv9tss.QuizResultSummary():
        return 'QuizResultSummary';
      case _i689tsk4.QuizSubmission():
        return 'QuizSubmission';
      case _izr2b0i4.RewardPerk():
        return 'RewardPerk';
      case _i9l2hi6q.RsvpUpdate():
        return 'RsvpUpdate';
      case _imxb4b9a.SearchItem():
        return 'SearchItem';
      case _iz2tuvmq.SearchResponse():
        return 'SearchResponse';
      case _iyrk4e0o.SectionTimetable():
        return 'SectionTimetable';
      case _i76e3tnf.StudentFreeSlot():
        return 'StudentFreeSlot';
      case _iovtxv26.StudentProfile():
        return 'StudentProfile';
      case _i2p0wucy.StudyRequest():
        return 'StudyRequest';
      case _ihtod3tm.SyllabusNode():
        return 'SyllabusNode';
      case _ir0y0iu6.UserRole():
        return 'UserRole';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AcademicResource') {
      return deserialize<_if13xk5x.AcademicResource>(data['data']);
    }
    if (dataClassName == 'AdminAuditLog') {
      return deserialize<_ihc3ja42.AdminAuditLog>(data['data']);
    }
    if (dataClassName == 'AttendanceRecord') {
      return deserialize<_ixvdsmvt.AttendanceRecord>(data['data']);
    }
    if (dataClassName == 'CampusEvent') {
      return deserialize<_ieh998j0.CampusEvent>(data['data']);
    }
    if (dataClassName == 'CampusNotification') {
      return deserialize<_ik9ino7k.CampusNotification>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_ivuncx2e.ChatMessage>(data['data']);
    }
    if (dataClassName == 'ChatRoom') {
      return deserialize<_i860mpd8.ChatRoom>(data['data']);
    }
    if (dataClassName == 'ContactMessage') {
      return deserialize<_itkhxrdg.ContactMessage>(data['data']);
    }
    if (dataClassName == 'EventCertificate') {
      return deserialize<_i18h4dy9.EventCertificate>(data['data']);
    }
    if (dataClassName == 'EventRsvp') {
      return deserialize<_it1gnu2n.EventRsvp>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'LeaderboardEntry') {
      return deserialize<_ikawkn1p.LeaderboardEntry>(data['data']);
    }
    if (dataClassName == 'LeaderboardUpdate') {
      return deserialize<_ivs2wzhx.LeaderboardUpdate>(data['data']);
    }
    if (dataClassName == 'MinutesOfMeeting') {
      return deserialize<_i25xzg8r.MinutesOfMeeting>(data['data']);
    }
    if (dataClassName == 'PointsLedger') {
      return deserialize<_ihcqna09.PointsLedger>(data['data']);
    }
    if (dataClassName == 'QuizAnswerSubmission') {
      return deserialize<_icbmbpey.QuizAnswerSubmission>(data['data']);
    }
    if (dataClassName == 'QuizAttempt') {
      return deserialize<_ibhufrza.QuizAttempt>(data['data']);
    }
    if (dataClassName == 'QuizQuestion') {
      return deserialize<_i6b38qpb.QuizQuestion>(data['data']);
    }
    if (dataClassName == 'QuizQuestionView') {
      return deserialize<_iuqiaozg.QuizQuestionView>(data['data']);
    }
    if (dataClassName == 'QuizResultItem') {
      return deserialize<_i1u2fv9w.QuizResultItem>(data['data']);
    }
    if (dataClassName == 'QuizResultSummary') {
      return deserialize<_i9iv9tss.QuizResultSummary>(data['data']);
    }
    if (dataClassName == 'QuizSubmission') {
      return deserialize<_i689tsk4.QuizSubmission>(data['data']);
    }
    if (dataClassName == 'RewardPerk') {
      return deserialize<_izr2b0i4.RewardPerk>(data['data']);
    }
    if (dataClassName == 'RsvpUpdate') {
      return deserialize<_i9l2hi6q.RsvpUpdate>(data['data']);
    }
    if (dataClassName == 'SearchItem') {
      return deserialize<_imxb4b9a.SearchItem>(data['data']);
    }
    if (dataClassName == 'SearchResponse') {
      return deserialize<_iz2tuvmq.SearchResponse>(data['data']);
    }
    if (dataClassName == 'SectionTimetable') {
      return deserialize<_iyrk4e0o.SectionTimetable>(data['data']);
    }
    if (dataClassName == 'StudentFreeSlot') {
      return deserialize<_i76e3tnf.StudentFreeSlot>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_iovtxv26.StudentProfile>(data['data']);
    }
    if (dataClassName == 'StudyRequest') {
      return deserialize<_i2p0wucy.StudyRequest>(data['data']);
    }
    if (dataClassName == 'SyllabusNode') {
      return deserialize<_ihtod3tm.SyllabusNode>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_ir0y0iu6.UserRole>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('campus_pulse', this);
    _iacs.Protocol().registerHostProtocol('campus_pulse', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _if13xk5x.AcademicResource:
        return _if13xk5x.AcademicResource.t;
      case _ihc3ja42.AdminAuditLog:
        return _ihc3ja42.AdminAuditLog.t;
      case _ixvdsmvt.AttendanceRecord:
        return _ixvdsmvt.AttendanceRecord.t;
      case _ieh998j0.CampusEvent:
        return _ieh998j0.CampusEvent.t;
      case _ivuncx2e.ChatMessage:
        return _ivuncx2e.ChatMessage.t;
      case _i860mpd8.ChatRoom:
        return _i860mpd8.ChatRoom.t;
      case _itkhxrdg.ContactMessage:
        return _itkhxrdg.ContactMessage.t;
      case _i18h4dy9.EventCertificate:
        return _i18h4dy9.EventCertificate.t;
      case _it1gnu2n.EventRsvp:
        return _it1gnu2n.EventRsvp.t;
      case _i25xzg8r.MinutesOfMeeting:
        return _i25xzg8r.MinutesOfMeeting.t;
      case _ihcqna09.PointsLedger:
        return _ihcqna09.PointsLedger.t;
      case _ibhufrza.QuizAttempt:
        return _ibhufrza.QuizAttempt.t;
      case _i6b38qpb.QuizQuestion:
        return _i6b38qpb.QuizQuestion.t;
      case _izr2b0i4.RewardPerk:
        return _izr2b0i4.RewardPerk.t;
      case _iyrk4e0o.SectionTimetable:
        return _iyrk4e0o.SectionTimetable.t;
      case _i76e3tnf.StudentFreeSlot:
        return _i76e3tnf.StudentFreeSlot.t;
      case _iovtxv26.StudentProfile:
        return _iovtxv26.StudentProfile.t;
      case _i2p0wucy.StudyRequest:
        return _i2p0wucy.StudyRequest.t;
      case _ihtod3tm.SyllabusNode:
        return _ihtod3tm.SyllabusNode.t;
      case _ir0y0iu6.UserRole:
        return _ir0y0iu6.UserRole.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'campus_pulse';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
