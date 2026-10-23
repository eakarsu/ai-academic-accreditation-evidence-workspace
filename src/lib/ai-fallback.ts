// Deterministic domain AI fallback — no provider calls. Labelled aiGenerated:false.
export const FALLBACK_LABEL = "Deterministic fallback — not AI-generated";
export type FallbackRecord = Record<string, unknown>;
export interface FallbackResult { aiGenerated: false; label: string; source: "deterministic-fallback"; kind: string; headline: string; recordsConsidered: number; metrics: { label: string; value: string | number | boolean }[]; sections: { title: string; detail: string }[] }
const text = (v: unknown) => (v == null ? "" : String(v));
const num = (v: unknown) => { const n = Number(v); return Number.isFinite(n) ? n : 0; };
function base(kind: string, headline: string, rows: FallbackRecord[], sections: { title: string; detail: string }[], metrics: FallbackResult["metrics"]): FallbackResult {
  return { aiGenerated: false, label: FALLBACK_LABEL, source: "deterministic-fallback", kind, headline, recordsConsidered: rows.length, metrics, sections };
}
function gaps(rows: FallbackRecord[]) { return rows.filter((r) => !text(r.owner).trim() || !(r.dueAt ?? r.due_at ?? r.dueDate) || !text(r.title ?? r.name ?? r.reference).trim()); }
function attention(rows: FallbackRecord[]) { return rows.filter((r) => ["High", "Critical"].includes(text(r.risk)) || ["Review", "Investigating", "In Progress"].includes(text(r.status))).length; }
export function evidenceCoverageSummary(rows: FallbackRecord[] = []): FallbackResult {
  const withEvidence = rows.filter((r) => text(r.sourceReference ?? r.evidence ?? r.description).trim()).length;
  return base("evidence-coverage", "Accreditation evidence coverage (deterministic)", rows, [
    { title: "Records reviewed", detail: String(rows.length) },
    { title: "Records with evidence reference", detail: String(withEvidence) },
    { title: "Records without evidence reference", detail: String(rows.length - withEvidence) },
  ], [{ label: "Records", value: rows.length }, { label: "With evidence", value: withEvidence }, { label: "Without evidence", value: rows.length - withEvidence }]);
}
export function assessmentGapReview(rows: FallbackRecord[] = []): FallbackResult {
  const g = gaps(rows);
  return base("assessment-gap", "Assessment gap review (deterministic)", rows, [
    { title: "Records reviewed", detail: String(rows.length) },
    { title: "Records missing owner, due date, or title", detail: String(g.length) },
    { title: "Attention queue", detail: String(attention(rows)) },
  ], [{ label: "Records", value: rows.length }, { label: "Gaps", value: g.length }, { label: "Attention", value: attention(rows) }]);
}
export function ownerWorkloadSummary(rows: FallbackRecord[] = []): FallbackResult {
  const byOwner: Record<string, number> = {};
  for (const r of rows) { const k = text(r.owner).trim() || "(unassigned)"; byOwner[k] = (byOwner[k] || 0) + 1; }
  return base("owner-workload", "Owner workload summary (deterministic)", rows, [
    { title: "Records reviewed", detail: String(rows.length) },
    { title: "Unassigned records", detail: String(byOwner["(unassigned)"] || 0) },
    { title: "By owner", detail: JSON.stringify(byOwner) },
  ], [{ label: "Records", value: rows.length }, { label: "Unassigned", value: byOwner["(unassigned)"] || 0 }, { label: "Total amount", value: rows.reduce((s, r) => s + num(r.amount), 0) }]);
}
export const AI_FALLBACKS = { "evidence-coverage": evidenceCoverageSummary, "assessment-gap": assessmentGapReview, "owner-workload": ownerWorkloadSummary } as const;
export type AiFallbackKind = keyof typeof AI_FALLBACKS;
export function runAiFallback(rows: FallbackRecord[], kind: string): FallbackResult {
  const fn = (AI_FALLBACKS as Record<string, (r: FallbackRecord[]) => FallbackResult>)[kind];
  if (!fn) throw new Error(`Unknown fallback kind: ${kind}`);
  return fn(rows || []);
}
