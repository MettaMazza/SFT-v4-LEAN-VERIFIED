import SFT.Physics.CollectiveBand
import SFT.Mathematics.GraphPathCompleteness
namespace SFT.Physics.CollectivePhaseOrder
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects

def inducedGraph (cells : CollectiveCoarseGrain.NetworkObservation) (members : List String) : GeneratedGraph :=
 ⟨members,cells.graph.edges.filter (fun edge => has members edge.1 && has members edge.2)⟩

structure OrderedRegion where
 cells : CollectiveCoarseGrain.NetworkObservation
 macrostate : ThermoTemperature.Macrostate
 sameSupport : macrostate.support = cells.graph.nodes
 sameObservation : macrostate.observation = cells.observation
 connected : ∀ a b, a ∈ macrostate.members → b ∈ macrostate.members →
   PathWitness (inducedGraph cells macrostate.members) a b

def fraction (o : OrderedRegion) := ThermoStatisticalWeight.weight o.macrostate

theorem exactOrderedFraction (o : OrderedRegion) :
 o.macrostate.members.length * (fraction o).denominator =
 (fraction o).numerator * o.cells.graph.nodes.length := by
 have h := ThermoStatisticalWeight.exactCensusRatio o.macrostate
 rw [o.sameSupport] at h
 exact h

theorem orderedFractionThroughOne (o : OrderedRegion) :
 (fraction o).numerator ≤ (fraction o).denominator := ThermoStatisticalWeight.throughOne _

theorem positiveOrderedFraction (o : OrderedRegion) : 0 < (fraction o).numerator :=
 ThermoStatisticalWeight.positiveWeight _

theorem everyMemberSharesLabel (o : OrderedRegion) (cell : String) (held : cell ∈ o.macrostate.members) :
 SFT.Mathematics.GeometryTopology.image o.cells.observation cell = some o.macrostate.label := by
 have full := ThermoEntropy.exactHeldFibre o.macrostate
 change o.macrostate.members = SFT.Mathematics.ProbabilityObservations.fibre o.macrostate.support o.macrostate.observation o.macrostate.label at full
 rw [full] at held
 have h := (SFT.Mathematics.ProbabilityObservations.fibreMembership _ _ _ _).mp held
 rw [o.sameObservation] at h
 exact h.2

theorem exactConnectedSupport (o : OrderedRegion) (a b : String)
 (ha : a ∈ o.macrostate.members) (hb : b ∈ o.macrostate.members) :
 PathWitness (inducedGraph o.cells o.macrostate.members) a b := o.connected a b ha hb

-- Symmetry is exactly reversible preservation of the retained region and its
-- induced adjacency relation. Values outside the region do not enter the test.
def symmetry (o : OrderedRegion) (forward backward : String → String) : Prop :=
 (∀ x, x ∈ o.macrostate.members → forward x ∈ o.macrostate.members ∧
   backward x ∈ o.macrostate.members ∧ backward (forward x) = x ∧ forward (backward x) = x) ∧
 (∀ a b, a ∈ o.macrostate.members → b ∈ o.macrostate.members →
   ((forward a,forward b) ∈ (inducedGraph o.cells o.macrostate.members).edges ↔
    (a,b) ∈ (inducedGraph o.cells o.macrostate.members).edges))

theorem identitySymmetry (o : OrderedRegion) : symmetry o id id :=
 ⟨fun _ h => ⟨h,h,rfl,rfl⟩,fun _ _ _ _ => Iff.rfl⟩

def sameSymmetryClass (a b : OrderedRegion) : Prop :=
 ∀ forward backward, symmetry a forward backward ↔ symmetry b forward backward

theorem symmetryClassReflexive (o : OrderedRegion) : sameSymmetryClass o o := fun _ _ => Iff.rfl

theorem symmetryClassTransitive (a b c : OrderedRegion)
 (ab : sameSymmetryClass a b) (bc : sameSymmetryClass b c) : sameSymmetryClass a c :=
 fun f g => (ab f g).trans (bc f g)

def fibreView (o : OrderedRegion) := ThermoEquilibrium.classView o.macrostate

def stableObservation (a b : OrderedRegion) : Prop := fibreView a = fibreView b ∧ sameSymmetryClass a b

structure PhaseTransition where
 before : MechanicalEvents.Event OrderedRegion
 after : MechanicalEvents.Event OrderedRegion
 transfer : MechanicalEvents.Change before after
 fibreChanged : fibreView before.carrier ≠ fibreView after.carrier
 symmetryChanged : ¬ sameSymmetryClass before.carrier after.carrier

theorem transitionExcludesStableObservation (t : PhaseTransition) :
 ¬ stableObservation t.before.carrier t.after.carrier := fun h => t.fibreChanged h.1

theorem transitionRetainsBothChanges (t : PhaseTransition) :
 fibreView t.before.carrier ≠ fibreView t.after.carrier ∧
 ¬ sameSymmetryClass t.before.carrier t.after.carrier := ⟨t.fibreChanged,t.symmetryChanged⟩

def transitionTrace (t : PhaseTransition) : MechanicalEvents.Path t.before t.after :=
 .append (.one _) t.transfer

theorem exactTransitionTrace (t : PhaseTransition) :
 MechanicalEvents.events (transitionTrace t) = [t.before,t.after] := rfl

theorem transitionSourceRetained (t : PhaseTransition) :
 MechanicalEvents.sourceRecords (transitionTrace t) = [(t.transfer.sourceIdentity,t.transfer.actionRecord)] := rfl

theorem changedSymmetryWitness (a b : OrderedRegion) (f g : String → String)
 (before : symmetry a f g) (after : ¬ symmetry b f g) : ¬ sameSymmetryClass a b :=
 fun same => after ((same f g).mp before)

abbrev equilibriumFibreCriterion := @ThermoPhaseEquilibrium.coexistenceCriterion
abbrev changedEquilibriumFibreExcluded := @ThermoPhaseEquilibrium.changedSelectedFibreExcludesUnchangedPhase
abbrev reciprocalCarrierConservation := @ThermoPhaseEquilibrium.transitionRetainsAllCarriers
end SFT.Physics.CollectivePhaseOrder
