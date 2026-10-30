BEGIN;

--
-- ACTION CREATE TABLE
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
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "downloadCount" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE INDEX "resource_filter_idx" ON "academic_resource" USING btree ("university", "course", "branch", "semester", "subjectCode");
CREATE INDEX "resource_approval_idx" ON "academic_resource" USING btree ("isApproved");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isEdited" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE INDEX "msg_room_idx" ON "chat_message" USING btree ("roomId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_room" (
    "id" bigserial PRIMARY KEY,
    "roomType" text NOT NULL,
    "referenceId" text,
    "name" text NOT NULL,
    "participantIds" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastMessageText" text,
    "lastMessageAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "room_type_ref_idx" ON "chat_room" USING btree ("roomType", "referenceId");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "attendance_record"
    ADD CONSTRAINT "attendance_record_fk_0"
    FOREIGN KEY("eventId")
    REFERENCES "campus_event"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "chat_message"
    ADD CONSTRAINT "chat_message_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "chat_room"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "event_certificate"
    ADD CONSTRAINT "event_certificate_fk_0"
    FOREIGN KEY("eventId")
    REFERENCES "campus_event"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR campus_pulse
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campus_pulse', '20261030052355042', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030052355042', "timestamp" = now();

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
