import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ConformerGenerationGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "name-or-coordinate-list"
  | .admitted => "complete-finite-molecular-graph"

inductive Rotor where
  | rejected | admitted

def rotorName : Rotor → String
  | .rejected => "selected-single-angle"
  | .admitted => "complete-ordered-rotor-census"

inductive Generation where
  | rejected | admitted

def generationName : Generation → String
  | .rejected => "energy-picked-conformer"
  | .admitted => "complete-cartesian-state-generation"

inductive Symmetry where
  | rejected | admitted

def symmetryName : Symmetry → String
  | .rejected => "named-symmetry-assumption"
  | .admitted => "exhaustive-graph-automorphism-action"

inductive Equivalence where
  | rejected | admitted

def equivalenceName : Equivalence → String
  | .rejected => "coordinate-tolerance-clustering"
  | .admitted => "exact-automorphism-orbit-equivalence"

inductive Quotient where
  | rejected | admitted

def quotientName : Quotient → String
  | .rejected => "selected-representative-list"
  | .admitted => "complete-disjoint-orbit-quotient"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "source-readable-generator"
  | .admitted => "value-free-operational-census-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-exception-or-extra-rule"
  | .admitted => "finite-product-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  rotor : Rotor
  generation : Generation
  symmetry : Symmetry
  equivalence : Equivalence
  quotient : Quotient
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, rotorName c.rotor, generationName c.generation, symmetryName c.symmetry, equivalenceName c.equivalence, quotientName c.quotient, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "rotor=" (rotorName c.rotor), SFT.Host.Text.append "generation=" (generationName c.generation), SFT.Host.Text.append "symmetry=" (symmetryName c.symmetry), SFT.Host.Text.append "equivalence=" (equivalenceName c.equivalence), SFT.Host.Text.append "quotient=" (quotientName c.quotient), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-finite-molecular-graph__complete-ordered-rotor-census__complete-cartesian-state-generation__exhaustive-graph-automorphism-action__exact-automorphism-orbit-equivalence__complete-disjoint-orbit-quotient__value-free-operational-census-seal__finite-product-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-finite-molecular-graph" &&
  SFT.Host.Text.equal (rotorName c.rotor) "complete-ordered-rotor-census" &&
  SFT.Host.Text.equal (generationName c.generation) "complete-cartesian-state-generation" &&
  SFT.Host.Text.equal (symmetryName c.symmetry) "exhaustive-graph-automorphism-action" &&
  SFT.Host.Text.equal (equivalenceName c.equivalence) "exact-automorphism-orbit-equivalence" &&
  SFT.Host.Text.equal (quotientName c.quotient) "complete-disjoint-orbit-quotient" &&
  SFT.Host.Text.equal (observationName c.observation) "value-free-operational-census-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "finite-product-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-finite-molecular-graph") then "A name or selected coordinates omit molecular identity and adjacency." else
  if !(SFT.Host.Text.equal (rotorName c.rotor) "complete-ordered-rotor-census") then "One selected angle omits other rotors and held states." else
  if !(SFT.Host.Text.equal (generationName c.generation) "complete-cartesian-state-generation") then "Measured energy cannot choose which assignments are generated." else
  if !(SFT.Host.Text.equal (symmetryName c.symmetry) "exhaustive-graph-automorphism-action") then "A named symmetry can omit or add an equivalence action." else
  if !(SFT.Host.Text.equal (equivalenceName c.equivalence) "exact-automorphism-orbit-equivalence") then "A tolerance or continuum metric introduces a fitted boundary." else
  if !(SFT.Host.Text.equal (quotientName c.quotient) "complete-disjoint-orbit-quotient") then "A selected list can duplicate or omit lawful conformers." else
  if !(SFT.Host.Text.equal (observationName c.observation) "value-free-operational-census-seal") then "External conformer names or energies could select the quotient." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "finite-product-successor-no-extra-rule") then "A species exception cannot establish a general finite algorithm." else
  "complete-finite-molecular-graph__complete-ordered-rotor-census__complete-cartesian-state-generation__exhaustive-graph-automorphism-action__exact-automorphism-orbit-equivalence__complete-disjoint-orbit-quotient__value-free-operational-census-seal__finite-product-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, rotor, state generation, symmetry, equivalence, quotient, observation and extension alternatives; decide all 256 forms solely from admitted exact finite graph, combinatoric, order, process, molecular, isomeric and torsional-state dependencies."
def grammarBoundary : String := "Every positive finite connected atom-labelled graph; every complete ordered four-site rotor; each positive finite held state alphabet with exact reversal involution; all Cartesian assignments; every atom-type and bond-preserving position bijection; all induced rotor actions; the complete disjoint orbit quotient; and the four frozen development-observed authority records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Rotor.rejected,Rotor.admitted]).flatMap fun rotor =>
  ([Generation.rejected,Generation.admitted]).flatMap fun generation =>
  ([Symmetry.rejected,Symmetry.admitted]).flatMap fun symmetry =>
  ([Equivalence.rejected,Equivalence.admitted]).flatMap fun equivalence =>
  ([Quotient.rejected,Quotient.admitted]).flatMap fun quotient =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,rotor,generation,symmetry,equivalence,quotient,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier rotor generation symmetry equivalence quotient observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrotor : rotor ∈ [Rotor.rejected,Rotor.admitted] := by
      cases rotor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgeneration : generation ∈ [Generation.rejected,Generation.admitted] := by
      cases generation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsymmetry : symmetry ∈ [Symmetry.rejected,Symmetry.admitted] := by
      cases symmetry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequivalence : equivalence ∈ [Equivalence.rejected,Equivalence.admitted] := by
      cases equivalence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquotient : quotient ∈ [Quotient.rejected,Quotient.admitted] := by
      cases quotient <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ rotor _ hrotor
    apply CommonRefinement.memFlatMap _ _ generation _ hgeneration
    apply CommonRefinement.memFlatMap _ _ symmetry _ hsymmetry
    apply CommonRefinement.memFlatMap _ _ equivalence _ hequivalence
    apply CommonRefinement.memFlatMap _ _ quotient _ hquotient
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (equivalence : Equivalence) (quotient : Quotient) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,equivalence,quotient,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,equivalence,quotient,observation,extension⟩ := by
 cases equivalence <;> cases quotient <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier rotor generation symmetry equivalence quotient observation extension =>
  cases carrier <;> cases rotor <;> cases generation <;> cases symmetry
  · exact sourceDecisionBlock0000 equivalence quotient observation extension
  · exact sourceDecisionBlock0001 equivalence quotient observation extension
  · exact sourceDecisionBlock0010 equivalence quotient observation extension
  · exact sourceDecisionBlock0011 equivalence quotient observation extension
  · exact sourceDecisionBlock0100 equivalence quotient observation extension
  · exact sourceDecisionBlock0101 equivalence quotient observation extension
  · exact sourceDecisionBlock0110 equivalence quotient observation extension
  · exact sourceDecisionBlock0111 equivalence quotient observation extension
  · exact sourceDecisionBlock1000 equivalence quotient observation extension
  · exact sourceDecisionBlock1001 equivalence quotient observation extension
  · exact sourceDecisionBlock1010 equivalence quotient observation extension
  · exact sourceDecisionBlock1011 equivalence quotient observation extension
  · exact sourceDecisionBlock1100 equivalence quotient observation extension
  · exact sourceDecisionBlock1101 equivalence quotient observation extension
  · exact sourceDecisionBlock1110 equivalence quotient observation extension
  · exact sourceDecisionBlock1111 equivalence quotient observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-finite-molecular-graph" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem rotorCriterion (value : Rotor) : SFT.Host.Text.equal (rotorName value) "complete-ordered-rotor-census" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem generationCriterion (value : Generation) : SFT.Host.Text.equal (generationName value) "complete-cartesian-state-generation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem symmetryCriterion (value : Symmetry) : SFT.Host.Text.equal (symmetryName value) "exhaustive-graph-automorphism-action" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem equivalenceCriterion (value : Equivalence) : SFT.Host.Text.equal (equivalenceName value) "exact-automorphism-orbit-equivalence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem quotientCriterion (value : Quotient) : SFT.Host.Text.equal (quotientName value) "complete-disjoint-orbit-quotient" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "value-free-operational-census-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "finite-product-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, rotorCriterion, generationCriterion, symmetryCriterion, equivalenceCriterion, quotientCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier rotor generation symmetry equivalence quotient observation extension =>
    cases carrier <;> cases rotor <;> cases generation <;> cases symmetry <;> cases equivalence <;> cases quotient <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.rotor = .admitted ∧ c.generation = .admitted ∧ c.symmetry = .admitted ∧ c.equivalence = .admitted ∧ c.quotient = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier rotor generation symmetry equivalence quotient observation extension =>
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

theorem rotor_rejected_rejected (c : Candidate) (h : c.rotor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rotor eq
    rw [h] at field
    cases field

theorem generation_rejected_rejected (c : Candidate) (h : c.generation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generation eq
    rw [h] at field
    cases field

theorem symmetry_rejected_rejected (c : Candidate) (h : c.symmetry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.symmetry eq
    rw [h] at field
    cases field

theorem equivalence_rejected_rejected (c : Candidate) (h : c.equivalence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equivalence eq
    rw [h] at field
    cases field

theorem quotient_rejected_rejected (c : Candidate) (h : c.quotient = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.quotient eq
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

end SFT.Chemistry.ConformerGenerationGrammar
