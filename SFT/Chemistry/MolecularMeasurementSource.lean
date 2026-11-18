import SFT.Chemistry.NuclearElectronicTargets
import SFT.Chemistry.ConfigurationObservation
namespace SFT.Chemistry.MolecularMeasurementSource
open SFT.Host SFT.Host.Canonical
open JointCorrelationTargets (field text integer)
open NuclearElectronicTargets (list strings)
-- csv.reader(default dialect), retaining quoted fields, embedded newlines and empty cells.
structure CsvState where
 rows : List (List String) := []
 row : List String := []
 cell : List Char := []
 quoted : Bool := false
 afterQuote : Bool := false
 skipLF : Bool := false
 touched : Bool := false

def finishCell (s : CsvState) : CsvState :=
 {s with row := s.row ++ [String.ofList s.cell],cell:=[],afterQuote:=false,touched:=true}
def finishRow (s : CsvState) : CsvState :=
 let cells := if s.touched || !s.row.isEmpty || !s.cell.isEmpty then s.row ++ [String.ofList s.cell] else []
 {s with rows:=s.rows++[cells],row:=[],cell:=[],quoted:=false,afterQuote:=false,touched:=false}
def csvStep (s : CsvState) (c : Char) : CsvState :=
 if s.skipLF && c.toNat==10 then {s with skipLF:=false} else
 let s := {s with skipLF:=false}
 if s.quoted then
  if c.toNat==34 then {s with quoted:=false,afterQuote:=true}
  else {s with cell:=s.cell++[c],touched:=true}
 else if s.afterQuote && c.toNat==34 then {s with quoted:=true,afterQuote:=false,cell:=s.cell++[c]}
 else if c.toNat==44 then finishCell s
 else if c.toNat==10 || c.toNat==13 then {finishRow s with skipLF:=c.toNat==13}
 else if c.toNat==34 && s.cell.isEmpty && !s.afterQuote then {s with quoted:=true,touched:=true}
 else {s with cell:=s.cell++[c],afterQuote:=false,touched:=true}
def parseCsv (source : String) : List (List String) :=
 -- Python's text-mode universal-newline conversion precedes csv.reader.
 let normalized := (Text.chars source).foldl (fun (acc,cr) c =>
  if c.toNat==13 then (acc++['\n'],true)
  else if cr && c.toNat==10 then (acc,false)
  else (acc++[c],false)) (([] : List Char),false)
 let cs := normalized.1
 let cs := if cs.head?.map Char.toNat == some 65279 then cs.drop 1 else cs
 let s := cs.foldl csvStep {}
 if s.touched || !s.row.isEmpty || !s.cell.isEmpty then (finishRow s).rows else s.rows
structure Snapshot where
 path : String
 actualHash : String
 content : String

def identityPath : String := "experiments/external_sources/chemistry/molecular_measurement_target_identities_v1.json"
def targetPath : String := "experiments/external_sources/chemistry/molecular_measurement_withheld_targets_v1.json"
def identityHash : String := "sha256:51dc19518f36c7b75342e524a89d60ba96c19dbb944856e83f54563927b59883"
def targetHash : String := "sha256:5f34dcfb27bb36ca8931e5a26dcfd290285708c7b4a4412884ff794273416eef"
def rowText (row : Value) (key : String) : Except String String := field row key >>= text

def dictionary (rows : List Value) : Except String (List (String × Value)) := do
 rows.foldlM (fun acc row => do
  let id ← rowText row "target_id"
  return if acc.any (fun x => Text.equal x.1 id) then acc.map (fun x => if Text.equal x.1 id then (id,row) else x) else acc++[(id,row)]) []
def snapshotAt (snapshots : List Snapshot) (path : String) : Except String Snapshot :=
 match snapshots.find? (fun s => Text.equal s.path path) with
 | some s => .ok s
 | none => .error (Text.append "missing source snapshot: " path)

def rows (actualIdentityHash actualTargetHash : String) (identities targets : Value)
 (snapshots : List Snapshot) : Except String (List Value) := do
 if !Text.equal actualIdentityHash identityHash then throw (Text.append "ELEC-014 registry changed: " identityPath)
 if !Text.equal actualTargetHash targetHash then throw (Text.append "ELEC-014 registry changed: " targetPath)
 let ids ← field identities "rows" >>= list
 let ts ← field targets "rows" >>= list >>= dictionary
 let source ← field identities "source"
 let components ← field source "components" >>= list
 if ids.length != 330 || ts.length != 330 || components.length != 9 then throw "ELEC-014 complete package missing"
 let _ ← components.mapM fun c => do
  let path ← rowText c "snapshot_path"
  let actual ← snapshotAt snapshots path
  if !Text.equal actual.actualHash (← rowText c "snapshot_hash") then throw "ELEC-014 NIST component changed"
 let metadata ← snapshotAt snapshots (← rowText source "metadata_snapshot_path")
 if !Text.equal metadata.actualHash (← rowText source "metadata_snapshot_hash") then throw "ELEC-014 NIST metadata changed"
 let parsed := snapshots.map fun s => (s.path,parseCsv s.content)
 ids.mapM fun id => do
  let path ← rowText id "snapshot_path"
  let rawRows ← match parsed.find? (fun p => Text.equal p.1 path) with
   | some p => pure p.2
   | none => throw "source snapshot missing"
  let targetId ← rowText id "target_id"
  let target ← match ts.find? (fun p => Text.equal p.1 targetId) with
   | some p => pure p.2
   | none => throw (Text.intercalate "" ["'",targetId,"'"])
  let raw ← NuclearElectronicSource.atInt rawRows (← field id "row_ordinal" >>= integer)
  let header ← NuclearElectronicSource.atNat rawRows 0
  let columns ← field id "column_identities" >>= strings
  let cells ← field target "cells" >>= strings
  if !NuclearElectronic.equalNuclear header columns || !NuclearElectronic.equalNuclear raw cells then
   throw "ELEC-014 independent row reconstruction differs"
  return target
end SFT.Chemistry.MolecularMeasurementSource
