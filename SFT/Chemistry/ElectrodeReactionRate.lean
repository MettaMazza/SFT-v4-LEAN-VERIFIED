import SFT.Chemistry.ComponentExchange
namespace SFT.Chemistry.ElectrodeReactionRate
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Foundation.ExactOperations SFT.Chemistry.DihedralTorsion
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure ElectrodeEventLedger where
 reaction : HeldLabel
 interface : HeldLabel
 condition : HeldLabel
 potentialOrientation : HeldLabel
 forwardEvents : PositiveCount
 reverseEvents : PositiveCount
 resourceIntervals : PositiveCount
structure ElectrodeRate where
 direction : HeldLabel
 netEventRate : Height
 completeEventRate : Ratio
 ledger : ElectrodeEventLedger
def makeLedger (reaction interface condition orientation : HeldLabel) (forward reverse intervals : CountInput) : Except String ElectrodeEventLedger := do
 if !Text.equal reaction.family "electrode-reaction" || !Text.equal interface.family "electrode-interface" ||
  !Text.equal condition.family "electrochemical-condition" || !Text.equal orientation.family "potential-orientation" then
  throw "reaction/interface/condition/potential custody required"
 let readCount := fun c=>match c with
  | CountInput.count n => Except.ok n
  | .other => Except.error "rate ledger uses positive exact counts"
 pure ⟨reaction,interface,condition,orientation,← readCount forward,← readCount reverse,← readCount intervals⟩
def electrodeRate (row : ElectrodeEventLedger) : ElectrodeRate :=
 let f := row.forwardEvents
 let r := row.reverseEvents
 let t := row.resourceIntervals
 let (direction,net) : HeldLabel×Height := if h : f.value=r.value then
   (⟨"reaction-rate-direction","balanced",rfl,rfl⟩,Height.emptyOne)
  else if higher : r.value<f.value then
   (⟨"reaction-rate-direction","forward",rfl,rfl⟩,Height.ratio (rawRatio (normalizePositive (f.value-r.value) t.value (SFT.Foundation.ExactCast.subtractPositive _ _ higher) t.positive)))
  else
   (⟨"reaction-rate-direction","reverse",rfl,rfl⟩,Height.ratio (rawRatio (normalizePositive (r.value-f.value) t.value
    (SFT.Foundation.ExactCast.subtractPositive _ _ (Nat.lt_of_le_of_ne (Nat.le_of_not_lt higher) h)) t.positive)))
 ⟨direction,net,rawRatio (normalizePositive (f.value+r.value) t.value (Nat.add_pos_left f.positive _) t.positive),row⟩
def exampleLedger (f r : Nat) : Except String ElectrodeEventLedger := do
 makeLedger (← heldLabel "electrode-reaction" "r") (← heldLabel "electrode-interface" "i")
  (← heldLabel "electrochemical-condition" "c") (← heldLabel "potential-orientation" "held")
  (.count (← count f)) (.count (← count r)) (.count (← count 2))
def witnesses : Except String (List Bool) := do
 let a := electrodeRate (← exampleLedger 5 1)
 let b := electrodeRate (← exampleLedger 1 5)
 let c := electrodeRate (← exampleLedger 3 3)
 let d := electrodeRate (← exampleLedger 6 1)
 pure [Text.equal a.direction.label "forward",Text.equal b.direction.label "reverse",
  equalHeight a.netEventRate (.ratio ⟨⟨2,by decide⟩,⟨1,by decide⟩⟩),equalHeight c.netEventRate .emptyOne,
  equalHeight (.ratio a.completeEventRate) (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩),Text.equal a.ledger.reaction.label "r",
  Text.equal a.ledger.condition.label "c",equalHeight d.netEventRate (.ratio ⟨⟨5,by decide⟩,⟨2,by decide⟩⟩)]
theorem originalEightWitnesses : witnesses = .ok [true,true,true,true,true,true,true,true] := rfl
end SFT.Chemistry.ElectrodeReactionRate
