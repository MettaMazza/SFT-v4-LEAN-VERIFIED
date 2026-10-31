import SFT.Physics.WaveEnergyMomentum
import SFT.QuantumComputation.InformationUnit
namespace SFT.Physics.QuantumPhysicalState
open SFT.QuantumComputation.ReversibleModel

-- Preparation carries the admitted Fold state, the full source action record,
-- and the actual finite generated gate/preparation history.
structure Prepared where
  state : State
  admitted : makeState state.branches state.phaseCycle = .ok state
  sourceIdentity : String
  preparation : List SFT.Host.Canonical.Value

def records (p : Prepared) :=
  p.state.branches.map (fun branch => (branch,p.sourceIdentity,p.preparation))

theorem completeBranchesRecovered (p : Prepared) : (records p).map Prod.fst = p.state.branches := by
  have all (branches : List (Word × String)) :
      (branches.map (fun branch => (branch,p.sourceIdentity,p.preparation))).map Prod.fst = branches := by
    induction branches with
    | nil => rfl
    | cons b bs ih => exact congrArg (List.cons b) ih
  exact all _

theorem distinctWordSupport (p : Prepared) :
    SFT.Mathematics.DiscreteObjects.distinct (support p.state) = true := admittedStateSupport _ p.admitted

theorem everyPhaseHeld (p : Prepared) (branch : Word × String) (member : branch ∈ p.state.branches) :
    branch.2 ∈ p.state.phaseCycle := admittedPhaseMember _ p.admitted _ member

theorem everyRecordHasPreparation (p : Prepared) :
    ∀ row ∈ records p, row.2.1 = p.sourceIdentity ∧ row.2.2 = p.preparation := by
  intro row member
  obtain ⟨b,_,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ member
  cases eq
  exact ⟨rfl,rfl⟩

theorem completeGeneratedWords (p : Prepared) (alphabet positions cycle : List String)
    (generated : completeSupport alphabet positions cycle = .ok p.state) :
    support p.state = SFT.InformationScience.QuantitySupport.words alphabet positions.length :=
  completeSupportWords _ _ _ _ generated

theorem changedPreparationDistinguished (p q : Prepared) (different : p.preparation ≠ q.preparation) : p ≠ q :=
  fun eq => different (congrArg Prepared.preparation eq)

theorem changedSourceDistinguished (p q : Prepared) (different : p.sourceIdentity ≠ q.sourceIdentity) : p ≠ q :=
  fun eq => different (congrArg Prepared.sourceIdentity eq)
end SFT.Physics.QuantumPhysicalState
