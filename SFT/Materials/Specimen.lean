import SFT.Materials.MaterialCarrierRetention
namespace SFT.Materials.Specimen
open MaterialCarrier SFT.Chemistry

-- MATERIALS_OBLIGATIONS[1]: an explicit source map for every sampled row.
structure Row (C : Type) (material : MaterialCarrier.Record C) where
 constituent : MaterialCarrier.Constituent C
 origin : constituent ∈ material.constituents

structure Record (C : Type) where
 material : MaterialCarrier.Record C
 sampled : List (Row C material)
 preparation : List (String × String)
 representativeness : String

variable {C : Type}

def sourceMap (record : Record C) : List (MaterialCarrier.Constituent C) :=
 record.sampled.map Row.constituent

theorem samplingComplete (record : Record C) (row : Row C record.material)
 (held : row ∈ record.sampled) : row.constituent ∈ sourceMap record :=
 SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem sourceMapSound (record : Record C) (c : MaterialCarrier.Constituent C)
 (held : c ∈ sourceMap record) : c ∈ record.material.constituents := by
 obtain ⟨row,_,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held
 cases same
 exact row.origin

def appendSample (record : Record C) (row : Row C record.material) : Record C :=
 {record with sampled := record.sampled ++ [row]}

def appendPreparation (record : Record C) (step : String × String) : Record C :=
 {record with preparation := record.preparation ++ [step]}

theorem sampleRetainsSource (record : Record C) (row : Row C record.material) :
 (appendSample record row).material = record.material ∧
 (appendSample record row).preparation = record.preparation ∧
 (appendSample record row).representativeness = record.representativeness := ⟨rfl,rfl,rfl⟩

theorem preparationRetainsSource (record : Record C) (step : String × String) :
 (appendPreparation record step).material = record.material ∧
 sourceMap (appendPreparation record step) = sourceMap record ∧
 (appendPreparation record step).representativeness = record.representativeness := ⟨rfl,rfl,rfl⟩

theorem sampledRowsRetained (record : Record C) (row prior : Row C record.material)
 (held : prior ∈ record.sampled) : prior ∈ (appendSample record row).sampled :=
 List.mem_append_left _ held

theorem preparationHistoryRetained (record : Record C) (step prior : String × String)
 (held : prior ∈ record.preparation) : prior ∈ (appendPreparation record step).preparation :=
 List.mem_append_left _ held

def prepareMany : Record C → List (String × String) → Record C
 | record, [] => record
 | record, step::steps => prepareMany (appendPreparation record step) steps

theorem finitePreparationSource (record : Record C) (steps : List (String × String)) :
 (prepareMany record steps).material = record.material ∧
 sourceMap (prepareMany record steps) = sourceMap record ∧
 (prepareMany record steps).representativeness = record.representativeness := by
 induction steps generalizing record with
 | nil => exact ⟨rfl,rfl,rfl⟩
 | cons step steps ih => exact ih (appendPreparation record step)

theorem finitePreparationHistory (record : Record C) (steps : List (String × String))
 (prior : String × String) (held : prior ∈ record.preparation) :
 prior ∈ (prepareMany record steps).preparation := by
 induction steps generalizing record with
 | nil => exact held
 | cons step steps ih => exact ih (appendPreparation record step) (preparationHistoryRetained record step prior held)

def initial (material : MaterialCarrier.Record C) (row : Row C material)
 (boundary : String) : Record C := ⟨material,[row],[],boundary⟩

theorem initialSource (material : MaterialCarrier.Record C) (row : Row C material)
 (boundary : String) : sourceMap (initial material row boundary) = [row.constituent] := rfl

def priorPreparation (record : Record C) : Record C :=
 {record with preparation := EntityIdentity.priorCoordinates record.preparation}

theorem preparationRecovery (record : Record C) (step : String × String) :
 priorPreparation (appendPreparation record step) = record := by
 cases record with
 | mk material sampled preparation boundary =>
   change Record.mk material sampled (EntityIdentity.priorCoordinates (preparation ++ [step])) boundary = _
   rw [EntityIdentity.priorCoordinatesExact]
end SFT.Materials.Specimen
