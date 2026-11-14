import SFT.Host.SHA256Chunks
import SFT.Physics.PrecisionValidationOperations
import SFT.Physics.RunningConvergenceMeasurement
namespace SFT.Physics.PrecisionValidationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PrecisionValidationOperations

def pdgSourceHashes : List (String × String) := [
 ("pdg-2025-electroweak-model.pdf","sha256:8642888a3408d8c57fc673b379325b07f02948135491f64a2e42320e8929320a"),
 ("pdg-2024-w-boson-listing.pdf","sha256:91cb466bfea8fa49b53ae53d2168797189c14a5a114f30d7cc926f64c4c1e772")]

def requiredRows : List String := ["on-shell sin-squared theta-W","Z mass",
 "W mass, world average using all measurements through 2023",
 "W mass, PDG evaluation excluding the incompatible CDF 2022 input"]

def assignRow (key : String) (value : Rat × Rat) :
 List (String × (Rat × Rat)) → List (String × (Rat × Rat))
 | [] => [(key,value)]
 | (k,v)::rest => if Text.equal k key then (k,value)::rest else (k,v)::assignRow key value rest

def pdgRows (files : List (String × ByteArray)) (payload : Value) :
 Except String (List (String × (Rat × Rat))) := do
 if !sameValue ((field payload "record_id").toOption.getD .null) (.text "PDG-ELECTROWEAK-PRECISION-2024-2025") then
  throw "PDG precision record identity changed"
 let sources ← (do array (← field payload "sources")).mapError (fun _ => "PDG precision record must retain both source documents")
 if sources.length != 2 then throw "PDG precision record must retain both source documents"
 let rows ← sources.foldlM (fun rows source => do
  let snapshot ← text (← field source "snapshot")
  let expected ← match pdgSourceHashes.find? (fun p => Text.equal p.1 snapshot) with
   | none => .error "PDG source snapshot differs from its registered identity"
   | some p => .ok p.2
  let bytes ← match files.find? (fun p => Text.equal p.1 snapshot) with
   | none => .error (Text.append "FileNotFoundError: " snapshot)
   | some p => .ok p.2
  if !Text.equal (Text.append "sha256:" (SFT.Host.SHA256Chunks.digest bytes)) expected then
   throw "PDG source snapshot differs from its registered identity"
  let sourceRows ← array (← field source "rows")
  sourceRows.foldlM (fun rows row => do
   let name ← text (← field row "quantity")
   let bounds ← interval (← text (← field row "central")) (← text (← field row "standard_uncertainty"))
   pure (assignRow name bounds rows)) rows) []
 if !(rows.all (fun p => requiredRows.any (Text.equal p.1)) &&
    requiredRows.all (fun name => rows.any (fun p => Text.equal name p.1))) then
  throw "PDG precision rows are missing or additional"
 pure rows

def codataRow (source quantity : String) : Except String (Rat × Rat) := do
 let rows := EvolutionMeasuredSource.matchingRows
  (EvolutionMeasuredSource.lines (Text.chars source)) quantity
 match rows with
 | [row] => interval (String.ofList (LeptonDecimal.strip ((row.drop 60).take 25))) (String.ofList (LeptonDecimal.strip ((row.drop 85).take 25)))
 | [] | _::_::_ => .error (Text.append "CODATA row must occur exactly once: " quantity)

def codataHierarchyInterval (source : String) : Except String (Rat × Rat) := do
 let planck ← codataRow source "Planck mass"
 let proton ← codataRow source "proton mass"
 squaredRatioInterval planck proton


def fractionString (value : Rat) : String :=
 if value.den == 1 then render (.integer value.num)
 else EvolutionMeasuredSource.fractionText value

def intervalStrings (bounds : Rat × Rat) : Value :=
 .array [.text (fractionString bounds.1),.text (fractionString bounds.2)]

def rowByName (rows : List (String × (Rat × Rat))) (name : String) : Except String (Rat × Rat) :=
 match rows.find? (fun p => Text.equal p.1 name) with
 | some p => .ok p.2
 | none => .error (Text.append "KeyError: " name)

def electroweakRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let rows ← pdgRows files payload
 let weak ← rowByName rows "on-shell sin-squared theta-W"
 let z ← rowByName rows "Z mass"
 let allW ← rowByName rows "W mass, world average using all measurements through 2023"
 let compatibleW ← rowByName rows "W mass, PDG evaluation excluding the incompatible CDF 2022 input"
 let result ← electroweakComparison weak z allW compatibleW
 let on := result.2.2.2.2.1
 let compatible := result.2.2.2.2.2.1
 let allInput := result.2.2.2.2.2.2
 let classification := if on && compatible && !allInput then
  "on-shell-pass__compatible-w-mass-pass__all-input-w-mass-tension-retained"
  else "electroweak-comparison-classification-changed"
 pure (.object [
  ("prediction_sin_squared",.text (fractionString result.1)),
  ("prediction_cos_squared",.text (fractionString result.2.1)),
  ("on_shell_interval",intervalStrings weak),
  ("compatible_wz_interval",intervalStrings result.2.2.1),
  ("all_input_wz_interval",intervalStrings result.2.2.2.1),
  ("outcomes",.object [("on_shell_weak_share_inside",.boolean on),
   ("compatible_input_wz_inside",.boolean compatible),("all_input_wz_inside",.boolean allInput)]),
  ("classification",.text classification)])

end SFT.Physics.PrecisionValidationRecords
