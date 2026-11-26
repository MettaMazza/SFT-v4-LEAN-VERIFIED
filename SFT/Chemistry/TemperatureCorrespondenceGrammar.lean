import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.TemperatureCorrespondenceGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Authority where
  | rejected | admitted

def authorityName : Authority → String
  | .rejected => "chemistry-redefines-temperature"
  | .admitted => "chemistry-consumes-admitted-physics-temperature-carrier"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "composition-erased-temperature-scalar"
  | .admitted => "held-chemical-composition-identity"

inductive Condition where
  | rejected | admitted

def conditionName : Condition → String
  | .rejected => "phase-and-equilibrium-reference-erased"
  | .admitted => "held-phase-and-equilibrium-reference"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "fitted-chemical-temperature-conversion"
  | .admitted => "identity-preserving-temperature-correspondence"

inductive Equilibrium where
  | rejected | admitted

def equilibriumName : Equilibrium → String
  | .rejected => "route-or-composition-specific-temperature"
  | .admitted => "one-common-carrier-across-equilibrated-routes"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "thermometric-values-readable-before-seal"
  | .admitted => "complete-value-free-thermometric-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-thermometry-route"
  | .admitted => "complete-three-row-two-route-value-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "composition-dependent-rescaling"
  | .admitted => "append-only-composition-consequence-with-common-carrier"

structure Candidate where
  authority : Authority
  composition : Composition
  condition : Condition
  relation : Relation
  equilibrium : Equilibrium
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [authorityName c.authority, compositionName c.composition, conditionName c.condition, relationName c.relation, equilibriumName c.equilibrium, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "authority=" (authorityName c.authority), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "condition=" (conditionName c.condition), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "equilibrium=" (equilibriumName c.equilibrium), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "chemistry-consumes-admitted-physics-temperature-carrier__held-chemical-composition-identity__held-phase-and-equilibrium-reference__identity-preserving-temperature-correspondence__one-common-carrier-across-equilibrated-routes__complete-value-free-thermometric-identity-seal__complete-three-row-two-route-value-vector__append-only-composition-consequence-with-common-carrier"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (authorityName c.authority) "chemistry-consumes-admitted-physics-temperature-carrier" &&
  SFT.Host.Text.equal (compositionName c.composition) "held-chemical-composition-identity" &&
  SFT.Host.Text.equal (conditionName c.condition) "held-phase-and-equilibrium-reference" &&
  SFT.Host.Text.equal (relationName c.relation) "identity-preserving-temperature-correspondence" &&
  SFT.Host.Text.equal (equilibriumName c.equilibrium) "one-common-carrier-across-equilibrated-routes" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-thermometric-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-three-row-two-route-value-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "append-only-composition-consequence-with-common-carrier"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (authorityName c.authority) "chemistry-consumes-admitted-physics-temperature-carrier") then "A Chemistry-specific temperature law duplicates and can contradict the admitted Physics carrier." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "held-chemical-composition-identity") then "Erasing composition loses the chemical state to which a consequence belongs." else
  if !(SFT.Host.Text.equal (conditionName c.condition) "held-phase-and-equilibrium-reference") then "Without phase and reference, distinct chemical states are conflated." else
  if !(SFT.Host.Text.equal (relationName c.relation) "identity-preserving-temperature-correspondence") then "A conversion coefficient lets composition or a target rescale temperature." else
  if !(SFT.Host.Text.equal (equilibriumName c.equilibrium) "one-common-carrier-across-equilibrated-routes") then "Separate route temperatures violate common equilibrium correspondence." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-thermometric-identity-seal") then "Measured centers or uncertainties could select the correspondence." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-three-row-two-route-value-vector") then "One favorable route cannot establish route-independent correspondence." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "append-only-composition-consequence-with-common-carrier") then "A new composition-specific scale is a free parameter." else
  "chemistry-consumes-admitted-physics-temperature-carrier__held-chemical-composition-identity__held-phase-and-equilibrium-reference__identity-preserving-temperature-correspondence__one-common-carrier-across-equilibrated-routes__complete-value-free-thermometric-identity-seal__complete-three-row-two-route-value-vector__append-only-composition-consequence-with-common-carrier"

def generationRule : String := "Generate the literal product of authority, composition, condition, relation, equilibrium, prediction, record and extension forms; decide all 256 candidates only from admitted Physics temperature/equilibrium and exact Chemistry state-support laws."
def grammarBoundary : String := "Every finite set of held chemical contexts sharing one admitted Physics temperature carrier at one held equilibrium reference, with append-only composition consequences. External testing retains the exact SI carrier, the complete acoustic-argon interval and the complete independent Johnson-noise interval."

def candidates : List Candidate :=
  ([Authority.rejected,Authority.admitted]).flatMap fun authority =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Condition.rejected,Condition.admitted]).flatMap fun condition =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Equilibrium.rejected,Equilibrium.admitted]).flatMap fun equilibrium =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨authority,composition,condition,relation,equilibrium,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk authority composition condition relation equilibrium prediction record extension =>
    have hauthority : authority ∈ [Authority.rejected,Authority.admitted] := by
      cases authority <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcondition : condition ∈ [Condition.rejected,Condition.admitted] := by
      cases condition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequilibrium : equilibrium ∈ [Equilibrium.rejected,Equilibrium.admitted] := by
      cases equilibrium <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ authority _ hauthority
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ condition _ hcondition
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ equilibrium _ hequilibrium
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (equilibrium : Equilibrium) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,equilibrium,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,equilibrium,prediction,record,extension⟩ := by
 cases equilibrium <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk authority composition condition relation equilibrium prediction record extension =>
  cases authority <;> cases composition <;> cases condition <;> cases relation
  · exact sourceDecisionBlock0000 equilibrium prediction record extension
  · exact sourceDecisionBlock0001 equilibrium prediction record extension
  · exact sourceDecisionBlock0010 equilibrium prediction record extension
  · exact sourceDecisionBlock0011 equilibrium prediction record extension
  · exact sourceDecisionBlock0100 equilibrium prediction record extension
  · exact sourceDecisionBlock0101 equilibrium prediction record extension
  · exact sourceDecisionBlock0110 equilibrium prediction record extension
  · exact sourceDecisionBlock0111 equilibrium prediction record extension
  · exact sourceDecisionBlock1000 equilibrium prediction record extension
  · exact sourceDecisionBlock1001 equilibrium prediction record extension
  · exact sourceDecisionBlock1010 equilibrium prediction record extension
  · exact sourceDecisionBlock1011 equilibrium prediction record extension
  · exact sourceDecisionBlock1100 equilibrium prediction record extension
  · exact sourceDecisionBlock1101 equilibrium prediction record extension
  · exact sourceDecisionBlock1110 equilibrium prediction record extension
  · exact sourceDecisionBlock1111 equilibrium prediction record extension

theorem authorityCriterion (value : Authority) : SFT.Host.Text.equal (authorityName value) "chemistry-consumes-admitted-physics-temperature-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "held-chemical-composition-identity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem conditionCriterion (value : Condition) : SFT.Host.Text.equal (conditionName value) "held-phase-and-equilibrium-reference" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "identity-preserving-temperature-correspondence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem equilibriumCriterion (value : Equilibrium) : SFT.Host.Text.equal (equilibriumName value) "one-common-carrier-across-equilibrated-routes" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-thermometric-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-three-row-two-route-value-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "append-only-composition-consequence-with-common-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [authorityCriterion, compositionCriterion, conditionCriterion, relationCriterion, equilibriumCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk authority composition condition relation equilibrium prediction record extension =>
    cases authority <;> cases composition <;> cases condition <;> cases relation <;> cases equilibrium <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.authority = .admitted ∧ c.composition = .admitted ∧ c.condition = .admitted ∧ c.relation = .admitted ∧ c.equilibrium = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk authority composition condition relation equilibrium prediction record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem authority_rejected_rejected (c : Candidate) (h : c.authority = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.authority eq
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

theorem condition_rejected_rejected (c : Candidate) (h : c.condition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.condition eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
    rw [h] at field
    cases field

theorem equilibrium_rejected_rejected (c : Candidate) (h : c.equilibrium = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equilibrium eq
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

end SFT.Chemistry.TemperatureCorrespondenceGrammar
