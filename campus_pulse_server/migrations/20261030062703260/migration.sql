BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "chat_message" ADD COLUMN "isFlagged" boolean NOT NULL DEFAULT false;
ALTER TABLE "chat_message" ADD COLUMN "isDeletedByModerator" boolean NOT NULL DEFAULT false;
--
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "chat_room" ADD COLUMN "allowedBranch" text;
ALTER TABLE "chat_room" ADD COLUMN "allowedAcademicYear" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "quiz_attempt" ADD COLUMN "attemptId" text;
ALTER TABLE "quiz_attempt" ADD COLUMN "quizId" text;
ALTER TABLE "quiz_attempt" ADD COLUMN "attemptNumber" bigint NOT NULL DEFAULT 1;
ALTER TABLE "quiz_attempt" ADD COLUMN "isRetake" boolean NOT NULL DEFAULT false;
CREATE INDEX "quiz_attempt_user_attempt_idx" ON "quiz_attempt" USING btree ("authUserId", "attemptId");
--
-- ACTION CREATE FOREIGN KEY
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
-- MIGRATION VERSION FOR campus_pulse
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campus_pulse', '20261030062703260', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030062703260', "timestamp" = now();

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
