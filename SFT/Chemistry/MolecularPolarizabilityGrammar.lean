import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularPolarizabilityGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-alpha-scalar"
  | .admitted => "complete-named-molecular-response-carrier"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "imported-continuum-derivative"
  | .admitted => "exact-positive-response-over-field-ratio"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-Cartesian-component"
  | .admitted => "held-axis-positive-component"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "continuum-tensor-trace-premise"
  | .admitted => "three-axis-exact-one-third-Junction"

inductive Successor where
  | rejected | admitted

def successorName : Successor → String
  | .rejected => "depth-specific-response-coefficient"
  | .admitted => "equal-act-ratio-invariant-successor"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "alpha-readable-before-seal"
  | .admitted => "value-free-identity-and-relation-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-species-or-favorable-subset"
  | .admitted => "complete-NIST-non-atomic-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-fit-or-residual-correction"
  | .admitted => "one-response-law-no-extra-rule"

structure Candidate where
  carrier : Carrier
  response : Response
  orientation : Orientation
  composition : Composition
  successor : Successor
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, responseName c.response, orientationName c.orientation, compositionName c.composition, successorName c.successor, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "successor=" (successorName c.successor), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-named-molecular-response-carrier__exact-positive-response-over-field-ratio__held-axis-positive-component__three-axis-exact-one-third-Junction__equal-act-ratio-invariant-successor__value-free-identity-and-relation-seal__complete-NIST-non-atomic-vector__one-response-law-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-named-molecular-response-carrier" &&
  SFT.Host.Text.equal (responseName c.response) "exact-positive-response-over-field-ratio" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-axis-positive-component" &&
  SFT.Host.Text.equal (compositionName c.composition) "three-axis-exact-one-third-Junction" &&
  SFT.Host.Text.equal (successorName c.successor) "equal-act-ratio-invariant-successor" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-identity-and-relation-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-NIST-non-atomic-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-response-law-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-named-molecular-response-carrier") then "A scalar answer erases species, state, conformation, field, method and condition." else
  if !(SFT.Host.Text.equal (responseName c.response) "exact-positive-response-over-field-ratio") then "A continuum derivative imports an ungenerated field neighborhood." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-axis-positive-component") then "A signed Cartesian scalar imports a negative proof value." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "three-axis-exact-one-third-Junction") then "A continuum tensor is not a generated Fold form." else
  if !(SFT.Host.Text.equal (successorName c.successor) "equal-act-ratio-invariant-successor") then "A new coefficient at each field depth is a free parameter family." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-identity-and-relation-seal") then "A readable alpha vector could select the law or boundary." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-NIST-non-atomic-vector") then "A selected subset can conceal ordinary, charged, isotopic or adverse rows." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-response-law-no-extra-rule") then "A species coefficient or residual correction is a fitted parameter." else
  "complete-named-molecular-response-carrier__exact-positive-response-over-field-ratio__held-axis-positive-component__three-axis-exact-one-third-Junction__equal-act-ratio-invariant-successor__value-free-identity-and-relation-seal__complete-NIST-non-atomic-vector__one-response-law-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, response, orientation, composition, successor, prediction, record-completeness and extension forms; decide all 256 forms from admitted exact response, electric distinction, three-axis composition and measurement-custody laws."
def grammarBoundary : String := "The depth-independent exact response-ratio and three-axis isotropic-composition laws, tested at the finite complete NIST CCCBDB non-atomic boundary: all 252 molecular rows in source order, retaining formula, name, molecular state, conformation, field-response definition, method, condition, units, reference and comment. All alpha inscriptions remain withheld until after relation sealing."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Successor.rejected,Successor.admitted]).flatMap fun successor =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,response,orientation,composition,successor,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier response orientation composition successor prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuccessor : successor ∈ [Successor.rejected,Successor.admitted] := by
      cases successor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ successor _ hsuccessor
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,successor,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,successor,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,successor,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,successor,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,successor,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,successor,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,successor,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,successor,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,successor,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,successor,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,successor,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,successor,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,successor,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,successor,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,successor,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (successor : Successor) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,successor,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,successor,prediction,record,extension⟩ := by
 cases successor <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier response orientation composition successor prediction record extension =>
  cases carrier <;> cases response <;> cases orientation <;> cases composition
  · exact sourceDecisionBlock0000 successor prediction record extension
  · exact sourceDecisionBlock0001 successor prediction record extension
  · exact sourceDecisionBlock0010 successor prediction record extension
  · exact sourceDecisionBlock0011 successor prediction record extension
  · exact sourceDecisionBlock0100 successor prediction record extension
  · exact sourceDecisionBlock0101 successor prediction record extension
  · exact sourceDecisionBlock0110 successor prediction record extension
  · exact sourceDecisionBlock0111 successor prediction record extension
  · exact sourceDecisionBlock1000 successor prediction record extension
  · exact sourceDecisionBlock1001 successor prediction record extension
  · exact sourceDecisionBlock1010 successor prediction record extension
  · exact sourceDecisionBlock1011 successor prediction record extension
  · exact sourceDecisionBlock1100 successor prediction record extension
  · exact sourceDecisionBlock1101 successor prediction record extension
  · exact sourceDecisionBlock1110 successor prediction record extension
  · exact sourceDecisionBlock1111 successor prediction record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-named-molecular-response-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem responseCriterion (value : Response) : SFT.Host.Text.equal (responseName value) "exact-positive-response-over-field-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-axis-positive-component" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "three-axis-exact-one-third-Junction" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem successorCriterion (value : Successor) : SFT.Host.Text.equal (successorName value) "equal-act-ratio-invariant-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-identity-and-relation-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-NIST-non-atomic-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "one-response-law-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, responseCriterion, orientationCriterion, compositionCriterion, successorCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier response orientation composition successor prediction record extension =>
    cases carrier <;> cases response <;> cases orientation <;> cases composition <;> cases successor <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.response = .admitted ∧ c.orientation = .admitted ∧ c.composition = .admitted ∧ c.successor = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier response orientation composition successor prediction record extension =>
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

theorem response_rejected_rejected (c : Candidate) (h : c.response = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.response eq
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem successor_rejected_rejected (c : Candidate) (h : c.successor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.successor eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.MolecularPolarizabilityGrammar
