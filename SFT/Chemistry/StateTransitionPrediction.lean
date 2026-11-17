import SFT.Chemistry.StateSymmetryPrediction
import SFT.Chemistry.ElectronSpinPrediction
namespace SFT.Chemistry.StateTransitionPrediction
open SFT.Host
open ElectronSpinPrediction (instruction numbered)
abbrev J := Canonical.Value
def identityHash : String := "sha256:3c4e8cb32c8a5f8992020d363894d2420056cc108dbf667bf5de4baba87cffc2"
def identities (actualHash schema : String) (targetIds : List String) : Except String (List String) := do
 if !Text.equal actualHash identityHash then throw "ELEC-009 identity registry changed"
 if !Text.equal schema "sft-v3-state-transition-identities/1" || targetIds.length != 60 || !StateSymmetryPrediction.distinctIds targetIds then
  throw "ELEC-009 identity registry is incomplete"
 return targetIds
def rows : List (String × String × String) := [("carrier","transition-result","retained-molecular-carrier"),("endpoints","transition-result","distinct-initial-and-terminal-states"),("forward","transition-orientation","forward-held"),("reverse","transition-orientation","reverse-held"),("bidirectional","transition-orientation","bidirectional-held"),("coupled","transition-orientation","coupled-without-direction"),("absence","transition-orientation","structurally-absent"),("composition","transition-result","matching-endpoint-composition"),("record","transition-result","complete-presence-coupling-absence-vector")]
def rowInstructions (position : Nat) (row : String × String × String) : List J :=
 let (name,family,value) := row
 [instruction "label" (numbered "key-" position) ["state-transition-law",name],
  instruction "label" (numbered "value-" position) [family,value]]
def predictionDocument (actualHash schema : String) (targetIds : List String) : Except String J := do
 let _ ← identities actualHash schema targetIds
 let instructions := [instruction "input" "premise" ["registered-premise"]] ++
  (rows.zipIdx 1).flatMap (fun (row,i) => rowInstructions i row) ++
  [instruction "table" "complete-transition-law" ((List.range rows.length).flatMap fun i => [numbered "key-" (i+1),numbered "value-" (i+1)]),
   instruction "emit" "" ["complete-transition-law"]]
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-MOLECULAR-STATE-TRANSITION-009-transition-law-prediction"),
  ("instructions",.array instructions)]
end SFT.Chemistry.StateTransitionPrediction
