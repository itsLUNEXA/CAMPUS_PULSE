BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "academic_resource" ADD COLUMN "rejectionReason" text;
--
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "section_timetables" ADD COLUMN "faculty" text;

--
-- MIGRATION VERSION FOR campus_pulse
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campus_pulse', '20261030085955978', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030085955978', "timestamp" = now();

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
