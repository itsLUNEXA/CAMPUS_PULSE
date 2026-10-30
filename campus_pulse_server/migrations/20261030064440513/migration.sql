BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "campus_event" ADD COLUMN "approvalStatus" text NOT NULL DEFAULT 'approved'::text;
ALTER TABLE "campus_event" ADD COLUMN "rejectionReason" text;
ALTER TABLE "campus_event" ADD COLUMN "registrationDeadline" timestamp without time zone;
ALTER TABLE "campus_event" ADD COLUMN "isTeamEvent" boolean NOT NULL DEFAULT false;
ALTER TABLE "campus_event" ADD COLUMN "minTeamSize" bigint NOT NULL DEFAULT 1;
ALTER TABLE "campus_event" ADD COLUMN "maxTeamSize" bigint NOT NULL DEFAULT 1;
ALTER TABLE "campus_event" ADD COLUMN "submissionVersion" bigint NOT NULL DEFAULT 1;
CREATE INDEX "event_approval_status_idx" ON "campus_event" USING btree ("approvalStatus");
--
-- ACTION ALTER TABLE
--
DROP INDEX "event_student_rsvp_idx";
DROP INDEX "rsvp_user_idx";
ALTER TABLE "event_rsvp" ADD COLUMN "teamName" text;
ALTER TABLE "event_rsvp" ADD COLUMN "teamMemberNames" json;
ALTER TABLE "event_rsvp" ADD COLUMN "teamMemberEmails" json;
CREATE UNIQUE INDEX "event_rsvp_unique_idx" ON "event_rsvp" USING btree ("eventId", "authUserId");

--
-- MIGRATION VERSION FOR campus_pulse
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campus_pulse', '20261030064440513', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030064440513', "timestamp" = now();

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
