import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.SelectionRuleGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-rule"
  | .admitted => "retained-endpoint-signatures"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "channel-independent-permission"
  | .admitted => "declared-observation-class"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "untracked-spin-support"
  | .admitted => "direct-multiplicity-retention"

inductive Inversion where
  | rejected | admitted

def inversionName : Inversion → String
  | .rejected => "same-fibre-direct-image"
  | .admitted => "known-inversion-fibre-change"

inductive Axis where
  | rejected | admitted

def axisName : Axis → String
  | .rejected => "arbitrary-axis-jump"
  | .admitted => "same-or-neighbour-axis-support"

inductive Mediation where
  | rejected | admitted

def mediationName : Mediation → String
  | .rejected => "exception-erases-law"
  | .admitted => "non-direct-requires-retained-mediator"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-or-universal-forbidden"
  | .admitted => "channel-closed-EmptyOne"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-success-only"
  | .admitted => "complete-adverse-inclusive-vector"

structure Candidate where
  carrier : Carrier
  observation : Observation
  multiplicity : Multiplicity
  inversion : Inversion
  axis : Axis
  mediation : Mediation
  absence : Absence
  record : Record

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, observationName c.observation, multiplicityName c.multiplicity, inversionName c.inversion, axisName c.axis, mediationName c.mediation, absenceName c.absence, recordName c.record]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "inversion=" (inversionName c.inversion), SFT.Host.Text.append "axis=" (axisName c.axis), SFT.Host.Text.append "mediation=" (mediationName c.mediation), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "record=" (recordName c.record)]
def survivorId : String := "retained-endpoint-signatures__declared-observation-class__direct-multiplicity-retention__known-inversion-fibre-change__same-or-neighbour-axis-support__non-direct-requires-retained-mediator__channel-closed-EmptyOne__complete-adverse-inclusive-vector"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "retained-endpoint-signatures" &&
  SFT.Host.Text.equal (observationName c.observation) "declared-observation-class" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "direct-multiplicity-retention" &&
  SFT.Host.Text.equal (inversionName c.inversion) "known-inversion-fibre-change" &&
  SFT.Host.Text.equal (axisName c.axis) "same-or-neighbour-axis-support" &&
  SFT.Host.Text.equal (mediationName c.mediation) "non-direct-requires-retained-mediator" &&
  SFT.Host.Text.equal (absenceName c.absence) "channel-closed-EmptyOne" &&
  SFT.Host.Text.equal (recordName c.record) "complete-adverse-inclusive-vector"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "retained-endpoint-signatures") then "A selection answer without state endpoints erases the chemical carrier." else
  if !(SFT.Host.Text.equal (observationName c.observation) "declared-observation-class") then "One universal yes/no label erases which observation operation was applied." else
  if !(SFT.Host.Text.equal (multiplicityName c.multiplicity) "direct-multiplicity-retention") then "Changing a retained support count in one direct Fold action erases a distinction." else
  if !(SFT.Host.Text.equal (inversionName c.inversion) "known-inversion-fibre-change") then "When both inversion fibres are known, an unchanged fibre supplies no direct observation distinction." else
  if !(SFT.Host.Text.equal (axisName c.axis) "same-or-neighbour-axis-support") then "One observation action cannot cross more than one generated axis recurrence." else
  if !(SFT.Host.Text.equal (mediationName c.mediation) "non-direct-requires-retained-mediator") then "Calling every observed exception direct destroys the closed distinction." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "channel-closed-EmptyOne") then "An empty source cell is neither a number nor a universal prohibition." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-adverse-inclusive-vector") then "Keeping only ordinary transitions hides couplings, absences and mediated cases." else
  "retained-endpoint-signatures__declared-observation-class__direct-multiplicity-retention__known-inversion-fibre-change__same-or-neighbour-axis-support__non-direct-requires-retained-mediator__channel-closed-EmptyOne__complete-adverse-inclusive-vector"

def generationRule : String := "Generate the literal product of endpoint, observation-class, multiplicity, inversion, axis, mediation, absence and complete-record forms. Decide all 256 forms only from admitted Fold observation, information-retention, state-symmetry and molecular-transition laws."
def grammarBoundary : String := "Every positive finite Fold axis recurrence under one direct observation action, together with mediated finite compositions and the complete registered NIST H2 transition, coupling, absence and adverse-note surface."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Inversion.rejected,Inversion.admitted]).flatMap fun inversion =>
  ([Axis.rejected,Axis.admitted]).flatMap fun axis =>
  ([Mediation.rejected,Mediation.admitted]).flatMap fun mediation =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Record.rejected,Record.admitted]).map fun record =>
  ⟨carrier,observation,multiplicity,inversion,axis,mediation,absence,record⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier observation multiplicity inversion axis mediation absence record =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinversion : inversion ∈ [Inversion.rejected,Inversion.admitted] := by
      cases inversion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haxis : axis ∈ [Axis.rejected,Axis.admitted] := by
      cases axis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmediation : mediation ∈ [Mediation.rejected,Mediation.admitted] := by
      cases mediation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ inversion _ hinversion
    apply CommonRefinement.memFlatMap _ _ axis _ haxis
    apply CommonRefinement.memFlatMap _ _ mediation _ hmediation
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    exact Count.TraceDerivation.memMap _ record _ hrecord

theorem sourceDecisionBlock0000 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,axis,mediation,absence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0001 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,axis,mediation,absence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0010 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,axis,mediation,absence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0011 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,axis,mediation,absence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0100 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,axis,mediation,absence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0101 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,axis,mediation,absence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0110 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,axis,mediation,absence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0111 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,axis,mediation,absence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1000 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,axis,mediation,absence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1001 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,axis,mediation,absence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1010 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,axis,mediation,absence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1011 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,axis,mediation,absence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1100 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,axis,mediation,absence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1101 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,axis,mediation,absence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1110 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,axis,mediation,absence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1111 (axis : Axis) (mediation : Mediation) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,axis,mediation,absence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,axis,mediation,absence,record⟩ := by
 cases axis <;> cases mediation <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier observation multiplicity inversion axis mediation absence record =>
  cases carrier <;> cases observation <;> cases multiplicity <;> cases inversion
  · exact sourceDecisionBlock0000 axis mediation absence record
  · exact sourceDecisionBlock0001 axis mediation absence record
  · exact sourceDecisionBlock0010 axis mediation absence record
  · exact sourceDecisionBlock0011 axis mediation absence record
  · exact sourceDecisionBlock0100 axis mediation absence record
  · exact sourceDecisionBlock0101 axis mediation absence record
  · exact sourceDecisionBlock0110 axis mediation absence record
  · exact sourceDecisionBlock0111 axis mediation absence record
  · exact sourceDecisionBlock1000 axis mediation absence record
  · exact sourceDecisionBlock1001 axis mediation absence record
  · exact sourceDecisionBlock1010 axis mediation absence record
  · exact sourceDecisionBlock1011 axis mediation absence record
  · exact sourceDecisionBlock1100 axis mediation absence record
  · exact sourceDecisionBlock1101 axis mediation absence record
  · exact sourceDecisionBlock1110 axis mediation absence record
  · exact sourceDecisionBlock1111 axis mediation absence record

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "retained-endpoint-signatures" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "declared-observation-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem multiplicityCriterion (value : Multiplicity) : SFT.Host.Text.equal (multiplicityName value) "direct-multiplicity-retention" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem inversionCriterion (value : Inversion) : SFT.Host.Text.equal (inversionName value) "known-inversion-fibre-change" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem axisCriterion (value : Axis) : SFT.Host.Text.equal (axisName value) "same-or-neighbour-axis-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem mediationCriterion (value : Mediation) : SFT.Host.Text.equal (mediationName value) "non-direct-requires-retained-mediator" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "channel-closed-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-adverse-inclusive-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, observationCriterion, multiplicityCriterion, inversionCriterion, axisCriterion, mediationCriterion, absenceCriterion, recordCriterion]
  cases c with
  | mk carrier observation multiplicity inversion axis mediation absence record =>
    cases carrier <;> cases observation <;> cases multiplicity <;> cases inversion <;> cases axis <;> cases mediation <;> cases absence <;> cases record
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.observation = .admitted ∧ c.multiplicity = .admitted ∧ c.inversion = .admitted ∧ c.axis = .admitted ∧ c.mediation = .admitted ∧ c.absence = .admitted ∧ c.record = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier observation multiplicity inversion axis mediation absence record =>
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

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
    rw [h] at field
    cases field

theorem multiplicity_rejected_rejected (c : Candidate) (h : c.multiplicity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.multiplicity eq
    rw [h] at field
    cases field

theorem inversion_rejected_rejected (c : Candidate) (h : c.inversion = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.inversion eq
    rw [h] at field
    cases field

theorem axis_rejected_rejected (c : Candidate) (h : c.axis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.axis eq
    rw [h] at field
    cases field

theorem mediation_rejected_rejected (c : Candidate) (h : c.mediation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mediation eq
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

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

end SFT.Chemistry.SelectionRuleGrammar
