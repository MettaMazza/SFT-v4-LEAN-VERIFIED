import SFT.Materials.Lattice
import SFT.Mathematics.DiscreteRelations
import SFT.Mathematics.GraphExtension
namespace SFT.Materials.UnitCellReconstruction
open SFT.Mathematics.DiscreteObjects
open SFT.Mathematics.AlgebraOperations
open SFT.Mathematics.GraphOperations

-- Source obligation: retain each translated site and relation exactly once.
-- These are explicit finite translation records, not fitted scientific values.
structure Trace where
 lattice : Lattice.Record
 siteSteps : List (Nat × String)
 relationSteps : List (Nat × Edge)

def sites (t : Trace) : List String :=
 t.siteSteps.map (fun row => Lattice.translate t.lattice row.1 row.2)

def relations (t : Trace) : List Edge :=
 t.relationSteps.map (fun row =>
   (Lattice.translate t.lattice row.1 row.2.1,
    Lattice.translate t.lattice row.1 row.2.2))

def occurrence {α : Type} [DecidableEq α] (x : α) : List α → Nat
 | [] => 0
 | y::ys => (if x=y then 1 else 0) + occurrence x ys

def reconstructsOnce (t : Trace) : Prop :=
 (∀ x, occurrence x (sites t) = occurrence x t.lattice.cells.graph.nodes) ∧
 (∀ e, occurrence e (relations t) = occurrence e t.lattice.cells.graph.edges)

theorem siteGenerated (t : Trace) (row : Nat × String)
 (held : row.2 ∈ t.lattice.cells.graph.nodes) :
 Lattice.translate t.lattice row.1 row.2 ∈ t.lattice.cells.graph.nodes :=
 Lattice.everyTranslationHeld t.lattice row.1 row.2 held

theorem relationGenerated (t : Trace) (row : Nat × Edge)
 (left : row.2.1 ∈ t.lattice.cells.graph.nodes)
 (right : row.2.2 ∈ t.lattice.cells.graph.nodes)
 (edge : row.2 ∈ t.lattice.cells.graph.edges) :
 (Lattice.translate t.lattice row.1 row.2.1,
 Lattice.translate t.lattice row.1 row.2.2) ∈ t.lattice.cells.graph.edges :=
 (Lattice.everyAdjacencyRecurs t.lattice row.1 row.2.1 row.2.2 left right).mpr edge

theorem wordRetained (t : Trace) (row : Nat × String)
 (held : row.2 ∈ t.lattice.cells.graph.nodes) :
 t.lattice.word (Lattice.translate t.lattice row.1 row.2)=t.lattice.word row.2 :=
 Lattice.everyLocalWordRecurs t.lattice row.1 row.2 held

theorem occurrenceAbsent {α : Type} [DecidableEq α] (x : α) (xs : List α)
 (absent : ¬ x ∈ xs) : occurrence x xs = 0 := by
 induction xs with
 | nil => rfl
 | cons y ys ih =>
   have unequal : x ≠ y := by
    intro same; cases same; exact absent (List.Mem.head _)
   change (if x=y then 1 else 0) + occurrence x ys = 0
   rw [ite_eq_right unequal,ih (fun h => absent (List.Mem.tail y h))]

theorem occurrenceMember {α : Type} [DecidableEq α] (x : α) (xs : List α)
 (held : x ∈ xs) : 0 < occurrence x xs := by
 induction xs with
 | nil => cases held
 | cons y ys ih =>
   change 0 < (if x=y then 1 else 0) + occurrence x ys
   by_cases same : x=y
   · rw [ite_eq_left same, Nat.add_comm]; exact Nat.zero_lt_succ _
   · rw [ite_eq_right same, Nat.zero_add]
     cases held with
     | head => exact False.elim (same rfl)
     | tail _ h => exact ih h

theorem occurrenceDistinct {α : Type} [DecidableEq α] (x : α) (xs : List α)
 (unique : distinct xs = true) (held : x ∈ xs) : occurrence x xs = 1 := by
 induction xs with
 | nil => cases held
 | cons y ys ih =>
   have parts := (distinctCons y ys).mp unique
   change (if x=y then 1 else 0) + occurrence x ys = 1
   by_cases same : x=y
   · cases same
     rw [ite_eq_left rfl, occurrenceAbsent x ys ((absentIff ys x).mp parts.1)]
   · rw [ite_eq_right same, Nat.zero_add]
     cases held with
     | head => exact False.elim (same rfl)
     | tail _ h => exact ih parts.2 h

theorem everySiteOnce (t : Trace) (exactTrace : reconstructsOnce t)
 (unique : distinct t.lattice.cells.graph.nodes = true)
 (site : String) (held : site ∈ t.lattice.cells.graph.nodes) :
 occurrence site (sites t)=1 :=
 (exactTrace.1 site).trans (occurrenceDistinct site _ unique held)

theorem everyRelationOnce (t : Trace) (exactTrace : reconstructsOnce t)
 (unique : distinct t.lattice.cells.graph.edges = true)
 (edge : Edge) (held : edge ∈ t.lattice.cells.graph.edges) :
 occurrence edge (relations t)=1 :=
 (exactTrace.2 edge).trans (occurrenceDistinct edge _ unique held)

-- A changed presentation of the same reconstruction retains every site and
-- adjacency multiplicity. No arbitrary choice of a preferred basis is made.
theorem presentationIndependent (a b : Trace)
 (sameNodes : a.lattice.cells.graph.nodes=b.lattice.cells.graph.nodes)
 (sameEdges : a.lattice.cells.graph.edges=b.lattice.cells.graph.edges)
 (ha : reconstructsOnce a) (hb : reconstructsOnce b) :
 (∀ x, occurrence x (sites a)=occurrence x (sites b)) ∧
 (∀ e, occurrence e (relations a)=occurrence e (relations b)) := by
 constructor
 · intro x; exact (ha.1 x).trans ((congrArg (occurrence x) sameNodes).trans (hb.1 x).symm)
 · intro e; exact (ha.2 e).trans ((congrArg (occurrence e) sameEdges).trans (hb.2 e).symm)

theorem latticeMultiplicity (l : Lattice.Record) :
 distinct l.cells.graph.nodes=true ∧ distinct l.cells.graph.edges=true := by
 have retained := Lattice.completeSiteCarrier l
 have accepted := l.cells.generated
 rw [retained] at accepted
 have checks := (graphConstructorMeaning l.cells.nodes l.cells.edges).mp accepted
 rw [retained]
 exact ⟨checks.2.1,checks.2.2.1⟩

theorem reconstructedSitesOnce (t : Trace) (exactTrace : reconstructsOnce t)
 (x : String) (held : x ∈ t.lattice.cells.graph.nodes) : occurrence x (sites t)=1 :=
 everySiteOnce t exactTrace (latticeMultiplicity t.lattice).1 x held

theorem reconstructedRelationsOnce (t : Trace) (exactTrace : reconstructsOnce t)
 (e : Edge) (held : e ∈ t.lattice.cells.graph.edges) : occurrence e (relations t)=1 :=
 everyRelationOnce t exactTrace (latticeMultiplicity t.lattice).2 e held

def identityTrace (l : Lattice.Record) : Trace :=
 ⟨l,l.cells.graph.nodes.map (fun x => (0,x)),
 l.cells.graph.edges.map (fun e => (0,e))⟩

theorem identitySites (l : Lattice.Record) : sites (identityTrace l)=l.cells.graph.nodes := by
 unfold sites identityTrace
 induction l.cells.graph.nodes with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih

theorem identityRelations (l : Lattice.Record) : relations (identityTrace l)=l.cells.graph.edges := by
 unfold relations identityTrace
 induction l.cells.graph.edges with
 | nil => rfl
 | cons e es ih => exact congrArg (List.cons e) ih

theorem identityReconstructs (l : Lattice.Record) : reconstructsOnce (identityTrace l) := by
 constructor
 · intro x; exact congrArg (occurrence x) (identitySites l)
 · intro e; exact congrArg (occurrence e) (identityRelations l)

def sameMultiplicity {α : Type} [DecidableEq α] (xs ys : List α) : Bool :=
 (xs ++ ys).all (fun x => decide (occurrence x xs=occurrence x ys))

theorem multiplicityCheckMeaning {α : Type} [DecidableEq α] (xs ys : List α) :
 sameMultiplicity xs ys=true ↔ ∀ x, occurrence x xs=occurrence x ys := by
 constructor
 · intro checked x
   have all := (SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mp checked
   cases hx : has xs x with
   | true => exact of_decide_eq_true (all x (SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ ((hasIff xs x).mp hx)))
   | false =>
     cases hy : has ys x with
     | true => exact of_decide_eq_true (all x (SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ ((hasIff ys x).mp hy)))
     | false =>
       have nx : ¬ x ∈ xs := by
        intro h; have yes := (hasIff xs x).mpr h; rw [hx] at yes; cases yes
       have ny : ¬ x ∈ ys := by
        intro h; have yes := (hasIff ys x).mpr h; rw [hy] at yes; cases yes
       exact (occurrenceAbsent x xs nx).trans (occurrenceAbsent x ys ny).symm
 · intro same
   exact (SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mpr
     (fun x _ => decide_eq_true (same x))

def reconstructionCheck (t : Trace) : Bool :=
 sameMultiplicity (sites t) t.lattice.cells.graph.nodes &&
 sameMultiplicity (relations t) t.lattice.cells.graph.edges

theorem reconstructionCheckMeaning (t : Trace) :
 reconstructionCheck t=true ↔ reconstructsOnce t := by
 constructor
 · intro checked
   have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp checked
   exact ⟨(multiplicityCheckMeaning _ _).mp both.1,(multiplicityCheckMeaning _ _).mp both.2⟩
 · intro exactTrace
   exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
     ⟨(multiplicityCheckMeaning _ _).mpr exactTrace.1,(multiplicityCheckMeaning _ _).mpr exactTrace.2⟩

theorem identityCheckPasses (l : Lattice.Record) : reconstructionCheck (identityTrace l)=true :=
 (reconstructionCheckMeaning _).mpr (identityReconstructs l)
end SFT.Materials.UnitCellReconstruction
