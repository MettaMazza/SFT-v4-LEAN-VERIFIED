import SFT.Chemistry.VibrationalFrequencyExperiment
import SFT.Chemistry.MolecularIonizationSource
namespace SFT.Chemistry.VibrationalFrequencySource
open SFT.Host SFT.Host.Canonical SFT.Physics VibrationalFrequencyExperiment
set_option maxRecDepth 50000
set_option maxHeartbeats 100000000
abbrev Snapshot := MolecularBondAngleSource.Snapshot
abbrev pair := MolecularIonizationSource.pair
structure Parser where
 inCell : Bool := false
 parts : List String := []
 current : List String := []
 rows : List (List String) := []
def handle (p : Parser) : ElectronSpinHtml.Event → Parser
 | .startTag tag _ => if Text.equal (Text.lowerAscii tag) "td" then {p with inCell:=true,parts:=[]} else p
 | .data s => if p.inCell then {p with parts:=p.parts++[s]} else p
 | .endTag tag =>
  let lower := Text.lowerAscii tag
  if Text.equal lower "td" && p.inCell then
   {p with current:=p.current++[ElectronSpinHtml.normalizeSpace (Text.join p.parts)],inCell:=false}
  else if Text.equal lower "tr" then
   {p with rows:=if p.current.length==9 then p.rows++[p.current] else p.rows,current:=[]}
  else p
def tableRows (events : List ElectronSpinHtml.Event) : List (List String) := (events.foldl handle {}).rows
def digits (s : String) : Bool := let cs:=Text.chars s; !cs.isEmpty && cs.all ElectronSpinHtml.decimal
def decimal (s : String) : Bool := match MolecularIonizationSource.decimalPrefix (Text.chars s) with
 | none => false
 | some (_,rest) => rest.isEmpty
structure Surface where
 formula : String := ""
 name : String := ""
 rows : List (List String) := []
def sourceStep (prior : Surface) (cells : List String) : Except String Surface := do
 let formula := if (cells.headD "").isEmpty then prior.formula else cells.headD ""
 let name := if ((cells.drop 1).headD "").isEmpty then prior.name else (cells.drop 1).headD ""
 let mode := (cells.drop 2).headD ""
 let symmetry := (cells.drop 3).headD ""
 let experiment := (cells.drop 5).headD ""
 let molecules := (cells.drop 7).headD ""
 let vibrations := (cells.drop 8).headD ""
 if formula.isEmpty || name.isEmpty || mode.isEmpty || molecules.isEmpty || vibrations.isEmpty then
  return {prior with formula,name}
 if !digits mode || !digits molecules || !digits vibrations then throw "PROP-009 source count is not exact"
 if !experiment.isEmpty && !decimal experiment then throw "PROP-009 source frequency is not exact"
 pure ⟨formula,name,prior.rows++[[formula,name,mode,symmetry,experiment,molecules,vibrations]]⟩
def snapshotRows (snapshot : Snapshot) : Except String (List (List String)) := do
 let surface ← (tableRows snapshot.events).foldl (fun acc cells => do sourceStep (← acc) cells) (.ok ({} : Surface))
 if surface.rows.length != 2009 then throw "PROP-009 displayed source row count changed"
 pure surface.rows
structure Target where
 targetId : String
 row : Value
 value : CapabilityValues.Value
def decimalCount (s : String) : Nat := (Text.chars s).foldl (fun n c => 10*n+(c.toNat-48)) 0
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (identityDocument targets primary : Value)
 (snapshot : Snapshot) : Except String (List Target) := do
 let _ ← [(snapshot.bytes,snapshotPath,snapshotHash),(primaryBytes,primaryPath,primaryHash),
  (targetBytes,targetPath,targetHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "PROP-009 registered source changed: " path)
  pure ()
 let rows ← RunningConvergenceMeasurement.array (get targets "rows")
 let counts : List (String × Int) := [("source_advertised_molecule_count",164),("source_advertised_vibration_count",2452),
  ("complete_displayed_molecule_count",145),("complete_displayed_vibration_count",2009),
  ("source_advertised_but_undisplayed_molecule_count",19),("source_advertised_but_undisplayed_vibration_count",443),
  ("experimental_measurement_present_count",1984),("experimental_measurement_absent_count",25)]
 if !sameValue (get primary "schema") (.text "sft-v3-nist-cccbdb-vibrational-frequency-primary-records/1") ||
  !(counts.all fun (key,n) => sameValue (get primary key) (.integer n)) ||
  !sameValue (get primary "all_rows_preserved") (.boolean true) ||
  !sameValue (get primary "calculated_frequency_ratio_and_fitted_scale_columns_excluded_from_derivation_and_measurement_vector") (.boolean true) ||
  !sameValue (get primary "rows") (.array rows) ||
  !sameValue (get targets "schema") (.text "sft-v3-vibrational-frequency-withheld-measurements/1") ||
  !sameValue (get targets "release_requires_prediction_seal") (.boolean true) ||
  !sameValue (get targets "all_rows_preserved") (.boolean true) ||
  !sameValue (get targets "complete_row_count") (.integer 2009) || rows.length != 2009 then
  throw "PROP-009 complete source surface changed"
 let ids ← identities identityBytes identityDocument
 let sources ← snapshotRows snapshot
 ((ids.zip rows).zip sources).mapM fun ((id,row),source) => do
  let formula := source.headD ""
  let name := (source.drop 1).headD ""
  let mode := (source.drop 2).headD ""
  let symmetry := (source.drop 3).headD ""
  let experiment := (source.drop 4).headD ""
  let molecules := (source.drop 5).headD ""
  let vibrations := (source.drop 6).headD ""
  let present := !experiment.isEmpty
  let value ← if present then field row "exact_positive_recurrence_ratio_per_centimeter" >>= pair
   else pure (.emptyOne "empty-One")
  let targetId ← field row "target_id" >>= text
  let modeCount ← field id "mode_count" >>= JointCorrelationTargets.integer
  let moleculeCount ← field id "molecule_count" >>= JointCorrelationTargets.integer
  let vibrationCount ← field id "vibration_count" >>= JointCorrelationTargets.integer
  if !sameValue (get id "target_id") (get row "target_id") ||
   (!sameValue (get id "formula") (.text formula) && !formula.isEmpty) ||
   (!sameValue (get id "name") (.text name) && !name.isEmpty) ||
   !(@decide (modeCount = Int.ofNat (decimalCount mode)) (Int.decEq _ _)) ||
   !sameValue (get id "symmetry_label") (.text symmetry) ||
   !(@decide (moleculeCount = Int.ofNat (decimalCount molecules)) (Int.decEq _ _)) || !(@decide (vibrationCount = Int.ofNat (decimalCount vibrations)) (Int.decEq _ _)) ||
   !sameValue (get row "measurement_present") (.boolean present) ||
   !sameValue (get row "frequency_inscription_cm_inverse") (if present then .text experiment else .null) then
   throw (Text.append "PROP-009 source reconstruction differs: " targetId)
  pure ⟨targetId,row,value⟩
end SFT.Chemistry.VibrationalFrequencySource
