import SFT.Materials.Specimen
namespace SFT.Materials.SpecimenAdmission
open Specimen
variable {C : Type}

def admitted (record : Record C) : Prop := record.sampled ≠ []

theorem initialAdmitted (material : MaterialCarrier.Record C) (row : Row C material)
 (boundary : String) : admitted (initial material row boundary) := by intro h; cases h

theorem materialAdmitted (record : Record C) (positive : admitted record) :
 MaterialCarrier.admitted record.material := by
 cases rows : record.sampled with
 | nil => exact False.elim (positive rows)
 | cons row rest =>
   intro empty
   have origin := row.origin
   rw [empty] at origin
   cases origin

theorem samplingPreservesAdmission (record : Record C) (row : Row C record.material)
 (positive : admitted record) : admitted (appendSample record row) := by
 intro empty
 cases rows : record.sampled with
 | nil => exact positive rows
 | cons a rest =>
   change record.sampled ++ [row] = [] at empty
   rw [rows] at empty
   cases empty

theorem preparationPreservesAdmission (record : Record C) (step : String × String)
 (positive : admitted record) : admitted (appendPreparation record step) := positive

theorem finitePreparationAdmitted (record : Record C) (steps : List (String × String))
 (positive : admitted record) : admitted (prepareMany record steps) := by
 induction steps generalizing record with
 | nil => exact positive
 | cons step steps ih => exact ih _ (preparationPreservesAdmission record step positive)

def appendSamples (record : Record C) (rows : List (Row C record.material)) : Record C :=
 {record with sampled := record.sampled ++ rows}

theorem finiteSamplingAdmitted (record : Record C) (rows : List (Row C record.material))
 (positive : admitted record) : admitted (appendSamples record rows) := by
 intro empty
 cases old : record.sampled with
 | nil => exact positive old
 | cons a rest =>
   change record.sampled ++ rows = [] at empty
   rw [old] at empty
   cases empty

theorem finiteSamplingRetains (record : Record C) (rows : List (Row C record.material))
 (prior : Row C record.material) (held : prior ∈ record.sampled) :
 prior ∈ (appendSamples record rows).sampled := List.mem_append_left _ held

theorem finiteSamplingBoundary (record : Record C) (rows : List (Row C record.material)) :
 (appendSamples record rows).material=record.material ∧
 (appendSamples record rows).preparation=record.preparation ∧
 (appendSamples record rows).representativeness=record.representativeness := ⟨rfl,rfl,rfl⟩

theorem emptySamplingRejected (record : Record C) (empty : record.sampled=[]) :
 ¬ admitted record := fun h => h empty

def retainOrigin (material : MaterialCarrier.Record C) (e : MaterialCarrier.Extension C)
 (row : Row C material) : Row C (MaterialCarrier.extend material e) :=
 ⟨row.constituent,MaterialCarrier.extensionRetainsConstituent material e row.constituent row.origin⟩

def extendSource (record : Record C) (e : MaterialCarrier.Extension C) : Record C :=
 ⟨MaterialCarrier.extend record.material e,record.sampled.map (retainOrigin record.material e),
 record.preparation,record.representativeness⟩

theorem retainedMap (material : MaterialCarrier.Record C) (e : MaterialCarrier.Extension C)
 (rows : List (Row C material)) :
 ((rows.map (retainOrigin material e)).map Row.constituent) = rows.map Row.constituent := by
 induction rows with
 | nil => rfl
 | cons row rows ih => exact congrArg (List.cons row.constituent) ih

theorem sourceExtensionRetainsSampling (record : Record C) (e : MaterialCarrier.Extension C) :
 sourceMap (extendSource record e) = sourceMap record := retainedMap _ _ _

theorem sourceExtensionRetainsBoundary (record : Record C) (e : MaterialCarrier.Extension C) :
 (extendSource record e).preparation=record.preparation ∧
 (extendSource record e).representativeness=record.representativeness := ⟨rfl,rfl⟩

theorem sourceExtensionAdmitted (record : Record C) (e : MaterialCarrier.Extension C)
 (positive : admitted record) : admitted (extendSource record e) := by
 intro empty
 cases old : record.sampled with
 | nil => exact positive old
 | cons row rows =>
   change record.sampled.map (retainOrigin record.material e) = [] at empty
   rw [old] at empty
   cases empty

def priorSample (record : Record C) : Record C :=
 {record with sampled := SFT.Chemistry.EntityIdentity.priorCoordinates record.sampled}

theorem samplingRecovery (record : Record C) (row : Row C record.material) :
 priorSample (appendSample record row)=record := by
 cases record with
 | mk material sampled preparation boundary =>
   change Record.mk material (SFT.Chemistry.EntityIdentity.priorCoordinates (sampled++[row])) preparation boundary = _
   rw [SFT.Chemistry.EntityIdentity.priorCoordinatesExact]

theorem samplingExtensionInjective (a b : Record C) (ra : Row C a.material) (rb : Row C b.material)
 (same : appendSample a ra = appendSample b rb) : a=b :=
 (samplingRecovery a ra).symm.trans ((congrArg priorSample same).trans (samplingRecovery b rb))

theorem samplingRetainsDistinctions (a b : Record C) (ra : Row C a.material) (rb : Row C b.material)
 (different : a ≠ b) : appendSample a ra ≠ appendSample b rb :=
 fun h => different (samplingExtensionInjective a b ra rb h)
end SFT.Materials.SpecimenAdmission

