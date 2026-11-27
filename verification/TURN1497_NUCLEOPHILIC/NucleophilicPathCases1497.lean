import SFT.Chemistry.NucleophilicWitnesses
open SFT.Chemistry SFT.Chemistry.NucleophilicCarrier SFT.Chemistry.NucleophilicPath SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def result {α : Type} (name : String) (x : Except String α) : J := .object [("case",.text name),("error",.text (match x with | .ok _ => "accepted" | .error e => e))]
def main : IO Unit := do
 let (c,one,two) ← IO.ofExcept NucleophilicWitnesses.sourcePaths
 let edge ← IO.ofExcept (itemAt one.transitions 0)
 let fresh ← IO.ofExcept (do pair (← electron "fresh1") (← electron "fresh2"))
 let label ← IO.ofExcept (heldLabel "substitution-action" "cleave-displaced-support")
 let other ← IO.ofExcept (heldLabel "other" "fresh")
 IO.println (SFT.Host.Canonical.render (.array [
  result "short" (forcedPath c [c.source] []),
  result "wrong_source" (forcedPath c one.states.reverse one.transitions),
  result "gap" (forcedPath c one.states [{edge with occurrence:=⟨2,by decide⟩}]),
  result "adjacency" (forcedPath c one.states [{edge with entry:=one.terminal}]),
  result "action" (forcedPath c one.states [{edge with action:=label}]),
  result "old_successor" (extend c two c.centre fresh),
  result "wrong_successor_family" (extend c two other fresh)]))
