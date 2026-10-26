import SFT.Foundation.RootEvidence
open SFT.Host.Canonical SFT.Foundation.Root.Evidence

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned v3 source manifest hash")
  IO.println (render (.object [
    ("registration", registration sourceHash),
    ("census", generateCandidates),
    ("decisions", .array (SFT.Foundation.Root.candidates.map candidateDecision)),
    ("closure", closureEvidence (SFT.Foundation.Root.candidates.map candidateDecision)),
    ("controls", runControls sourceHash)]))
