BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
