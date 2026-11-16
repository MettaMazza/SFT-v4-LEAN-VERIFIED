import SFT.Chemistry.ElectronSpinSource
import SFT.Chemistry.ElectronSpinRegistry
namespace SFT.Chemistry.ElectronSpinTargets
open SFT.Host ElectronSpinSource ElectronSpinRegistry ElectronSpinExperiment
abbrev J := SFT.Host.Canonical.Value
structure TargetFields where
 rowId : String
 record : TargetRecord
structure Snapshot where
 path : String
 hash : String
 events : List ElectronSpinHtml.Event
-- File reading, SHA-256 and HTML tokenization are the original host IO operations.
-- Registry support, table parsing and target resolution execute below in Lean.
def insertTarget (rows : List TargetFields) (row : TargetFields) : List TargetFields :=
 if rows.any (fun old => Text.equal old.rowId row.rowId) then
  rows.map (fun old => if Text.equal old.rowId row.rowId then row else old)
 else rows++[row]
def targetSchemaMatches : Option J → Bool
 | none => false
 | some v => match v with
   | .text s => Text.equal s "sft-v3-electron-spin-withheld-targets/1"
   | .null | .boolean _ | .integer _ | .array _ | .object _ => false
def loadTargets (actualHash : String) (schema : Option J) (targets : List TargetFields)
 (inputs : List InputFields) : Except String (List TargetFields) := do
 if !Text.equal actualHash targetRegistryHash then
  throw "withheld NIST state target registry changed"
 let mapped := targets.foldl insertTarget []
 let targetIds := mapped.map TargetFields.rowId
 let inputIds := SFT.Physics.GrandLockDependency.unique (inputs.map InputFields.rowId)
 if !targetSchemaMatches schema || targetIds.length != inputIds.length ||
  !(targetIds.all (fun id => inputIds.any (Text.equal id))) then
  throw "withheld NIST state target support differs from prediction support"
 return mapped
def sourceTargets (inputs : List InputFields) (targets : List TargetFields)
 (snapshots : List Snapshot) : Except String (List Resolved) :=
 references.mapM fun reference =>
  match targets.find? (fun row => Text.equal row.rowId reference.targetId) with
  | none => .error (Text.append "KeyError: " reference.targetId)
  | some target => match inputs.find? (fun row => Text.equal row.rowId reference.targetId) with
    | none => .error (Text.append "KeyError: " reference.targetId)
    | some input => match snapshots.find? (fun row => Text.equal row.path reference.snapshotPath) with
      | none => .error (Text.append "FileNotFoundError: " reference.snapshotPath)
      | some snapshot => do
       let row ← countInput input
       resolveTarget row input.molecularFormula reference.snapshotHash snapshot.hash target.record
        (ElectronSpinHtml.parseEvents snapshot.events).rows
end SFT.Chemistry.ElectronSpinTargets
