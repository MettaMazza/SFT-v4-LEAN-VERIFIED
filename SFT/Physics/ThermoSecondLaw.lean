import SFT.Physics.ThermoEntropy
import SFT.InformationScience.EntropyPairs
import SFT.InformationScience.ConservationReverse
namespace SFT.Physics.ThermoSecondLaw
open SFT.InformationScience ConservationLedger ConservationComposition EntropyPartition EntropyRefinement
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.GeometryTopology

structure Process where
 support : List String
 first : Observation
 second : Observation
 firstValid : validateTransformation support first = .ok first
 secondValid : validateTransformation (MutualObservation.labels support first) second = .ok second
 before : Partition
 after : Partition
 beforeComputed : exactPartition support first = .ok before
 afterComputed : exactPartition support (composedRows support first second) = .ok after

def finalObservation (p : Process) := composedRows p.support p.first p.second

theorem actualComposition (p : Process) : compose p.support p.first p.second = .ok (finalObservation p) :=
 composeAdmitted _ _ _ p.firstValid p.secondValid

theorem inducedRefinement (p : Process) : refines p.support p.first (finalObservation p) = true := by
 apply (refinementMeaning _ _ _).mpr
 refine ⟨((validityMeaning _ _).mp (partitionResult _ _ _ p.beforeComputed).1).2.2.2,
   ((validityMeaning _ _).mp (partitionResult _ _ _ p.afterComputed).1).2.2.2,?_⟩
 intro a b ha hb same
 change image (composedRows p.support p.first p.second) a = image (composedRows p.support p.first p.second) b
 rw [composedImage _ _ _ _ ha,composedImage _ _ _ _ hb]
 have held : value p.first a = value p.first b := congrArg (fun o : Option String => o.getD "") same
 rw [held]

theorem predecessorSupportCannotShrink (p : Process) (label : String) (members : List String)
 (present : (label,members) ∈ p.before) :
 ∃ laterLabel laterMembers, (laterLabel,laterMembers) ∈ p.after ∧
   (∀ state, state ∈ members → state ∈ laterMembers) ∧ members.length ≤ laterMembers.length := by
 obtain ⟨laterLabel,laterMembers,row,contained⟩ :=
   classContainment _ _ _ _ _ p.beforeComputed p.afterComputed (inducedRefinement p) label members present
 exact ⟨laterLabel,laterMembers,row,contained,
   SFT.Mathematics.ProbabilityEvents.distinctSubsetLength _ _
     (partitionClassDistinct _ _ _ p.beforeComputed _ _ present) contained⟩

theorem unresolvedPairCountCannotDecrease (p : Process) :
 (p.before.flatMap (fun row => uncertaintyPairs (unresolvedPairs row.2))).length ≤
 (p.after.flatMap (fun row => uncertaintyPairs (unresolvedPairs row.2))).length :=
 EntropyPairs.refinementPairCount _ _ _ _ _ p.beforeComputed p.afterComputed (inducedRefinement p)

theorem closedDistinctionsPersist (p : Process) (pair : String × String)
 (closedBefore : pair ∈ closed p.support p.first) : pair ∈ closed p.support (finalObservation p) :=
 closedPersists _ _ _ _ closedBefore

theorem retainedDistinctionsCannotIncrease (p : Process) (pair : String × String)
 (retainedAfter : pair ∈ retained p.support (finalObservation p)) : pair ∈ retained p.support p.first :=
 retainedSubset _ _ _ _ retainedAfter

theorem exactReverseRecord (p : Process) :
 ConservationReverse.reverseRecord p.support (finalObservation p) =
 .ok (ConservationReverse.reverseRows (classRows p.support (finalObservation p))) :=
 ConservationReverse.reverseAdmitted _ _
  (composedAdmitted _ _ _ ((validationMeaning _ _ _).mp p.firstValid).1)

theorem noUnrecordedReverse (p : Process) (a b : String)
 (same : image (finalObservation p) a = image (finalObservation p) b) (different : a ≠ b)
 (decode : Option String → String)
 (recoverA : decode (image (finalObservation p) a) = a)
 (recoverB : decode (image (finalObservation p) b) = b) : False :=
 different (recoverA.symm.trans ((congrArg decode same).trans recoverB))

abbrev heldPredecessorRecovery := ConservationReverse.heldRecovery
abbrev uniquePredecessorRecovery := ConservationReverse.uniqueRecovery
abbrev distinctPredecessorsRequireRecords := ConservationReverse.distinctPredecessorsNotUnique
abbrev oneStateBase := EntropyExtension.singletonBase
abbrev successorPreservesFibre := EntropyExtension.fibreSuccessor
end SFT.Physics.ThermoSecondLaw
