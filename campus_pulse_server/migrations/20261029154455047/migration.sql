BEGIN;

--
-- ACTION CREATE TABLE
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
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "event_category_idx" ON "campus_event" USING btree ("category");
CREATE INDEX "event_start_time_idx" ON "campus_event" USING btree ("startTime");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "event_rsvp" (
    "id" bigserial PRIMARY KEY,
    "eventId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "studentName" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "event_student_rsvp_idx" ON "event_rsvp" USING btree ("eventId", "authUserId");
CREATE INDEX "rsvp_user_idx" ON "event_rsvp" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quiz_attempt" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "studentName" text NOT NULL,
    "studentBranch" text NOT NULL,
    "subject" text NOT NULL,
    "score" bigint NOT NULL,
    "totalQuestions" bigint NOT NULL,
    "percentage" double precision NOT NULL,
    "durationSeconds" bigint NOT NULL,
    "completedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "quiz_attempt_subject_score_idx" ON "quiz_attempt" USING btree ("subject", "score");
CREATE INDEX "quiz_attempt_user_idx" ON "quiz_attempt" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "event_rsvp"
    ADD CONSTRAINT "event_rsvp_fk_0"
    FOREIGN KEY("eventId")
    REFERENCES "campus_event"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR campus_pulse
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campus_pulse', '20261029154455047', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261029154455047', "timestamp" = now();

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
