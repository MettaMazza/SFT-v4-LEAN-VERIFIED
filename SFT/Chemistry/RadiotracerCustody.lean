import SFT.Chemistry.IsotopeExchange
namespace SFT.Chemistry.RadiotracerCustody
open SFT.Host SFT.Physics.CapabilityValues
structure Observation where
 tracer : HeldLabel
 chemicalCarrier : HeldLabel
 location : HeldLabel
 rank : PositiveCount
 observedEvents : PositiveCount
 administeredEvents : PositiveCount

def construct (t c l : HeldLabel) (rank observed administered : PositiveCount) : Except String Observation := do
 if !(Text.equal t.family "radiotracer" && Text.equal c.family "chemical-carrier" && Text.equal l.family "observation-location") then
  throw "complete radiotracer identity and location required"
 if observed.value > administered.value then throw "observed tracer cannot exceed administered custody"
 return ⟨t,c,l,rank,observed,administered⟩
def recovery (row : Observation) : Nat × Nat :=
 let n := row.observedEvents.value
 let d := row.administeredEvents.value
 let g := Nat.gcd n d
 (n/g,d/g)
def unobserved (row : Observation) : Value :=
 match row.administeredEvents.value-row.observedEvents.value with
 | 0 => .emptyOne "empty-One"
 | n+1 => .count ⟨n+1,Nat.zero_lt_succ n⟩
def completeSequence : Nat → List Observation → Bool
 | _,[] => true
 | n,r::rs => r.rank.value == n && completeSequence (n+1) rs
def commonIdentity : List Observation → Bool
 | [] => false
 | r::rs => rs.all fun s => IsotopeExchange.sameLabel s.tracer r.tracer && IsotopeExchange.sameLabel s.chemicalCarrier r.chemicalCarrier
abbrev RecordRow := HeldLabel × (Nat × Nat) × Value
def project (row : Observation) : RecordRow := (row.location,recovery row,unobserved row)
def tracerRecord (rows : List Observation) : Except String (List RecordRow) := do
 if rows.isEmpty || !completeSequence 1 rows then throw "complete ordered tracer support required"
 if !commonIdentity rows then throw "tracer or chemical identity changed"
 return rows.map project

def row (rank observed administered : Nat) (location : String) : Except String Observation := do
 construct (← heldLabel "radiotracer" "Tc-99m") (← heldLabel "chemical-carrier" "pertechnetate") (← heldLabel "observation-location" location) (← count rank) (← count observed) (← count administered)
def first : Except String Observation := row 1 3 5 "inlet"
def second : Except String Observation := row 2 4 5 "outlet"
def rows : Except String (List Observation) := do return [← first,← second]
def identityWitness : Bool := match first with
 | .ok r => Text.equal r.tracer.label "Tc-99m" && Text.equal r.chemicalCarrier.label "pertechnetate"
 | .error _ => false
def supportWitness : Bool := match rows with
 | .ok rs => rs.map (fun r => r.rank.value) == [1,2]
 | .error _ => false
def locationsWitness : Bool := match first,second with
 | .ok a,.ok b => !IsotopeExchange.sameLabel a.location b.location
 | .error _,_ | _,.error _ => false
def eventsWitness : Bool := match first with
 | .ok r => r.observedEvents.value == 3 && r.administeredEvents.value == 5
 | .error _ => false
def recoveryWitness : Bool := match first with
 | .ok r => recovery r == (3,5)
 | .error _ => false
def lossWitness : Bool := match first,row 1 5 5 "one" with
 | .ok a,.ok b => match unobserved a with
  | .count n => match unobserved b with
   | .emptyOne _ => n.value == 2
   | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false
  | .emptyOne _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false
 | .error _,.ok _ | .ok _,.error _ | .error _,.error _ => false
def inferenceWitness : Bool := match (do tracerRecord (← rows)) with
 | .ok rs => rs.length == 2
 | .error _ => false
def successorWitness : Bool := match (do tracerRecord ((← rows)++[← row 3 5 5 "terminal"])) with
 | .ok rs => rs.length == 3
 | .error _ => false
theorem identityWitnessPassed : identityWitness = true := rfl
theorem supportWitnessPassed : supportWitness = true := rfl
theorem locationsWitnessPassed : locationsWitness = true := rfl
theorem eventsWitnessPassed : eventsWitness = true := rfl
theorem recoveryWitnessPassed : recoveryWitness = true := rfl
theorem lossWitnessPassed : lossWitness = true := rfl
theorem inferenceWitnessPassed : inferenceWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl

theorem acceptedRecordExact (rows : List Observation) (result : List RecordRow)
 (accepted : tracerRecord rows = .ok result) : result = rows.map project := by
 unfold tracerRecord at accepted
 cases guard0 : (rows.isEmpty || !completeSequence 1 rows) with
 | true => rw [guard0] at accepted; cases accepted
 | false =>
  rw [guard0] at accepted
  cases guard1 : (!commonIdentity rows) with
  | true => rw [guard1] at accepted; cases accepted
  | false =>
   rw [guard1] at accepted
   exact (Except.ok.inj accepted).symm

theorem completeExtensionPreservesRecord (prior extra : List Observation) (before after : List RecordRow)
 (oldAccepted : tracerRecord prior = .ok before)
 (newAccepted : tracerRecord (prior++extra) = .ok after) :
 after = before ++ extra.map project := by
 rw [acceptedRecordExact _ _ newAccepted, acceptedRecordExact _ _ oldAccepted]
 have mapped : ∀ xs : List Observation, (xs++extra).map project = xs.map project ++ extra.map project := by
  intro xs
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons (project x)) ih
 exact mapped prior

theorem successorPreservesRecord (prior : List Observation) (next : Observation) (before after : List RecordRow)
 (oldAccepted : tracerRecord prior = .ok before)
 (newAccepted : tracerRecord (prior++[next]) = .ok after) :
 after = before ++ [project next] := completeExtensionPreservesRecord prior [next] before after oldAccepted newAccepted
end SFT.Chemistry.RadiotracerCustody
