import SFT.Chemistry.IsotopeExchange
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.IsotopeExchange
abbrev J := Canonical.Value
def makeState (mask : Nat) (sameIsotope sameCarrier : Bool) : Except String State := do
 construct (← heldLabel (if mask%2==0 then "element" else "wrong") "oxygen")
  (← heldLabel (if mask/2%2==0 then "isotope" else "wrong") "light")
  (← heldLabel (if mask/4%2==0 then "isotope" else "wrong") (if sameIsotope then "light" else "heavy"))
  (← heldLabel (if mask/8%2==0 then "chemical-carrier" else "wrong") "A")
  (← heldLabel (if mask/16%2==0 then "chemical-carrier" else "wrong") (if sameCarrier then "A" else "B"))
  (← count 4) (← count 2) (← count 3) (← count 1)
def stateValue : Except String State → J
 | .error e => .object [("error",.text e)]
 | .ok s => .object [("ok",.array [.integer (.ofNat (quotient s).1),.integer (.ofNat (quotient s).2)])]
def resultValue : Except String Value → J
 | .error e => .object [("error",.text e)]
 | .ok (.emptyOne i) => .object [("ok",.text i)]
 | .ok (.label l) => .object [("ok",.array [.text l.family,.text l.label])]
 | .ok (.pair (.label l) (.count n)) => .object [("ok",.array [.text l.family,.text l.label,.integer (.ofNat n.value)])]
 | _ => .null

def main : IO Unit := do
 let mut constructors := []
 for mask in List.range 32 do
  for si in [false,true] do
   for sc in [false,true] do
    constructors := constructors++[stateValue (makeState mask si sc)]
 let mut states := [before,after]
 for la in [1,2] do
  for ha in [1,2] do
   for lb in [1,2] do
    for hb in [1,2] do
     states := states++[state la ha lb hb]
 let mut transitions := []
 for a in states do
  for b in states do
   transitions := transitions++[resultValue (do exchangeTransition (← a) (← b))]
 let mismatch := do
  let b ← after
  exchangeTransition (← before) {b with element := ← heldLabel "element" "other"}
 transitions := transitions++[resultValue mismatch]
 let mut events := []
 for f in [1,2,3,4] do
  for r in [1,2,3,4] do
   events := events++[resultValue (do eventBalance (← count f) (← count r))]
 IO.println (Canonical.render (.object [("constructors",.array constructors),("states",.array (states.map stateValue)),("transitions",.array transitions),("events",.array events),("witnesses",.array ([identityWitness,carriersWitness,inventoryWitness,conservationWitness,directionWitness,quotientWitness,equilibriumWitness,successorWitness].map Canonical.Value.boolean))]))
