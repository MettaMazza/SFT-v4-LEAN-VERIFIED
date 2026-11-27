import SFT.Materials.BulkWaterEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in BulkWaterGrammar.candidates do
    match BulkWaterEvidence.decideCandidate (BulkWaterEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match BulkWaterEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("ledger",.object [("required_fields",.array (BulkWater.certificate.requiredFields.map SFT.Host.Canonical.Value.text)),("field_count",.object [("value",.integer (.ofNat BulkWater.certificate.fieldCount.value))]),("complete",.boolean BulkWater.certificate.complete)]),
    ("registration",BulkWaterEvidence.registration sourceHash),
    ("census",BulkWaterEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",BulkWaterEvidence.closure decisions),
    ("controls",BulkWaterEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
