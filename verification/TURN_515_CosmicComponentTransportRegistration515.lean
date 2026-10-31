import SFT.Physics.CosmicComponentTransportEvidence
open SFT.Host.Canonical SFT.Physics
 def main (args : List String) : IO Unit := do
  let unknown := match CosmicComponentTransportEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
   | .error e => e
   | .ok _ => "incorrectly accepted"
  IO.println (render (.object [("registration",CosmicComponentTransportEvidence.registration (args.headD "")),("unknown_id",.text unknown)]))
