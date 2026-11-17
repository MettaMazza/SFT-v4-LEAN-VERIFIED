import SFT.Chemistry.RadiochemicalSeparation
open SFT.Chemistry.RadiochemicalSeparation SFT.Physics.CapabilityValues
def makeLedger (ft fc pt pc wt wc : Nat) (t : String := "Sc") (c : String := "V") : Except String Ledger := do
 construct (← heldLabel "target-species" t) (← heldLabel "contaminant-species" c)
  (← count ft) (← count fc) (← count pt) (← count pc) (← count wt) (← count wc)
def valueText : Except String Value → String
 | .error _ => "error"
 | .ok (.emptyOne _) => "empty-One"
 | .ok (.count n) => toString n.value
 | _ => "unexpected"
def display : Except String Ledger → String
 | .error _ => "error"
 | .ok l => let r := recovery l; let d := decontaminationFactor l
            s!"{r.1}/{r.2},{d.1}/{d.2},{valueText (completeRecovery l)}"
def main : IO Unit := do
 for pt in [1,2,3] do
  for pc in [1,2,3] do
   for wt in [1,2,3] do
    for wc in [1,2,3] do
     for delta in [0,1] do
      IO.println s!"ledger:{pt},{pc},{wt},{wc},{delta}:{display (makeLedger (pt+wt+delta) (pc+wc) pt pc wt wc)}"
 for f in [1,2,3,4,5] do
  for p in [1,2,3,4,5] do
   IO.println s!"residual:{f},{p}:{valueText (do residualCustody (← count f) (← count p))}"
 IO.println ("same-label:" ++ display (makeLedger 10 12 8 2 2 10 "Sc" "Sc"))
