import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ConcentrationDependenceGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Reactant where
  | rejected | admitted

def reactantName : Reactant → String
  | .rejected => "anonymous-or-changing-reactant"
  | .admitted => "one-held-registered-reactant-identity"

inductive Intervention where
  | rejected | admitted

def interventionName : Intervention → String
  | .rejected => "concentration-erased-or-continuum-variable"
  | .admitted => "exact-positive-concentration-support-per-row"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "answer-only-rate-or-unregistered-change"
  | .admitted => "exact-positive-elementary-rate-response-per-row"

inductive Condition where
  | rejected | admitted

def conditionName : Condition → String
  | .rejected => "temperature-method-or-uncertainty-collapsed"
  | .admitted => "complete-held-condition-method-and-uncertainty-record"

inductive Completeness where
  | rejected | admitted

def completenessName : Completeness → String
  | .rejected => "selected-favorable-rows-or-averaged-answer"
  | .admitted => "complete-source-ordered-row-census"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "imported-mass-action-power-order-fit-or-logarithm"
  | .admitted => "exact-condition-bound-concentration-rate-table"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "species-condition-density-rate-or-value-readable-before-seal"
  | .admitted => "complete-value-free-9-row-identity-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-after-complete-row-append"
  | .admitted => "depth-independent-complete-row-append-with-prior-trace-preserved"

structure Candidate where
  reactant : Reactant
  intervention : Intervention
  response : Response
  condition : Condition
  completeness : Completeness
  relation : Relation
  prediction : Prediction
  extension : Extension

def sourceFields (c : Candidate) : List String := [reactantName c.reactant, interventionName c.intervention, responseName c.response, conditionName c.condition, completenessName c.completeness, relationName c.relation, predictionName c.prediction, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "reactant=" (reactantName c.reactant), SFT.Host.Text.append "intervention=" (interventionName c.intervention), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "condition=" (conditionName c.condition), SFT.Host.Text.append "completeness=" (completenessName c.completeness), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-held-registered-reactant-identity__exact-positive-concentration-support-per-row__exact-positive-elementary-rate-response-per-row__complete-held-condition-method-and-uncertainty-record__complete-source-ordered-row-census__exact-condition-bound-concentration-rate-table__complete-value-free-9-row-identity-seal__depth-independent-complete-row-append-with-prior-trace-preserved"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (reactantName c.reactant) "one-held-registered-reactant-identity" &&
  SFT.Host.Text.equal (interventionName c.intervention) "exact-positive-concentration-support-per-row" &&
  SFT.Host.Text.equal (responseName c.response) "exact-positive-elementary-rate-response-per-row" &&
  SFT.Host.Text.equal (conditionName c.condition) "complete-held-condition-method-and-uncertainty-record" &&
  SFT.Host.Text.equal (completenessName c.completeness) "complete-source-ordered-row-census" &&
  SFT.Host.Text.equal (relationName c.relation) "exact-condition-bound-concentration-rate-table" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-9-row-identity-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-complete-row-append-with-prior-trace-preserved"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (reactantName c.reactant) "one-held-registered-reactant-identity") then "Rows for different reactants cannot define one dependence relation." else
  if !(SFT.Host.Text.equal (interventionName c.intervention) "exact-positive-concentration-support-per-row") then "Erasing the intervention coordinate destroys the tested dependence." else
  if !(SFT.Host.Text.equal (responseName c.response) "exact-positive-elementary-rate-response-per-row") then "A detached response cannot be traced to a transition." else
  if !(SFT.Host.Text.equal (conditionName c.condition) "complete-held-condition-method-and-uncertainty-record") then "Condition collapse can manufacture a dependency." else
  if !(SFT.Host.Text.equal (completenessName c.completeness) "complete-source-ordered-row-census") then "Selection or averaging erases adverse and distinct responses." else
  if !(SFT.Host.Text.equal (relationName c.relation) "exact-condition-bound-concentration-rate-table") then "An imported exponent or fit could choose the relation." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-9-row-identity-seal") then "Readable targets could select the law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-complete-row-append-with-prior-trace-preserved") then "Refitting would alter prior evidence." else
  "one-held-registered-reactant-identity__exact-positive-concentration-support-per-row__exact-positive-elementary-rate-response-per-row__complete-held-condition-method-and-uncertainty-record__complete-source-ordered-row-census__exact-condition-bound-concentration-rate-table__complete-value-free-9-row-identity-seal__depth-independent-complete-row-append-with-prior-trace-preserved"

def generationRule : String := "Generate the literal product of reactant, intervention, response, condition, completeness, relation, prediction and extension forms; decide all 256 candidates only from admitted exact arithmetic, intervention, observation, transition-rate, condition, record-retention, EmptyOne and finite-successor laws."
def grammarBoundary : String := "Every finite source-bound concentration/rate census for one registered reactant with exact positive concentration and rate supports and complete condition, method, uncertainty and row provenance. External testing preserves all nine rows, columns, uncertainties and notes in the complete primary-source Table 2."

def candidates : List Candidate :=
  ([Reactant.rejected,Reactant.admitted]).flatMap fun reactant =>
  ([Intervention.rejected,Intervention.admitted]).flatMap fun intervention =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Condition.rejected,Condition.admitted]).flatMap fun condition =>
  ([Completeness.rejected,Completeness.admitted]).flatMap fun completeness =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨reactant,intervention,response,condition,completeness,relation,prediction,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk reactant intervention response condition completeness relation prediction extension =>
    have hreactant : reactant ∈ [Reactant.rejected,Reactant.admitted] := by
      cases reactant <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hintervention : intervention ∈ [Intervention.rejected,Intervention.admitted] := by
      cases intervention <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcondition : condition ∈ [Condition.rejected,Condition.admitted] := by
      cases condition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcompleteness : completeness ∈ [Completeness.rejected,Completeness.admitted] := by
      cases completeness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ reactant _ hreactant
    apply CommonRefinement.memFlatMap _ _ intervention _ hintervention
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ condition _ hcondition
    apply CommonRefinement.memFlatMap _ _ completeness _ hcompleteness
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (completeness : Completeness) (relation : Relation) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,completeness,relation,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,completeness,relation,prediction,extension⟩ := by
 cases completeness <;> cases relation <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk reactant intervention response condition completeness relation prediction extension =>
  cases reactant <;> cases intervention <;> cases response <;> cases condition
  · exact sourceDecisionBlock0000 completeness relation prediction extension
  · exact sourceDecisionBlock0001 completeness relation prediction extension
  · exact sourceDecisionBlock0010 completeness relation prediction extension
  · exact sourceDecisionBlock0011 completeness relation prediction extension
  · exact sourceDecisionBlock0100 completeness relation prediction extension
  · exact sourceDecisionBlock0101 completeness relation prediction extension
  · exact sourceDecisionBlock0110 completeness relation prediction extension
  · exact sourceDecisionBlock0111 completeness relation prediction extension
  · exact sourceDecisionBlock1000 completeness relation prediction extension
  · exact sourceDecisionBlock1001 completeness relation prediction extension
  · exact sourceDecisionBlock1010 completeness relation prediction extension
  · exact sourceDecisionBlock1011 completeness relation prediction extension
  · exact sourceDecisionBlock1100 completeness relation prediction extension
  · exact sourceDecisionBlock1101 completeness relation prediction extension
  · exact sourceDecisionBlock1110 completeness relation prediction extension
  · exact sourceDecisionBlock1111 completeness relation prediction extension

theorem reactantCriterion (value : Reactant) : SFT.Host.Text.equal (reactantName value) "one-held-registered-reactant-identity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem interventionCriterion (value : Intervention) : SFT.Host.Text.equal (interventionName value) "exact-positive-concentration-support-per-row" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem responseCriterion (value : Response) : SFT.Host.Text.equal (responseName value) "exact-positive-elementary-rate-response-per-row" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem conditionCriterion (value : Condition) : SFT.Host.Text.equal (conditionName value) "complete-held-condition-method-and-uncertainty-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem completenessCriterion (value : Completeness) : SFT.Host.Text.equal (completenessName value) "complete-source-ordered-row-census" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "exact-condition-bound-concentration-rate-table" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-9-row-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-complete-row-append-with-prior-trace-preserved" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [reactantCriterion, interventionCriterion, responseCriterion, conditionCriterion, completenessCriterion, relationCriterion, predictionCriterion, extensionCriterion]
  cases c with
  | mk reactant intervention response condition completeness relation prediction extension =>
    cases reactant <;> cases intervention <;> cases response <;> cases condition <;> cases completeness <;> cases relation <;> cases prediction <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.reactant = .admitted ∧ c.intervention = .admitted ∧ c.response = .admitted ∧ c.condition = .admitted ∧ c.completeness = .admitted ∧ c.relation = .admitted ∧ c.prediction = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk reactant intervention response condition completeness relation prediction extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem reactant_rejected_rejected (c : Candidate) (h : c.reactant = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reactant eq
    rw [h] at field
    cases field

theorem intervention_rejected_rejected (c : Candidate) (h : c.intervention = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.intervention eq
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

theorem condition_rejected_rejected (c : Candidate) (h : c.condition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.condition eq
    rw [h] at field
    cases field

theorem completeness_rejected_rejected (c : Candidate) (h : c.completeness = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.completeness eq
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

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
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

end SFT.Chemistry.ConcentrationDependenceGrammar
