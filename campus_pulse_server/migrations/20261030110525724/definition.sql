BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- Class AcademicResource as table academic_resource
--
CREATE TABLE "academic_resource" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text,
    "university" text NOT NULL,
    "course" text NOT NULL,
    "branch" text NOT NULL,
    "academicYear" bigint NOT NULL,
    "semester" bigint NOT NULL,
    "subjectCode" text NOT NULL,
    "subjectName" text NOT NULL,
    "unitNumber" bigint,
    "resourceType" text NOT NULL,
    "fileUrl" text NOT NULL,
    "fileSize" bigint,
    "uploadedByUserId" uuid NOT NULL,
    "uploaderName" text NOT NULL,
    "isApproved" boolean NOT NULL DEFAULT false,
    "approvedByUserId" uuid,
    "rejectionReason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "downloadCount" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE INDEX "resource_filter_idx" ON "academic_resource" USING btree ("university", "course", "branch", "semester", "subjectCode");
CREATE INDEX "resource_approval_idx" ON "academic_resource" USING btree ("isApproved");

--
-- Class AdminAuditLog as table admin_audit_log
--
CREATE TABLE "admin_audit_log" (
    "id" bigserial PRIMARY KEY,
    "actorUserId" uuid NOT NULL,
    "actorName" text NOT NULL,
    "actionType" text NOT NULL,
    "targetEntity" text NOT NULL,
    "targetId" text NOT NULL,
    "details" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "audit_time_idx" ON "admin_audit_log" USING btree ("timestamp");

--
-- Class AttendanceRecord as table attendance_record
--
CREATE TABLE "attendance_record" (
    "id" bigserial PRIMARY KEY,
    "eventId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "studentName" text NOT NULL,
    "status" text NOT NULL,
    "checkInCode" text,
    "markedByUserId" uuid,
    "markedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" text
);

-- Indexes
CREATE UNIQUE INDEX "event_attendance_user_idx" ON "attendance_record" USING btree ("eventId", "authUserId");
CREATE INDEX "attendance_user_idx" ON "attendance_record" USING btree ("authUserId");

--
-- Class CampusEvent as table campus_event
--
CREATE TABLE "campus_event" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "category" text NOT NULL,
    "startTime" timestamp without time zone NOT NULL,
    "endTime" timestamp without time zone,
    "venue" text NOT NULL,
    "bannerUrl" text,
    "organizerAuthUserId" uuid NOT NULL,
    "organizerName" text NOT NULL,
    "rsvpCount" bigint NOT NULL DEFAULT 0,
    "approvalStatus" text NOT NULL DEFAULT 'approved'::text,
    "rejectionReason" text,
    "registrationDeadline" timestamp without time zone,
    "isTeamEvent" boolean NOT NULL DEFAULT false,
    "minTeamSize" bigint NOT NULL DEFAULT 1,
    "maxTeamSize" bigint NOT NULL DEFAULT 1,
    "submissionVersion" bigint NOT NULL DEFAULT 1,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "event_category_idx" ON "campus_event" USING btree ("category");
CREATE INDEX "event_start_time_idx" ON "campus_event" USING btree ("startTime");
CREATE INDEX "event_approval_status_idx" ON "campus_event" USING btree ("approvalStatus");

--
-- Class CampusNotification as table campus_notifications
--
CREATE TABLE "campus_notifications" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "title" text NOT NULL,
    "message" text NOT NULL,
    "type" text NOT NULL,
    "targetRoute" text,
    "targetId" text,
    "isRead" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "eventIdTag" text
);

-- Indexes
CREATE INDEX "notif_user_read_idx" ON "campus_notifications" USING btree ("authUserId", "isRead");
CREATE INDEX "notif_dedup_idx" ON "campus_notifications" USING btree ("authUserId", "eventIdTag");

--
-- Class ChatMessage as table chat_message
--
CREATE TABLE "chat_message" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "senderUserId" uuid NOT NULL,
    "senderName" text NOT NULL,
    "content" text NOT NULL,
    "attachmentUrl" text,
    "attachmentType" text,
    "isRead" boolean NOT NULL DEFAULT false,
    "isFlagged" boolean NOT NULL DEFAULT false,
    "isDeletedByModerator" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isEdited" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE INDEX "msg_room_idx" ON "chat_message" USING btree ("roomId", "createdAt");

--
-- Class ChatReport as table chat_report
--
CREATE TABLE "chat_report" (
    "id" bigserial PRIMARY KEY,
    "messageId" bigint NOT NULL,
    "roomId" bigint NOT NULL,
    "reporterUserId" uuid NOT NULL,
    "reporterName" text NOT NULL,
    "reason" text NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "actionTaken" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reviewedByUserId" uuid,
    "reviewedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "chat_report_status_idx" ON "chat_report" USING btree ("status");
CREATE INDEX "chat_report_msg_idx" ON "chat_report" USING btree ("messageId");

--
-- Class ChatRoom as table chat_room
--
CREATE TABLE "chat_room" (
    "id" bigserial PRIMARY KEY,
    "roomType" text NOT NULL,
    "referenceId" text,
    "name" text NOT NULL,
    "description" text,
    "topic" text,
    "creatorAuthUserId" uuid,
    "participantIds" json NOT NULL,
    "allowedBranch" text,
    "allowedAcademicYear" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastMessageText" text,
    "lastMessageAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "room_type_ref_idx" ON "chat_room" USING btree ("roomType", "referenceId");

--
-- Class ContactMessage as table contact_message
--
CREATE TABLE "contact_message" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "email" text NOT NULL,
    "subject" text NOT NULL,
    "message" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "contact_message_email_idx" ON "contact_message" USING btree ("email");

--
-- Class EventCertificate as table event_certificate
--
CREATE TABLE "event_certificate" (
    "id" bigserial PRIMARY KEY,
    "certificateId" text NOT NULL,
    "eventId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "studentName" text NOT NULL,
    "eventName" text NOT NULL,
    "eventDate" timestamp without time zone NOT NULL,
    "issuedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "issuedByUserId" uuid,
    "verificationUrl" text NOT NULL,
    "status" text NOT NULL,
    "signatureTitle" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "event_certificate__certificateId__unique_idx" ON "event_certificate" USING btree ("certificateId");
CREATE UNIQUE INDEX "cert_unique_id_idx" ON "event_certificate" USING btree ("certificateId");
CREATE UNIQUE INDEX "cert_event_student_idx" ON "event_certificate" USING btree ("eventId", "authUserId");
CREATE INDEX "cert_user_idx" ON "event_certificate" USING btree ("authUserId");

--
-- Class EventRsvp as table event_rsvp
--
CREATE TABLE "event_rsvp" (
    "id" bigserial PRIMARY KEY,
    "eventId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "studentName" text NOT NULL,
    "teamName" text,
    "teamMemberNames" json,
    "teamMemberEmails" json,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "event_rsvp_unique_idx" ON "event_rsvp" USING btree ("eventId", "authUserId");

--
-- Class MinutesOfMeeting as table minutes_of_meeting
--
CREATE TABLE "minutes_of_meeting" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "meetingDate" timestamp without time zone NOT NULL,
    "organizerUserId" uuid NOT NULL,
    "organizerName" text NOT NULL,
    "attendeeNames" json NOT NULL,
    "agenda" text NOT NULL,
    "discussionPoints" json NOT NULL,
    "decisions" json NOT NULL,
    "actionItems" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "mom_date_idx" ON "minutes_of_meeting" USING btree ("meetingDate");

--
-- Class PointsLedger as table points_ledger
--
CREATE TABLE "points_ledger" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "studentName" text NOT NULL,
    "source" text NOT NULL,
    "points" bigint NOT NULL,
    "description" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "ledger_user_idx" ON "points_ledger" USING btree ("authUserId", "timestamp");

--
-- Class PrintPointTransaction as table print_point_transactions
--
CREATE TABLE "print_point_transactions" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "printRequestId" bigint,
    "type" text NOT NULL,
    "points" bigint NOT NULL,
    "balanceAfter" bigint NOT NULL,
    "description" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "print_tx_user_idx" ON "print_point_transactions" USING btree ("authUserId", "createdAt");
CREATE INDEX "print_tx_req_idx" ON "print_point_transactions" USING btree ("printRequestId");

--
-- Class PrintPointWallet as table print_point_wallets
--
CREATE TABLE "print_point_wallets" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "studentName" text NOT NULL,
    "balance" bigint NOT NULL,
    "lifetimeEarned" bigint NOT NULL,
    "lifetimeRedeemed" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "print_point_wallets__authUserId__unique_idx" ON "print_point_wallets" USING btree ("authUserId");
CREATE UNIQUE INDEX "print_wallet_user_idx" ON "print_point_wallets" USING btree ("authUserId");

--
-- Class PrintRequest as table print_requests
--
CREATE TABLE "print_requests" (
    "id" bigserial PRIMARY KEY,
    "studentAuthUserId" uuid NOT NULL,
    "studentName" text NOT NULL,
    "studentBranch" text NOT NULL,
    "studentYear" bigint NOT NULL,
    "hostelOrLocation" text NOT NULL,
    "fileName" text NOT NULL,
    "fileUrl" text NOT NULL,
    "fileSizeBytes" bigint,
    "pageCount" bigint NOT NULL,
    "copies" bigint NOT NULL,
    "totalPages" bigint NOT NULL,
    "printType" text NOT NULL,
    "paperSize" text NOT NULL,
    "printSide" text NOT NULL,
    "binding" text NOT NULL,
    "deliveryMode" text NOT NULL,
    "counterName" text NOT NULL,
    "amountPaid" double precision NOT NULL,
    "pointsUsed" bigint NOT NULL,
    "pointsEarned" bigint NOT NULL,
    "pointsAwarded" boolean NOT NULL DEFAULT false,
    "paymentStatus" text NOT NULL,
    "paymentTransactionId" text,
    "paymentFailureReason" text,
    "status" text NOT NULL,
    "collectionCode" text,
    "collectionQrToken" text,
    "statusReason" text,
    "processedByStaffName" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "collectedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "print_req_student_idx" ON "print_requests" USING btree ("studentAuthUserId", "createdAt");
CREATE INDEX "print_req_counter_status_idx" ON "print_requests" USING btree ("counterName", "status", "paymentStatus");
CREATE INDEX "print_req_code_idx" ON "print_requests" USING btree ("collectionCode");

--
-- Class QuizAttempt as table quiz_attempt
--
CREATE TABLE "quiz_attempt" (
    "id" bigserial PRIMARY KEY,
    "attemptId" text,
    "authUserId" uuid NOT NULL,
    "studentName" text NOT NULL,
    "studentBranch" text NOT NULL,
    "academicYear" bigint DEFAULT 1,
    "subject" text NOT NULL,
    "quizId" text,
    "score" bigint NOT NULL,
    "totalQuestions" bigint NOT NULL,
    "percentage" double precision NOT NULL,
    "durationSeconds" bigint NOT NULL,
    "attemptNumber" bigint NOT NULL DEFAULT 1,
    "isRetake" boolean NOT NULL DEFAULT false,
    "completedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "quiz_attempt_user_attempt_idx" ON "quiz_attempt" USING btree ("authUserId", "attemptId");
CREATE INDEX "quiz_attempt_subject_score_idx" ON "quiz_attempt" USING btree ("subject", "score");
CREATE INDEX "quiz_attempt_user_idx" ON "quiz_attempt" USING btree ("authUserId");
CREATE INDEX "quiz_attempt_branch_year_idx" ON "quiz_attempt" USING btree ("studentBranch", "academicYear");

--
-- Class QuizQuestion as table quiz_question
--
CREATE TABLE "quiz_question" (
    "id" bigserial PRIMARY KEY,
    "subject" text NOT NULL,
    "question" text NOT NULL,
    "options" json NOT NULL,
    "correctOptionIndex" bigint NOT NULL,
    "explanation" text NOT NULL,
    "difficulty" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "quiz_question_subject_idx" ON "quiz_question" USING btree ("subject");

--
-- Class RewardPerk as table reward_perks
--
CREATE TABLE "reward_perks" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "category" text NOT NULL,
    "description" text NOT NULL,
    "costPoints" bigint NOT NULL,
    "stockRemaining" bigint NOT NULL,
    "imageUrl" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "reward_active_idx" ON "reward_perks" USING btree ("isActive");

--
-- Class SectionTimetable as table section_timetables
--
CREATE TABLE "section_timetables" (
    "id" bigserial PRIMARY KEY,
    "branch" text NOT NULL,
    "academicYear" bigint NOT NULL,
    "semester" bigint NOT NULL,
    "section" text NOT NULL,
    "dayOfWeek" text NOT NULL,
    "startTime" text NOT NULL,
    "endTime" text NOT NULL,
    "subject" text NOT NULL,
    "room" text NOT NULL,
    "faculty" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "section_schedule_idx" ON "section_timetables" USING btree ("branch", "semester", "section", "dayOfWeek");

--
-- Class StudentFreeSlot as table student_free_slots
--
CREATE TABLE "student_free_slots" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "dayOfWeek" text NOT NULL,
    "slotLabel" text NOT NULL,
    "startTime" text NOT NULL,
    "endTime" text NOT NULL,
    "isFree" boolean NOT NULL DEFAULT true,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "student_slot_idx" ON "student_free_slots" USING btree ("authUserId", "dayOfWeek", "slotLabel");
CREATE INDEX "student_free_user_idx" ON "student_free_slots" USING btree ("authUserId");

--
-- Class StudentProfile as table student_profile
--
CREATE TABLE "student_profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "fullName" text NOT NULL,
    "email" text NOT NULL,
    "branch" text NOT NULL,
    "academicYear" bigint NOT NULL,
    "hostelOrArea" text NOT NULL,
    "bio" text,
    "subjectInterests" json NOT NULL,
    "eventInterests" json,
    "preferredQuizSubjects" json,
    "preferredQuizTypes" json,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "student_profile__authUserId__unique_idx" ON "student_profile" USING btree ("authUserId");
CREATE UNIQUE INDEX "student_profile__email__unique_idx" ON "student_profile" USING btree ("email");
CREATE UNIQUE INDEX "student_auth_user_idx" ON "student_profile" USING btree ("authUserId");
CREATE UNIQUE INDEX "student_email_idx" ON "student_profile" USING btree ("email");
CREATE INDEX "student_branch_year_idx" ON "student_profile" USING btree ("branch", "academicYear");

--
-- Class StudyRequest as table study_request
--
CREATE TABLE "study_request" (
    "id" bigserial PRIMARY KEY,
    "senderAuthUserId" uuid NOT NULL,
    "senderName" text NOT NULL,
    "senderBranch" text NOT NULL,
    "senderYear" bigint NOT NULL,
    "recipientAuthUserId" uuid NOT NULL,
    "recipientName" text NOT NULL,
    "subject" text NOT NULL,
    "message" text NOT NULL,
    "status" text NOT NULL,
    "urgency" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "study_request_sender_idx" ON "study_request" USING btree ("senderAuthUserId");
CREATE INDEX "study_request_recipient_idx" ON "study_request" USING btree ("recipientAuthUserId");
CREATE INDEX "study_request_status_idx" ON "study_request" USING btree ("status");

--
-- Class SyllabusNode as table syllabus_node
--
CREATE TABLE "syllabus_node" (
    "id" bigserial PRIMARY KEY,
    "university" text NOT NULL,
    "course" text NOT NULL,
    "branch" text NOT NULL,
    "semester" bigint NOT NULL,
    "subjectCode" text NOT NULL,
    "subjectName" text NOT NULL,
    "unitNumber" bigint NOT NULL,
    "unitTitle" text NOT NULL,
    "topics" json NOT NULL,
    "academicYear" bigint NOT NULL,
    "version" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "syllabus_hierarchy_idx" ON "syllabus_node" USING btree ("university", "course", "branch", "semester", "subjectCode", "unitNumber");

--
-- Class UserRole as table user_role
--
CREATE TABLE "user_role" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "role" text NOT NULL,
    "assignedScope" text,
    "grantedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "user_role_user_idx" ON "user_role" USING btree ("authUserId", "role");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectDownloadEntry as table serverpod_cloud_storage_direct_download
--
CREATE TABLE "serverpod_cloud_storage_direct_download" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "downloadFileName" text,
    "contentType" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_download_auth_key" ON "serverpod_cloud_storage_direct_download" USING btree ("authKey");
CREATE INDEX "serverpod_cloud_storage_direct_download_expiration" ON "serverpod_cloud_storage_direct_download" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "maxFileSize" bigint NOT NULL DEFAULT 10485760,
    "contentLength" bigint,
    "preventOverwrite" boolean NOT NULL DEFAULT false,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text,
    "scheduling" json
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class FutureCallClaimEntry as table serverpod_future_call_claim
--
CREATE TABLE "serverpod_future_call_claim" (
    "id" bigserial PRIMARY KEY,
    "futureCallId" bigint,
    "lastHeartbeatTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "future_call_unique_idx" ON "serverpod_future_call_claim" USING btree ("futureCallId");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId", "order");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_message_log_sessionLogId_idx" ON "serverpod_message_log" USING btree ("sessionLogId", "order");

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId", "order");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AnonymousAccount as table serverpod_auth_idp_anonymous_account
--
CREATE TABLE "serverpod_auth_idp_anonymous_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class AppleAccount as table serverpod_auth_idp_apple_account
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- Class EmailAccount as table serverpod_auth_idp_email_account
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- Class EmailAccountPasswordResetRequest as table serverpod_auth_idp_email_account_password_reset_request
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- Class EmailAccountRequest as table serverpod_auth_idp_email_account_request
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- Class FacebookAccount as table serverpod_auth_idp_facebook_account
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- Class FirebaseAccount as table serverpod_auth_idp_firebase_account
--
CREATE TABLE "serverpod_auth_idp_firebase_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text,
    "phone" text,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_firebase_account_user_identifier" ON "serverpod_auth_idp_firebase_account" USING btree ("userIdentifier");

--
-- Class GitHubAccount as table serverpod_auth_idp_github_account
--
CREATE TABLE "serverpod_auth_idp_github_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_github_account_user_identifier" ON "serverpod_auth_idp_github_account" USING btree ("userIdentifier");

--
-- Class GoogleAccount as table serverpod_auth_idp_google_account
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- Class MicrosoftAccount as table serverpod_auth_idp_microsoft_account
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- Class PasskeyAccount as table serverpod_auth_idp_passkey_account
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- Class PasskeyChallenge as table serverpod_auth_idp_passkey_challenge
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- Class RateLimitedRequestAttempt as table serverpod_auth_idp_rate_limited_request_attempt
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "key" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_composite" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain", "source", "key", "attemptedAt");

--
-- Class SecretChallenge as table serverpod_auth_idp_secret_challenge
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- Class RefreshToken as table serverpod_auth_core_jwt_refresh_token
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- Class UserProfile as table serverpod_auth_core_profile
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- Class UserProfileImage as table serverpod_auth_core_profile_image
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- Class ServerSideSession as table serverpod_auth_core_session
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- Class AuthUser as table serverpod_auth_core_user
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- Foreign relations for "attendance_record" table
--
ALTER TABLE ONLY "attendance_record"
    ADD CONSTRAINT "attendance_record_fk_0"
    FOREIGN KEY("eventId")
    REFERENCES "campus_event"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "chat_message" table
--
ALTER TABLE ONLY "chat_message"
    ADD CONSTRAINT "chat_message_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "chat_room"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "chat_report" table
--
ALTER TABLE ONLY "chat_report"
    ADD CONSTRAINT "chat_report_fk_0"
    FOREIGN KEY("messageId")
    REFERENCES "chat_message"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "chat_report"
    ADD CONSTRAINT "chat_report_fk_1"
    FOREIGN KEY("roomId")
    REFERENCES "chat_room"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "event_certificate" table
--
ALTER TABLE ONLY "event_certificate"
    ADD CONSTRAINT "event_certificate_fk_0"
    FOREIGN KEY("eventId")
    REFERENCES "campus_event"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "event_rsvp" table
--
ALTER TABLE ONLY "event_rsvp"
    ADD CONSTRAINT "event_rsvp_fk_0"
    FOREIGN KEY("eventId")
    REFERENCES "campus_event"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_future_call_claim" table
--
ALTER TABLE ONLY "serverpod_future_call_claim"
    ADD CONSTRAINT "serverpod_future_call_claim_fk_0"
    FOREIGN KEY("futureCallId")
    REFERENCES "serverpod_future_call"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_anonymous_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_anonymous_account"
    ADD CONSTRAINT "serverpod_auth_idp_anonymous_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_apple_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_password_reset_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_facebook_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_firebase_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_firebase_account"
    ADD CONSTRAINT "serverpod_auth_idp_firebase_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_github_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_github_account"
    ADD CONSTRAINT "serverpod_auth_idp_github_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_google_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_microsoft_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_passkey_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_jwt_refresh_token" table
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    DEFERRABLE INITIALLY DEFERRED;

--
-- Foreign relations for "serverpod_auth_core_profile_image" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_session" table
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR campus_pulse
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campus_pulse', '20261030110525724', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030110525724', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
