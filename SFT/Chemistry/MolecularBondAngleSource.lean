import SFT.Chemistry.MolecularBondAngleExperiment
import SFT.Chemistry.EquilibriumBondLengthSource
import SFT.Chemistry.ElectronSpinHtml
namespace SFT.Chemistry.MolecularBondAngleSource
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals
open MolecularBondAngle MolecularBondAngleExperiment
abbrev field := JointCorrelationTargets.field
abbrev text := JointCorrelationTargets.text
abbrev sameValue := RunningConvergenceMeasurement.sameValue
-- The original HTMLParser tokenizer supplies events. All custom handlers below
-- implement bond_angle_validation_v1.py:_TableParser, including nested-row state.
structure TableParser where
 rows : List (List String) := []
 row : Option (List String) := none
 cell : Option (List String) := none
def startTag (p : TableParser) (tag : String) : TableParser :=
 let tag := Text.lowerAscii tag
 if Text.equal tag "tr" then {p with row := some []}
 else if (Text.equal tag "td" || Text.equal tag "th") && p.row.isSome then {p with cell := some []}
 else p
def data (p : TableParser) (value : String) : TableParser :=
 match p.cell with
 | none => p
 | some cell =>
  let normalized := ElectronSpinHtml.normalizeSpace value
  if normalized.isEmpty then p else {p with cell := some (cell++[normalized])}
def endTag (p : TableParser) (tag : String) : TableParser :=
 let tag := Text.lowerAscii tag
 if Text.equal tag "td" || Text.equal tag "th" then
  match p.cell,p.row with
  | some cell,some row => {p with row := some (row++[Text.join cell]),cell := none}
  | none,none => p
  | none,some _ => p
  | some _,none => p
 else if Text.equal tag "tr" then
  match p.row with
  | none => p
  | some row => {rows := if row.isEmpty then p.rows else p.rows++[row],row := none,cell := none}
 else p
def handle (p : TableParser) : ElectronSpinHtml.Event → TableParser
 | .startTag tag _ => startTag p tag
 | .endTag tag => endTag p tag
 | .data value => data p value
def tableRows (events : List ElectronSpinHtml.Event) : List (List String) :=
 (events.foldl handle {}).rows
structure Snapshot where
 path : String
 bytes : ByteArray
 events : List ElectronSpinHtml.Event
def bf3Path := "experiments/external_sources/chemistry/snapshots/prop-003-nist-cccbdb-bf3-v1.html"
def bf3Hash := "sha256:3585dfdfe7551bce657c377a96f7800759e027325a0b5bac96c264591ba01181"
def xef2Path := "experiments/external_sources/chemistry/snapshots/prop-003-nist-cccbdb-xef2-v1.html"
def xef2Hash := "sha256:39e69a157c1bda28a8aa1dc48e39e0e9550ecb79c396cd543bc4aaf728938df4"
def xef4Path := "experiments/external_sources/chemistry/snapshots/prop-003-nist-cccbdb-xef4-v1.html"
def xef4Hash := "sha256:26ca18c0606aca4acb21c8e5555d1a6bc2a263c22510776e7834a22783ea3426"
def specifications : List (String × String × String × List (String × List String)) :=
 [(bf3Path,bf3Hash,"aFBF",[("NIST-CCCBDB-BF3-FBF-ADJACENT",["2","1","3"])]),
 (xef2Path,xef2Hash,"aFXeF",[("NIST-CCCBDB-XEF2-FXEF-OPPOSITE",["2","1","3"])]),
 (xef4Path,xef4Hash,"aFXeF",[("NIST-CCCBDB-XEF4-FXEF-ADJACENT",["2","1","3"]),
 ("NIST-CCCBDB-XEF4-FXEF-OPPOSITE",["2","1","4"])])]
def bytesMatch (bytes : ByteArray) (hash : String) : Bool :=
 Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) hash
def connectivity (row : List String) : List String := (row.drop 2).take 3
-- The source hash pins the three NIST inscription domains. Their exact decimal
-- decoding reuses LeptonDecimal; no floating conversion or rounded answer table.
def sourceAngleRows (snapshots : List Snapshot) : Except String (List (String × Rat)) := do
 let parts ← specifications.mapM fun (path,hash,coordinate,targets) => do
  let snapshot ← match snapshots.find? (fun s => Text.equal s.path path) with
   | none => throw (Text.append "FileNotFoundError: " path)
   | some s => pure s
  if !bytesMatch snapshot.bytes hash then throw (Text.append "PROP-003 NIST snapshot changed: " path)
  let rows := (tableRows snapshot.events).filter (fun row => row.length ≥ 5 && Text.equal (row.headD "") coordinate)
  let keys := rows.map connectivity
  let unique := keys.foldl (fun acc key => if acc.any (fun old => old == key) then acc else acc++[key]) []
  if unique.length != rows.length then throw (Text.append "PROP-003 duplicate source coordinate row: " path)
  targets.mapM fun (target,key) => do
   let row ← match rows.find? (fun row => connectivity row == key) with
    | none => throw (Text.append "PROP-003 source connectivity absent: " target)
    | some row => pure row
   let value ← LeptonDecimal.exactDecimal ((row.drop 1).headD "")
   if !(@decide (Int.lt 0 value.num) (Int.decLt _ _)) then throw "PROP-003 source angle is not exact and positive"
   pure (target,value)
 let resolved := parts.flatten
 if resolved.length != 4 then throw "PROP-003 source angle vector is incomplete"
 pure resolved
def ratio (value : Rat) : Except String CapabilityValues.Value := do
 if !(@decide (Int.lt 0 value.num) (Int.decLt _ _)) then throw "PROP-003 exact ratio left the positive domain"
 pure (.ratio (← CapabilityValues.count value.num.natAbs) (← CapabilityValues.count value.den))
def fractionText (value : Rat) : String :=
 if value.den == 1 then render (.integer value.num)
 else Text.intercalate "/" [render (.integer value.num),toString value.den]
def sameKeys (a b : List String) : Bool :=
 a.all (fun key => b.any (Text.equal key)) && b.all (fun key => a.any (Text.equal key))
def get (row : Value) (key : String) : Value := (field row key).toOption.getD .null
structure Target where
 targetId : String
 species : String
 geometry : String
 coordinate : String
 role : String
 sourceInscription : String
 sourceDegrees : Rat
 sourceComment : Value
 targetValue : CapabilityValues.Value
def loadTargets (identityBytes targetBytes : ByteArray) (identities targets : Value)
 (snapshots : List Snapshot) : Except String (List Target) := do
 if !bytesMatch identityBytes identityHash || !bytesMatch targetBytes targetHash then
  throw "PROP-003 identity or target registry changed"
 let identityList ← RunningConvergenceMeasurement.array (get identities "rows")
 let targetList ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get identities "schema") (.text "sft-v3-molecular-bond-angle-identities/1") ||
    !sameValue (get identities "all_measurement_values_absent") (.boolean true) ||
    !sameValue (get targets "schema") (.text "sft-v3-molecular-bond-angle-withheld-measurements/1") ||
    !sameValue (get targets "release_requires_prediction_seal") (.boolean true) ||
    !sameValue (get targets "identity_document_hash") (.text (identity identities)) ||
    identityList.length != 4 || targetList.length != 4 then throw "PROP-003 registered target boundary changed"
 let identityRows ← EquilibriumBondLengthSource.indexedRows identities
 let targetRows ← EquilibriumBondLengthSource.indexedRows targets
 let sourceValues ← sourceAngleRows snapshots
 let structural := molecularAngleVector
 if !sameKeys (identityRows.map Prod.fst) (targetRows.map Prod.fst) ||
    !sameKeys (targetRows.map Prod.fst) (sourceValues.map Prod.fst) ||
    !sameKeys (sourceValues.map Prod.fst) (structural.map MolecularAngleCarrier.targetId) then
  throw "PROP-003 identity, source and structural supports differ"
 (SFT.Engine.sortIdentifiers (structural.map MolecularAngleCarrier.targetId)).mapM fun targetId => do
  let identityRow ← field (.object identityRows) targetId
  let target ← field (.object targetRows) targetId
  let carrier ← match structural.find? (fun c => Text.equal c.targetId targetId) with
   | none => throw "PROP-003 identity, source and structural supports differ"
   | some c => pure c
  let sourceValue ← match sourceValues.find? (fun p => Text.equal p.1 targetId) with
   | none => throw "PROP-003 identity, source and structural supports differ"
   | some p => pure p.2
  let interval := get target "observation_interval"
  let inscription := fractionText sourceValue
  if !sameValue (get identityRow "target_value_absent") (.boolean true) ||
     !sameValue (get identityRow "species") (.text carrier.species.label) ||
     !sameValue (get identityRow "geometry") (.text carrier.geometry.label) ||
     !sameValue (get identityRow "coordinate") (.text carrier.coordinate.label) ||
     !sameValue (get identityRow "sector_count") (.integer carrier.sectorCount.value) ||
     !sameValue (get identityRow "sector_separation") (.integer carrier.sectorSeparation.value) ||
     !sameValue (get target "species") (.text carrier.species.label) ||
     !sameValue (get target "coordinate") (.text carrier.coordinate.label) ||
     !sameValue (get target "source_snapshot_hash") (get identityRow "snapshot_hash") ||
     !sameValue (get target "inscription") (.text inscription) ||
     !sameValue (get interval "central") (.text inscription) ||
     !sameValue (get interval "lower") (.text inscription) ||
     !sameValue (get interval "upper") (.text inscription) ||
     !sameValue (get interval "uncertainty_form") (.text "source-absent-structural-EmptyOne") then
   throw (Text.append "PROP-003 source reconstruction differs: " targetId)
  let comment ← field target "source_comment"
  pure ⟨targetId,carrier.species.label,carrier.geometry.label,carrier.coordinate.label,
   carrier.angleRole.label,inscription,sourceValue,comment,← ratio sourceValue⟩
theorem initialRowsEmpty : tableRows [] = [] := rfl
theorem dataOutsideCell (value : String) : data {} value = {} := rfl
end SFT.Chemistry.MolecularBondAngleSource
