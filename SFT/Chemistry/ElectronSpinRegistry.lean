import SFT.Chemistry.ElectronSpinExperiment
namespace SFT.Chemistry.ElectronSpinRegistry
open SFT.Host SFT.Physics.CapabilityValues ElectronCountSpin ElectronSpinPrediction
abbrev J := SFT.Host.Canonical.Value
-- JSON decoding and the source's Python str/int conversions are host primitives.
-- These records retain their results; source admission and scientific operations
-- below execute natively, including the original count and transfer guards.
structure PopulationFields where
 elementSymbol : String
 atomicNumber : Int
 occurrenceCount : Int
structure InputFields where
 rowId : String
 molecularFormula : String
 chargeAction : String
 chargeCount : Option J
 nuclearComposition : List PopulationFields
def positiveInteger (n : Int) : Except String PositiveCount :=
 if n ≤ 0 then .error "an SFT count must be a positive counted value" else count n.toNat
def population (p : PopulationFields) : Except String NuclearPopulation := do
 let symbol ← heldLabel "element-symbol" p.elementSymbol
 let atomic ← positiveInteger p.atomicNumber
 let occurrences ← positiveInteger p.occurrenceCount
 validPopulation ⟨symbol,atomic,occurrences⟩
def directedCount : Option J → Except String PositiveCount
 | none => .error "directed electron transfer requires a positive registered count"
 | some v => match v with
   | .integer n => if n < 1 then .error "directed electron transfer requires a positive registered count" else count n.toNat
   | .null | .boolean _ | .text _ | .array _ | .object _ => .error "directed electron transfer requires a positive registered count"
def transferFromRow (row : InputFields) : Except String HeldChargeTransfer := do
 if Text.equal row.chargeAction "empty-One" then
  validTransfer ⟨← heldLabel "electron-transfer" row.chargeAction,structuralEmpty⟩
 else
  let n ← directedCount row.chargeCount
  validTransfer ⟨← heldLabel "electron-transfer" row.chargeAction,.count n⟩
def countInput (row : InputFields) : Except String InputRow := do
 let populations ← row.nuclearComposition.mapM population
 let transfer ← transferFromRow row
 return ⟨row.rowId,populations,transfer⟩
def schemaMatches (schema : Option J) : Bool :=
 match schema with
 | none => false
 | some value => match value with
   | .text s => Text.equal s "sft-v3-electron-spin-inputs/1"
   | .null | .boolean _ | .integer _ | .array _ | .object _ => false
def loadInputs (actualHash : String) (schema : Option J) (rows : List InputFields) :
 Except String (List InputFields) := do
 if !Text.equal actualHash ElectronSpinExperiment.inputRegistryHash then
  throw "ELEC-002 prediction input registry changed"
 if !schemaMatches schema || rows.length != 22 then
  throw "ELEC-002 prediction input registry is incomplete"
 if (SFT.Physics.GrandLockDependency.unique (rows.map InputFields.rowId)).length != rows.length then
  throw "ELEC-002 prediction rows are duplicated"
 return rows
end SFT.Chemistry.ElectronSpinRegistry
