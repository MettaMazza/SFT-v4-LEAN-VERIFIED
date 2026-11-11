import SFT.Chemistry.ChemicalPhase
namespace SFT.Materials.Phase
open SFT.Physics.CollectivePhaseOrder
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GraphOperations

-- MATERIALS_OBLIGATIONS[3]: shared stable recurrence and symmetry class
-- on connected support at the declared conditions.
structure System where
 graph : GeneratedGraph
 region : String → OrderedRegion
 conditions : List SFT.Chemistry.ChemicalPhase.HeldLabel

def InPhase (system : System) (root cell : String) : Prop :=
 ∃ prior : List String, pathIsValid system.graph (prior++[cell])=true ∧
 (prior++[cell]).head?=some root ∧
 ∀ x∈prior++[cell], stableObservation (system.region root) (system.region x)

theorem stableReflexive (region : OrderedRegion) : stableObservation region region :=
 ⟨rfl,symmetryClassReflexive region⟩

theorem stableTransitive (a b c : OrderedRegion)
 (ab : stableObservation a b) (bc : stableObservation b c) : stableObservation a c :=
 ⟨ab.1.trans bc.1,symmetryClassTransitive a b c ab.2 bc.2⟩

theorem base (system : System) (root : String) (held : root∈system.graph.nodes) :
 InPhase system root root := by
 refine ⟨[],(identityPathIff system.graph root).mpr held,rfl,?_⟩
 intro x hx
 cases hx with
 | head => exact stableReflexive _
 | tail _ h => cases h

theorem memberSharesClass (system : System) (root cell : String)
 (member : InPhase system root cell) : stableObservation (system.region root) (system.region cell) := by
 obtain ⟨prior,_,_,same⟩ := member
 exact same cell (SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head _))

theorem memberConnected (system : System) (root cell : String)
 (member : InPhase system root cell) : PathWitness system.graph root cell := by
 obtain ⟨prior,valid,starts,_⟩ := member
 exact ⟨prior,valid,starts⟩

theorem maximalConnectedClass (system : System) (root : String) (support : List String)
 (same : ∀ x∈support, stableObservation (system.region root) (system.region x))
 (connected : ∀ x∈support, ∃ prior, pathIsValid system.graph (prior++[x])=true ∧
 (prior++[x]).head?=some root ∧ ∀ n∈prior++[x], n∈support) :
 ∀ x∈support, InPhase system root x := by
 intro x held
 obtain ⟨prior,valid,starts,inside⟩ := connected x held
 exact ⟨prior,valid,starts,fun n hn => same n (inside n hn)⟩

theorem differentRecurrenceExcluded (system : System) (root cell : String)
 (different : fibreView (system.region root) ≠ fibreView (system.region cell)) :
 ¬ InPhase system root cell := fun h => different (memberSharesClass system root cell h).1

theorem differentSymmetryExcluded (system : System) (root cell : String)
 (different : ¬sameSymmetryClass (system.region root) (system.region cell)) :
 ¬ InPhase system root cell := fun h => different (memberSharesClass system root cell h).2
end SFT.Materials.Phase
