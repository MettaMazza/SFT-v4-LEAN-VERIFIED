import SFT.Chemistry.StateTransitionPrediction
import SFT.Chemistry.JointCorrelationTargets
namespace SFT.Chemistry.DefectPrediction
open SFT.Host
open JointCorrelationTargets (field text)
abbrev J := Canonical.Value

def identityHash := "sha256:3ca9d30a0cc2e34d8cf9a01a9ce3f095d024a7a5295dd823f31396f2e273634a"
def get (row : J) (key : String) : J := match row with
 | .object fields => match fields.find? (fun p => Text.equal p.1 key) with
   | some p => p.2
   | none => .null
 | .null | .text _ | .boolean _ | .integer _ | .array _ => .null
def equal := StateSymmetryPrediction.canonicalEqual

def identities (actualHash : String) (document : J) : Except String (List J) := do
 if !Text.equal actualHash identityHash then throw "INORG-016 identity changed"
 let rows := match get document "rows" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 let forbidden := ["definition","value","outcome","source_outcome","registered_surface_phrase","target_payload_hash"]
 let hasForbidden := rows.any fun row => match row with
  | .object fs => fs.any (fun p => forbidden.any (Text.equal p.1))
  | .null | .text _ | .boolean _ | .integer _ | .array _ => false
 if !equal (get document "complete_registered_target_count") (.integer 15) ||
    !equal (get document "target_definitions_examples_values_outcomes_presence_flags_or_payload_hashes_present") (.boolean false) ||
    rows.length != 15 || hasForbidden then
  throw "INORG-016 value-free identity boundary changed"
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
 let recordPrefix := ElectronSpinPrediction.numbered "defect-record-" ordinal
 let target := Text.append recordPrefix "-target"
 let start := [ElectronSpinPrediction.instruction "label" target ["target-id",← field row "target_id" >>= text]]
 let (instructions,registers) ← [(1,"source_record_ordinal"),(2,"source_id"),(3,"authority"),(4,"registered_identity"),(5,"source_record_role"),(6,"custody_class")].foldlM
  (fun (instructions,registers) (number,key) => do
   let destination := ElectronSpinPrediction.numbered (Text.append recordPrefix "-identity-") number
   return (instructions++[ElectronSpinPrediction.instruction "label" destination ["registered-source-identity",← identityText row key]],registers++[destination]))
  (start,["premise"])
 let (instructions,registers) := [("defect-law","complete-reference-and-observed-local-support"),("defect-law","vacancy-is-retained-site-with-EmptyOne"),("defect-law","separate-positive-missing-and-added-supports"),("defect-law","exact-formula-defect-and-origin-classification")].foldl
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
 let instructions := instructions++[ElectronSpinPrediction.instruction "table" "complete-defect-vector" table,
  ElectronSpinPrediction.instruction "emit" "" ["complete-defect-vector"]]
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-DEFECT-NONSTOICHIOMETRY-016-value-free-vector"),
  ("instructions",.array instructions)]
end SFT.Chemistry.DefectPrediction
