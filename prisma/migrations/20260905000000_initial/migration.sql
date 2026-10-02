-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'MANAGER', 'ANALYST');

-- CreateTable
CREATE TABLE "User" (
    "active" BOOLEAN NOT NULL DEFAULT true,
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'ANALYST',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuditLog" (
    "id" TEXT NOT NULL,
    "actorId" TEXT,
    "actorName" TEXT,
    "action" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT,
    "detail" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkflowAnalysis" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "workflow" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "input" JSONB NOT NULL,
    "evidence" JSONB NOT NULL,
    "evidenceHash" TEXT NOT NULL,
    "result" JSONB NOT NULL,
    "model" TEXT NOT NULL,
    "receipt" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WorkflowAnalysis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecordReview" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RecordReview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UsageBucket" (
    "id" TEXT NOT NULL,
    "calls" INTEGER NOT NULL,

    CONSTRAINT "UsageBucket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IssuedCredential" (
    "token" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "assertion" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revokedAt" TIMESTAMP(3),

    CONSTRAINT "IssuedCredential_pkey" PRIMARY KEY ("token")
);

-- CreateTable
CREATE TABLE "DomainArtifact" (
    "id" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "contentHash" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "approvedBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DomainArtifact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecordApproval" (
    "id" TEXT NOT NULL,
    "version" TEXT NOT NULL,

    CONSTRAINT "RecordApproval_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DomainExecution" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "connectorId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "result" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DomainExecution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkSession" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "respondentId" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "questions" JSONB NOT NULL,
    "answers" JSONB NOT NULL,
    "currentQuestion" TEXT,
    "status" TEXT NOT NULL,
    "deadline" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WorkSession_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SessionMedia" (
    "id" TEXT NOT NULL,
    "sessionId" TEXT NOT NULL,
    "questionId" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "contentType" TEXT NOT NULL,
    "bytes" BYTEA NOT NULL,
    "contentHash" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SessionMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AppSetting" (
    "id" TEXT NOT NULL,
    "value" JSONB NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AppSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AccreditationCycle" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "institution" TEXT NOT NULL,
    "accreditor" TEXT NOT NULL,
    "frameworkVersion" TEXT NOT NULL,
    "cycleStart" TIMESTAMP(3) NOT NULL,
    "visitAt" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AccreditationCycle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AccreditationStandard" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "standardCode" TEXT NOT NULL,
    "requirementText" TEXT NOT NULL,
    "owner" TEXT NOT NULL,
    "dueAt" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AccreditationStandard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StandardEvidence" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "accreditationStandardId" TEXT NOT NULL,
    "sourceReference" TEXT NOT NULL,
    "collectedAt" TIMESTAMP(3) NOT NULL,
    "owner" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "StandardEvidence_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AssessmentMeasure" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "accreditationStandardId" TEXT NOT NULL,
    "metric" TEXT NOT NULL,
    "target" DOUBLE PRECISION NOT NULL,
    "observed" DOUBLE PRECISION NOT NULL,
    "periodEnd" TIMESTAMP(3) NOT NULL,
    "method" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AssessmentMeasure_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SelfStudySection" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "accreditationStandardId" TEXT NOT NULL,
    "narrative" TEXT NOT NULL,
    "sourceReferences" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "revisedAt" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SelfStudySection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SiteVisitRequest" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "requester" TEXT NOT NULL,
    "requestedAt" TIMESTAMP(3) NOT NULL,
    "dueAt" TIMESTAMP(3) NOT NULL,
    "requestText" TEXT NOT NULL,
    "evidenceReference" TEXT,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SiteVisitRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AccreditationFinding" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "accreditationStandardId" TEXT NOT NULL,
    "findingText" TEXT NOT NULL,
    "receivedAt" TIMESTAMP(3) NOT NULL,
    "severity" TEXT NOT NULL,
    "responseDueAt" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AccreditationFinding_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ImprovementAction" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "accreditationFindingId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "owner" TEXT NOT NULL,
    "dueAt" TIMESTAMP(3) NOT NULL,
    "evidence" TEXT,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ImprovementAction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommitteeMeeting" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "heldAt" TIMESTAMP(3) NOT NULL,
    "chair" TEXT NOT NULL,
    "participants" TEXT NOT NULL,
    "decisions" TEXT NOT NULL,
    "followUp" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CommitteeMeeting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OperationalTask" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "owner" TEXT NOT NULL,
    "priority" TEXT NOT NULL,
    "startAt" TIMESTAMP(3) NOT NULL,
    "dueAt" TIMESTAMP(3) NOT NULL,
    "done" BOOLEAN NOT NULL,
    "notes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OperationalTask_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RuleVersion" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "jurisdiction" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "effectiveAt" TIMESTAMP(3) NOT NULL,
    "expiresAt" TIMESTAMP(3),
    "sourceUrl" TEXT NOT NULL,
    "requirementText" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RuleVersion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentRequirement" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "requiredBy" TIMESTAMP(3) NOT NULL,
    "sourceReference" TEXT NOT NULL,
    "evidenceReference" TEXT,
    "reviewNotes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "accreditationCycleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DocumentRequirement_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "WorkflowAnalysis_workflow_createdAt_idx" ON "WorkflowAnalysis"("workflow", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "RecordReview_entity_entityId_version_actorId_key" ON "RecordReview"("entity", "entityId", "version", "actorId");

-- CreateIndex
CREATE INDEX "IssuedCredential_entity_entityId_createdAt_idx" ON "IssuedCredential"("entity", "entityId", "createdAt");

-- CreateIndex
CREATE INDEX "DomainArtifact_subjectEntity_subjectId_idx" ON "DomainArtifact"("subjectEntity", "subjectId");

-- CreateIndex
CREATE INDEX "WorkSession_respondentId_createdAt_idx" ON "WorkSession"("respondentId", "createdAt");

-- CreateIndex
CREATE INDEX "SessionMedia_sessionId_idx" ON "SessionMedia"("sessionId");

-- CreateIndex
CREATE INDEX "AccreditationCycle_createdAt_idx" ON "AccreditationCycle"("createdAt");

-- CreateIndex
CREATE INDEX "AccreditationStandard_createdAt_idx" ON "AccreditationStandard"("createdAt");

-- CreateIndex
CREATE INDEX "AccreditationStandard_accreditationCycleId_idx" ON "AccreditationStandard"("accreditationCycleId");

-- CreateIndex
CREATE INDEX "StandardEvidence_createdAt_idx" ON "StandardEvidence"("createdAt");

-- CreateIndex
CREATE INDEX "StandardEvidence_accreditationCycleId_idx" ON "StandardEvidence"("accreditationCycleId");

-- CreateIndex
CREATE INDEX "AssessmentMeasure_createdAt_idx" ON "AssessmentMeasure"("createdAt");

-- CreateIndex
CREATE INDEX "AssessmentMeasure_accreditationCycleId_idx" ON "AssessmentMeasure"("accreditationCycleId");

-- CreateIndex
CREATE INDEX "SelfStudySection_createdAt_idx" ON "SelfStudySection"("createdAt");

-- CreateIndex
CREATE INDEX "SelfStudySection_accreditationCycleId_idx" ON "SelfStudySection"("accreditationCycleId");

-- CreateIndex
CREATE INDEX "SiteVisitRequest_createdAt_idx" ON "SiteVisitRequest"("createdAt");

-- CreateIndex
CREATE INDEX "SiteVisitRequest_accreditationCycleId_idx" ON "SiteVisitRequest"("accreditationCycleId");

-- CreateIndex
CREATE INDEX "AccreditationFinding_createdAt_idx" ON "AccreditationFinding"("createdAt");

-- CreateIndex
CREATE INDEX "AccreditationFinding_accreditationCycleId_idx" ON "AccreditationFinding"("accreditationCycleId");

-- CreateIndex
CREATE INDEX "ImprovementAction_createdAt_idx" ON "ImprovementAction"("createdAt");

-- CreateIndex
CREATE INDEX "ImprovementAction_accreditationCycleId_idx" ON "ImprovementAction"("accreditationCycleId");

-- CreateIndex
CREATE INDEX "CommitteeMeeting_createdAt_idx" ON "CommitteeMeeting"("createdAt");

-- CreateIndex
CREATE INDEX "CommitteeMeeting_accreditationCycleId_idx" ON "CommitteeMeeting"("accreditationCycleId");

-- CreateIndex
CREATE INDEX "OperationalTask_createdAt_idx" ON "OperationalTask"("createdAt");

-- CreateIndex
CREATE INDEX "OperationalTask_accreditationCycleId_idx" ON "OperationalTask"("accreditationCycleId");

-- CreateIndex
CREATE INDEX "RuleVersion_createdAt_idx" ON "RuleVersion"("createdAt");

-- CreateIndex
CREATE INDEX "RuleVersion_accreditationCycleId_idx" ON "RuleVersion"("accreditationCycleId");

-- CreateIndex
CREATE INDEX "DocumentRequirement_createdAt_idx" ON "DocumentRequirement"("createdAt");

-- CreateIndex
CREATE INDEX "DocumentRequirement_accreditationCycleId_idx" ON "DocumentRequirement"("accreditationCycleId");

-- AddForeignKey
ALTER TABLE "AccreditationStandard" ADD CONSTRAINT "AccreditationStandard_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StandardEvidence" ADD CONSTRAINT "StandardEvidence_accreditationStandardId_fkey" FOREIGN KEY ("accreditationStandardId") REFERENCES "AccreditationStandard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StandardEvidence" ADD CONSTRAINT "StandardEvidence_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AssessmentMeasure" ADD CONSTRAINT "AssessmentMeasure_accreditationStandardId_fkey" FOREIGN KEY ("accreditationStandardId") REFERENCES "AccreditationStandard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AssessmentMeasure" ADD CONSTRAINT "AssessmentMeasure_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SelfStudySection" ADD CONSTRAINT "SelfStudySection_accreditationStandardId_fkey" FOREIGN KEY ("accreditationStandardId") REFERENCES "AccreditationStandard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SelfStudySection" ADD CONSTRAINT "SelfStudySection_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SiteVisitRequest" ADD CONSTRAINT "SiteVisitRequest_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccreditationFinding" ADD CONSTRAINT "AccreditationFinding_accreditationStandardId_fkey" FOREIGN KEY ("accreditationStandardId") REFERENCES "AccreditationStandard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccreditationFinding" ADD CONSTRAINT "AccreditationFinding_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ImprovementAction" ADD CONSTRAINT "ImprovementAction_accreditationFindingId_fkey" FOREIGN KEY ("accreditationFindingId") REFERENCES "AccreditationFinding"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ImprovementAction" ADD CONSTRAINT "ImprovementAction_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommitteeMeeting" ADD CONSTRAINT "CommitteeMeeting_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OperationalTask" ADD CONSTRAINT "OperationalTask_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RuleVersion" ADD CONSTRAINT "RuleVersion_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentRequirement" ADD CONSTRAINT "DocumentRequirement_accreditationCycleId_fkey" FOREIGN KEY ("accreditationCycleId") REFERENCES "AccreditationCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

