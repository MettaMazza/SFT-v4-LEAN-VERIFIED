import SFT.Physics.SpacetimeInterval
namespace SFT.Physics.SpacetimeCausalOrder
open MechanicalEvents FieldLocality
variable {State : Type} {adjacent : Event State → Event State → Prop}

-- CAUSAL_ORDER: only generated adjacent paths within the retained finite
-- recurrence support are accessible. The bound is a source observation.
def Within (a b : Event State) (support : Nat) : Prop :=
 ∃ path : Propagation adjacent a b, count (trace path) ≤ support

def cone (a : Event State) (support : Nat) : Event State → Prop :=
 fun b => @Within State adjacent a b support

theorem reflexive (a : Event State) (support : Nat) : @Within State adjacent a a support :=
 ⟨.one a,Nat.zero_le _⟩

theorem compositionCount {a b c : Event State}
 (p : Propagation adjacent a b) (q : Propagation adjacent b c) :
 count (trace (join p q)) = count (trace p)+count (trace q) := by
 rw [joinTrace]
 exact MechanicalAngularMotion.joinCount _ _

theorem transitive {a b c : Event State} {first second : Nat}
 (ab : @Within State adjacent a b first) (bc : @Within State adjacent b c second) :
 @Within State adjacent a c (first+second) := by
 obtain ⟨p,hp⟩ := ab
 obtain ⟨q,hq⟩ := bc
 refine ⟨join p q,?_⟩
 rw [compositionCount]
 exact Nat.add_le_add hp hq

theorem allowanceExtension {a b : Event State} {first second : Nat}
 (h : @Within State adjacent a b first) (extension : first ≤ second) :
 @Within State adjacent a b second := by
 obtain ⟨p,hp⟩ := h
 exact ⟨p,Nat.le_trans hp extension⟩

theorem completeCone (a b : Event State) (support : Nat) :
 @cone State adjacent a support b ↔ ∃ p : Propagation adjacent a b, count (trace p) ≤ support :=
 ⟨fun h => h,fun h => h⟩

theorem outsideExcludesEveryPath (a b : Event State) (support : Nat)
 (outside : ¬ @cone State adjacent a support b) :
 ∀ p : Propagation adjacent a b, ¬ count (trace p) ≤ support :=
 fun p bound => outside ⟨p,bound⟩

theorem everyReachableStepAdjacent {a b : Event State} {support : Nat}
 (h : @Within State adjacent a b support) :
 ∃ p : Propagation adjacent a b,
 count (trace p) ≤ support ∧ ∀ r ∈ changes (trace p), adjacent r.before r.after := by
 obtain ⟨p,hp⟩ := h
 exact ⟨p,hp,everyTransitionAdjacent p⟩

-- Irreversible records have a generated finite history; an admitted adjacent
-- extension strictly increases its length. Reversible recurrence is not
-- silently equated with an irreversible record order.
def IrreversibleHistory {Record : Type} (history : Event State → List Record) : Prop :=
 ∀ a b, adjacent a b → (history a).length < (history b).length

theorem appendRecordStrict {Record : Type} (history : List Record) (next : Record) :
 history.length < (history ++ [next]).length := by
 rw [ReferenceRealization.lengthAppendOne]
 exact Nat.lt_succ_self _

theorem pathHistoryMonotone {Record : Type} (history : Event State → List Record)
 (irreversible : @IrreversibleHistory State adjacent Record history)
 {a b : Event State} (p : Propagation adjacent a b) :
 (history a).length ≤ (history b).length := by
 induction p with
 | one => exact Nat.le_refl _
 | append p step edge ih => exact Nat.le_trans ih (Nat.le_of_lt (irreversible _ _ edge))

theorem irreversibleAntisymmetric {Record : Type} (history : Event State → List Record)
 (irreversible : @IrreversibleHistory State adjacent Record history)
 {a b : Event State} {forward backward : Nat}
 (ab : @Within State adjacent a b forward) (ba : @Within State adjacent b a backward) : a=b := by
 obtain ⟨p,hp⟩ := ab
 obtain ⟨q,hq⟩ := ba
 cases p with
 | one => rfl
 | append prior step edge =>
   have strict := Nat.lt_of_le_of_lt (pathHistoryMonotone history irreversible prior)
     (irreversible _ _ edge)
   exact False.elim (Nat.not_le_of_gt strict (pathHistoryMonotone history irreversible q))

theorem sourceExtensionWithin {a b c : Event State} {support : Nat}
 (h : @Within State adjacent a b support) (step : Change b c) (edge : adjacent b c) :
 @Within State adjacent a c (support+1) := by
 obtain ⟨p,hp⟩ := h
 refine ⟨.append p step edge,?_⟩
 change count (Path.append (trace p) step) ≤ support+1
 rw [successorAddsOne]
 exact Nat.add_le_add_right hp 1
end SFT.Physics.SpacetimeCausalOrder

#print axioms SFT.Physics.SpacetimeCausalOrder.Within
#print axioms SFT.Physics.SpacetimeCausalOrder.cone
#print axioms SFT.Physics.SpacetimeCausalOrder.reflexive
#print axioms SFT.Physics.SpacetimeCausalOrder.compositionCount
#print axioms SFT.Physics.SpacetimeCausalOrder.transitive
#print axioms SFT.Physics.SpacetimeCausalOrder.allowanceExtension
#print axioms SFT.Physics.SpacetimeCausalOrder.completeCone
#print axioms SFT.Physics.SpacetimeCausalOrder.outsideExcludesEveryPath
#print axioms SFT.Physics.SpacetimeCausalOrder.everyReachableStepAdjacent
#print axioms SFT.Physics.SpacetimeCausalOrder.IrreversibleHistory
#print axioms SFT.Physics.SpacetimeCausalOrder.appendRecordStrict
#print axioms SFT.Physics.SpacetimeCausalOrder.pathHistoryMonotone
#print axioms SFT.Physics.SpacetimeCausalOrder.irreversibleAntisymmetric
#print axioms SFT.Physics.SpacetimeCausalOrder.sourceExtensionWithin