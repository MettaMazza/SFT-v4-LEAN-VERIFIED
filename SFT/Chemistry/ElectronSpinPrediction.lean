import SFT.Chemistry.ElectronCountSpin
namespace SFT.Chemistry.ElectronSpinPrediction
open SFT.Host SFT.Physics.CapabilityValues ElectronCountSpin
abbrev J := SFT.Host.Canonical.Value
-- Source: electron_count_spin_validation_v1.py prediction_rows and
-- prediction_program_document. Input rows retain the source's validated values.
structure InputRow where
 rowId : String
 populations : List NuclearPopulation
 transfer : HeldChargeTransfer
structure PredictionRow where
 rowId : String
 electronCount : PositiveCount
 requiredSpinWidthParity : HeldLabel
def predictionRow (row : InputRow) : Except String PredictionRow := do
 let count ← exactElectronCount row.populations row.transfer
 let parity ← ElectronCountSpin.requiredSpinWidthParity count
 return ⟨row.rowId,count,parity⟩
def predictionRows (rows : List InputRow) : Except String (List PredictionRow) :=
 rows.mapM predictionRow
def rowValue (row : PredictionRow) : J := .object [
 ("row_id",.text row.rowId),("electron_count",.integer (.ofNat row.electronCount.value)),
 ("required_spin_width_parity",.text row.requiredSpinWidthParity.label)]
def instruction (opcode destination : String) (arguments : List String) : J :=
 .object [("opcode",.text opcode),("destination",.text destination),("arguments",.array (arguments.map .text))]
def numbered (label : String) (position : Nat) : String :=
 Text.append label (Canonical.render (.integer (.ofNat position)))
def rowInstructions (position : Nat) (row : PredictionRow) : List J :=
 let key := numbered "key-" position
 let count := numbered "count-" position
 let parity := numbered "parity-" position
 let value := numbered "value-" position
 [instruction "label" key ["molecular-row",row.rowId],
  instruction "count" count [Canonical.render (.integer (.ofNat row.electronCount.value))],
  instruction "label" parity ["spin-width-parity",row.requiredSpinWidthParity.label],
  instruction "word" value [count,parity]]
def programDocument (rows : List PredictionRow) : J :=
 let numberedRows := rows.zipIdx 1
 let instructions := [instruction "input" "premise" ["registered-premise"]] ++
  numberedRows.flatMap (fun (row,i) => rowInstructions i row) ++
  [instruction "table" "complete-prediction-vector"
    (numberedRows.flatMap (fun (_,i) => [numbered "key-" i,numbered "value-" i])),
   instruction "emit" "" ["complete-prediction-vector"]]
 .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-ELECTRON-COUNT-SPIN-002-complete-vector-prediction"),
  ("instructions",.array instructions)]
end SFT.Chemistry.ElectronSpinPrediction
