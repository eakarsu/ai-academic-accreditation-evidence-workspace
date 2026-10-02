export interface PageConfig {
  label: string;
  href: string;
  description: string;
  entities: string[];
  workflows: string[];
}

export interface EntityConfig {
  name: string;
  label: string;
  fields: Array<{ name: string; kind: "string" | "number" | "boolean" | "date" }>;
}

export interface WorkflowConfig {
  slug: string;
  title: string;
  description: string;
  prompt: string;
  fields: string[];
}

export const appConfig = {
  "slug": "ai-academic-accreditation-evidence-workspace",
  "title": "Academic Accreditation Evidence Workspace",
  "tagline": "Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions.",
  "accent": "rose"
};
export const pages: PageConfig[] = [
  {
    "label": "Intake & registers",
    "href": "/registers",
    "description": "Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions.",
    "entities": [
      "AccreditationCycle",
      "AccreditationStandard",
      "StandardEvidence"
    ],
    "workflows": [
      "standard-evidence-mapping",
      "assessment-gap-review"
    ]
  },
  {
    "label": "Operational records",
    "href": "/workflow",
    "description": "Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions.",
    "entities": [
      "AssessmentMeasure",
      "SelfStudySection",
      "SiteVisitRequest"
    ],
    "workflows": [
      "self-study-section-drafting",
      "site-visit-response-preparation"
    ]
  },
  {
    "label": "Review & delivery",
    "href": "/delivery",
    "description": "Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions.",
    "entities": [
      "AccreditationFinding",
      "ImprovementAction",
      "CommitteeMeeting"
    ],
    "workflows": [
      "finding-response-draft",
      "improvement-narrative"
    ]
  },
  {
    "label": "Tasks & requirements",
    "href": "/operations",
    "description": "Assignments, versioned rules and document requirements.",
    "entities": [
      "OperationalTask",
      "RuleVersion",
      "DocumentRequirement"
    ],
    "workflows": [
      "evidence-completeness-review",
      "operations-handoff-draft"
    ]
  }
];
export const entities: Record<string, EntityConfig> = {
  "AccreditationCycle": {
    "name": "AccreditationCycle",
    "label": "Accreditation Cycle",
    "fields": [
      {
        "name": "name",
        "kind": "string"
      },
      {
        "name": "institution",
        "kind": "string"
      },
      {
        "name": "accreditor",
        "kind": "string"
      },
      {
        "name": "frameworkVersion",
        "kind": "string"
      },
      {
        "name": "cycleStart",
        "kind": "date"
      },
      {
        "name": "visitAt",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      }
    ]
  },
  "AccreditationStandard": {
    "name": "AccreditationStandard",
    "label": "Accreditation Standard",
    "fields": [
      {
        "name": "name",
        "kind": "string"
      },
      {
        "name": "standardCode",
        "kind": "string"
      },
      {
        "name": "requirementText",
        "kind": "string"
      },
      {
        "name": "owner",
        "kind": "string"
      },
      {
        "name": "dueAt",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  },
  "StandardEvidence": {
    "name": "StandardEvidence",
    "label": "Standard Evidence",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "accreditationStandardId",
        "kind": "string"
      },
      {
        "name": "sourceReference",
        "kind": "string"
      },
      {
        "name": "collectedAt",
        "kind": "date"
      },
      {
        "name": "owner",
        "kind": "string"
      },
      {
        "name": "description",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  },
  "AssessmentMeasure": {
    "name": "AssessmentMeasure",
    "label": "Assessment Measure",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "accreditationStandardId",
        "kind": "string"
      },
      {
        "name": "metric",
        "kind": "string"
      },
      {
        "name": "target",
        "kind": "number"
      },
      {
        "name": "observed",
        "kind": "number"
      },
      {
        "name": "periodEnd",
        "kind": "date"
      },
      {
        "name": "method",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  },
  "SelfStudySection": {
    "name": "SelfStudySection",
    "label": "Self Study Section",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "accreditationStandardId",
        "kind": "string"
      },
      {
        "name": "narrative",
        "kind": "string"
      },
      {
        "name": "sourceReferences",
        "kind": "string"
      },
      {
        "name": "author",
        "kind": "string"
      },
      {
        "name": "revisedAt",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  },
  "SiteVisitRequest": {
    "name": "SiteVisitRequest",
    "label": "Site Visit Request",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "requester",
        "kind": "string"
      },
      {
        "name": "requestedAt",
        "kind": "date"
      },
      {
        "name": "dueAt",
        "kind": "date"
      },
      {
        "name": "requestText",
        "kind": "string"
      },
      {
        "name": "evidenceReference",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  },
  "AccreditationFinding": {
    "name": "AccreditationFinding",
    "label": "Accreditation Finding",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "accreditationStandardId",
        "kind": "string"
      },
      {
        "name": "findingText",
        "kind": "string"
      },
      {
        "name": "receivedAt",
        "kind": "date"
      },
      {
        "name": "severity",
        "kind": "string"
      },
      {
        "name": "responseDueAt",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  },
  "ImprovementAction": {
    "name": "ImprovementAction",
    "label": "Improvement Action",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "accreditationFindingId",
        "kind": "string"
      },
      {
        "name": "action",
        "kind": "string"
      },
      {
        "name": "owner",
        "kind": "string"
      },
      {
        "name": "dueAt",
        "kind": "date"
      },
      {
        "name": "evidence",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  },
  "CommitteeMeeting": {
    "name": "CommitteeMeeting",
    "label": "Committee Meeting",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "heldAt",
        "kind": "date"
      },
      {
        "name": "chair",
        "kind": "string"
      },
      {
        "name": "participants",
        "kind": "string"
      },
      {
        "name": "decisions",
        "kind": "string"
      },
      {
        "name": "followUp",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  },
  "OperationalTask": {
    "name": "OperationalTask",
    "label": "Operational Task",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "owner",
        "kind": "string"
      },
      {
        "name": "priority",
        "kind": "string"
      },
      {
        "name": "startAt",
        "kind": "date"
      },
      {
        "name": "dueAt",
        "kind": "date"
      },
      {
        "name": "done",
        "kind": "boolean"
      },
      {
        "name": "notes",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  },
  "RuleVersion": {
    "name": "RuleVersion",
    "label": "Rule Version",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "jurisdiction",
        "kind": "string"
      },
      {
        "name": "version",
        "kind": "string"
      },
      {
        "name": "effectiveAt",
        "kind": "date"
      },
      {
        "name": "expiresAt",
        "kind": "date"
      },
      {
        "name": "sourceUrl",
        "kind": "string"
      },
      {
        "name": "requirementText",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  },
  "DocumentRequirement": {
    "name": "DocumentRequirement",
    "label": "Document Requirement",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "category",
        "kind": "string"
      },
      {
        "name": "requiredBy",
        "kind": "date"
      },
      {
        "name": "sourceReference",
        "kind": "string"
      },
      {
        "name": "evidenceReference",
        "kind": "string"
      },
      {
        "name": "reviewNotes",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "accreditationCycleId",
        "kind": "string"
      }
    ]
  }
};
export const workflows: WorkflowConfig[] = [
  {
    "slug": "standard-evidence-mapping",
    "title": "Standard evidence mapping",
    "description": "Standard evidence mapping using selected accreditation cycle records and supplied evidence.",
    "prompt": "Standard evidence mapping for Academic Accreditation Evidence Workspace. Operational scope: Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions. Specific AI scope: Find evidence gaps and draft traceable self-study sections. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "assessment-gap-review",
    "title": "Assessment gap review",
    "description": "Assessment gap review using selected accreditation cycle records and supplied evidence.",
    "prompt": "Assessment gap review for Academic Accreditation Evidence Workspace. Operational scope: Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions. Specific AI scope: Find evidence gaps and draft traceable self-study sections. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "self-study-section-drafting",
    "title": "Self-study section drafting",
    "description": "Self-study section drafting using selected accreditation cycle records and supplied evidence.",
    "prompt": "Self-study section drafting for Academic Accreditation Evidence Workspace. Operational scope: Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions. Specific AI scope: Find evidence gaps and draft traceable self-study sections. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "site-visit-response-preparation",
    "title": "Site visit response preparation",
    "description": "Site visit response preparation using selected accreditation cycle records and supplied evidence.",
    "prompt": "Site visit response preparation for Academic Accreditation Evidence Workspace. Operational scope: Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions. Specific AI scope: Find evidence gaps and draft traceable self-study sections. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "finding-response-draft",
    "title": "Finding response draft",
    "description": "Finding response draft using selected accreditation cycle records and supplied evidence.",
    "prompt": "Finding response draft for Academic Accreditation Evidence Workspace. Operational scope: Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions. Specific AI scope: Find evidence gaps and draft traceable self-study sections. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "improvement-narrative",
    "title": "Improvement narrative",
    "description": "Improvement narrative using selected accreditation cycle records and supplied evidence.",
    "prompt": "Improvement narrative for Academic Accreditation Evidence Workspace. Operational scope: Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions. Specific AI scope: Find evidence gaps and draft traceable self-study sections. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "evidence-completeness-review",
    "title": "Evidence completeness review",
    "description": "Evidence completeness review using selected accreditation cycle records and supplied evidence.",
    "prompt": "Evidence completeness review for Academic Accreditation Evidence Workspace. Operational scope: Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions. Specific AI scope: Find evidence gaps and draft traceable self-study sections. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "operations-handoff-draft",
    "title": "Operations handoff draft",
    "description": "Operations handoff draft using selected accreditation cycle records and supplied evidence.",
    "prompt": "Operations handoff draft for Academic Accreditation Evidence Workspace. Operational scope: Map standards to evidence, owners, assessment cycles, site-visit requests and corrective actions. Specific AI scope: Find evidence gaps and draft traceable self-study sections. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  }
];
export function findPage(href:string){return pages.find(p=>p.href===href);}
