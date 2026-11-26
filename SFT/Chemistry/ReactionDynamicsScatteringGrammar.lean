import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ReactionDynamicsScatteringGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Incoming where
  | rejected | admitted

def incomingName : Incoming → String
  | .rejected => "incoming-carriers-erased-or-replaced-by-continuum-beam"
  | .admitted => "finite-held-incoming-channel-and-preparation"

inductive Outgoing where
  | rejected | admitted

def outgoingName : Outgoing → String
  | .rejected => "selected-product-or-continuous-outgoing-distribution"
  | .admitted => "complete-finite-distinct-outgoing-product-state-support"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "coproduct-states-separated-or-marginalized"
  | .admitted => "joint-ordered-coproduct-state-word"

inductive Quantity where
  | rejected | admitted

def quantityName : Quantity → String
  | .rejected => "imported-cross-section-probability-amplitude-or-fitted-density"
  | .admitted => "completed-state-events-per-complete-positive-event-support"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-angle-continuum-or-numerical-zero-direction"
  | .admitted => "held-incoming-outgoing-orientation-relation"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "selected-normalized-or-favorable-product-vector"
  | .admitted => "complete-51-record-36-page-14-worksheet-978591-cell-vector"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "experimental-theoretical-fitted-estimated-and-tentative-records-mixed"
  | .admitted => "experiment-theory-fit-estimate-tentative-control-and-review-status-separated"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "product-values-workbook-or-target-readable-before-seal"
  | .admitted => "value-free-51-record-identity-seal-and-depth-independent-scattering-successor"

structure Candidate where
  incoming : Incoming
  outgoing : Outgoing
  composition : Composition
  quantity : Quantity
  orientation : Orientation
  observation : Observation
  provenance : Provenance
  prediction : Prediction

def sourceFields (c : Candidate) : List String := [incomingName c.incoming, outgoingName c.outgoing, compositionName c.composition, quantityName c.quantity, orientationName c.orientation, observationName c.observation, provenanceName c.provenance, predictionName c.prediction]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "incoming=" (incomingName c.incoming), SFT.Host.Text.append "outgoing=" (outgoingName c.outgoing), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "quantity=" (quantityName c.quantity), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "prediction=" (predictionName c.prediction)]
def survivorId : String := "finite-held-incoming-channel-and-preparation__complete-finite-distinct-outgoing-product-state-support__joint-ordered-coproduct-state-word__completed-state-events-per-complete-positive-event-support__held-incoming-outgoing-orientation-relation__complete-51-record-36-page-14-worksheet-978591-cell-vector__experiment-theory-fit-estimate-tentative-control-and-review-status-separated__value-free-51-record-identity-seal-and-depth-independent-scattering-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (incomingName c.incoming) "finite-held-incoming-channel-and-preparation" &&
  SFT.Host.Text.equal (outgoingName c.outgoing) "complete-finite-distinct-outgoing-product-state-support" &&
  SFT.Host.Text.equal (compositionName c.composition) "joint-ordered-coproduct-state-word" &&
  SFT.Host.Text.equal (quantityName c.quantity) "completed-state-events-per-complete-positive-event-support" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-incoming-outgoing-orientation-relation" &&
  SFT.Host.Text.equal (observationName c.observation) "complete-51-record-36-page-14-worksheet-978591-cell-vector" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "experiment-theory-fit-estimate-tentative-control-and-review-status-separated" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-51-record-identity-seal-and-depth-independent-scattering-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (incomingName c.incoming) "finite-held-incoming-channel-and-preparation") then "Erased or continuous input cannot retain which finite reaction channel was prepared." else
  if !(SFT.Host.Text.equal (outgoingName c.outgoing) "complete-finite-distinct-outgoing-product-state-support") then "A selected or continuous outcome erases finite alternative product states." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "joint-ordered-coproduct-state-word") then "Marginal product states erase which coproduct pair occurred together." else
  if !(SFT.Host.Text.equal (quantityName c.quantity) "completed-state-events-per-complete-positive-event-support") then "An imported or fitted distribution can select the answer." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-incoming-outgoing-orientation-relation") then "A continuum angle or signed scalar imports forbidden numerical structure." else
  if !(SFT.Host.Text.equal (observationName c.observation) "complete-51-record-36-page-14-worksheet-978591-cell-vector") then "Selection or normalization can erase weak, absent, adverse or discrepant channels." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "experiment-theory-fit-estimate-tentative-control-and-review-status-separated") then "Mixed provenance lets a model or correction masquerade as observation." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-51-record-identity-seal-and-depth-independent-scattering-successor") then "Target access can select the channel or orientation law." else
  "finite-held-incoming-channel-and-preparation__complete-finite-distinct-outgoing-product-state-support__joint-ordered-coproduct-state-word__completed-state-events-per-complete-positive-event-support__held-incoming-outgoing-orientation-relation__complete-51-record-36-page-14-worksheet-978591-cell-vector__experiment-theory-fit-estimate-tentative-control-and-review-status-separated__value-free-51-record-identity-seal-and-depth-independent-scattering-successor"

def generationRule : String := "Generate the literal product of incoming, outgoing, composition, quantity, orientation, observation, provenance and prediction forms; decide all 256 candidates only from admitted finite channel, state, transition, mechanism and exact-count laws."
def grammarBoundary : String := "Every finite held incoming reaction channel and preparation; every complete finite, source-ordered support of distinct joint coproduct-state words; exact positive completed-event shares; held incoming/outgoing orientations; and every favorable, adverse, control, fitted, normalized, estimated, tentative or unresolved status. External testing binds all 51 pre-registered records: article landing, 36 PDF pages and all 14 source-data worksheets containing 978,591 nonempty cells and 6,408 key state-resolved product, branching and scattering cells."

def candidates : List Candidate :=
  ([Incoming.rejected,Incoming.admitted]).flatMap fun incoming =>
  ([Outgoing.rejected,Outgoing.admitted]).flatMap fun outgoing =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Quantity.rejected,Quantity.admitted]).flatMap fun quantity =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Prediction.rejected,Prediction.admitted]).map fun prediction =>
  ⟨incoming,outgoing,composition,quantity,orientation,observation,provenance,prediction⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk incoming outgoing composition quantity orientation observation provenance prediction =>
    have hincoming : incoming ∈ [Incoming.rejected,Incoming.admitted] := by
      cases incoming <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have houtgoing : outgoing ∈ [Outgoing.rejected,Outgoing.admitted] := by
      cases outgoing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquantity : quantity ∈ [Quantity.rejected,Quantity.admitted] := by
      cases quantity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ incoming _ hincoming
    apply CommonRefinement.memFlatMap _ _ outgoing _ houtgoing
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ quantity _ hquantity
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
 | mk incoming outgoing composition quantity orientation observation provenance prediction =>
  cases incoming <;> cases outgoing <;> cases composition <;> cases quantity
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

theorem incomingCriterion (value : Incoming) : SFT.Host.Text.equal (incomingName value) "finite-held-incoming-channel-and-preparation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem outgoingCriterion (value : Outgoing) : SFT.Host.Text.equal (outgoingName value) "complete-finite-distinct-outgoing-product-state-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "joint-ordered-coproduct-state-word" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem quantityCriterion (value : Quantity) : SFT.Host.Text.equal (quantityName value) "completed-state-events-per-complete-positive-event-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-incoming-outgoing-orientation-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "complete-51-record-36-page-14-worksheet-978591-cell-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "experiment-theory-fit-estimate-tentative-control-and-review-status-separated" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-51-record-identity-seal-and-depth-independent-scattering-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [incomingCriterion, outgoingCriterion, compositionCriterion, quantityCriterion, orientationCriterion, observationCriterion, provenanceCriterion, predictionCriterion]
  cases c with
  | mk incoming outgoing composition quantity orientation observation provenance prediction =>
    cases incoming <;> cases outgoing <;> cases composition <;> cases quantity <;> cases orientation <;> cases observation <;> cases provenance <;> cases prediction
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.incoming = .admitted ∧ c.outgoing = .admitted ∧ c.composition = .admitted ∧ c.quantity = .admitted ∧ c.orientation = .admitted ∧ c.observation = .admitted ∧ c.provenance = .admitted ∧ c.prediction = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk incoming outgoing composition quantity orientation observation provenance prediction =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem incoming_rejected_rejected (c : Candidate) (h : c.incoming = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.incoming eq
    rw [h] at field
    cases field

theorem outgoing_rejected_rejected (c : Candidate) (h : c.outgoing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.outgoing eq
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

theorem quantity_rejected_rejected (c : Candidate) (h : c.quantity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.quantity eq
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

end SFT.Chemistry.ReactionDynamicsScatteringGrammar
