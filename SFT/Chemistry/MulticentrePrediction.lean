import SFT.Chemistry.StateSymmetryPrediction
import SFT.Chemistry.ElectronSpinPrediction
namespace SFT.Chemistry.MulticentrePrediction
open SFT.Host
open ElectronSpinPrediction (instruction numbered)
abbrev J := Canonical.Value
def identityHash : String := "sha256:c77b359440bb7f44259974e34ce23b13de0ff2057f4c859c9015a27f033958c4"
def identities (actualHash schema : String) (targetIds : List String) : Except String (List String) := do
 if !Text.equal actualHash identityHash then throw "ELEC-008 identity registry changed"
 if !Text.equal schema "sft-v3-multicentre-identities/1" || targetIds.length != 20 || !StateSymmetryPrediction.distinctIds targetIds then
  throw "ELEC-008 identity registry is incomplete"
 return targetIds
def rows : List (String × String × String × String) := [
 ("minimum-centre-count","count","3",""),
 ("support-identity","label","one-complete-extended-support","multicentre-result"),
 ("connection","label","connected-generated-graph","multicentre-result"),
 ("ribbon","label","ribbon-path","delocalized-topology"),
 ("surface","label","surface-cycle","delocalized-topology"),
 ("volume","label","volume-polyhedron","delocalized-topology"),
 ("reduction","label","irreducible-to-one-localized-pair","multicentre-result"),
 ("extension","label","connected-successor-with-no-extra-rule","multicentre-result")]
def rowInstructions (position : Nat) (row : String × String × String × String) : List J :=
 let (name,opcode,value,family) := row
 [instruction "label" (numbered "key-" position) ["multicentre-law",name],
 if Text.equal opcode "count" then instruction opcode (numbered "value-" position) [value]
 else instruction "label" (numbered "value-" position) [family,value]]
def predictionDocument (actualHash schema : String) (targetIds : List String) : Except String J := do
 let _ ← identities actualHash schema targetIds
 let instructions := [instruction "input" "premise" ["registered-premise"]] ++
  (rows.zipIdx 1).flatMap (fun (row,i) => rowInstructions i row) ++
  [instruction "table" "complete-multicentre-law" ((List.range rows.length).flatMap fun i => [numbered "key-" (i+1),numbered "value-" (i+1)]),
   instruction "emit" "" ["complete-multicentre-law"]]
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-MULTICENTRE-DELOCALIZED-SUPPORT-008-multicentre-law-prediction"),
  ("instructions",.array instructions)]
end SFT.Chemistry.MulticentrePrediction
