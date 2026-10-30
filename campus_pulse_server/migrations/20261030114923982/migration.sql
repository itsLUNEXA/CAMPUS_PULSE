BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "campus_clubs" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "tagline" text NOT NULL,
    "category" text NOT NULL,
    "description" text NOT NULL,
    "logoUrl" text,
    "leadName" text NOT NULL,
    "leadEmail" text NOT NULL,
    "techTeamLead" text NOT NULL,
    "techTeamEmail" text NOT NULL,
    "managementLead" text NOT NULL,
    "managementEmail" text NOT NULL,
    "membersCount" bigint NOT NULL DEFAULT 0,
    "recruitmentOpen" boolean NOT NULL DEFAULT false,
    "meetingSchedule" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "club_category_idx" ON "campus_clubs" USING btree ("category");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "campus_companies" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "tier" text NOT NULL,
    "avgPackageLpa" double precision NOT NULL,
    "eligibleBranches" json NOT NULL,
    "cgpaCutoff" double precision NOT NULL,
    "hiringRounds" json NOT NULL,
    "keyFocusAreas" json NOT NULL,
    "description" text NOT NULL,
    "logoUrl" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "company_name_idx" ON "campus_companies" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "club_query_requests" (
    "id" bigserial PRIMARY KEY,
    "clubId" bigint NOT NULL,
    "clubName" text NOT NULL,
    "targetTeam" text NOT NULL,
    "senderAuthUserId" uuid NOT NULL,
    "senderName" text NOT NULL,
    "senderEmail" text NOT NULL,
    "senderBranch" text NOT NULL,
    "senderYear" bigint NOT NULL,
    "category" text NOT NULL,
    "subject" text NOT NULL,
    "message" text NOT NULL,
    "status" text NOT NULL DEFAULT 'PENDING'::text,
    "responseMessage" text,
    "responderName" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "respondedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "club_query_club_idx" ON "club_query_requests" USING btree ("clubId");
CREATE INDEX "club_query_sender_idx" ON "club_query_requests" USING btree ("senderAuthUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "mock_interview_slots" (
    "id" bigserial PRIMARY KEY,
    "studentAuthUserId" uuid NOT NULL,
    "studentName" text NOT NULL,
    "studentEmail" text NOT NULL,
    "targetCompany" text NOT NULL,
    "targetRole" text NOT NULL,
    "mockRound" text NOT NULL,
    "preferredDate" timestamp without time zone NOT NULL,
    "resumeUrl" text,
    "notes" text,
    "status" text NOT NULL DEFAULT 'REQUESTED'::text,
    "seniorMentorName" text,
    "meetingLink" text,
    "feedbackNotes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "mock_slot_user_idx" ON "mock_interview_slots" USING btree ("studentAuthUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "senior_experiences" (
    "id" bigserial PRIMARY KEY,
    "companyName" text NOT NULL,
    "seniorName" text NOT NULL,
    "seniorBranch" text NOT NULL,
    "batchYear" bigint NOT NULL,
    "placedRole" text NOT NULL,
    "packageOffered" text,
    "difficultyRating" bigint NOT NULL DEFAULT 3,
    "interviewQuestions" json NOT NULL,
    "experienceReview" text NOT NULL,
    "tipsForJuniors" text NOT NULL,
    "contactHandle" text,
    "verified" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "senior_exp_company_idx" ON "senior_experiences" USING btree ("companyName");


--
-- MIGRATION VERSION FOR campus_pulse
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campus_pulse', '20261030114923982', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030114923982', "timestamp" = now();

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
