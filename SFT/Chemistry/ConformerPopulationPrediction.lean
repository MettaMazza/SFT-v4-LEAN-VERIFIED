import SFT.Chemistry.StateTransitionPrediction
import SFT.Chemistry.JointCorrelationTargets
namespace SFT.Chemistry.ConformerPopulationPrediction
open SFT.Host
open JointCorrelationTargets (field text)
abbrev J := Canonical.Value

def identityHash := "sha256:ba488c309eb8a3081959b7f1ae6850bd43c0db50abdf3d351532d9da76c69d17"
def get (row : J) (key : String) : J := match row with
 | .object fields => match fields.find? (fun p => Text.equal p.1 key) with
   | some p => p.2
   | none => .null
 | .null | .text _ | .boolean _ | .integer _ | .array _ => .null
def equal := StateSymmetryPrediction.canonicalEqual

def identities (actualHash : String) (document : J) : Except String (List J) := do
 if !Text.equal actualHash identityHash then throw "ORG-006 identity changed"
 let rows := match get document "rows" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 let forbidden := ["definition","value","outcome","source_outcome","target_payload_hash"]
 let hasForbidden := rows.any fun row => match row with
  | .object fs => fs.any (fun p => forbidden.any (Text.equal p.1))
  | .null | .text _ | .boolean _ | .integer _ | .array _ => false
 if !equal (get document "complete_registered_target_count") (.integer 14) ||
    !equal (get document "external_values_or_outcomes_used_to_select_identity") (.boolean false) ||
    rows.length != 14 || hasForbidden then
  throw "ORG-006 value-free identity boundary changed"
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
 let recordPrefix := ElectronSpinPrediction.numbered "population-record-" ordinal
 let target := Text.append recordPrefix "-target"
 let start := [ElectronSpinPrediction.instruction "label" target ["target-id",← field row "target_id" >>= text]]
 let (instructions,registers) ← [(1,"source_record_ordinal"),(2,"source_id"),(3,"authority"),(4,"registered_identity"),(5,"source_record_role"),(6,"custody_class")].foldlM
  (fun (instructions,registers) (number,key) => do
   let destination := ElectronSpinPrediction.numbered (Text.append recordPrefix "-identity-") number
   return (instructions++[ElectronSpinPrediction.instruction "label" destination ["registered-source-identity",← identityText row key]],registers++[destination]))
  (start,["premise"])
 let (instructions,registers) := [("conformer-population-law","exact-conditioned-class-count-ratio"),
   ("conformer-population-law","structural-EmptyOne-absence"),
   ("conformer-population-law","positive-Take-energy-and-population-order"),
   ("conformer-population-law","complete-blind-condition-bound-value-vector")].foldl
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
 let instructions := instructions++[ElectronSpinPrediction.instruction "table" "complete-conditioned-population-vector" table,
  ElectronSpinPrediction.instruction "emit" "" ["complete-conditioned-population-vector"]]
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-CONFORMER-POPULATION-ORDERING-006-value-free-vector"),
  ("instructions",.array instructions)]
end SFT.Chemistry.ConformerPopulationPrediction
