import SFT.Mathematics.CategoryWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.CategoryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Objects where
  | rejected | admitted

def objectsName : Objects → String
  | .rejected => "presentation-objects"
  | .admitted => "canonical-Fold-objects"

inductive Arrows where
  | rejected | admitted

def arrowsName : Arrows → String
  | .rejected => "endpoint-only-arrow"
  | .admitted => "proof-carrying-transition"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "assumed-neutral-map"
  | .admitted => "empty-One-return"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "presentation-concatenation"
  | .admitted => "exact-interface-match"

inductive Association where
  | rejected | admitted

def associationName : Association → String
  | .rejected => "borrowed-category-axiom"
  | .admitted => "canonical-path-flattening"

inductive Types where
  | rejected | admitted

def typesName : Types → String
  | .rejected => "informal-class-name"
  | .admitted => "source-bound-form-predicate"

inductive Constructors where
  | rejected | admitted

def constructorsName : Constructors → String
  | .rejected => "borrowed-set-constructor"
  | .admitted => "joint-pairs-and-held-alternatives"

inductive Functor where
  | rejected | admitted

def functorName : Functor → String
  | .rejected => "arbitrary-renaming"
  | .admitted => "identity-and-composition-preservation"

inductive Naturality where
  | rejected | admitted

def naturalityName : Naturality → String
  | .rejected => "diagram-by-appearance"
  | .admitted => "equal-complete-paths"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-composition-axiom"
  | .admitted => "no-extra-composition-axiom"

structure Candidate where
  objects : Objects
  arrows : Arrows
  identity : Identity
  composition : Composition
  association : Association
  types : Types
  constructors : Constructors
  functor : Functor
  naturality : Naturality
  addition : Addition

def sourceFields (c : Candidate) : List String := [objectsName c.objects, arrowsName c.arrows, identityName c.identity, compositionName c.composition, associationName c.association, typesName c.types, constructorsName c.constructors, functorName c.functor, naturalityName c.naturality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "objects=" (objectsName c.objects), SFT.Host.Text.append "arrows=" (arrowsName c.arrows), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "association=" (associationName c.association), SFT.Host.Text.append "types=" (typesName c.types), SFT.Host.Text.append "constructors=" (constructorsName c.constructors), SFT.Host.Text.append "functor=" (functorName c.functor), SFT.Host.Text.append "naturality=" (naturalityName c.naturality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "canonical-Fold-objects__proof-carrying-transition__empty-One-return__exact-interface-match__canonical-path-flattening__source-bound-form-predicate__joint-pairs-and-held-alternatives__identity-and-composition-preservation__equal-complete-paths__no-extra-composition-axiom"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (objectsName c.objects) "canonical-Fold-objects" &&
  SFT.Host.Text.equal (arrowsName c.arrows) "proof-carrying-transition" &&
  SFT.Host.Text.equal (identityName c.identity) "empty-One-return" &&
  SFT.Host.Text.equal (compositionName c.composition) "exact-interface-match" &&
  SFT.Host.Text.equal (associationName c.association) "canonical-path-flattening" &&
  SFT.Host.Text.equal (typesName c.types) "source-bound-form-predicate" &&
  SFT.Host.Text.equal (constructorsName c.constructors) "joint-pairs-and-held-alternatives" &&
  SFT.Host.Text.equal (functorName c.functor) "identity-and-composition-preservation" &&
  SFT.Host.Text.equal (naturalityName c.naturality) "equal-complete-paths" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-composition-axiom"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (objectsName c.objects) "canonical-Fold-objects") then "Presentation names can alias distinct structures." else
  if !(SFT.Host.Text.equal (arrowsName c.arrows) "proof-carrying-transition") then "Endpoints alone erase the transformation proof." else
  if !(SFT.Host.Text.equal (identityName c.identity) "empty-One-return") then "A named neutral map has no return witness." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "exact-interface-match") then "Textual concatenation can join unequal interfaces." else
  if !(SFT.Host.Text.equal (associationName c.association) "canonical-path-flattening") then "Importing an axiom would reverse the derivation order." else
  if !(SFT.Host.Text.equal (typesName c.types) "source-bound-form-predicate") then "A class name need not decide carrier membership." else
  if !(SFT.Host.Text.equal (constructorsName c.constructors) "joint-pairs-and-held-alternatives") then "A borrowed constructor imports its ambient universe." else
  if !(SFT.Host.Text.equal (functorName c.functor) "identity-and-composition-preservation") then "Renaming can break interfaces and composites." else
  if !(SFT.Host.Text.equal (naturalityName c.naturality) "equal-complete-paths") then "A drawn square cannot prove both routes equal." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-composition-axiom") then "An extra universal property is not supplied by the registered traces." else
  "The compositional kernel is canonical Fold objects, proof-carrying arrows, empty-One identity, exact-interface composition, path-flattening association, source-bound types, joint products, held sums, preserving functors and equal-path naturality."

def generationRule : String := "Generate the complete product of objects, arrows, identity, composition, association, types, product/sum structure, functoriality, naturality and extra-composition status."
def grammarBoundary : String := "All finite compositional structures generated from canonical objects, proof-carrying arrows, exact interface matching, empty-One returns, flattened paths, source-bound type predicates and held joint/alternative forms."

def candidates : List Candidate :=
  ([Objects.rejected,Objects.admitted]).flatMap fun objects =>
  ([Arrows.rejected,Arrows.admitted]).flatMap fun arrows =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Association.rejected,Association.admitted]).flatMap fun association =>
  ([Types.rejected,Types.admitted]).flatMap fun types =>
  ([Constructors.rejected,Constructors.admitted]).flatMap fun constructors =>
  ([Functor.rejected,Functor.admitted]).flatMap fun functor =>
  ([Naturality.rejected,Naturality.admitted]).flatMap fun naturality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨objects,arrows,identity,composition,association,types,constructors,functor,naturality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk objects arrows identity composition association types constructors functor naturality addition =>
    have hobjects : objects ∈ [Objects.rejected,Objects.admitted] := by
      cases objects <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have harrows : arrows ∈ [Arrows.rejected,Arrows.admitted] := by
      cases arrows <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hassociation : association ∈ [Association.rejected,Association.admitted] := by
      cases association <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htypes : types ∈ [Types.rejected,Types.admitted] := by
      cases types <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconstructors : constructors ∈ [Constructors.rejected,Constructors.admitted] := by
      cases constructors <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfunctor : functor ∈ [Functor.rejected,Functor.admitted] := by
      cases functor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnaturality : naturality ∈ [Naturality.rejected,Naturality.admitted] := by
      cases naturality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ objects _ hobjects
    apply CommonRefinement.memFlatMap _ _ arrows _ harrows
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ association _ hassociation
    apply CommonRefinement.memFlatMap _ _ types _ htypes
    apply CommonRefinement.memFlatMap _ _ constructors _ hconstructors
    apply CommonRefinement.memFlatMap _ _ functor _ hfunctor
    apply CommonRefinement.memFlatMap _ _ naturality _ hnaturality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk objects arrows identity composition association types constructors functor naturality addition =>
    cases objects <;> cases arrows <;> cases identity <;> cases composition <;> cases association <;> cases types <;> cases constructors <;> cases functor <;> cases naturality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk objects arrows identity composition association types constructors functor naturality addition =>
    cases objects <;> cases arrows <;> cases identity <;> cases composition <;> cases association <;> cases types <;> cases constructors <;> cases functor <;> cases naturality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.objects = .admitted ∧ c.arrows = .admitted ∧ c.identity = .admitted ∧ c.composition = .admitted ∧ c.association = .admitted ∧ c.types = .admitted ∧ c.constructors = .admitted ∧ c.functor = .admitted ∧ c.naturality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk objects arrows identity composition association types constructors functor naturality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem objects_rejected_rejected (c : Candidate) (h : c.objects = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.objects eq
    rw [h] at field
    cases field

theorem arrows_rejected_rejected (c : Candidate) (h : c.arrows = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.arrows eq
    rw [h] at field
    cases field

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
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

theorem association_rejected_rejected (c : Candidate) (h : c.association = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.association eq
    rw [h] at field
    cases field

theorem types_rejected_rejected (c : Candidate) (h : c.types = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.types eq
    rw [h] at field
    cases field

theorem constructors_rejected_rejected (c : Candidate) (h : c.constructors = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.constructors eq
    rw [h] at field
    cases field

theorem functor_rejected_rejected (c : Candidate) (h : c.functor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.functor eq
    rw [h] at field
    cases field

theorem naturality_rejected_rejected (c : Candidate) (h : c.naturality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.naturality eq
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

end SFT.Mathematics.CategoryGrammar
