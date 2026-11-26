import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.KineticIsotopeEffectGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "isotopologue-identities-collapsed-or-replaced-by-numerical-mass"
  | .admitted => "two-distinct-held-isotopologue-identities"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "different-truncated-or-answer-only-paths-compared"
  | .admitted => "same-complete-reaction-path-and-condition"

inductive Rate where
  | rejected | admitted

def rateName : Rate → String
  | .rejected => "imported-rate-law-continuum-time-or-fitted-rate"
  | .admitted => "completed-events-per-exact-positive-observation-parts"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "imported-KIE-mass-frequency-exponent-or-statistical-law"
  | .admitted => "ordered-quotient-of-two-exact-positive-event-rates"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-difference-negative-or-zero-number"
  | .admitted => "positive-ratio-plus-held-greater-less-or-equal-orientation"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "selected-average-or-single-favorable-isotope-effect"
  | .admitted => "complete-90-rate-ratio-3-decay-and-adverse-vector"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "experimental-fitted-calculated-and-interpretive-records-mixed"
  | .admitted => "experimental-vectors-separated-from-source-models-and-review-questions"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "rate-ratio-value-workbook-or-target-readable-before-seal"
  | .admitted => "value-free-71-record-identity-seal-and-depth-independent-pair-successor"

structure Candidate where
  identity : Identity
  path : Path
  rate : Rate
  relation : Relation
  orientation : Orientation
  observation : Observation
  provenance : Provenance
  prediction : Prediction

def sourceFields (c : Candidate) : List String := [identityName c.identity, pathName c.path, rateName c.rate, relationName c.relation, orientationName c.orientation, observationName c.observation, provenanceName c.provenance, predictionName c.prediction]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "rate=" (rateName c.rate), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "prediction=" (predictionName c.prediction)]
def survivorId : String := "two-distinct-held-isotopologue-identities__same-complete-reaction-path-and-condition__completed-events-per-exact-positive-observation-parts__ordered-quotient-of-two-exact-positive-event-rates__positive-ratio-plus-held-greater-less-or-equal-orientation__complete-90-rate-ratio-3-decay-and-adverse-vector__experimental-vectors-separated-from-source-models-and-review-questions__value-free-71-record-identity-seal-and-depth-independent-pair-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "two-distinct-held-isotopologue-identities" &&
  SFT.Host.Text.equal (pathName c.path) "same-complete-reaction-path-and-condition" &&
  SFT.Host.Text.equal (rateName c.rate) "completed-events-per-exact-positive-observation-parts" &&
  SFT.Host.Text.equal (relationName c.relation) "ordered-quotient-of-two-exact-positive-event-rates" &&
  SFT.Host.Text.equal (orientationName c.orientation) "positive-ratio-plus-held-greater-less-or-equal-orientation" &&
  SFT.Host.Text.equal (observationName c.observation) "complete-90-rate-ratio-3-decay-and-adverse-vector" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "experimental-vectors-separated-from-source-models-and-review-questions" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-71-record-identity-seal-and-depth-independent-pair-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "two-distinct-held-isotopologue-identities") then "Collapsed or numerical identities cannot preserve which reaction carrier changed." else
  if !(SFT.Host.Text.equal (pathName c.path) "same-complete-reaction-path-and-condition") then "Different or truncated paths do not isolate an isotope relation." else
  if !(SFT.Host.Text.equal (rateName c.rate) "completed-events-per-exact-positive-observation-parts") then "An imported or fitted rate can select the result." else
  if !(SFT.Host.Text.equal (relationName c.relation) "ordered-quotient-of-two-exact-positive-event-rates") then "An imported isotope-effect model is not forced by the retained pair." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "positive-ratio-plus-held-greater-less-or-equal-orientation") then "A signed difference imports forbidden numerical structure." else
  if !(SFT.Host.Text.equal (observationName c.observation) "complete-90-rate-ratio-3-decay-and-adverse-vector") then "Selection or averaging erases replicates, normal, inverse and equal cases." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "experimental-vectors-separated-from-source-models-and-review-questions") then "Mixed provenance lets an interpretation masquerade as measurement." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-71-record-identity-seal-and-depth-independent-pair-successor") then "Target access can select the law." else
  "two-distinct-held-isotopologue-identities__same-complete-reaction-path-and-condition__completed-events-per-exact-positive-observation-parts__ordered-quotient-of-two-exact-positive-event-rates__positive-ratio-plus-held-greater-less-or-equal-orientation__complete-90-rate-ratio-3-decay-and-adverse-vector__experimental-vectors-separated-from-source-models-and-review-questions__value-free-71-record-identity-seal-and-depth-independent-pair-successor"

def generationRule : String := "Generate the literal product of identity, path, rate, relation, orientation, observation, provenance and prediction forms; decide all 256 candidates only from admitted exact isotope identity, state-transition, mechanism and rate laws."
def grammarBoundary : String := "Every finite source-ordered family of complete ordered isotopologue pairs retaining two distinct held isotope identities on one identical reaction path and condition, two independently counted exact positive event rates, one exact positive quotient and every favorable, adverse, control or unresolved status. External testing binds all 71 pre-registered records: article landing, 47 PDF pages and all 23 complete source-data worksheets containing 923,260 nonempty cells, ninety explicit rate-ratio rows and three direct decay KIE inscriptions."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Rate.rejected,Rate.admitted]).flatMap fun rate =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Prediction.rejected,Prediction.admitted]).map fun prediction =>
  ⟨identity,path,rate,relation,orientation,observation,provenance,prediction⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity path rate relation orientation observation provenance prediction =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrate : rate ∈ [Rate.rejected,Rate.admitted] := by
      cases rate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ rate _ hrate
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ prediction _ hprediction

theorem sourceDecisionBlock0000 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0001 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0010 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0011 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0100 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0101 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0110 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0111 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1000 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1001 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1010 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1011 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1100 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1101 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1110 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1111 (orientation : Orientation) (observation : Observation) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,orientation,observation,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,orientation,observation,provenance,prediction⟩ := by
 cases orientation <;> cases observation <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity path rate relation orientation observation provenance prediction =>
  cases identity <;> cases path <;> cases rate <;> cases relation
  · exact sourceDecisionBlock0000 orientation observation provenance prediction
  · exact sourceDecisionBlock0001 orientation observation provenance prediction
  · exact sourceDecisionBlock0010 orientation observation provenance prediction
  · exact sourceDecisionBlock0011 orientation observation provenance prediction
  · exact sourceDecisionBlock0100 orientation observation provenance prediction
  · exact sourceDecisionBlock0101 orientation observation provenance prediction
  · exact sourceDecisionBlock0110 orientation observation provenance prediction
  · exact sourceDecisionBlock0111 orientation observation provenance prediction
  · exact sourceDecisionBlock1000 orientation observation provenance prediction
  · exact sourceDecisionBlock1001 orientation observation provenance prediction
  · exact sourceDecisionBlock1010 orientation observation provenance prediction
  · exact sourceDecisionBlock1011 orientation observation provenance prediction
  · exact sourceDecisionBlock1100 orientation observation provenance prediction
  · exact sourceDecisionBlock1101 orientation observation provenance prediction
  · exact sourceDecisionBlock1110 orientation observation provenance prediction
  · exact sourceDecisionBlock1111 orientation observation provenance prediction

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "two-distinct-held-isotopologue-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "same-complete-reaction-path-and-condition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem rateCriterion (value : Rate) : SFT.Host.Text.equal (rateName value) "completed-events-per-exact-positive-observation-parts" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "ordered-quotient-of-two-exact-positive-event-rates" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "positive-ratio-plus-held-greater-less-or-equal-orientation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "complete-90-rate-ratio-3-decay-and-adverse-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "experimental-vectors-separated-from-source-models-and-review-questions" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-71-record-identity-seal-and-depth-independent-pair-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, pathCriterion, rateCriterion, relationCriterion, orientationCriterion, observationCriterion, provenanceCriterion, predictionCriterion]
  cases c with
  | mk identity path rate relation orientation observation provenance prediction =>
    cases identity <;> cases path <;> cases rate <;> cases relation <;> cases orientation <;> cases observation <;> cases provenance <;> cases prediction
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.path = .admitted ∧ c.rate = .admitted ∧ c.relation = .admitted ∧ c.orientation = .admitted ∧ c.observation = .admitted ∧ c.provenance = .admitted ∧ c.prediction = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity path rate relation orientation observation provenance prediction =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
    rw [h] at field
    cases field

theorem rate_rejected_rejected (c : Candidate) (h : c.rate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rate eq
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

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
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

end SFT.Chemistry.KineticIsotopeEffectGrammar
