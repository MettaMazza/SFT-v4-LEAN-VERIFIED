import SFT.Chemistry.RadioactiveChemicalTransformation
open SFT.Chemistry.RadioactiveChemicalTransformation SFT.Host SFT.Host.Canonical SFT.Physics.CapabilityValues

def labelValue (x : HeldLabel) : Canonical.Value := .array [.text x.family,.text x.label]
def edgeValue (e : Edge) : Canonical.Value := .array [labelValue e.parent,labelValue e.daughter,labelValue e.parentSpecies,labelValue e.daughterSpecies,labelValue e.channel,.integer (.ofNat e.events.value)]
def result (x : Except String Edge) : Canonical.Value := match x with
 | .ok e => .object [("ok",edgeValue e)]
 | .error e => .object [("error",.text e)]
def networkValue (x : Except String Network) : Canonical.Value := match x with
 | .error e => .object [("error",.text e)]
 | .ok .emptyOne => .text "EmptyOne"
 | .ok (.edges es) => .array (es.map edgeValue)
def main : IO Unit := do
 let mut cases : List Canonical.Value := []
 for mask in List.range 32 do
  for n in [0,1,2] do
   let family (i : Nat) (name : String) := if mask / 2^i % 2 == 0 then name else "wrong"
   let x := do
    construct (← heldLabel (family 0 "parent-nuclide") "p") (← heldLabel (family 1 "daughter-nuclide") "d")
     (← heldLabel (family 2 "parent-species") "ps") (← heldLabel (family 3 "daughter-species") "ds")
     (← heldLabel (family 4 "decay-channel") "1") (← count n)
   cases := cases ++ [result x]
 let a ← IO.ofExcept (original 1)
 let b ← IO.ofExcept (original 2)
 let changedSpecies ← IO.ofExcept (heldLabel "parent-species" "other")
 let changedCount ← IO.ofExcept (count 3)
 let networks := [[],[a],[a,b],[b,a],[a,a],[a,{a with parentSpecies := changedSpecies}],
  [a,{a with events := changedCount}],[a,b,a]]
 IO.println (render (.object [("cases",.array cases),("networks",.array (networks.map (networkValue ∘ network))),
  ("witnesses",.array ([parentWitness,daughterWitness,speciesWitness,channelWitness,eventsWitness,networkWitness,absenceWitness,successorWitness].map Canonical.Value.boolean))]))
