import SFT.Mathematics.DynamicsStability
namespace SFT.Chemistry.AffinityClosure
open SFT.Foundation.Count.TraceDerivation
abbrev Relation := List (String × String)
abbrev Precedes := SFT.Mathematics.DynamicsStability.Reaches

theorem reflexive (comparisons : Relation) (a : String) : Precedes comparisons a a := .identity

theorem transitive (comparisons : Relation) (a b c : String)
 (first : Precedes comparisons a b) (second : Precedes comparisons b c) : Precedes comparisons a c := by
 induction second with
 | identity => exact first
 | step prior edge ih => exact .step ih edge

theorem leastClosure (comparisons : Relation) (R : String → String → Prop)
 (identity : ∀ a, R a a) (trans : ∀ a b c, R a b → R b c → R a c)
 (includes : ∀ a b, (a,b)∈comparisons → R a b)
 (a b : String) (path : Precedes comparisons a b) : R a b := by
 induction path with
 | identity => exact identity a
 | @step left right prior edge ih => exact trans a left right ih (includes left right edge)

theorem uniqueLeastClosure (comparisons : Relation) (Q : String → String → Prop)
 (identity : ∀ a, Q a a) (trans : ∀ a b c, Q a b → Q b c → Q a c)
 (includes : ∀ a b, (a,b)∈comparisons → Q a b)
 (least : ∀ (R : String → String → Prop), (∀ a, R a a) →
   (∀ a b c, R a b → R b c → R a c) →
   (∀ a b, (a,b)∈comparisons → R a b) → ∀ a b, Q a b → R a b)
 (a b : String) : Q a b ↔ Precedes comparisons a b := by
 constructor
 · exact least (Precedes comparisons) (reflexive comparisons) (transitive comparisons)
     (fun _ _ held => .step .identity held) a b
 · exact leastClosure comparisons Q identity trans includes a b

def Tied (comparisons : Relation) (a b : String) := Precedes comparisons a b ∧ Precedes comparisons b a

theorem tieReflexive (comparisons : Relation) (a : String) : Tied comparisons a a := ⟨.identity,.identity⟩
theorem tieSymmetric (comparisons : Relation) (a b : String) (tied : Tied comparisons a b) : Tied comparisons b a := ⟨tied.2,tied.1⟩
theorem tieTransitive (comparisons : Relation) (a b c : String)
 (ab : Tied comparisons a b) (bc : Tied comparisons b c) : Tied comparisons a c :=
 ⟨transitive _ _ _ _ ab.1 bc.1,transitive _ _ _ _ bc.2 ab.2⟩

theorem retainedClosure (before added : Relation) (a b : String) (prior : Precedes before a b) :
 Precedes (before++added) a b := by
 induction prior with
 | identity => exact .identity
 | step prior edge ih => exact .step ih (memAppendLeft _ _ _ edge)

theorem retainedTie (before added : Relation) (a b : String) (prior : Tied before a b) :
 Tied (before++added) a b := ⟨retainedClosure _ _ _ _ prior.1,retainedClosure _ _ _ _ prior.2⟩

theorem executableClosure (comparisons : Relation) (a b : String) :
 SFT.Mathematics.DynamicsStability.perturbationReaches comparisons a b=true ↔ Precedes comparisons a b :=
 SFT.Mathematics.DynamicsStability.perturbationReachabilityIff comparisons a b
end SFT.Chemistry.AffinityClosure
