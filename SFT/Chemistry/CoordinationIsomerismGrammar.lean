import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CoordinationIsomerismGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "names-or-formulae-only"
  | .admitted => "two-complete-retained-coordination-forms"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "different-compositions-called-isomers"
  | .admitted => "same-complete-composition-multiset"

inductive Bijection where
  | rejected | admitted

def bijectionName : Bijection → String
  | .rejected => "selected-correspondence-between-occurrences"
  | .admitted => "enumerate-every-occurrence-bijection"

inductive Graph where
  | rejected | admitted

def graphName : Graph → String
  | .rejected => "partial-or-named-connectivity"
  | .admitted => "complete-attachment-and-adjacency-preservation"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "shape-name-point-group-or-continuum-transform"
  | .admitted => "complete-three-axis-two-fibre-relation"

inductive Class where
  | rejected | admitted

def classAxisName : Class → String
  | .rejected => "imported-isomer-catalogue"
  | .admitted => "first-failed-invariant-forces-native-class"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "selected-favourable-term"
  | .admitted => "complete-17-surface-sealed-vector-with-linkage-addendum"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "new-occurrence-reclassifies-prior-subform"
  | .admitted => "successor-preserves-prior-signatures-and-adds-relations"

structure Candidate where
  carrier : Carrier
  composition : Composition
  bijection : Bijection
  graph : Graph
  orientation : Orientation
  classAxis : Class
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, compositionName c.composition, bijectionName c.bijection, graphName c.graph, orientationName c.orientation, classAxisName c.classAxis, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "bijection=" (bijectionName c.bijection), SFT.Host.Text.append "graph=" (graphName c.graph), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "class=" (classAxisName c.classAxis), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "two-complete-retained-coordination-forms__same-complete-composition-multiset__enumerate-every-occurrence-bijection__complete-attachment-and-adjacency-preservation__complete-three-axis-two-fibre-relation__first-failed-invariant-forces-native-class__complete-17-surface-sealed-vector-with-linkage-addendum__successor-preserves-prior-signatures-and-adds-relations"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "two-complete-retained-coordination-forms" &&
  SFT.Host.Text.equal (compositionName c.composition) "same-complete-composition-multiset" &&
  SFT.Host.Text.equal (bijectionName c.bijection) "enumerate-every-occurrence-bijection" &&
  SFT.Host.Text.equal (graphName c.graph) "complete-attachment-and-adjacency-preservation" &&
  SFT.Host.Text.equal (orientationName c.orientation) "complete-three-axis-two-fibre-relation" &&
  SFT.Host.Text.equal (classAxisName c.classAxis) "first-failed-invariant-forces-native-class" &&
  SFT.Host.Text.equal (observationName c.observation) "complete-17-surface-sealed-vector-with-linkage-addendum" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-preserves-prior-signatures-and-adds-relations"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "two-complete-retained-coordination-forms") then "Names do not retain complete forms." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "same-complete-composition-multiset") then "Isomer comparison requires the same complete composition." else
  if !(SFT.Host.Text.equal (bijectionName c.bijection) "enumerate-every-occurrence-bijection") then "A selected mapping can manufacture equivalence." else
  if !(SFT.Host.Text.equal (graphName c.graph) "complete-attachment-and-adjacency-preservation") then "Partial connectivity omits attachment distinctions." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "complete-three-axis-two-fibre-relation") then "Imported transformations select the result." else
  if !(SFT.Host.Text.equal (classAxisName c.classAxis) "first-failed-invariant-forces-native-class") then "A catalogue does not force the first failed invariant." else
  if !(SFT.Host.Text.equal (observationName c.observation) "complete-17-surface-sealed-vector-with-linkage-addendum") then "Selected definitions cannot test all classes." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-preserves-prior-signatures-and-adds-relations") then "Rewriting loses the prior class trace." else
  "two-complete-retained-coordination-forms__same-complete-composition-multiset__enumerate-every-occurrence-bijection__complete-attachment-and-adjacency-preservation__complete-three-axis-two-fibre-relation__first-failed-invariant-forces-native-class__complete-17-surface-sealed-vector-with-linkage-addendum__successor-preserves-prior-signatures-and-adds-relations"

def generationRule : String := "Generate the literal product of carrier, composition, bijection, graph, orientation, native-class, observation and successor forms; decide all 256 candidates solely from admitted finite-form, exact-combinatorial, graph, information-retention, stereochemical and INORG-004 geometry dependencies."
def grammarBoundary : String := "Every pair of positive finite complete coordination forms with the same complete composition multiset, every occurrence permutation, every retained attachment and adjacency, every three-axis word using only fibre-one, fibre-two or structural EmptyOne, the generated global fibre complement, all seventeen sealed IUPAC surfaces, both preserved Gold Book identity redirects and the explicitly absent literal linkage term."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Bijection.rejected,Bijection.admitted]).flatMap fun bijection =>
  ([Graph.rejected,Graph.admitted]).flatMap fun graph =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Class.rejected,Class.admitted]).flatMap fun classAxis =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,composition,bijection,graph,orientation,classAxis,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier composition bijection graph orientation classAxis observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbijection : bijection ∈ [Bijection.rejected,Bijection.admitted] := by
      cases bijection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgraph : graph ∈ [Graph.rejected,Graph.admitted] := by
      cases graph <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclassAxis : classAxis ∈ [Class.rejected,Class.admitted] := by
      cases classAxis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ bijection _ hbijection
    apply CommonRefinement.memFlatMap _ _ graph _ hgraph
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ classAxis _ hclassAxis
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (orientation : Orientation) (classAxis : Class) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,orientation,classAxis,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,orientation,classAxis,observation,extension⟩ := by
 cases orientation <;> cases classAxis <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier composition bijection graph orientation classAxis observation extension =>
  cases carrier <;> cases composition <;> cases bijection <;> cases graph
  · exact sourceDecisionBlock0000 orientation classAxis observation extension
  · exact sourceDecisionBlock0001 orientation classAxis observation extension
  · exact sourceDecisionBlock0010 orientation classAxis observation extension
  · exact sourceDecisionBlock0011 orientation classAxis observation extension
  · exact sourceDecisionBlock0100 orientation classAxis observation extension
  · exact sourceDecisionBlock0101 orientation classAxis observation extension
  · exact sourceDecisionBlock0110 orientation classAxis observation extension
  · exact sourceDecisionBlock0111 orientation classAxis observation extension
  · exact sourceDecisionBlock1000 orientation classAxis observation extension
  · exact sourceDecisionBlock1001 orientation classAxis observation extension
  · exact sourceDecisionBlock1010 orientation classAxis observation extension
  · exact sourceDecisionBlock1011 orientation classAxis observation extension
  · exact sourceDecisionBlock1100 orientation classAxis observation extension
  · exact sourceDecisionBlock1101 orientation classAxis observation extension
  · exact sourceDecisionBlock1110 orientation classAxis observation extension
  · exact sourceDecisionBlock1111 orientation classAxis observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "two-complete-retained-coordination-forms" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "same-complete-composition-multiset" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem bijectionCriterion (value : Bijection) : SFT.Host.Text.equal (bijectionName value) "enumerate-every-occurrence-bijection" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem graphCriterion (value : Graph) : SFT.Host.Text.equal (graphName value) "complete-attachment-and-adjacency-preservation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "complete-three-axis-two-fibre-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem classAxisCriterion (value : Class) : SFT.Host.Text.equal (classAxisName value) "first-failed-invariant-forces-native-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "complete-17-surface-sealed-vector-with-linkage-addendum" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-preserves-prior-signatures-and-adds-relations" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, compositionCriterion, bijectionCriterion, graphCriterion, orientationCriterion, classAxisCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier composition bijection graph orientation classAxis observation extension =>
    cases carrier <;> cases composition <;> cases bijection <;> cases graph <;> cases orientation <;> cases classAxis <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.composition = .admitted ∧ c.bijection = .admitted ∧ c.graph = .admitted ∧ c.orientation = .admitted ∧ c.classAxis = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier composition bijection graph orientation classAxis observation extension =>
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem bijection_rejected_rejected (c : Candidate) (h : c.bijection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bijection eq
    rw [h] at field
    cases field

theorem graph_rejected_rejected (c : Candidate) (h : c.graph = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.graph eq
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

theorem classAxis_rejected_rejected (c : Candidate) (h : c.classAxis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.classAxis eq
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

end SFT.Chemistry.CoordinationIsomerismGrammar
