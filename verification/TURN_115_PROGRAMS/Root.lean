import SFT.Foundation.RootEvidence
open SFT.Host.Canonical SFT.Foundation.Root SFT.Foundation.Root.Evidence

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  let decisions ← candidates.mapM fun c => match decideCandidate (candidateId c) with
    | .ok v => pure v
    | .error e => throw (IO.userError e)
  let unknown := match decideCandidate "not-a-source-candidate" with
    | .ok _ => false
    | .error e => e == "KeyError: not-a-source-candidate"
  IO.println (render (.object [
    ("registration", registration sourceHash), ("census", generateCandidates),
    ("decisions", .array decisions), ("closure", closureEvidence decisions),
    ("controls", runControls sourceHash), ("unknown_rejected", .boolean unknown)]))
