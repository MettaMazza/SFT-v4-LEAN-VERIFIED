import SFT.Physics.FieldRadiation
namespace SFT.Physics.FieldInteractionClasses

structure Signature (Source Propagation Response : Type) where
  conservedSources : List Source
  propagationCarriers : List Propagation
  responseTraces : List Response

structure Description (Source Propagation Response Name : Type) where
  signature : Signature Source Propagation Response
  name : Name

variable {Source Propagation Response Name : Type}

def equivalent (a b : Description Source Propagation Response Name) : Prop := a.signature = b.signature

def canonical (a : Description Source Propagation Response Name) := a.signature

theorem namesAloneDoNotDistinguish (s : Signature Source Propagation Response) (a b : Name) :
    equivalent (Description.mk s a) (Description.mk s b) := rfl

theorem exactClassCriterion (a b : Description Source Propagation Response Name) :
    canonical a = canonical b ↔ equivalent a b := ⟨fun h => h,fun h => h⟩

theorem reflexive (a : Description Source Propagation Response Name) : equivalent a a := rfl

theorem symmetric (a b : Description Source Propagation Response Name) (h : equivalent a b) :
    equivalent b a := h.symm

theorem transitive (a b c : Description Source Propagation Response Name)
    (h : equivalent a b) (k : equivalent b c) : equivalent a c := h.trans k

theorem preservesAllSources (a b : Description Source Propagation Response Name) (h : equivalent a b) :
    a.signature.conservedSources = b.signature.conservedSources := congrArg Signature.conservedSources h

theorem preservesAllPropagation (a b : Description Source Propagation Response Name) (h : equivalent a b) :
    a.signature.propagationCarriers = b.signature.propagationCarriers := congrArg Signature.propagationCarriers h

theorem preservesAllResponses (a b : Description Source Propagation Response Name) (h : equivalent a b) :
    a.signature.responseTraces = b.signature.responseTraces := congrArg Signature.responseTraces h

theorem completeTracesSuffice (a b : Description Source Propagation Response Name)
    (hs : a.signature.conservedSources = b.signature.conservedSources)
    (hp : a.signature.propagationCarriers = b.signature.propagationCarriers)
    (hr : a.signature.responseTraces = b.signature.responseTraces) : equivalent a b := by
  cases a with
  | mk a na => cases b with
    | mk b nb => cases a with
      | mk sa pa ra => cases b with
        | mk sb pb rb => cases hs; cases hp; cases hr; rfl

theorem changedCompleteTraceDistinguishes (a b : Description Source Propagation Response Name)
    (h : a.signature.conservedSources ≠ b.signature.conservedSources ∨
      a.signature.propagationCarriers ≠ b.signature.propagationCarriers ∨
      a.signature.responseTraces ≠ b.signature.responseTraces) : ¬ equivalent a b := by
  intro eq
  cases h with
  | inl h => exact h (preservesAllSources a b eq)
  | inr h => cases h with
    | inl h => exact h (preservesAllPropagation a b eq)
    | inr h => exact h (preservesAllResponses a b eq)

def completeClasses (rows : List (Description Source Propagation Response Name)) := rows.map canonical

theorem allOriginalClassesPresent (rows : List (Description Source Propagation Response Name))
    (a : Description Source Propagation Response Name) (h : a ∈ rows) : canonical a ∈ completeClasses rows := by
  induction h with
  | head => exact .head _
  | tail _ _ ih => exact .tail _ ih

theorem noInventedClass (rows : List (Description Source Propagation Response Name))
    (s : Signature Source Propagation Response) (h : s ∈ completeClasses rows) :
    ∃ a ∈ rows, canonical a = s := by
  induction rows with
  | nil => cases h
  | cons a rest ih => cases h with
    | head => exact ⟨a,.head _,rfl⟩
    | tail _ h => obtain ⟨b,hb,eq⟩ := ih h; exact ⟨b,.tail _ hb,eq⟩
end SFT.Physics.FieldInteractionClasses
