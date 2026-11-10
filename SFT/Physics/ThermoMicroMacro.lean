import SFT.InformationScience.EntropyExtension
import SFT.Physics.MechanicalConservation
namespace SFT.Physics.ThermoMicroMacro
open SFT.InformationScience EntropyPartition
open SFT.Mathematics.ProbabilityObservations

-- V3 thermodynamics_laws.MICRO_MACRO: the existing entropy partition is the
-- macro-observation, with its entire fibre retained, not a new thermal law.
abbrev macroObservation := exactPartition

theorem exactFibre (support : List String) (observation : Observation)
    (partition : Partition) (h : macroObservation support observation = .ok partition)
    (label : String) (members : List String) :
    (label,members) ∈ partition ↔
      (∃ state, state ∈ support ∧ SFT.Mathematics.GeometryTopology.image observation state = some label) ∧
      members = fibre support observation label :=
  partitionMembership support observation partition h label members

theorem eachMicrostateHasUniqueMacrostate (support : List String) (observation : Observation)
    (partition : Partition) (h : macroObservation support observation = .ok partition)
    (state : String) (hs : state ∈ support) :
    ∃ label members, (label,members) ∈ partition ∧ state ∈ members ∧
      ∀ other others, (other,others) ∈ partition → state ∈ others →
        other = label ∧ others = members := by
  obtain ⟨label,members,hr,hm⟩ := partitionCovers support observation partition h state hs
  refine ⟨label,members,hr,hm,?_⟩
  intro other others ho hso
  have same := partitionDisjoint support observation partition h other label others members ho hr state hso hm
  refine ⟨same,?_⟩
  have one := ((exactFibre support observation partition h other others).mp ho).2
  have two := ((exactFibre support observation partition h label members).mp hr).2
  rw [one,two,same]

theorem everyPredecessorRetainedOnce (support : List String) (observation : Observation)
    (partition : Partition) (h : macroObservation support observation = .ok partition)
    (label : String) (members : List String) (hm : (label,members) ∈ partition) :
    SFT.Mathematics.DiscreteObjects.distinct members = true :=
  partitionClassDistinct support observation partition h label members hm

theorem exactMultiplicity (support : List String) (observation : Observation)
    (records : List EntropyLedger.Record) (h : EntropyLedger.entropyLedger support observation = .ok records)
    (record : EntropyLedger.Record) (hr : record ∈ records) :
    record.microstates.length * record.exactSupportPart.denominator =
      record.exactSupportPart.numerator * support.length :=
  EntropyLedger.rowExactPart support observation records h record hr

theorem unresolvedFibreRetained (support : List String) (observation : Observation)
    (records : List EntropyLedger.Record) (h : EntropyLedger.entropyLedger support observation = .ok records)
    (record : EntropyLedger.Record) (hr : record ∈ records) :
    uncertaintyPairs record.unresolvedDistinctions =
      SFT.InformationScience.EncodingLoss.sourcePairs record.microstates := by
  rw [EntropyLedger.rowUncertainty support observation records h record hr]
  exact unresolvedContents record.microstates

-- V3 thermal_law base/successor: reuse the source-bound partition induction
-- and complete source/destination accounting, without resampling either.
abbrev oneStateBase := EntropyExtension.singletonBase
abbrev successorFibre := EntropyExtension.fibreSuccessor
abbrev successorValidity := EntropyExtension.validSuccessor
abbrev sourceDestinationAccounting := @MechanicalConservation.completeConservation
end SFT.Physics.ThermoMicroMacro
