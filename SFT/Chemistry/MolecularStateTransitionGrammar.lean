import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularStateTransitionGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "transition-label-alone"
  | .admitted => "retained-molecular-carrier"

inductive Endpoints where
  | rejected | admitted

def endpointsName : Endpoints → String
  | .rejected => "unbound-final-answer"
  | .admitted => "distinct-initial-and-terminal-states"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-or-unoriented-change"
  | .admitted => "held-forward-reverse-bidirectional-or-coupled"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "absence-treated-as-number"
  | .admitted => "closed-terminal-EmptyOne"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "endpoint-only-lookup"
  | .admitted => "complete-state-transition-trace"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "nonmatching-path-concatenation"
  | .admitted => "matching-endpoint-composition"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-present-transition"
  | .admitted => "complete-presence-coupling-absence-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-selection-rule-premise"
  | .admitted => "finite-path-successor-with-no-extra-rule"

structure Candidate where
  carrier : Carrier
  endpoints : Endpoints
  orientation : Orientation
  absence : Absence
  trace : Trace
  composition : Composition
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, endpointsName c.endpoints, orientationName c.orientation, absenceName c.absence, traceName c.trace, compositionName c.composition, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "endpoints=" (endpointsName c.endpoints), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "retained-molecular-carrier__distinct-initial-and-terminal-states__held-forward-reverse-bidirectional-or-coupled__closed-terminal-EmptyOne__complete-state-transition-trace__matching-endpoint-composition__complete-presence-coupling-absence-vector__finite-path-successor-with-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "retained-molecular-carrier" &&
  SFT.Host.Text.equal (endpointsName c.endpoints) "distinct-initial-and-terminal-states" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-forward-reverse-bidirectional-or-coupled" &&
  SFT.Host.Text.equal (absenceName c.absence) "closed-terminal-EmptyOne" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-state-transition-trace" &&
  SFT.Host.Text.equal (compositionName c.composition) "matching-endpoint-composition" &&
  SFT.Host.Text.equal (recordName c.record) "complete-presence-coupling-absence-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "finite-path-successor-with-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "retained-molecular-carrier") then "A label alone erases the transforming molecular carrier." else
  if !(SFT.Host.Text.equal (endpointsName c.endpoints) "distinct-initial-and-terminal-states") then "An answer without endpoints cannot identify a state transformation." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-forward-reverse-bidirectional-or-coupled") then "A sign or erased orientation loses the observed direction class." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "closed-terminal-EmptyOne") then "Numerical absence violates the Fold domain." else
  if !(SFT.Host.Text.equal (traceName c.trace) "complete-state-transition-trace") then "Endpoints alone erase the transition record and provenance." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "matching-endpoint-composition") then "Transitions with unequal adjacent endpoints cannot form one path." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-presence-coupling-absence-vector") then "Selecting only observed rows cannot test absence or coupling records." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "finite-path-successor-with-no-extra-rule") then "A selection rule at this stage imports the next obligation." else
  "retained-molecular-carrier__distinct-initial-and-terminal-states__held-forward-reverse-bidirectional-or-coupled__closed-terminal-EmptyOne__complete-state-transition-trace__matching-endpoint-composition__complete-presence-coupling-absence-vector__finite-path-successor-with-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, endpoints, orientation, absence, trace, composition, record and extension forms. Decide all 256 forms only from admitted state-transition, observation, molecular-state and exact-composition laws."
def grammarBoundary : String := "Every positive finite molecular-state transition record and every matching finite path successor, externally tested against all 46 NIST H2 primary state rows and all 14 continuation transition rows."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Endpoints.rejected,Endpoints.admitted]).flatMap fun endpoints =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,endpoints,orientation,absence,trace,composition,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier endpoints orientation absence trace composition record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hendpoints : endpoints ∈ [Endpoints.rejected,Endpoints.admitted] := by
      cases endpoints <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ endpoints _ hendpoints
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,trace,composition,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,trace,composition,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,trace,composition,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,trace,composition,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,trace,composition,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,trace,composition,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,trace,composition,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,trace,composition,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,trace,composition,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,trace,composition,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,trace,composition,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,trace,composition,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,trace,composition,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,trace,composition,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,trace,composition,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (trace : Trace) (composition : Composition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,trace,composition,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,trace,composition,record,extension⟩ := by
 cases trace <;> cases composition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier endpoints orientation absence trace composition record extension =>
  cases carrier <;> cases endpoints <;> cases orientation <;> cases absence
  · exact sourceDecisionBlock0000 trace composition record extension
  · exact sourceDecisionBlock0001 trace composition record extension
  · exact sourceDecisionBlock0010 trace composition record extension
  · exact sourceDecisionBlock0011 trace composition record extension
  · exact sourceDecisionBlock0100 trace composition record extension
  · exact sourceDecisionBlock0101 trace composition record extension
  · exact sourceDecisionBlock0110 trace composition record extension
  · exact sourceDecisionBlock0111 trace composition record extension
  · exact sourceDecisionBlock1000 trace composition record extension
  · exact sourceDecisionBlock1001 trace composition record extension
  · exact sourceDecisionBlock1010 trace composition record extension
  · exact sourceDecisionBlock1011 trace composition record extension
  · exact sourceDecisionBlock1100 trace composition record extension
  · exact sourceDecisionBlock1101 trace composition record extension
  · exact sourceDecisionBlock1110 trace composition record extension
  · exact sourceDecisionBlock1111 trace composition record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "retained-molecular-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem endpointsCriterion (value : Endpoints) : SFT.Host.Text.equal (endpointsName value) "distinct-initial-and-terminal-states" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-forward-reverse-bidirectional-or-coupled" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "closed-terminal-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem traceCriterion (value : Trace) : SFT.Host.Text.equal (traceName value) "complete-state-transition-trace" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "matching-endpoint-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-presence-coupling-absence-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "finite-path-successor-with-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, endpointsCriterion, orientationCriterion, absenceCriterion, traceCriterion, compositionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier endpoints orientation absence trace composition record extension =>
    cases carrier <;> cases endpoints <;> cases orientation <;> cases absence <;> cases trace <;> cases composition <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.endpoints = .admitted ∧ c.orientation = .admitted ∧ c.absence = .admitted ∧ c.trace = .admitted ∧ c.composition = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier endpoints orientation absence trace composition record extension =>
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

theorem endpoints_rejected_rejected (c : Candidate) (h : c.endpoints = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.endpoints eq
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

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
    rw [h] at field
    cases field

theorem trace_rejected_rejected (c : Candidate) (h : c.trace = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trace eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.MolecularStateTransitionGrammar
