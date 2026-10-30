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
import 'package:campus_pulse_client/src/protocol/academic_resource.dart'
    as _id97hjpr;
import 'package:campus_pulse_client/src/protocol/admin_audit_log.dart'
    as _i6e8adep;
import 'package:campus_pulse_client/src/protocol/attendance_record.dart'
    as _id4j1rwr;
import 'package:campus_pulse_client/src/protocol/campus_event.dart'
    as _ip4v6fvs;
import 'package:campus_pulse_client/src/protocol/chat_message.dart'
    as _ik3iv9q2;
import 'package:campus_pulse_client/src/protocol/chat_report.dart' as _izhvp4kh;
import 'package:campus_pulse_client/src/protocol/chat_room.dart' as _i69co3yd;
import 'package:campus_pulse_client/src/protocol/event_certificate.dart'
    as _ihpqvest;
import 'package:campus_pulse_client/src/protocol/event_rsvp.dart' as _in2xsmyl;
import 'package:campus_pulse_client/src/protocol/leaderboard_entry.dart'
    as _ipx1rsvs;
import 'package:campus_pulse_client/src/protocol/minutes_of_meeting.dart'
    as _idz08l1h;
import 'package:campus_pulse_client/src/protocol/quiz_attempt.dart'
    as _i395nlzx;
import 'package:campus_pulse_client/src/protocol/quiz_question_view.dart'
    as _iipzebr3;
import 'package:campus_pulse_client/src/protocol/reward_perk.dart' as _i04nrlxs;
import 'package:campus_pulse_client/src/protocol/section_timetable.dart'
    as _ij8cgkiw;
import 'package:campus_pulse_client/src/protocol/student_free_slot.dart'
    as _iuvh50w9;
import 'package:campus_pulse_client/src/protocol/student_profile.dart'
    as _i66wptcz;
import 'package:campus_pulse_client/src/protocol/study_request.dart'
    as _i18m6utc;
import 'package:campus_pulse_client/src/protocol/syllabus_node.dart'
    as _i5ej9mnt;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'academic_resource.dart' as _if13xk5x;
import 'admin_audit_log.dart' as _ihc3ja42;
import 'attendance_record.dart' as _ixvdsmvt;
import 'campus_event.dart' as _ieh998j0;
import 'campus_notification.dart' as _ik9ino7k;
import 'chat_message.dart' as _ivuncx2e;
import 'chat_report.dart' as _i9uqw2ol;
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
export 'chat_report.dart';
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
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

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
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _i9uqw2ol.ChatReport) {
      return _i9uqw2ol.ChatReport.fromJson(data) as T;
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
    if (t == _isc.getType<_if13xk5x.AcademicResource?>()) {
      return (data != null ? _if13xk5x.AcademicResource.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ihc3ja42.AdminAuditLog?>()) {
      return (data != null ? _ihc3ja42.AdminAuditLog.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ixvdsmvt.AttendanceRecord?>()) {
      return (data != null ? _ixvdsmvt.AttendanceRecord.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ieh998j0.CampusEvent?>()) {
      return (data != null ? _ieh998j0.CampusEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ik9ino7k.CampusNotification?>()) {
      return (data != null ? _ik9ino7k.CampusNotification.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivuncx2e.ChatMessage?>()) {
      return (data != null ? _ivuncx2e.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i9uqw2ol.ChatReport?>()) {
      return (data != null ? _i9uqw2ol.ChatReport.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i860mpd8.ChatRoom?>()) {
      return (data != null ? _i860mpd8.ChatRoom.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itkhxrdg.ContactMessage?>()) {
      return (data != null ? _itkhxrdg.ContactMessage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i18h4dy9.EventCertificate?>()) {
      return (data != null ? _i18h4dy9.EventCertificate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_it1gnu2n.EventRsvp?>()) {
      return (data != null ? _it1gnu2n.EventRsvp.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ikawkn1p.LeaderboardEntry?>()) {
      return (data != null ? _ikawkn1p.LeaderboardEntry.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivs2wzhx.LeaderboardUpdate?>()) {
      return (data != null ? _ivs2wzhx.LeaderboardUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i25xzg8r.MinutesOfMeeting?>()) {
      return (data != null ? _i25xzg8r.MinutesOfMeeting.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ihcqna09.PointsLedger?>()) {
      return (data != null ? _ihcqna09.PointsLedger.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_icbmbpey.QuizAnswerSubmission?>()) {
      return (data != null
              ? _icbmbpey.QuizAnswerSubmission.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibhufrza.QuizAttempt?>()) {
      return (data != null ? _ibhufrza.QuizAttempt.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i6b38qpb.QuizQuestion?>()) {
      return (data != null ? _i6b38qpb.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iuqiaozg.QuizQuestionView?>()) {
      return (data != null ? _iuqiaozg.QuizQuestionView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1u2fv9w.QuizResultItem?>()) {
      return (data != null ? _i1u2fv9w.QuizResultItem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9iv9tss.QuizResultSummary?>()) {
      return (data != null ? _i9iv9tss.QuizResultSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i689tsk4.QuizSubmission?>()) {
      return (data != null ? _i689tsk4.QuizSubmission.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izr2b0i4.RewardPerk?>()) {
      return (data != null ? _izr2b0i4.RewardPerk.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i9l2hi6q.RsvpUpdate?>()) {
      return (data != null ? _i9l2hi6q.RsvpUpdate.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imxb4b9a.SearchItem?>()) {
      return (data != null ? _imxb4b9a.SearchItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iz2tuvmq.SearchResponse?>()) {
      return (data != null ? _iz2tuvmq.SearchResponse.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iyrk4e0o.SectionTimetable?>()) {
      return (data != null ? _iyrk4e0o.SectionTimetable.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i76e3tnf.StudentFreeSlot?>()) {
      return (data != null ? _i76e3tnf.StudentFreeSlot.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iovtxv26.StudentProfile?>()) {
      return (data != null ? _iovtxv26.StudentProfile.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i2p0wucy.StudyRequest?>()) {
      return (data != null ? _i2p0wucy.StudyRequest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ihtod3tm.SyllabusNode?>()) {
      return (data != null ? _ihtod3tm.SyllabusNode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ir0y0iu6.UserRole?>()) {
      return (data != null ? _ir0y0iu6.UserRole.fromJson(data) : null) as T;
    }
    if (t == List<_isc.UuidValue>) {
      return (data as List).map((e) => deserialize<_isc.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
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
    if (t == List<_id97hjpr.AcademicResource>) {
      return (data as List)
              .map((e) => deserialize<_id97hjpr.AcademicResource>(e))
              .toList()
          as T;
    }
    if (t == List<_i5ej9mnt.SyllabusNode>) {
      return (data as List)
              .map((e) => deserialize<_i5ej9mnt.SyllabusNode>(e))
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
    if (t == List<_i6e8adep.AdminAuditLog>) {
      return (data as List)
              .map((e) => deserialize<_i6e8adep.AdminAuditLog>(e))
              .toList()
          as T;
    }
    if (t == List<_id4j1rwr.AttendanceRecord>) {
      return (data as List)
              .map((e) => deserialize<_id4j1rwr.AttendanceRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_ihpqvest.EventCertificate>) {
      return (data as List)
              .map((e) => deserialize<_ihpqvest.EventCertificate>(e))
              .toList()
          as T;
    }
    if (t == List<_isc.UuidValue>) {
      return (data as List).map((e) => deserialize<_isc.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_ik3iv9q2.ChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_ik3iv9q2.ChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_izhvp4kh.ChatReport>) {
      return (data as List)
              .map((e) => deserialize<_izhvp4kh.ChatReport>(e))
              .toList()
          as T;
    }
    if (t == List<_i69co3yd.ChatRoom>) {
      return (data as List)
              .map((e) => deserialize<_i69co3yd.ChatRoom>(e))
              .toList()
          as T;
    }
    if (t == List<_ip4v6fvs.CampusEvent>) {
      return (data as List)
              .map((e) => deserialize<_ip4v6fvs.CampusEvent>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_in2xsmyl.EventRsvp>) {
      return (data as List)
              .map((e) => deserialize<_in2xsmyl.EventRsvp>(e))
              .toList()
          as T;
    }
    if (t == List<_ipx1rsvs.LeaderboardEntry>) {
      return (data as List)
              .map((e) => deserialize<_ipx1rsvs.LeaderboardEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_idz08l1h.MinutesOfMeeting>) {
      return (data as List)
              .map((e) => deserialize<_idz08l1h.MinutesOfMeeting>(e))
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
    if (t == List<_i04nrlxs.RewardPerk>) {
      return (data as List)
              .map((e) => deserialize<_i04nrlxs.RewardPerk>(e))
              .toList()
          as T;
    }
    if (t == List<_iipzebr3.QuizQuestionView>) {
      return (data as List)
              .map((e) => deserialize<_iipzebr3.QuizQuestionView>(e))
              .toList()
          as T;
    }
    if (t == List<_i395nlzx.QuizAttempt>) {
      return (data as List)
              .map((e) => deserialize<_i395nlzx.QuizAttempt>(e))
              .toList()
          as T;
    }
    if (t == List<_i66wptcz.StudentProfile>) {
      return (data as List)
              .map((e) => deserialize<_i66wptcz.StudentProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i18m6utc.StudyRequest>) {
      return (data as List)
              .map((e) => deserialize<_i18m6utc.StudyRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_ij8cgkiw.SectionTimetable>) {
      return (data as List)
              .map((e) => deserialize<_ij8cgkiw.SectionTimetable>(e))
              .toList()
          as T;
    }
    if (t == List<_iuvh50w9.StudentFreeSlot>) {
      return (data as List)
              .map((e) => deserialize<_iuvh50w9.StudentFreeSlot>(e))
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
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
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
      _i9uqw2ol.ChatReport => 'ChatReport',
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
      case _i9uqw2ol.ChatReport():
        return 'ChatReport';
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
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
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
    if (dataClassName == 'ChatReport') {
      return deserialize<_i9uqw2ol.ChatReport>(data['data']);
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
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('campus_pulse', this);
    _iacc.Protocol().registerHostProtocol('campus_pulse', this);
  }

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
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
