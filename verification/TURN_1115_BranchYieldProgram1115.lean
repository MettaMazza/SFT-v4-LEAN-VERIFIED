import SFT.Chemistry.RadioactiveBranchYield
open SFT.Chemistry.RadioactiveBranchYield SFT.Host SFT.Physics.CapabilityValues
abbrev J := Canonical.Value
def ratio (p : PositiveCount × PositiveCount) : J :=
 let q := reduced p
 .array [.integer (.ofNat p.1.value),.integer (.ofNat p.2.value),.integer (.ofNat q.1),.integer (.ofNat q.2)]
def result (r : Except String BranchYield) : J := match r with
 | .error e => .object [("error",.text e)]
 | .ok r => .object [("ok",ratio (recovery r))]
def partitionResult (rs : List BranchYield) : J := match branchPartition rs with
 | .error e => .object [("error",.text e)]
 | .ok ps => .object [("ok",.array (ps.map ratio))]
def main : IO Unit := do
 let mut cases : List J := []
 for mask in List.range 4 do
  for e in List.range 6 do
   for r in List.range 6 do
    let row := do
     construct (← heldLabel (if mask%2==0 then "decay-channel" else "wrong") "c")
      (← heldLabel (if mask/2==0 then "daughter-species" else "wrong") "d") (← count e) (← count r)
    cases := cases ++ [result row]
 let a ← IO.ofExcept (original 1 3 2)
 let b ← IO.ofExcept (original 2 1 1)
 let c ← IO.ofExcept (original 3 2 1)
 let other ← IO.ofExcept (heldLabel "daughter-species" "other")
 let four ← IO.ofExcept (count 4)
 let networks := [[],[a],[a,b],[b,a],[a,b,c],[a,a],[a,{a with daughterSpecies := other}],[a,{a with events := four}]]
 IO.println (Canonical.render (.object [("cases",.array cases),("partitions",.array (networks.map partitionResult)),
  ("witnesses",.array ([channelWitness,daughterWitness,eventsWitness,recoveryWitness,yieldWitness,partitionWitness,completeWitness,successorWitness].map Canonical.Value.boolean))]))
