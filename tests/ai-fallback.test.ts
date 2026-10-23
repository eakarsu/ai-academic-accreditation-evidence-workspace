import { test } from "node:test";
import assert from "node:assert/strict";
import { runAiFallback, AI_FALLBACKS } from "../src/lib/ai-fallback";
const rows = [
  { title: "Standard 1 evidence", owner: "", status: "Review", amount: 0, active: false, note: "", sourceReference: "EV-1" },
  { title: "Standard 2 evidence", owner: "Sam", status: "Closed", dueAt: "2026-01-01", amount: 25 },
];
test("deterministic AI fallback is labelled aiGenerated:false with labelled sections", () => {
  const kinds = Object.keys(AI_FALLBACKS); assert.ok(kinds.length >= 3);
  for (const kind of kinds) { const r = runAiFallback(rows, kind); assert.equal(r.aiGenerated, false); assert.match(r.label, /not AI-generated/i); assert.ok(r.sections.length >= 2); assert.equal(r.recordsConsidered, 2); }
  assert.equal(runAiFallback([], kinds[0]).recordsConsidered, 0);
  assert.throws(() => runAiFallback(rows, "nope"), /Unknown fallback/);
});
test("fallback preserves false, 0 and empty values in input records", () => {
  const empty = runAiFallback([], Object.keys(AI_FALLBACKS)[0]);
  assert.equal(empty.recordsConsidered, 0);
  assert.ok(empty.metrics.some((m) => m.value === 0));
  assert.ok(empty.sections.some((s) => s.detail === "0"));
  const r = runAiFallback(rows, Object.keys(AI_FALLBACKS)[0]);
  assert.equal(JSON.parse(JSON.stringify(r)).recordsConsidered, 2);
});
