import SFT.Chemistry.StateTransitionPrediction
import SFT.Chemistry.JointCorrelationTargets
namespace SFT.Chemistry.CoordinationIsomerismPrediction
open SFT.Host
open JointCorrelationTargets (field text)
abbrev J := Canonical.Value

def identityHash := "sha256:60a107df040a81774fd312354a36710c7455d6175495c5c300ec83382a0033d1"
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
 if !Text.equal actualHash identityHash then throw "INORG-005 identity registry changed"
 let rows := match get document "rows" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 let ids ← rows.mapM (fun row => field row "target_id" >>= text)
 let forbidden := ["source_inscription","target_payload_hash","definition","class","example","formula","page","section","status","value","outcome"]
 let hasForbidden := rows.any fun row => match row with
  | .object fs => fs.any (fun p => forbidden.any (Text.equal p.1))
  | .null | .text _ | .boolean _ | .integer _ | .array _ => false
 if !equal (get document "complete_registered_target_count") (.integer 17) ||
    !equal (get document "target_values_or_payload_hashes_present") (.boolean false) ||
    !equal (get document "all_definition_class_example_formula_page_section_status_source_citation_license_disclaimer_and_target_payload_values_absent") (.boolean true) ||
    !equal (get document "preserved_incomplete_preliminary_identity_sha256") (.text "sha256:52224a0a386431cc43129efe732acf6c46fe0c09ea3dacf586cc1e17e0c7d34c") ||
    rows.length != 17 || !completeOrdinals 1 rows || !StateSymmetryPrediction.distinctIds ids || hasForbidden then
  throw "INORG-005 value-free identity boundary changed"
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
 let recordPrefix := ElectronSpinPrediction.numbered "coordination-isomerism-record-" ordinal
 let target := Text.append recordPrefix "-target"
 let start := [ElectronSpinPrediction.instruction "label" target ["target-id",← field row "target_id" >>= text]]
 let (instructions,registers) ← [(1,"source_record_ordinal"),(2,"authority"),(3,"source_id"),(4,"registered_identity"),(5,"source_record_role"),(6,"source_locator")].foldlM
  (fun (instructions,registers) (number,key) => do
   let destination := ElectronSpinPrediction.numbered (Text.append recordPrefix "-identity-") number
   return (instructions++[ElectronSpinPrediction.instruction "label" destination ["registered-source-identity",← identityText row key]],registers++[destination]))
  (start,["premise"])
 let (instructions,registers) := [("coordination-isomer-equivalence-law","complete-occurrence-bijection-preserves-composition-attachment-adjacency-and-three-axis-two-fibre-words"),("coordination-isomer-composition-boundary","same-complete-composition-required"),("coordination-isomer-attachment-law","first-attachment-or-graph-failure-forces-attachment-class"),("coordination-isomer-orientation-law","global-fibre-complement-precedes-remaining-orientation-adjacency-class"),("coordination-isomer-evidence-law","all-seventeen-surfaces-two-identity-redirects-and-literal-term-absence-retained")].foldl
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
 let instructions := instructions++[ElectronSpinPrediction.instruction "table" "complete-coordination-isomerism-vector" table,
  ElectronSpinPrediction.instruction "emit" "" ["complete-coordination-isomerism-vector"]]
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-COORDINATION-ISOMERISM-EQUIVALENCE-005-value-free-complete-vector"),
  ("instructions",.array instructions)]
end SFT.Chemistry.CoordinationIsomerismPrediction
