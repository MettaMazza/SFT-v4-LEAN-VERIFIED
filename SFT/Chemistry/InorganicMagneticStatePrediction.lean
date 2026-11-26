import SFT.Chemistry.StateTransitionPrediction
import SFT.Chemistry.JointCorrelationTargets
namespace SFT.Chemistry.InorganicMagneticStatePrediction
open SFT.Host
open JointCorrelationTargets (field text)
abbrev J := Canonical.Value

def identityHash := "sha256:87f36708bf7712467fea1e08e9ca82464eb648c9d37f91fb10661694b7062555"
def get (row : J) (key : String) : J := match row with
 | .object fields => match fields.find? (fun p => Text.equal p.1 key) with
   | some p => p.2
   | none => .null
 | .null | .text _ | .boolean _ | .integer _ | .array _ => .null
def equal := StateSymmetryPrediction.canonicalEqual

def completeOrdinals : Nat → List J → Bool
 | _,[] => true
 | n,row::rows => equal (get row "source_record_ordinal") (.integer (.ofNat n)) && completeOrdinals (n+1) rows

def identities (actualHash : String) (document : J) : Except String (List J) := do
 if !Text.equal actualHash identityHash then throw "INORG-009 identity registry changed"
 let rows := match get document "rows" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 let forbidden := ["value","outcome","definition","source_value_inscription","native_value","target_payload_hash"]
 let hasForbidden := rows.any fun row => match row with
  | .object fs => fs.any (fun p => forbidden.any (Text.equal p.1))
  | .null | .text _ | .boolean _ | .integer _ | .array _ => false
 if !equal (get document "complete_registered_target_count") (.integer 177) ||
    !equal (get document "target_values_orientations_presence_flags_definitions_outcomes_or_payload_hashes_present") (.boolean false) ||
    rows.length != 177 || !completeOrdinals 1 rows || hasForbidden then
  throw "INORG-009 value-free identity boundary changed"
 return rows

def identityText (row : J) (key : String) : Except String String := do
 let value ← field row key
 match value with
 | .text s => return s
 | .integer (.ofNat n) => return toString n
 | .integer (.negSucc n) => return Text.append "-" (toString (n+1))
 | .null => return "None"
 | .boolean b => return if b then "True" else "False"
 | .array _ | .object _ => throw "registered identity must be scalar"

def recordInstructions (ordinal : Nat) (row : J) : Except String (List J × List String) := do
 let recordPrefix := ElectronSpinPrediction.numbered "inorganic-magnetic-state-record-" ordinal
 let target := Text.append recordPrefix "-target"
 let start := [ElectronSpinPrediction.instruction "label" target ["target-id",← field row "target_id" >>= text]]
 let (instructions,registers) ← [(1,"source_record_ordinal"),(2,"source_id"),(3,"authority"),(4,"registered_identity"),(5,"source_record_role"),(6,"custody_class")].foldlM
  (fun (instructions,registers) (number,key) => do
   let destination := ElectronSpinPrediction.numbered (Text.append recordPrefix "-identity-") number
   return (instructions++[ElectronSpinPrediction.instruction "label" destination ["registered-source-identity",← identityText row key]],registers++[destination]))
  (start,["premise"])
 let (instructions,registers) := [("inorganic-magnetic-state-law","complete-unpaired-support-or-EmptyOne"),("inorganic-magnetic-state-law","exact-moment-count-and-successor-width"),("inorganic-magnetic-state-law","held-drawn-paramagnetic-or-repelled-diamagnetic-class"),("inorganic-magnetic-state-law","all-177-definition-value-orientation-and-absence-surfaces-retained")].foldl
  (fun (instructions,registers) (family,label) =>
   let destination := ElectronSpinPrediction.numbered (Text.append recordPrefix "-law-") registers.length
   (instructions++[ElectronSpinPrediction.instruction "label" destination [family,label]],registers++[destination]))
  (instructions,registers)
 let word := Text.append recordPrefix "-word"
 return (instructions++[ElectronSpinPrediction.instruction "word" word registers],[target,word])

def predictionDocument (actualHash : String) (document : J) : Except String J := do
 let rows ← identities actualHash document
 let (instructions,table) ← (rows.zipIdx 1).foldlM (fun (instructions,table) (row,ordinal) => do
  let (newInstructions,newTable) ← recordInstructions ordinal row
  return (instructions++newInstructions,table++newTable))
  ([ElectronSpinPrediction.instruction "input" "premise" ["registered-premise"]],[])
 let instructions := instructions++[ElectronSpinPrediction.instruction "table" "complete-inorganic-magnetic-state-vector" table,
  ElectronSpinPrediction.instruction "emit" "" ["complete-inorganic-magnetic-state-vector"]]
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-INORGANIC-MAGNETIC-STATE-009-value-free-vector"),
  ("instructions",.array instructions)]
end SFT.Chemistry.InorganicMagneticStatePrediction
