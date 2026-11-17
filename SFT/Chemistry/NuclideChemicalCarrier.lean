import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.NuclideChemicalCarrier
open SFT.Host SFT.Physics.CapabilityValues
structure Carrier where
 element : HeldLabel
 nucleonCount : PositiveCount
 nuclearState : HeldLabel
 species : HeldLabel
 phase : HeldLabel
 occurrence : PositiveCount

def validFamilies (r : Carrier) : Bool :=
 Text.equal r.element.family "element" && Text.equal r.nuclearState.family "nuclear-state" &&
 Text.equal r.species.family "chemical-species" && Text.equal r.phase.family "chemical-phase"
def construct (element : HeldLabel) (nucleonCount : PositiveCount) (nuclearState species phase : HeldLabel)
 (occurrence : PositiveCount) : Except String Carrier :=
 let r := Carrier.mk element nucleonCount nuclearState species phase occurrence
 if validFamilies r then .ok r else .error "complete nuclide chemical carrier required"
def withOccurrence (r : Carrier) (n : PositiveCount) : Except String Carrier :=
 construct r.element r.nucleonCount r.nuclearState r.species r.phase n

theorem occurrenceReplacement (r : Carrier) (n : PositiveCount) (valid : validFamilies r = true) :
 withOccurrence r n = .ok {r with occurrence := n} := by
 unfold withOccurrence construct
 change ((if validFamilies r then .ok {r with occurrence := n} else .error "complete nuclide chemical carrier required") : Except String Carrier) = _
 rw [valid]
 rfl

def original : Except String Carrier := do
 construct (← heldLabel "element" "strontium") (← count 90) (← heldLabel "nuclear-state" "held")
  (← heldLabel "chemical-species" "solution-carrier") (← heldLabel "chemical-phase" "aqueous") (← count 1)
def check (predicate : Carrier → Bool) : Bool := match original with
 | .error _ => false
 | .ok r => predicate r
def elementWitness : Bool := check (fun r => Text.equal r.element.label "strontium")
def nuclideWitness : Bool := check (fun r => r.nucleonCount.value==90)
def stateWitness : Bool := check (fun r => Text.equal r.nuclearState.label "held")
def speciesWitness : Bool := check (fun r => Text.equal r.species.label "solution-carrier")
def phaseWitness : Bool := check (fun r => Text.equal r.phase.label "aqueous")
def occurrenceWitness : Bool := check (fun r => r.occurrence.value==1)
def distinctWitness : Bool := check (fun r =>
 !(Text.equal r.element.family r.species.family) && !(Text.equal r.element.family r.phase.family) &&
 !(Text.equal r.species.family r.phase.family))
def successorWitness : Bool := check (fun r =>
 match count 2 >>= withOccurrence r with
 | .error _ => false
 | .ok next => Text.equal next.species.family r.species.family && Text.equal next.species.label r.species.label)
theorem elementWitnessPassed : elementWitness = true := by rfl
theorem nuclideWitnessPassed : nuclideWitness = true := by rfl
theorem stateWitnessPassed : stateWitness = true := by rfl
theorem speciesWitnessPassed : speciesWitness = true := by rfl
theorem phaseWitnessPassed : phaseWitness = true := by rfl
theorem occurrenceWitnessPassed : occurrenceWitness = true := by rfl
theorem distinctWitnessPassed : distinctWitness = true := by rfl
theorem successorWitnessPassed : successorWitness = true := by rfl
end SFT.Chemistry.NuclideChemicalCarrier
