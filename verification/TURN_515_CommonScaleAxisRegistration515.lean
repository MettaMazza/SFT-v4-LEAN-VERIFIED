import SFT.Physics.CommonScaleAxisEvidence
open SFT.Host.Canonical SFT.Physics
 def main (args : List String) : IO Unit := do
  let unknown := match CommonScaleAxisEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
   | .error e => e
   | .ok _ => "incorrectly accepted"
  IO.println (render (.object [("registration",CommonScaleAxisEvidence.registration (args.headD "")),("unknown_id",.text unknown)]))
