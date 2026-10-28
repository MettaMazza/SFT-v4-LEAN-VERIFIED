import SFT.InformationScience.QuantityWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.QuantityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "partial-support"
  | .admitted => "complete-canonical-support"

inductive Pairs where
  | rejected | admitted

def pairsName : Pairs → String
  | .rejected => "sampled-pairs"
  | .admitted => "complete-unordered-pair-ledger"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "assumed-resolution"
  | .admitted => "exact-observation-classes"

inductive Unit where
  | rejected | admitted

def unitName : Unit → String
  | .rejected => "imported-bit"
  | .admitted => "first-Fold-distinction"

inductive Positions where
  | rejected | admitted

def positionsName : Positions → String
  | .rejected => "word-length-only"
  | .admitted => "independent-position-witness"

inductive Quantity where
  | rejected | admitted

def quantityName : Quantity → String
  | .rejected => "real-logarithm"
  | .admitted => "exact-support-and-distinction-profile"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "count-product-only"
  | .admitted => "complete-pair-support"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "depth-table"
  | .admitted => "position-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-log-base-or-unit"
  | .admitted => "no-extra-information-scale"

structure Candidate where
  support : Support
  pairs : Pairs
  observation : Observation
  unit : Unit
  positions : Positions
  quantity : Quantity
  composition : Composition
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [supportName c.support, pairsName c.pairs, observationName c.observation, unitName c.unit, positionsName c.positions, quantityName c.quantity, compositionName c.composition, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "pairs=" (pairsName c.pairs), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "unit=" (unitName c.unit), SFT.Host.Text.append "positions=" (positionsName c.positions), SFT.Host.Text.append "quantity=" (quantityName c.quantity), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-support__complete-unordered-pair-ledger__exact-observation-classes__first-Fold-distinction__independent-position-witness__exact-support-and-distinction-profile__complete-pair-support__position-successor__no-extra-information-scale"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-canonical-support" &&
  SFT.Host.Text.equal (pairsName c.pairs) "complete-unordered-pair-ledger" &&
  SFT.Host.Text.equal (observationName c.observation) "exact-observation-classes" &&
  SFT.Host.Text.equal (unitName c.unit) "first-Fold-distinction" &&
  SFT.Host.Text.equal (positionsName c.positions) "independent-position-witness" &&
  SFT.Host.Text.equal (quantityName c.quantity) "exact-support-and-distinction-profile" &&
  SFT.Host.Text.equal (compositionName c.composition) "complete-pair-support" &&
  SFT.Host.Text.equal (generalityName c.generality) "position-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-information-scale"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-canonical-support") then "Omitting a generated alternative changes every distinction count." else
  if !(SFT.Host.Text.equal (pairsName c.pairs) "complete-unordered-pair-ledger") then "Sampling cannot prove a distinction ledger complete." else
  if !(SFT.Host.Text.equal (observationName c.observation) "exact-observation-classes") then "An assumed resolution has no source-to-image evidence." else
  if !(SFT.Host.Text.equal (unitName c.unit) "first-Fold-distinction") then "A conventional binary unit would select the answer." else
  if !(SFT.Host.Text.equal (positionsName c.positions) "independent-position-witness") then "Length alone does not show each position can vary independently." else
  if !(SFT.Host.Text.equal (quantityName c.quantity) "exact-support-and-distinction-profile") then "A logarithm imports irrational and floating proof values." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "complete-pair-support") then "A scalar product erases source-coordinate provenance." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "position-successor") then "A table of small supports does not prove the next position." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-information-scale") then "A chosen base or physical scale is a free parameter." else
  "The information-quantity kernel is complete support and pair ledgers, exact retained/closed observation distinctions, first-Fold units, independently witnessed position traces, pair-support composition and no log scale."

def generationRule : String := "Generate the complete product of support coverage, distinction ledger, observation classes, native unit, position independence, quantity representation, composition, generality and extra-scale status."
def grammarBoundary : String := "All finite information profiles generated from complete canonical Fold-word support, total observation classes, exact pair distinctions, independently varied positions and pair-cell composition."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Pairs.rejected,Pairs.admitted]).flatMap fun pairs =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Unit.rejected,Unit.admitted]).flatMap fun unit =>
  ([Positions.rejected,Positions.admitted]).flatMap fun positions =>
  ([Quantity.rejected,Quantity.admitted]).flatMap fun quantity =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨support,pairs,observation,unit,positions,quantity,composition,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support pairs observation unit positions quantity composition generality addition =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpairs : pairs ∈ [Pairs.rejected,Pairs.admitted] := by
      cases pairs <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunit : unit ∈ [Unit.rejected,Unit.admitted] := by
      cases unit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpositions : positions ∈ [Positions.rejected,Positions.admitted] := by
      cases positions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquantity : quantity ∈ [Quantity.rejected,Quantity.admitted] := by
      cases quantity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ pairs _ hpairs
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ unit _ hunit
    apply CommonRefinement.memFlatMap _ _ positions _ hpositions
    apply CommonRefinement.memFlatMap _ _ quantity _ hquantity
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support pairs observation unit positions quantity composition generality addition =>
    cases support <;> cases pairs <;> cases observation <;> cases unit <;> cases positions <;> cases quantity <;> cases composition <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support pairs observation unit positions quantity composition generality addition =>
    cases support <;> cases pairs <;> cases observation <;> cases unit <;> cases positions <;> cases quantity <;> cases composition <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.pairs = .admitted ∧ c.observation = .admitted ∧ c.unit = .admitted ∧ c.positions = .admitted ∧ c.quantity = .admitted ∧ c.composition = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support pairs observation unit positions quantity composition generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem pairs_rejected_rejected (c : Candidate) (h : c.pairs = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pairs eq
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

theorem unit_rejected_rejected (c : Candidate) (h : c.unit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.unit eq
    rw [h] at field
    cases field

theorem positions_rejected_rejected (c : Candidate) (h : c.positions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.positions eq
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.InformationScience.QuantityGrammar
