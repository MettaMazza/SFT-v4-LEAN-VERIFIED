import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.DihedralTorsionGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "unordered-or-three-site-angle"
  | .admitted => "named-ordered-four-site-carrier"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-conventional-angle"
  | .admitted => "held-cycle-orientation"

inductive Coordinate where
  | rejected | admitted

def coordinateName : Coordinate → String
  | .rejected => "continuum-rotation-coordinate"
  | .admitted => "generated-sector-successor-coordinate"

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "named-conformer-without-neighbours"
  | .admitted => "complete-neighbour-conformer-state"

inductive Barrier where
  | rejected | admitted

def barrierName : Barrier → String
  | .rejected => "imported-saddle-or-signed-difference"
  | .admitted => "local-barrier-and-ordered-positive-Take"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "duplicated-terminal-configuration"
  | .admitted => "terminal-One-identifies-anchor-class"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "angle-or-energy-target-readable"
  | .admitted => "value-free-coordinate-and-operation-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-extrema-or-one-rotor"
  | .admitted => "complete-two-rotor-fifty-row-vector"

structure Candidate where
  carrier : Carrier
  orientation : Orientation
  coordinate : Coordinate
  state : State
  barrier : Barrier
  recurrence : Recurrence
  prediction : Prediction
  record : Record

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, orientationName c.orientation, coordinateName c.coordinate, stateName c.state, barrierName c.barrier, recurrenceName c.recurrence, predictionName c.prediction, recordName c.record]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "coordinate=" (coordinateName c.coordinate), SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "barrier=" (barrierName c.barrier), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record)]
def survivorId : String := "named-ordered-four-site-carrier__held-cycle-orientation__generated-sector-successor-coordinate__complete-neighbour-conformer-state__local-barrier-and-ordered-positive-Take__terminal-One-identifies-anchor-class__value-free-coordinate-and-operation-seal__complete-two-rotor-fifty-row-vector"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "named-ordered-four-site-carrier" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-cycle-orientation" &&
  SFT.Host.Text.equal (coordinateName c.coordinate) "generated-sector-successor-coordinate" &&
  SFT.Host.Text.equal (stateName c.state) "complete-neighbour-conformer-state" &&
  SFT.Host.Text.equal (barrierName c.barrier) "local-barrier-and-ordered-positive-Take" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "terminal-One-identifies-anchor-class" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-coordinate-and-operation-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-two-rotor-fifty-row-vector"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "named-ordered-four-site-carrier") then "A dihedral cannot be identified without four ordered sites." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-cycle-orientation") then "A signed scalar imports negative proof magnitude." else
  if !(SFT.Host.Text.equal (coordinateName c.coordinate) "generated-sector-successor-coordinate") then "A continuum coordinate imports ungenerated positions." else
  if !(SFT.Host.Text.equal (stateName c.state) "complete-neighbour-conformer-state") then "A conformer name without complete neighbours cannot force local stability." else
  if !(SFT.Host.Text.equal (barrierName c.barrier) "local-barrier-and-ordered-positive-Take") then "An imported saddle equation or signed residue is outside the exact domain." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "terminal-One-identifies-anchor-class") then "Treating the complete turn endpoint as new duplicates one state." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-coordinate-and-operation-seal") then "Readable source values could select the coordinate or state result." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-two-rotor-fifty-row-vector") then "A selected subset hides ordinary, adverse or second-rotor rows." else
  "named-ordered-four-site-carrier__held-cycle-orientation__generated-sector-successor-coordinate__complete-neighbour-conformer-state__local-barrier-and-ordered-positive-Take__terminal-One-identifies-anchor-class__value-free-coordinate-and-operation-seal__complete-two-rotor-fifty-row-vector"

def generationRule : String := "Generate the literal product of ordered carrier, held orientation, sector coordinate, conformer state, barrier Take, recurrence, value-free prediction and record-completeness forms; decide all 256 from admitted exact structure and the value-free fifty-row identity surface."
def grammarBoundary : String := "The complete two-path NIST CCCBDB gauche-ethanol internal-rotation surface at its registered 24-sector observation resolution: OH torsion atoms 1-2-3-4 and CH3 torsion atoms 3-2-1-5, each with 24 unique sector states plus one recurrent endpoint, retaining molecule, state, rotor type, orientation, conformer and barrier roles, source method/condition and both energy-unit inscriptions."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Coordinate.rejected,Coordinate.admitted]).flatMap fun coordinate =>
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Barrier.rejected,Barrier.admitted]).flatMap fun barrier =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).map fun record =>
  ⟨carrier,orientation,coordinate,state,barrier,recurrence,prediction,record⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier orientation coordinate state barrier recurrence prediction record =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoordinate : coordinate ∈ [Coordinate.rejected,Coordinate.admitted] := by
      cases coordinate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbarrier : barrier ∈ [Barrier.rejected,Barrier.admitted] := by
      cases barrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ coordinate _ hcoordinate
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ barrier _ hbarrier
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    exact Count.TraceDerivation.memMap _ record _ hrecord

theorem sourceDecisionBlock0000 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock0001 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock0010 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock0011 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock0100 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock0101 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock0110 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock0111 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock1000 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock1001 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock1010 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock1011 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock1100 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock1101 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock1110 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionBlock1111 (barrier : Barrier) (recurrence : Recurrence) (prediction : Prediction) (record : Record) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,barrier,recurrence,prediction,record⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,barrier,recurrence,prediction,record⟩ := by
 cases barrier <;> cases recurrence <;> cases prediction <;> cases record <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier orientation coordinate state barrier recurrence prediction record =>
  cases carrier <;> cases orientation <;> cases coordinate <;> cases state
  · exact sourceDecisionBlock0000 barrier recurrence prediction record
  · exact sourceDecisionBlock0001 barrier recurrence prediction record
  · exact sourceDecisionBlock0010 barrier recurrence prediction record
  · exact sourceDecisionBlock0011 barrier recurrence prediction record
  · exact sourceDecisionBlock0100 barrier recurrence prediction record
  · exact sourceDecisionBlock0101 barrier recurrence prediction record
  · exact sourceDecisionBlock0110 barrier recurrence prediction record
  · exact sourceDecisionBlock0111 barrier recurrence prediction record
  · exact sourceDecisionBlock1000 barrier recurrence prediction record
  · exact sourceDecisionBlock1001 barrier recurrence prediction record
  · exact sourceDecisionBlock1010 barrier recurrence prediction record
  · exact sourceDecisionBlock1011 barrier recurrence prediction record
  · exact sourceDecisionBlock1100 barrier recurrence prediction record
  · exact sourceDecisionBlock1101 barrier recurrence prediction record
  · exact sourceDecisionBlock1110 barrier recurrence prediction record
  · exact sourceDecisionBlock1111 barrier recurrence prediction record

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "named-ordered-four-site-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-cycle-orientation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem coordinateCriterion (value : Coordinate) : SFT.Host.Text.equal (coordinateName value) "generated-sector-successor-coordinate" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem stateCriterion (value : State) : SFT.Host.Text.equal (stateName value) "complete-neighbour-conformer-state" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem barrierCriterion (value : Barrier) : SFT.Host.Text.equal (barrierName value) "local-barrier-and-ordered-positive-Take" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recurrenceCriterion (value : Recurrence) : SFT.Host.Text.equal (recurrenceName value) "terminal-One-identifies-anchor-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-coordinate-and-operation-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-two-rotor-fifty-row-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, orientationCriterion, coordinateCriterion, stateCriterion, barrierCriterion, recurrenceCriterion, predictionCriterion, recordCriterion]
  cases c with
  | mk carrier orientation coordinate state barrier recurrence prediction record =>
    cases carrier <;> cases orientation <;> cases coordinate <;> cases state <;> cases barrier <;> cases recurrence <;> cases prediction <;> cases record
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.orientation = .admitted ∧ c.coordinate = .admitted ∧ c.state = .admitted ∧ c.barrier = .admitted ∧ c.recurrence = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier orientation coordinate state barrier recurrence prediction record =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
    rw [h] at field
    cases field

theorem coordinate_rejected_rejected (c : Candidate) (h : c.coordinate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coordinate eq
    rw [h] at field
    cases field

theorem state_rejected_rejected (c : Candidate) (h : c.state = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.state eq
    rw [h] at field
    cases field

theorem barrier_rejected_rejected (c : Candidate) (h : c.barrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.barrier eq
    rw [h] at field
    cases field

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
    rw [h] at field
    cases field

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

end SFT.Chemistry.DihedralTorsionGrammar
