import SFT.Chemistry.StateSymmetryPrediction
import SFT.Chemistry.ElectronSpinPrediction
namespace SFT.Chemistry.JointCorrelationPrediction
open SFT.Host
open ElectronSpinPrediction (instruction numbered)
abbrev J := Canonical.Value
-- Source _identities: target identifiers after the original str conversion.
def identityHash : String := "sha256:52c9f872da74817277f48aacaa8536b3dbf972f9cbee8b6d05bf96aa0e181c31"
def identities (actualHash schema : String) (targetIds : List String) : Except String (List String) := do
 if !Text.equal actualHash identityHash then throw "ELEC-007 identity registry changed"
 if !Text.equal schema "sft-v3-joint-correlation-identities/1" || targetIds.length != 9 then
  throw "ELEC-007 identity registry is incomplete"
 if !StateSymmetryPrediction.distinctIds targetIds then
  throw "ELEC-007 identity registry contains duplicate targets"
 return targetIds

def rows : List (String × String × String) := [
 ("joint-word-count","count","2"),
 ("independent-cartesian-count","count","4"),
 ("joint-relation","label","nonfactorizable-complementary-cross-centre-pair"),
 ("same-centre-support","label","excluded"),
 ("dissociation-record","label","exact-positive-post-seal-observation")]
def rowInstructions (position : Nat) (row : String × String × String) : List J :=
 let (name,opcode,value) := row
 [instruction "label" (numbered "key-" position) ["joint-support-law",name],
 if Text.equal opcode "count" then instruction opcode (numbered "value-" position) [value]
 else instruction "label" (numbered "value-" position) ["joint-support-result",value]]
def predictionDocument (actualHash schema : String) (targetIds : List String) : Except String J := do
 let _ ← identities actualHash schema targetIds
 let instructions := [instruction "input" "premise" ["registered-premise"]] ++
  (rows.zipIdx 1).flatMap (fun (row,i) => rowInstructions i row) ++
  [instruction "table" "complete-joint-support-law" ((List.range rows.length).flatMap fun i => [numbered "key-" (i+1),numbered "value-" (i+1)]),
   instruction "emit" "" ["complete-joint-support-law"]]
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-JOINT-CORRELATION-DISSOCIATION-007-joint-support-prediction"),
  ("instructions",.array instructions)]
end SFT.Chemistry.JointCorrelationPrediction
