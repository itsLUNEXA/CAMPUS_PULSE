BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "quiz_attempt" ADD COLUMN "academicYear" bigint DEFAULT 1;
CREATE INDEX "quiz_attempt_branch_year_idx" ON "quiz_attempt" USING btree ("studentBranch", "academicYear");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "student_profile" ADD COLUMN "eventInterests" json;
ALTER TABLE "student_profile" ADD COLUMN "preferredQuizSubjects" json;
ALTER TABLE "student_profile" ADD COLUMN "preferredQuizTypes" json;

--
-- MIGRATION VERSION FOR campus_pulse
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campus_pulse', '20261030070152309', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030070152309', "timestamp" = now();

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
