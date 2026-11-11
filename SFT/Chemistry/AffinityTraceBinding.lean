import SFT.Chemistry.AffinityComparison
import SFT.Chemistry.AffinityClosure
namespace SFT.Chemistry.AffinityTraceBinding
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure EndpointTrace where
 atom : String
 support : HeldLabel
 visits : List HeldLabel

def sameTrace (a b : EndpointTrace) : Prop := a.support=b.support ∧ a.visits=b.visits
instance (a b : EndpointTrace) : Decidable (sameTrace a b) := inferInstanceAs (Decidable (a.support=b.support ∧ a.visits=b.visits))
def equalEdges (a : EndpointTrace) : List EndpointTrace → List (String × String)
 | [] => []
 | b::rest => if sameTrace a b then (a.atom,b.atom)::equalEdges a rest else equalEdges a rest

def tieEdges (rows : List EndpointTrace) := rows.flatMap (fun a => equalEdges a rows)
def preferenceEdge (comparison : AffinityComparison.Comparison) : String × String :=
 if comparison.raw.preferredEndpoint=comparison.raw.firstAtom then
 (comparison.raw.secondAtom,comparison.raw.firstAtom)
 else (comparison.raw.firstAtom,comparison.raw.secondAtom)

def edges (traces : List EndpointTrace) (comparisons : List AffinityComparison.Comparison) :=
 tieEdges traces ++ comparisons.map preferenceEdge

theorem equalEdgePresent (a b : EndpointTrace) (rows : List EndpointTrace)
 (member : b∈rows) (same : sameTrace a b) : (a.atom,b.atom)∈equalEdges a rows := by
 induction rows with
 | nil => cases member
 | cons first rest ih =>
   cases member with
   | head => rw [equalEdges,ite_eq_left same]; exact .head _
   | tail _ held =>
     unfold equalEdges
     split
     · exact .tail _ (ih held)
     · exact ih held

theorem equalTracesTied (traces : List EndpointTrace) (comparisons : List AffinityComparison.Comparison)
 (a b : EndpointTrace) (ha : a∈traces) (hb : b∈traces) (same : sameTrace a b) :
 AffinityClosure.Tied (edges traces comparisons) a.atom b.atom := by
 have forward := memFlatMap (fun a => equalEdges a traces) traces a (a.atom,b.atom) ha (equalEdgePresent a b traces hb same)
 have backward := memFlatMap (fun b => equalEdges b traces) traces b (b.atom,a.atom) hb (equalEdgePresent b a traces ha ⟨same.1.symm,same.2.symm⟩)
 exact ⟨.step .identity (memAppendLeft _ _ _ forward),.step .identity (memAppendLeft _ _ _ backward)⟩

def Strict (relation : AffinityClosure.Relation) (a b : String) :=
 AffinityClosure.Precedes relation a b ∧ ¬AffinityClosure.Precedes relation b a

theorem equalTracesCannotBeStrict (traces : List EndpointTrace) (comparisons : List AffinityComparison.Comparison)
 (a b : EndpointTrace) (ha : a∈traces) (hb : b∈traces) (same : sameTrace a b) :
 ¬Strict (edges traces comparisons) a.atom b.atom :=
 fun strict => strict.2 (equalTracesTied traces comparisons a b ha hb same).2

def cycleCheck (traces : List EndpointTrace) (comparisons : List AffinityComparison.Comparison) : Bool :=
 traces.all fun a => traces.all fun b =>
 if SFT.Mathematics.DynamicsStability.perturbationReaches (edges traces comparisons) a.atom b.atom &&
 SFT.Mathematics.DynamicsStability.perturbationReaches (edges traces comparisons) b.atom a.atom
 then decide (sameTrace a b) else true

theorem acceptedCyclesAreExactTies (traces : List EndpointTrace) (comparisons : List AffinityComparison.Comparison)
 (passed : cycleCheck traces comparisons=true) (a b : EndpointTrace) (ha : a∈traces) (hb : b∈traces)
 (tied : AffinityClosure.Tied (edges traces comparisons) a.atom b.atom) : sameTrace a b := by
 have rows := allTrueAtMember _ traces passed a ha
 have cell := allTrueAtMember _ traces rows b hb
 have forward := (AffinityClosure.executableClosure _ _ _).mpr tied.1
 have backward := (AffinityClosure.executableClosure _ _ _).mpr tied.2
 rw [forward,backward] at cell
 exact of_decide_eq_true cell

theorem exactTieClass (traces : List EndpointTrace) (comparisons : List AffinityComparison.Comparison)
 (passed : cycleCheck traces comparisons=true) (a b : EndpointTrace) (ha : a∈traces) (hb : b∈traces) :
 AffinityClosure.Tied (edges traces comparisons) a.atom b.atom ↔ sameTrace a b :=
 ⟨acceptedCyclesAreExactTies _ _ passed _ _ ha hb,equalTracesTied _ _ _ _ ha hb⟩

theorem comparisonRetained (traces : List EndpointTrace) (comparisons : List AffinityComparison.Comparison)
 (row : AffinityComparison.Comparison) (held : row∈comparisons) :
 AffinityClosure.Precedes (edges traces comparisons) (preferenceEdge row).1 (preferenceEdge row).2 :=
 .step .identity (memAppendRight _ _ _ (memMap preferenceEdge row comparisons held))

theorem appendComparisonEdges (traces : List EndpointTrace) (before : List AffinityComparison.Comparison)
 (fresh : AffinityComparison.Comparison) : edges traces (before++[fresh])=edges traces before++[preferenceEdge fresh] := by
 unfold edges
 rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend]
 exact (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _).symm

theorem appendRetainsEveryComparisonPath (traces : List EndpointTrace) (before : List AffinityComparison.Comparison)
 (fresh : AffinityComparison.Comparison) (a b : String) (prior : AffinityClosure.Precedes (edges traces before) a b) :
 AffinityClosure.Precedes (edges traces (before++[fresh])) a b := by
 rw [appendComparisonEdges]
 exact AffinityClosure.retainedClosure _ _ _ _ prior

theorem appendRetainsExactTie (traces : List EndpointTrace) (before : List AffinityComparison.Comparison)
 (fresh : AffinityComparison.Comparison) (a b : String) (prior : AffinityClosure.Tied (edges traces before) a b) :
 AffinityClosure.Tied (edges traces (before++[fresh])) a b :=
 ⟨appendRetainsEveryComparisonPath _ _ _ _ _ prior.1,appendRetainsEveryComparisonPath _ _ _ _ _ prior.2⟩

structure BoundComparison where
 comparison : AffinityComparison.Comparison
 first : EndpointTrace
 second : EndpointTrace
 firstIdentity : first.atom=comparison.raw.firstAtom
 secondIdentity : second.atom=comparison.raw.secondAtom
 firstSupport : first.support=comparison.raw.sharedSupport
 secondSupport : second.support=comparison.raw.sharedSupport

theorem identicalSharedSupport (record : BoundComparison) : record.first.support=record.second.support :=
 record.firstSupport.trans record.secondSupport.symm
end SFT.Chemistry.AffinityTraceBinding
