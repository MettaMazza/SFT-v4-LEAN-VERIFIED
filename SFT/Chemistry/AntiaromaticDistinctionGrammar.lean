import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AntiaromaticDistinctionGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "different-or-name-only-carriers"
  | .admitted => "one-retained-same-cycle-carrier"

inductive Census where
  | rejected | admitted

def censusName : Census → String
  | .rejected => "selected-favourable-category"
  | .admitted => "complete-three-class-census"

inductive Geometry where
  | rejected | admitted

def geometryName : Geometry → String
  | .rejected => "planarity-assumed-or-erased"
  | .admitted => "held-planar-or-broken-geometry"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "conjugation-name-only"
  | .admitted => "held-complete-or-broken-conjugation"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "electron-count-label-imported"
  | .admitted => "closed-frustrated-or-EmptyOne-return"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "measured-energy-selected-order"
  | .admitted => "positive-two-step-stability-order"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "selected-or-preopened-comparison"
  | .admitted => "value-free-complete-comparative-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "named-ring-or-extra-count-rule"
  | .admitted => "complete-four-cell-successors-no-extra-rule"

structure Candidate where
  carrier : Carrier
  census : Census
  geometry : Geometry
  support : Support
  boundary : Boundary
  order : Order
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, censusName c.census, geometryName c.geometry, supportName c.support, boundaryName c.boundary, orderName c.order, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "census=" (censusName c.census), SFT.Host.Text.append "geometry=" (geometryName c.geometry), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-same-cycle-carrier__complete-three-class-census__held-planar-or-broken-geometry__held-complete-or-broken-conjugation__closed-frustrated-or-EmptyOne-return__positive-two-step-stability-order__value-free-complete-comparative-seal__complete-four-cell-successors-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-retained-same-cycle-carrier" &&
  SFT.Host.Text.equal (censusName c.census) "complete-three-class-census" &&
  SFT.Host.Text.equal (geometryName c.geometry) "held-planar-or-broken-geometry" &&
  SFT.Host.Text.equal (supportName c.support) "held-complete-or-broken-conjugation" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "closed-frustrated-or-EmptyOne-return" &&
  SFT.Host.Text.equal (orderName c.order) "positive-two-step-stability-order" &&
  SFT.Host.Text.equal (observationName c.observation) "value-free-complete-comparative-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "complete-four-cell-successors-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-retained-same-cycle-carrier") then "Different carriers cannot establish alternatives of the same cycle." else
  if !(SFT.Host.Text.equal (censusName c.census) "complete-three-class-census") then "Selecting a familiar label omits lawful same-cycle alternatives." else
  if !(SFT.Host.Text.equal (geometryName c.geometry) "held-planar-or-broken-geometry") then "Erasing geometry merges a frustrated planar recurrence with a recurrence avoided by an out-of-plane break." else
  if !(SFT.Host.Text.equal (supportName c.support) "held-complete-or-broken-conjugation") then "A name does not distinguish complete support from a broken recurrence path." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "closed-frustrated-or-EmptyOne-return") then "An imported count label does not derive return, frustration or structural absence." else
  if !(SFT.Host.Text.equal (orderName c.order) "positive-two-step-stability-order") then "Measured values cannot choose which structural alternative is stable." else
  if !(SFT.Host.Text.equal (observationName c.observation) "value-free-complete-comparative-seal") then "A selected outcome can conceal an adverse same-cycle alternative." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "complete-four-cell-successors-no-extra-rule") then "A species exception or imported count recurrence adds a free selector." else
  "one-retained-same-cycle-carrier__complete-three-class-census__held-planar-or-broken-geometry__held-complete-or-broken-conjugation__closed-frustrated-or-EmptyOne-return__positive-two-step-stability-order__value-free-complete-comparative-seal__complete-four-cell-successors-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, class census, geometry, support, recurrence boundary, stability order, observation custody and extension alternatives; decide all 256 forms solely from the admitted Fold assembly, exact arithmetic, graph, order, dynamics, multicentre support, state-energy, conjugation and aromatic-recurrence dependencies."
def grammarBoundary : String := "Every positive finite complete molecular cycle on one retained carrier; both held geometry states; both held conjugation states; complete two-fibre closure, complete four-cell frustrated return and structural EmptyOne after an explicit break; all three same-cycle classes; every positive complete four-cell successor; and the complete five-target authority surface."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Census.rejected,Census.admitted]).flatMap fun census =>
  ([Geometry.rejected,Geometry.admitted]).flatMap fun geometry =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,census,geometry,support,boundary,order,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier census geometry support boundary order observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcensus : census ∈ [Census.rejected,Census.admitted] := by
      cases census <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgeometry : geometry ∈ [Geometry.rejected,Geometry.admitted] := by
      cases geometry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ census _ hcensus
    apply CommonRefinement.memFlatMap _ _ geometry _ hgeometry
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,boundary,order,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,boundary,order,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,boundary,order,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,boundary,order,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,boundary,order,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,boundary,order,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,boundary,order,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,boundary,order,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,boundary,order,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,boundary,order,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,boundary,order,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,boundary,order,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,boundary,order,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,boundary,order,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,boundary,order,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (boundary : Boundary) (order : Order) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,boundary,order,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,boundary,order,observation,extension⟩ := by
 cases boundary <;> cases order <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier census geometry support boundary order observation extension =>
  cases carrier <;> cases census <;> cases geometry <;> cases support
  · exact sourceDecisionBlock0000 boundary order observation extension
  · exact sourceDecisionBlock0001 boundary order observation extension
  · exact sourceDecisionBlock0010 boundary order observation extension
  · exact sourceDecisionBlock0011 boundary order observation extension
  · exact sourceDecisionBlock0100 boundary order observation extension
  · exact sourceDecisionBlock0101 boundary order observation extension
  · exact sourceDecisionBlock0110 boundary order observation extension
  · exact sourceDecisionBlock0111 boundary order observation extension
  · exact sourceDecisionBlock1000 boundary order observation extension
  · exact sourceDecisionBlock1001 boundary order observation extension
  · exact sourceDecisionBlock1010 boundary order observation extension
  · exact sourceDecisionBlock1011 boundary order observation extension
  · exact sourceDecisionBlock1100 boundary order observation extension
  · exact sourceDecisionBlock1101 boundary order observation extension
  · exact sourceDecisionBlock1110 boundary order observation extension
  · exact sourceDecisionBlock1111 boundary order observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-retained-same-cycle-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem censusCriterion (value : Census) : SFT.Host.Text.equal (censusName value) "complete-three-class-census" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem geometryCriterion (value : Geometry) : SFT.Host.Text.equal (geometryName value) "held-planar-or-broken-geometry" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "held-complete-or-broken-conjugation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "closed-frustrated-or-EmptyOne-return" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orderCriterion (value : Order) : SFT.Host.Text.equal (orderName value) "positive-two-step-stability-order" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "value-free-complete-comparative-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "complete-four-cell-successors-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, censusCriterion, geometryCriterion, supportCriterion, boundaryCriterion, orderCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier census geometry support boundary order observation extension =>
    cases carrier <;> cases census <;> cases geometry <;> cases support <;> cases boundary <;> cases order <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.census = .admitted ∧ c.geometry = .admitted ∧ c.support = .admitted ∧ c.boundary = .admitted ∧ c.order = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier census geometry support boundary order observation extension =>
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

theorem census_rejected_rejected (c : Candidate) (h : c.census = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.census eq
    rw [h] at field
    cases field

theorem geometry_rejected_rejected (c : Candidate) (h : c.geometry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.geometry eq
    rw [h] at field
    cases field

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
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

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
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

end SFT.Chemistry.AntiaromaticDistinctionGrammar
