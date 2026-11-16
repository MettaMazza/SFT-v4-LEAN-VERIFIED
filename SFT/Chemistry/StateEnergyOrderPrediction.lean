import SFT.Chemistry.ElectronSpinPrediction
import SFT.Physics.GrandLockDependency
namespace SFT.Chemistry.StateEnergyOrderPrediction
open SFT.Host ElectronSpinPrediction
abbrev J := Canonical.Value
-- Input species strings are the original str(row["species_row_id"]) values.
def speciesInOrder (identities : List String) : List String :=
 identities.foldl (fun retained name =>
  if retained.any (Text.equal name) then retained else retained++[name]) []
def programDocument (identities : List String) : J :=
 let indexed := (speciesInOrder identities).zipIdx 1
 let body := indexed.flatMap fun (name,position) =>
  [instruction "label" (numbered "key-" position) ["molecular-carrier",name],
   instruction "label" (numbered "value-" position) ["state-order-law","unique-structural-least-plus-positive-successors"]]
 let args := indexed.flatMap fun (_,position) => [numbered "key-" position,numbered "value-" position]
 .object [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text "SFT-EXP-CHEM-STATE-ENERGY-ORDER-004-order-law-prediction"),
 ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++ body ++
 [instruction "table" "complete-order-law-vector" args,instruction "emit" "" ["complete-order-law-vector"]]))]
#print axioms speciesInOrder
#print axioms programDocument
end SFT.Chemistry.StateEnergyOrderPrediction
