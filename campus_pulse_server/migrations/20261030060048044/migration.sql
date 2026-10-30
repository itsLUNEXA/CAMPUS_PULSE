BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "section_schedule_idx" ON "section_timetables" USING btree ("branch", "semester", "section", "dayOfWeek");

--
-- ACTION CREATE TABLE
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
-- MIGRATION VERSION FOR campus_pulse
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campus_pulse', '20261030060048044', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030060048044', "timestamp" = now();

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
