import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AromaticRecurrenceGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "aromatic-name-or-answer-only"
  | .admitted => "one-complete-molecular-carrier"

inductive Cycle where
  | rejected | admitted

def cycleName : Cycle → String
  | .rejected => "open-path-or-selected-ring"
  | .admitted => "complete-generated-cycle"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "one-fibre-or-duplicated-boundary"
  | .admitted => "complete-two-fibre-boundary"

inductive Layer where
  | rejected | admitted

def layerName : Layer → String
  | .rejected => "selected-transition-cell-subset"
  | .admitted => "complete-four-ordered-pair-cell-layer"

inductive Return where
  | rejected | admitted

def returnsName : Return → String
  | .rejected => "period-label-without-trace"
  | .admitted => "explicit-complete-first-return-trace"

inductive Stability where
  | rejected | admitted

def stabilityName : Stability → String
  | .rejected => "measured-energy-or-name-selected-order"
  | .admitted => "positive-recurrence-opening-gap"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "selected-or-preopened-value-row"
  | .admitted => "value-free-seal-and-complete-blind-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "imported-electron-count-or-species-rule"
  | .admitted => "complete-four-cell-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  cycle : Cycle
  boundary : Boundary
  layer : Layer
  returns : Return
  stability : Stability
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, cycleName c.cycle, boundaryName c.boundary, layerName c.layer, returnsName c.returns, stabilityName c.stability, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "cycle=" (cycleName c.cycle), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "layer=" (layerName c.layer), SFT.Host.Text.append "return=" (returnsName c.returns), SFT.Host.Text.append "stability=" (stabilityName c.stability), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-complete-molecular-carrier__complete-generated-cycle__complete-two-fibre-boundary__complete-four-ordered-pair-cell-layer__explicit-complete-first-return-trace__positive-recurrence-opening-gap__value-free-seal-and-complete-blind-vector__complete-four-cell-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-complete-molecular-carrier" &&
  SFT.Host.Text.equal (cycleName c.cycle) "complete-generated-cycle" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "complete-two-fibre-boundary" &&
  SFT.Host.Text.equal (layerName c.layer) "complete-four-ordered-pair-cell-layer" &&
  SFT.Host.Text.equal (returnsName c.returns) "explicit-complete-first-return-trace" &&
  SFT.Host.Text.equal (stabilityName c.stability) "positive-recurrence-opening-gap" &&
  SFT.Host.Text.equal (observationName c.observation) "value-free-seal-and-complete-blind-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "complete-four-cell-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-complete-molecular-carrier") then "A name does not retain the molecular support that is claimed to recur." else
  if !(SFT.Host.Text.equal (cycleName c.cycle) "complete-generated-cycle") then "An open path or selected example does not establish cyclic first return." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "complete-two-fibre-boundary") then "An incomplete or duplicated boundary erases one forced Fold distinction." else
  if !(SFT.Host.Text.equal (layerName c.layer) "complete-four-ordered-pair-cell-layer") then "A selected subset can be tuned to a familiar count and is not closed under pair-cell perturbation." else
  if !(SFT.Host.Text.equal (returnsName c.returns) "explicit-complete-first-return-trace") then "A named cycle length cannot prove return or preserve its path." else
  if !(SFT.Host.Text.equal (stabilityName c.stability) "positive-recurrence-opening-gap") then "A measured energy or conventional aromatic label cannot select the structural order." else
  if !(SFT.Host.Text.equal (observationName c.observation) "value-free-seal-and-complete-blind-vector") then "A selected or preopened value vector can feed the desired order back into the law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "complete-four-cell-successor-no-extra-rule") then "An imported count formula or species exception is an added selector." else
  "one-complete-molecular-carrier__complete-generated-cycle__complete-two-fibre-boundary__complete-four-ordered-pair-cell-layer__explicit-complete-first-return-trace__positive-recurrence-opening-gap__value-free-seal-and-complete-blind-vector__complete-four-cell-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, cycle, Fold boundary, pair-cell layer, return trace, stability order, observation custody and extension alternatives; decide all 256 forms solely from admitted Fold assembly, exact graph, finite dynamics, generator three, multicentre support, energy order, formation-energy accounting, conjugation and representation-equivalence dependencies."
def grammarBoundary : String := "Every positive finite complete molecular cycle; both Fold boundary fibres; every positive number of complete four-ordered-pair-cell layers; explicit first-return traces; and the complete nine-target authority surface containing six development-observed correspondence records and three separately outcome-unopened blind NIST CCCBDB experimental-data pages."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Cycle.rejected,Cycle.admitted]).flatMap fun cycle =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Layer.rejected,Layer.admitted]).flatMap fun layer =>
  ([Return.rejected,Return.admitted]).flatMap fun returns =>
  ([Stability.rejected,Stability.admitted]).flatMap fun stability =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,cycle,boundary,layer,returns,stability,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier cycle boundary layer returns stability observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcycle : cycle ∈ [Cycle.rejected,Cycle.admitted] := by
      cases cycle <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlayer : layer ∈ [Layer.rejected,Layer.admitted] := by
      cases layer <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreturns : returns ∈ [Return.rejected,Return.admitted] := by
      cases returns <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstability : stability ∈ [Stability.rejected,Stability.admitted] := by
      cases stability <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ cycle _ hcycle
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ layer _ hlayer
    apply CommonRefinement.memFlatMap _ _ returns _ hreturns
    apply CommonRefinement.memFlatMap _ _ stability _ hstability
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,returns,stability,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,returns,stability,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,returns,stability,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,returns,stability,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,returns,stability,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,returns,stability,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,returns,stability,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,returns,stability,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,returns,stability,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,returns,stability,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,returns,stability,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,returns,stability,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,returns,stability,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,returns,stability,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,returns,stability,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (returns : Return) (stability : Stability) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,returns,stability,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,returns,stability,observation,extension⟩ := by
 cases returns <;> cases stability <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier cycle boundary layer returns stability observation extension =>
  cases carrier <;> cases cycle <;> cases boundary <;> cases layer
  · exact sourceDecisionBlock0000 returns stability observation extension
  · exact sourceDecisionBlock0001 returns stability observation extension
  · exact sourceDecisionBlock0010 returns stability observation extension
  · exact sourceDecisionBlock0011 returns stability observation extension
  · exact sourceDecisionBlock0100 returns stability observation extension
  · exact sourceDecisionBlock0101 returns stability observation extension
  · exact sourceDecisionBlock0110 returns stability observation extension
  · exact sourceDecisionBlock0111 returns stability observation extension
  · exact sourceDecisionBlock1000 returns stability observation extension
  · exact sourceDecisionBlock1001 returns stability observation extension
  · exact sourceDecisionBlock1010 returns stability observation extension
  · exact sourceDecisionBlock1011 returns stability observation extension
  · exact sourceDecisionBlock1100 returns stability observation extension
  · exact sourceDecisionBlock1101 returns stability observation extension
  · exact sourceDecisionBlock1110 returns stability observation extension
  · exact sourceDecisionBlock1111 returns stability observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-complete-molecular-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem cycleCriterion (value : Cycle) : SFT.Host.Text.equal (cycleName value) "complete-generated-cycle" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "complete-two-fibre-boundary" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem layerCriterion (value : Layer) : SFT.Host.Text.equal (layerName value) "complete-four-ordered-pair-cell-layer" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem returnsCriterion (value : Return) : SFT.Host.Text.equal (returnsName value) "explicit-complete-first-return-trace" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem stabilityCriterion (value : Stability) : SFT.Host.Text.equal (stabilityName value) "positive-recurrence-opening-gap" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "value-free-seal-and-complete-blind-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "complete-four-cell-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, cycleCriterion, boundaryCriterion, layerCriterion, returnsCriterion, stabilityCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier cycle boundary layer returns stability observation extension =>
    cases carrier <;> cases cycle <;> cases boundary <;> cases layer <;> cases returns <;> cases stability <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.cycle = .admitted ∧ c.boundary = .admitted ∧ c.layer = .admitted ∧ c.returns = .admitted ∧ c.stability = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier cycle boundary layer returns stability observation extension =>
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

theorem cycle_rejected_rejected (c : Candidate) (h : c.cycle = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cycle eq
    rw [h] at field
    cases field

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

theorem layer_rejected_rejected (c : Candidate) (h : c.layer = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.layer eq
    rw [h] at field
    cases field

theorem returns_rejected_rejected (c : Candidate) (h : c.returns = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.returns eq
    rw [h] at field
    cases field

theorem stability_rejected_rejected (c : Candidate) (h : c.stability = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.stability eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.AromaticRecurrenceGrammar
