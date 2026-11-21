import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RealGasExchangeGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "unbound-fugacity-number"
  | .admitted => "complete-gas-component-exchange-account"

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "erased-pressure-temperature-or-composition"
  | .admitted => "complete-held-pressure-temperature-composition-state"

inductive Component where
  | rejected | admitted

def componentName : Component → String
  | .rejected => "bulk-mixture-answer-without-component-identity"
  | .admitted => "held-component-resolved-exchange-support"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "imported-fugacity-eos-or-fitted-correction"
  | .admitted => "exact-accessible-over-reference-support-relation"

inductive Equilibrium where
  | rejected | admitted

def equilibriumName : Equilibrium → String
  | .rejected => "assumed-ideal-gas-or-target-derived-balance"
  | .admitted => "exact-component-exchange-support-balance"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "real-gas-values-readable-before-seal"
  | .admitted => "complete-value-free-94-state-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-mixture-or-deleted-pressure-only-state"
  | .admitted => "complete-21-dataset-176-point-94-state-record"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-after-exact-support-replication"
  | .admitted => "depth-independent-common-support-replication"

structure Candidate where
  carrier : Carrier
  state : State
  component : Component
  relation : Relation
  equilibrium : Equilibrium
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, stateName c.state, componentName c.component, relationName c.relation, equilibriumName c.equilibrium, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "component=" (componentName c.component), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "equilibrium=" (equilibriumName c.equilibrium), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-gas-component-exchange-account__complete-held-pressure-temperature-composition-state__held-component-resolved-exchange-support__exact-accessible-over-reference-support-relation__exact-component-exchange-support-balance__complete-value-free-94-state-identity-seal__complete-21-dataset-176-point-94-state-record__depth-independent-common-support-replication"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-gas-component-exchange-account" &&
  SFT.Host.Text.equal (stateName c.state) "complete-held-pressure-temperature-composition-state" &&
  SFT.Host.Text.equal (componentName c.component) "held-component-resolved-exchange-support" &&
  SFT.Host.Text.equal (relationName c.relation) "exact-accessible-over-reference-support-relation" &&
  SFT.Host.Text.equal (equilibriumName c.equilibrium) "exact-component-exchange-support-balance" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-94-state-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-21-dataset-176-point-94-state-record" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-support-replication"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-gas-component-exchange-account") then "An unbound scalar erases the component exchange support and gas state it names." else
  if !(SFT.Host.Text.equal (stateName c.state) "complete-held-pressure-temperature-composition-state") then "Erasing a held coordinate merges distinguishable real-gas states." else
  if !(SFT.Host.Text.equal (componentName c.component) "held-component-resolved-exchange-support") then "A bulk answer cannot preserve which component exchanges across the phase boundary." else
  if !(SFT.Host.Text.equal (relationName c.relation) "exact-accessible-over-reference-support-relation") then "An imported equation or fitted correction lets an external model select the answer." else
  if !(SFT.Host.Text.equal (equilibriumName c.equilibrium) "exact-component-exchange-support-balance") then "Assumed ideality or target-derived adjustment does not force phase exchange." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-94-state-identity-seal") then "Readable values could select or tune the generated law." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-21-dataset-176-point-94-state-record") then "Selection would hide the complete favorable, adverse and incomplete-measurement surface." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-support-replication") then "Refitting after replication destroys the exact support relation." else
  "complete-gas-component-exchange-account__complete-held-pressure-temperature-composition-state__held-component-resolved-exchange-support__exact-accessible-over-reference-support-relation__exact-component-exchange-support-balance__complete-value-free-94-state-identity-seal__complete-21-dataset-176-point-94-state-record__depth-independent-common-support-replication"

def generationRule : String := "Generate the literal product of carrier, state, component, relation, equilibrium, prediction, record and extension forms; decide all 256 candidates only from admitted finite-support, component-exchange, phase-equilibrium, held-coordinate and exact-replication laws."
def grammarBoundary : String := "Every finite gas-mixture component exchange account with held component, gas phase, pressure, temperature, composition, accessible/reference/independent support and partner-phase support. External testing preserves the complete NIST TRC ThermoML source: five compounds, 21 datasets, 176 raw points, seven direct pressure datasets, three paired vapor-composition datasets and all 94 equilibrium states."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Component.rejected,Component.admitted]).flatMap fun component =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Equilibrium.rejected,Equilibrium.admitted]).flatMap fun equilibrium =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,state,component,relation,equilibrium,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier state component relation equilibrium prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomponent : component ∈ [Component.rejected,Component.admitted] := by
      cases component <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
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
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ component _ hcomponent
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
 | mk carrier state component relation equilibrium prediction record extension =>
  cases carrier <;> cases state <;> cases component <;> cases relation
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

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-gas-component-exchange-account" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem stateCriterion (value : State) : SFT.Host.Text.equal (stateName value) "complete-held-pressure-temperature-composition-state" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem componentCriterion (value : Component) : SFT.Host.Text.equal (componentName value) "held-component-resolved-exchange-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "exact-accessible-over-reference-support-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem equilibriumCriterion (value : Equilibrium) : SFT.Host.Text.equal (equilibriumName value) "exact-component-exchange-support-balance" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-94-state-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-21-dataset-176-point-94-state-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-common-support-replication" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, stateCriterion, componentCriterion, relationCriterion, equilibriumCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier state component relation equilibrium prediction record extension =>
    cases carrier <;> cases state <;> cases component <;> cases relation <;> cases equilibrium <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.state = .admitted ∧ c.component = .admitted ∧ c.relation = .admitted ∧ c.equilibrium = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier state component relation equilibrium prediction record extension =>
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

theorem state_rejected_rejected (c : Candidate) (h : c.state = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.state eq
    rw [h] at field
    cases field

theorem component_rejected_rejected (c : Candidate) (h : c.component = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.component eq
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

end SFT.Chemistry.RealGasExchangeGrammar
