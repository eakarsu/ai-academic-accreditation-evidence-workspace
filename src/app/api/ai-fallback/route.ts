import { NextRequest, NextResponse } from "next/server";
import { requireUser } from "@/lib/api-auth";
import { runAiFallback, type FallbackRecord } from "@/lib/ai-fallback";
// Deterministic fallback over records the caller already loaded from this workspace. No provider call.
export async function POST(request: NextRequest) {
  const user = await requireUser();
  if (!user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const body = (await request.json().catch(() => ({}))) as Record<string, unknown>;
  const records = Array.isArray(body.records) ? (body.records as FallbackRecord[]) : [];
  if (records.length > 500) return NextResponse.json({ error: "At most 500 records" }, { status: 422 });
  try { return NextResponse.json({ result: runAiFallback(records, typeof body.kind === "string" ? body.kind : "evidence-coverage") }); }
  catch (e) { return NextResponse.json({ error: e instanceof Error ? e.message : "Unknown fallback kind" }, { status: 422 }); }
}
