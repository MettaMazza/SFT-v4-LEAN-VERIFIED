import SFT.Chemistry.StateTransitionPrediction
import SFT.Chemistry.JointCorrelationTargets
namespace SFT.Chemistry.CoordinationNumberPrediction
open SFT.Host
open JointCorrelationTargets (field text)
abbrev J := Canonical.Value

def identityHash := "sha256:c018c7ca63e082958f73c5b48fe6cbc873dc020026b8e2c519e57a4bb2ed005a"
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
 if !Text.equal actualHash identityHash then throw "INORG-002 identity registry changed"
 let rows := match get document "rows" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 let ids ← rows.mapM (fun row => field row "target_id" >>= text)
 let forbidden := ["source_inscription","target_payload_hash","value","formula","point_group","link_count","coordinate","status"]
 let hasForbidden := rows.any fun row => match row with
  | .object fs => fs.any (fun p => forbidden.any (Text.equal p.1))
  | .null | .text _ | .boolean _ | .integer _ | .array _ => false
 if !equal (get document "complete_registered_target_count") (.integer 23) ||
    !equal (get document "target_values_or_hashes_present") (.boolean false) ||
    !equal (get document "all_definition_formula_point_group_link_count_coordinate_limitation_values_absent") (.boolean true) ||
    rows.length != 23 || !completeOrdinals 1 rows || !StateSymmetryPrediction.distinctIds ids || hasForbidden then
  throw "INORG-002 value-free identity boundary changed"
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
 let recordPrefix := ElectronSpinPrediction.numbered "coordination-number-record-" ordinal
 let target := Text.append recordPrefix "-target"
 let start := [ElectronSpinPrediction.instruction "label" target ["target-id",← field row "target_id" >>= text]]
 let (instructions,registers) ← [(1,"source_record_ordinal"),(2,"authority"),(3,"source_document_identity"),(4,"source_record_role")].foldlM
  (fun (instructions,registers) (number,key) => do
   let destination := ElectronSpinPrediction.numbered (Text.append recordPrefix "-identity-") number
   return (instructions++[ElectronSpinPrediction.instruction "label" destination ["registered-source-identity",← identityText row key]],registers++[destination]))
  (start,["premise"])
 let (instructions,registers) := [("coordination-count-law","positive-cardinality-of-complete-distinct-direct-central-incidences"),
   ("coordination-boundary-law","general-inorganic-sigma-pi-exclusion-and-crystal-senses-remain-distinct"),
   ("coordination-custody-law","all-23-definition-structure-count-boundary-and-limitation-records-retained")].foldl
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
 let instructions := instructions++[ElectronSpinPrediction.instruction "table" "complete-coordination-number-vector" table,
  ElectronSpinPrediction.instruction "emit" "" ["complete-coordination-number-vector"]]
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-COORDINATION-NUMBER-INCIDENCE-COUNT-002-value-free-complete-vector"),
  ("instructions",.array instructions)]
end SFT.Chemistry.CoordinationNumberPrediction
