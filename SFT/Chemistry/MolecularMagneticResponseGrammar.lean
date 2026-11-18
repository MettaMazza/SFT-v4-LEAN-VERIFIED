import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularMagneticResponseGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-magnetic-number"
  | .admitted => "complete-molecular-state-and-angular-carrier"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-direction-as-proof-number"
  | .admitted => "opposed-held-orientation-labels"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "assume-every-carrier-has-net-moment"
  | .admitted => "pairwise-closure-to-EmptyOne-or-positive-excess"

inductive Moment where
  | rejected | admitted

def momentName : Moment → String
  | .rejected => "fitted-or-species-g-coefficient"
  | .admitted => "positive-response-per-angular-recurrence"

inductive Susceptibility where
  | rejected | admitted

def susceptibilityName : Susceptibility → String
  | .rejected => "continuum-derivative-field-law"
  | .admitted => "positive-induced-response-per-field-act"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "moment-or-susceptibility-readable-before-seal"
  | .admitted => "value-free-complete-magnetic-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "favorable-or-accessible-molecule-subset"
  | .admitted => "complete-g-factor-susceptibility-and-unavailable-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-correction-or-new-field-coefficient"
  | .admitted => "one-ratio-law-with-depth-independent-repetition"

structure Candidate where
  carrier : Carrier
  orientation : Orientation
  closure : Closure
  moment : Moment
  susceptibility : Susceptibility
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, orientationName c.orientation, closureName c.closure, momentName c.moment, susceptibilityName c.susceptibility, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "moment=" (momentName c.moment), SFT.Host.Text.append "susceptibility=" (susceptibilityName c.susceptibility), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-molecular-state-and-angular-carrier__opposed-held-orientation-labels__pairwise-closure-to-EmptyOne-or-positive-excess__positive-response-per-angular-recurrence__positive-induced-response-per-field-act__value-free-complete-magnetic-identity-seal__complete-g-factor-susceptibility-and-unavailable-custody__one-ratio-law-with-depth-independent-repetition"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-molecular-state-and-angular-carrier" &&
  SFT.Host.Text.equal (orientationName c.orientation) "opposed-held-orientation-labels" &&
  SFT.Host.Text.equal (closureName c.closure) "pairwise-closure-to-EmptyOne-or-positive-excess" &&
  SFT.Host.Text.equal (momentName c.moment) "positive-response-per-angular-recurrence" &&
  SFT.Host.Text.equal (susceptibilityName c.susceptibility) "positive-induced-response-per-field-act" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-magnetic-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-g-factor-susceptibility-and-unavailable-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-ratio-law-with-depth-independent-repetition"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-molecular-state-and-angular-carrier") then "A bare number erases molecule, state and angular support." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "opposed-held-orientation-labels") then "A signed proof scalar imports negative numbers and loses the generating side." else
  if !(SFT.Host.Text.equal (closureName c.closure) "pairwise-closure-to-EmptyOne-or-positive-excess") then "Paired complementary support can close and must not be assigned a numerical zero." else
  if !(SFT.Host.Text.equal (momentName c.moment) "positive-response-per-angular-recurrence") then "A fitted g-factor lets the measured molecule select the law." else
  if !(SFT.Host.Text.equal (susceptibilityName c.susceptibility) "positive-induced-response-per-field-act") then "A continuum derivative imports an ungenerated field model." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-magnetic-identity-seal") then "Readable targets could select the relation or molecule subset." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-g-factor-susceptibility-and-unavailable-custody") then "Selecting positive, convenient or currently accessible pages conceals blanks and source failures." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-ratio-law-with-depth-independent-repetition") then "A species residual creates a free parameter for every molecule." else
  "complete-molecular-state-and-angular-carrier__opposed-held-orientation-labels__pairwise-closure-to-EmptyOne-or-positive-excess__positive-response-per-angular-recurrence__positive-induced-response-per-field-act__value-free-complete-magnetic-identity-seal__complete-g-factor-susceptibility-and-unavailable-custody__one-ratio-law-with-depth-independent-repetition"

def generationRule : String := "Generate the literal product of carrier, orientation, closure, moment, susceptibility, prediction, record and extension forms; decide all 256 candidates from admitted exact molecular-state, spin, field and response laws."
def grammarBoundary : String := "Every generated finite molecular state with positive angular and field counts, plus all 267 molecules represented by the 215 NIST SRD 114/115/117 holding groups, every accessible triatomic/hydrocarbon constants page, every officially linked unavailable diatomic page, and the complete 162-page NIST diatomic reference-data table."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Moment.rejected,Moment.admitted]).flatMap fun moment =>
  ([Susceptibility.rejected,Susceptibility.admitted]).flatMap fun susceptibility =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,orientation,closure,moment,susceptibility,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier orientation closure moment susceptibility prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmoment : moment ∈ [Moment.rejected,Moment.admitted] := by
      cases moment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsusceptibility : susceptibility ∈ [Susceptibility.rejected,Susceptibility.admitted] := by
      cases susceptibility <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ moment _ hmoment
    apply CommonRefinement.memFlatMap _ _ susceptibility _ hsusceptibility
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (susceptibility : Susceptibility) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,susceptibility,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,susceptibility,prediction,record,extension⟩ := by
 cases susceptibility <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier orientation closure moment susceptibility prediction record extension =>
  cases carrier <;> cases orientation <;> cases closure <;> cases moment
  · exact sourceDecisionBlock0000 susceptibility prediction record extension
  · exact sourceDecisionBlock0001 susceptibility prediction record extension
  · exact sourceDecisionBlock0010 susceptibility prediction record extension
  · exact sourceDecisionBlock0011 susceptibility prediction record extension
  · exact sourceDecisionBlock0100 susceptibility prediction record extension
  · exact sourceDecisionBlock0101 susceptibility prediction record extension
  · exact sourceDecisionBlock0110 susceptibility prediction record extension
  · exact sourceDecisionBlock0111 susceptibility prediction record extension
  · exact sourceDecisionBlock1000 susceptibility prediction record extension
  · exact sourceDecisionBlock1001 susceptibility prediction record extension
  · exact sourceDecisionBlock1010 susceptibility prediction record extension
  · exact sourceDecisionBlock1011 susceptibility prediction record extension
  · exact sourceDecisionBlock1100 susceptibility prediction record extension
  · exact sourceDecisionBlock1101 susceptibility prediction record extension
  · exact sourceDecisionBlock1110 susceptibility prediction record extension
  · exact sourceDecisionBlock1111 susceptibility prediction record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-molecular-state-and-angular-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "opposed-held-orientation-labels" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem closureCriterion (value : Closure) : SFT.Host.Text.equal (closureName value) "pairwise-closure-to-EmptyOne-or-positive-excess" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem momentCriterion (value : Moment) : SFT.Host.Text.equal (momentName value) "positive-response-per-angular-recurrence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem susceptibilityCriterion (value : Susceptibility) : SFT.Host.Text.equal (susceptibilityName value) "positive-induced-response-per-field-act" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-complete-magnetic-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-g-factor-susceptibility-and-unavailable-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "one-ratio-law-with-depth-independent-repetition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, orientationCriterion, closureCriterion, momentCriterion, susceptibilityCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier orientation closure moment susceptibility prediction record extension =>
    cases carrier <;> cases orientation <;> cases closure <;> cases moment <;> cases susceptibility <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.orientation = .admitted ∧ c.closure = .admitted ∧ c.moment = .admitted ∧ c.susceptibility = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier orientation closure moment susceptibility prediction record extension =>
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

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
    rw [h] at field
    cases field

theorem moment_rejected_rejected (c : Candidate) (h : c.moment = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.moment eq
    rw [h] at field
    cases field

theorem susceptibility_rejected_rejected (c : Candidate) (h : c.susceptibility = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.susceptibility eq
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

end SFT.Chemistry.MolecularMagneticResponseGrammar
