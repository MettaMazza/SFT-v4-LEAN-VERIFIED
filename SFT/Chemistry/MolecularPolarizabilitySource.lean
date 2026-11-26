import SFT.Chemistry.MolecularPolarizabilityExperiment
import SFT.Chemistry.ConfigurationObservation
namespace SFT.Chemistry.MolecularPolarizabilitySource
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularPolarizabilityExperiment
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev Snapshot := MolecularBondAngleSource.Snapshot
abbrev tableRows := MolecularBondAngleSource.tableRows
-- Source JSON values are bound by the original immutable source hashes.
def pair (value : Value) : Except String CapabilityValues.Value := do
 let n ← field value "numerator" >>= JointCorrelationTargets.integer
 let d ← field value "denominator" >>= JointCorrelationTargets.integer
 if !(@decide (Int.lt 0 n) (Int.decLt _ _)) || !(@decide (Int.lt 0 d) (Int.decLt _ _)) then
  throw "an SFT count must be a positive counted value"
 pure (.ratio (← CapabilityValues.count n.natAbs) (← CapabilityValues.count d.natAbs))
def removeFirstDot : List Char → List Char
 | [] => []
 | c::cs => if c == '.' then cs else c::removeFirstDot cs
def decimalInscription (s : String) : Bool :=
 let cs := removeFirstDot (Text.chars s)
 !cs.isEmpty && cs.all Char.isDigit
def atomName (s : String) : Bool := (Text.chars " atom").isSuffixOf (Text.chars (Text.lowerAscii s))
def ordinalTarget (ordinal : Nat) : String :=
 let digits := toString ordinal
 let padded := if ordinal<10 then Text.append "00" digits else if ordinal<100 then Text.append "0" digits else digits
 Text.append "NIST-CCCBDB-PROP-006-MOLECULAR-" padded
structure Target where
 targetId : String
 row : Value
 value : CapabilityValues.Value
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (identityDocument targets : Value)
 (snapshot : Snapshot) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(snapshot.bytes,snapshotPath,snapshotHash),
  (primaryBytes,primaryPath,primaryHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "PROP-006 registered source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let rows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "schema") (.text "sft-v3-molecular-polarizability-withheld-measurements/1") ||
    !sameValue (get targets "release_requires_prediction_seal") (.boolean true) ||
    !sameValue (get targets "all_molecular_rows_preserved") (.boolean true) ||
    !sameValue (get targets "complete_molecular_row_count") (.integer 252) || rows.length != 252 then
  throw "PROP-006 withheld registry changed"
 let allSource := (tableRows snapshot.events).filter fun row =>
  row.length==7 && !Text.equal (row.headD "") "Molecule" && decimalInscription ((row.drop 4).headD "")
 let molecular := allSource.filter fun row => !atomName ((row.drop 1).headD "")
 if allSource.length != 276 || molecular.length != 252 then throw "PROP-006 complete source support changed"
 ((ids.zip rows).zip molecular).zipIdx.mapM fun (((id,row),source),index) => do
  let ordinal := index+1
  let targetId := ordinalTarget ordinal
  let formula := source.headD ""
  let name := (source.drop 1).headD ""
  let state := (source.drop 2).headD ""
  let conformation := (source.drop 3).headD ""
  let inscription := (source.drop 4).headD ""
  let reference := (source.drop 5).headD ""
  let comment := (source.drop 6).headD ""
  let exact ← ConfigurationObservation.exact inscription
  let value ← field row "value" >>= pair
  let exactMatch := match value with
   | .ratio n d => (@decide (Int.ofNat n.value*Int.ofNat exact.den=exact.num*Int.ofNat d.value) (Int.decEq _ _))
   | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
  let fields := [("formula",formula),("name",name),("molecular_state",state),
   ("conformation",conformation),("reference",reference),("comment",comment)]
  if !sameValue (get id "target_id") (.text targetId) || !sameValue (get row "target_id") (.text targetId) ||
     !sameValue (get id "source_row_ordinal") (.integer ordinal) || !sameValue (get row "source_row_ordinal") (.integer ordinal) ||
     !(fields.all fun (key,value) => sameValue (get id key) (.text value) && sameValue (get row key) (.text value)) ||
     !sameValue (get row "inscription") (.text inscription) || !exactMatch then
   throw (Text.append "PROP-006 source reconstruction differs: " targetId)
  pure ⟨targetId,row,value⟩
theorem firstOrdinalTarget : ordinalTarget 1="NIST-CCCBDB-PROP-006-MOLECULAR-001" := rfl
theorem terminalOrdinalTarget : ordinalTarget 252="NIST-CCCBDB-PROP-006-MOLECULAR-252" := rfl
end SFT.Chemistry.MolecularPolarizabilitySource
