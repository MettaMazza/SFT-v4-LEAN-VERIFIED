import SFT.Chemistry.DihedralTorsionExperiment
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.ConfigurationObservation
namespace SFT.Chemistry.DihedralTorsionSource
open SFT.Host SFT.Host.Canonical SFT.Physics DihedralTorsion DihedralTorsionCycle DihedralTorsionExperiment
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev get := MolecularBondAngleSource.get
abbrev field := MolecularBondAngleSource.field
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev sameKeys := MolecularBondAngleSource.sameKeys
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
-- These three original HTML handlers are identical to the retained bond-angle handlers.
abbrev tableRows := MolecularBondAngleSource.tableRows
abbrev Snapshot := MolecularBondAngleSource.Snapshot
def snapshotPath := "experiments/external_sources/chemistry/snapshots/configuration-order-v1/nist-cccbdb-ethanol-experimental-rotational-barrier.html"
def snapshotHash := "sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209"
def exactSourceValue (inscription : String) : Except String Height := do
 let value ← ConfigurationObservation.exact inscription
 if (@decide (value.num=0) (Int.decEq _ _)) then pure .emptyOne
 else if (@decide (Int.lt 0 value.num) (Int.decLt _ _)) then
  pure (.ratio ⟨← CapabilityValues.count value.num.natAbs,← CapabilityValues.count value.den⟩)
 else throw "PROP-004 source value left the exact positive/EmptyOne domain"
def toFold : Height → Except String CapabilityValues.Value
 | .emptyOne => pure (.emptyOne "empty-One")
 | .otherEmptyOne id => pure (.emptyOne id)
 | .ratio r => pure (.ratio r.numerator r.denominator)
 | .invalid => throw "PROP-004 source value left the exact positive/EmptyOne domain"
structure SourceRow where
 structural : Row
 identityRow : Value
 angleInscription : String
 energyKjInscription : String
 energyCmInscription : String
 angle : Height
 energyKj : Height
 energyCm : Height
 vaultValue : CapabilityValues.Value
def sourceRows (identityBytes targetBytes : ByteArray) (identities targets : Value)
 (snapshot : Snapshot) : Except String (List SourceRow) := do
 let _ ← [(identityBytes,identityPath,identityHash),(targetBytes,targetPath,targetHash),
  (snapshot.bytes,snapshotPath,snapshotHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "PROP-004 registered source changed: " path)
  pure ()
 let identityList ← RunningConvergenceMeasurement.array (get identities "rows")
 let targetList ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get identities "schema") (.text "sft-v3-dihedral-torsion-identities/1") ||
    !sameValue (get identities "all_angle_and_energy_values_absent") (.boolean true) ||
    !sameValue (get targets "schema") (.text "sft-v3-dihedral-torsion-withheld-measurements/1") ||
    !sameValue (get targets "release_requires_prediction_seal") (.boolean true) ||
    !sameValue (get targets "source_zero_is_absence_glyph_only") (.boolean true) ||
    !sameValue (get targets "identity_document_hash") (.text (identity identities)) ||
    identityList.length != 50 || targetList.length != 50 then
  throw "PROP-004 registered two-path boundary changed"
 let raw := (tableRows snapshot.events).filter fun row =>
  row.length==4 && (Text.equal (row.headD "") "1" || Text.equal (row.headD "") "2") &&
   !(row.drop 1 |>.headD "").isEmpty && (Text.chars ((row.drop 1).headD "")).all Char.isDigit
 let identityRows ← EquilibriumBondLengthSource.indexedRows identities
 let targetRows ← EquilibriumBondLengthSource.indexedRows targets
 let structural ← structuralRows
 if raw.length != 50 || !sameKeys (identityRows.map Prod.fst) (targetRows.map Prod.fst) ||
    !sameKeys (targetRows.map Prod.fst) (structural.map Row.targetId) then
  throw "PROP-004 identity, source and structural supports differ"
 (raw.zip structural).mapM fun (source,row) => do
  let identityRow ← field (.object identityRows) row.targetId
  let target ← field (.object targetRows) row.targetId
  let torsion := source.headD ""
  let angleText := (source.drop 1).headD ""
  let kjText := (source.drop 2).headD ""
  let cmText := (source.drop 3).headD ""
  let torsionIndex ← match LeptonDecimal.digits (Text.chars torsion) with
   | none => throw "PROP-004 source torsion index is not an integer"
   | some n => pure n
  if !sameValue (get identityRow "target_value_absent") (.boolean true) ||
     !sameValue (get identityRow "species") (.text "ethanol") ||
     !sameValue (get identityRow "torsion_index") (.integer row.rotor.index) ||
     !sameValue (get identityRow "ordered_four_atom_carrier") (.array (row.rotor.atoms.map Value.text)) ||
     !sameValue (get identityRow "rotor_type") (.text row.rotor.kind) ||
     !sameValue (get identityRow "held_orientation") (.text "source-forward-periodic-order") ||
     !sameValue (get identityRow "registered_sector_count") (.integer 24) ||
     !sameValue (get identityRow "path_position") (.integer row.position.value) ||
     !sameValue (get identityRow "coordinate_form") (.text row.coordinateForm) ||
     !sameValue (get target "torsion_index") (.integer torsionIndex) ||
     !sameValue (get target "path_position") (.integer row.position.value) ||
     !sameValue (get target "angle_inscription_degrees") (.text angleText) ||
     !sameValue (get target "energy_inscription_kj_mol") (.text kjText) ||
     !sameValue (get target "energy_inscription_cm_inverse") (.text cmText) ||
     !sameValue (get target "source_snapshot_hash") (.text snapshotHash) then
   throw (Text.append "PROP-004 source reconstruction differs: " row.targetId)
  let angle ← exactSourceValue angleText
  let kj ← exactSourceValue kjText
  let cm ← exactSourceValue cmText
  let vault := CapabilityValues.Value.word [← toFold angle,← toFold kj,← toFold cm]
  pure ⟨row,identityRow,angleText,kjText,cmText,angle,kj,cm,vault⟩
def carrier (row : SourceRow) : Except String Carrier := do
 let atoms ← RunningConvergenceMeasurement.array (get row.identityRow "ordered_four_atom_carrier")
 let atomLabels ← atoms.mapM fun atom => do
  let value ← text atom
  CapabilityValues.heldLabel "ordered-torsion-atom" value
 let rotor ← text (get row.identityRow "rotor_type")
 let orientation ← text (get row.identityRow "held_orientation")
 validateCarrier ⟨⟨"molecular-carrier","ethanol",rfl,rfl⟩,
  ⟨"molecular-state","gauche-ethanol-internal-rotation",rfl,rfl⟩,
  atomLabels,← CapabilityValues.heldLabel "rotor-type" rotor,← CapabilityValues.heldLabel "held-orientation" orientation⟩
inductive EnergyUnit where
 | kj | cm
def cycles (rows : List SourceRow) (unit : EnergyUnit) : Except String (List (Nat × Cycle)) :=
 [1,2].mapM fun index => do
  let path := rows.filter fun row => row.structural.rotor.index==index
  let nodes ← path.mapM fun row => do
   let height := match unit with | .kj => row.energyKj | .cm => row.energyCm
   validateNode ⟨← carrier row,row.structural.position,row.structural.coordinate,height,
    ← CapabilityValues.heldLabel "torsion-record" row.structural.targetId⟩
  let cycle ← validateCycle (.count ⟨24,by decide⟩) nodes
  pure (index,cycle)
theorem sourceEmptyGlyph : exactSourceValue "0" = .ok .emptyOne := rfl
theorem positiveSourceInscription : exactSourceValue "5.41" = .ok (.ratio ⟨⟨541,by decide⟩,⟨100,by decide⟩⟩) := rfl
end SFT.Chemistry.DihedralTorsionSource
