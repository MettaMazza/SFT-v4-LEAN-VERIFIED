import SFT.Chemistry.OrbitalSupportTargets
import SFT.Chemistry.OrbitalSupportPrediction
import SFT.Chemistry.OrbitalSupportWitnesses
namespace SFT.Chemistry.OrbitalSupportComparison
open SFT.Host SFT.Physics.CapabilityValues OrbitalSupportTargets
abbrev Predictions := List (HeldLabel × Value)
def insertPrediction (rows : Predictions) (key : HeldLabel) (value : Value) : Predictions :=
 if rows.any (fun row => ElectronCountSpin.sameLabel row.1 key) then
  rows.map (fun row => if ElectronCountSpin.sameLabel row.1 key then (key,value) else row)
 else rows++[(key,value)]
def predictionMap (entries : List (Value × Value)) : Except String Predictions := do
 let result ← entries.foldlM (fun rows (key,value) =>
  match key with
  | .label key => .ok (insertPrediction rows key value)
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "ELEC-003 prediction key is invalid") []
 if result.length != entries.length then throw "ELEC-003 prediction contains duplicate keys"
 return result
def lookup (rows : Predictions) (family label : String) : Except String Value :=
 match rows.find? (fun row => Text.equal row.1.family family && Text.equal row.1.label label) with
 | none => .error (Text.intercalate "" ["KeyError: (",family,", ",label,")"])
 | some row => .ok row.2
def rankLabel (symbol : String) : Except String HeldLabel :=
 match OrbitalSupportPrediction.rankLabels.find? (fun row => Text.equal row.1 symbol) with
 | none => .error (Text.append "KeyError: " symbol)
 | some row => heldLabel "axis-support-rank" row.2
structure Comparison where
 targetId : String
 speciesRowId : String
 stateRecord : String
 termCount : Nat
 configurationCount : Nat
 termsPassed : Bool
 configurationsPassed : Bool
 passed : Bool
def compare (predicted : Predictions) (row : Resolved) : Except String Comparison := do
 let speciesParity ← lookup predicted "species-spin-parity" row.speciesRowId
 let termPasses ← row.terms.mapM fun term => do
  let expected ← lookup predicted "source-support-symbol" term.symbol
  let derived ← rankLabel term.symbol
  let parity ← heldLabel "spin-width-parity" (if term.multiplicity%2 != 0 then "odd-positive-width" else "even-positive-width")
  pure (equal expected (.label derived) && equal (.label parity) speciesParity)
 let configPasses ← row.configurations.mapM fun config => do
  let radial ← count config.radial
  let occupancy ← count config.occupancy
  let support ← OrbitalSupport.occupiedSupportFromSourceAssignment row.speciesRowId radial config.symbol occupancy
  let expected ← lookup predicted "source-support-symbol" config.symbol
  let derived ← rankLabel config.symbol
  let supportedCount ← OrbitalSupport.occupancyCount support
  pure (equal (.label derived) expected && supportedCount.value ≤ 2)
 let termsPassed := termPasses.all id
 let configsPassed := configPasses.all id
 return ⟨row.targetId,row.speciesRowId,row.stateRecord,row.terms.length,row.configurations.length,
  termsPassed,configsPassed,termsPassed && configsPassed⟩
def comparisonValue (row : Comparison) : SFT.Host.Canonical.Value := .object [
 ("target_id",.text row.targetId),("species_row_id",.text row.speciesRowId),("NIST_state_record",.text row.stateRecord),
 ("term_assignment_count",.integer (.ofNat row.termCount)),("configuration_assignment_count",.integer (.ofNat row.configurationCount)),
 ("term_support_and_multiplicity_passed",.boolean row.termsPassed),
 ("configuration_support_and_occupancy_passed",.boolean row.configurationsPassed),("passed",.boolean row.passed)]
def termTotal (rows : List Comparison) : Nat := (rows.map Comparison.termCount).foldl (·+·) 0
def configurationTotal (rows : List Comparison) : Nat := (rows.map Comparison.configurationCount).foldl (·+·) 0
def adverseControls (predicted : Predictions) (comparisons : List Comparison)
 (snapshotHash changedHash registeredHash : String) : Except String (List (String × Bool)) := do
 let unknown := match OrbitalSupport.conventionalSupportCorrespondence "unknown" with | .error _ => true | .ok _ => false
 let triple := match OrbitalSupport.occupiedSupportFromSourceAssignment "tampered" ⟨1,by decide⟩ "σ" ⟨3,by decide⟩ with | .error _ => true | .ok _ => false
 let even ← heldLabel "spin-width-parity" "even-positive-width"
 let hydrogen ← lookup predicted "species-spin-parity" "hydrogen-neutral"
 return [("unknown_support_symbol_rejected",unknown),("triple_occupancy_rejected",triple),
  ("wrong_multiplicity_parity_rejected",!equal (.label even) hydrogen),
  ("omitted_row_rejected",comparisons.length-1 != 360),
  ("tampered_snapshot_rejected",Text.equal snapshotHash registeredHash && !Text.equal changedHash registeredHash),
  ("complete_assignment_counts_retained",comparisons.length==360 && termTotal comparisons==362 && configurationTotal comparisons==87)]
def message (row : Comparison) : String := Text.intercalate "" [
 row.targetId," (",row.speciesRowId,"): NIST state ",row.stateRecord,"; term assignments ",
 Canonical.render (.integer (.ofNat row.termCount))," pass ",if row.termsPassed then "True" else "False",
 "; configuration assignments ",Canonical.render (.integer (.ofNat row.configurationCount))," pass ",
 if row.configurationsPassed then "True" else "False","; row pass ",if row.passed then "True" else "False"]
end SFT.Chemistry.OrbitalSupportComparison
