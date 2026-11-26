import SFT.Chemistry.InternalEnergyCompositionExperiment
import SFT.Chemistry.FiniteMicrostateSupportSource
namespace SFT.Chemistry.InternalEnergyCompositionSource
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev canonicalPayloadHash := SFT.Host.Canonical.identity
abbrev attachPayload := FiniteMicrostateSupportSource.attachPayload
structure Target where
 targetId : String
 row : Value
 value : CapabilityValues.Value
def targetKeys (target : Value) : Bool := match target with
 | .object fields => fields.length==18 &&
   (valueColumns++["target_id","source_class","source_row_ordinal","snapshot_hash"]).all (hasKey target)
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def sourceRows (identityBytes targetBytes primaryBytes snapshotBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),(snapshotBytes,snapshotPath,snapshotHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-003 registered source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "schema") (.text "sft-v3-thermophysical-state-withheld-targets/1") ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) ||
  !sameValue (get targets "identity_registry_hash") (.text identityHash) ||
  !sameValue (get targets "complete_target_count") (.integer 13) || targetRows.length != 13 then
  throw "THERMO-003 withheld registry changed"
 let resolved ← (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") ||
   !sameValue (get id "source_class") (get target "source_class") ||
   !sameValue (get id "source_row_ordinal") (get target "source_row_ordinal") ||
   !targetKeys target || !sameValue (get target "snapshot_hash") (.text snapshotHash) then
   throw "THERMO-003 identity/target binding changed"
  let hash := canonicalPayloadHash target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-state-vector-hash" hash
  pure (⟨targetId,attachPayload id target hash,.label held⟩ : Target)
 let phases := resolved.map fun row => get (get row.row "target_payload") "phase-identity"
 let boundary := resolved.filter fun row => sameValue (get (get row.row "target_payload") "temperature-kelvin") (.text "372.75593")
 let boundaryPhases := boundary.map fun row => get (get row.row "target_payload") "phase-identity"
 if (phases.filter fun v => sameValue v (.text "liquid")).length != 9 ||
  (phases.filter fun v => sameValue v (.text "vapor")).length != 4 || boundary.length != 2 ||
  !(boundaryPhases.any fun v => sameValue v (.text "liquid")) ||
  !(boundaryPhases.any fun v => sameValue v (.text "vapor")) then
  throw "THERMO-003 complete phase surface changed"
 pure resolved
structure Analysis where
 internalEnergyValues : List Rat
 adjacentExactPositiveSteps : List Rat
 checks : List (String × Bool)
def exactInternalEnergyAnalysis (rows : List Target) : Except String Analysis := do
 let payloads := rows.map fun row => get row.row "target_payload"
 let energies ← payloads.mapM fun p => do
  LeptonDecimal.exactDecimal (← field p "internal-energy-kilojoule-per-mole" >>= identityString)
 let steps := (energies.zip (energies.drop 1)).map fun (first,second) => subtract second first
 let phases ← payloads.mapM fun p => field p "phase-identity" >>= identityString
 let boundaryIndices := (payloads.zipIdx.filter fun (p,_) => sameValue (get p "temperature-kelvin") (.text "372.75593")).map Prod.snd
 let signedSource ← payloads.mapM fun p => field p "joule-thomson-kelvin-per-bar" >>= identityString
 let first ← match energies.head? with | some v => pure v | none => throw "tuple index out of range"
 let last ← match energies.getLast? with | some v => pure v | none => throw "tuple index out of range"
 let eighth ← match (energies.drop 8).head? with | some v => pure v | none => throw "tuple index out of range"
 let ninth ← match (energies.drop 9).head? with | some v => pure v | none => throw "tuple index out of range"
 let sum := steps.foldl add zero
 let difference := subtract last first
 let jump := subtract ninth eighth
 let negative := signedSource.filter fun value => Text.isPrefix "-".toUTF8.data.toList value.toUTF8.data.toList
 pure ⟨energies,steps,[
  ("all_internal_energy_values_exact_positive",energies.all fun value => @decide (0<value.num) (Int.decLt _ _)),
  ("all_adjacent_internal_energy_steps_exact_positive",steps.all fun value => @decide (0<value.num) (Int.decLt _ _)),
  ("complete_path_composes_exactly",(@decide (sum.num=difference.num) (Int.decEq _ _)) && sum.den==difference.den),
  ("phase_boundary_pair_retained",boundaryIndices==[8,9] &&
    (phases.drop 8).take 2 == ["liquid","vapor"]),
  ("phase_boundary_internal_energy_jump_exact_positive",@decide (0<jump.num) (Int.decLt _ _)),
  ("all_fourteen_columns_retained",payloads.all fun p => valueColumns.all (hasKey p)),
  ("all_13_rows_retained",rows.length==13),
  ("nine_liquid_and_four_vapor_rows_retained",(phases.filter (Text.equal "liquid")).length==9 && (phases.filter (Text.equal "vapor")).length==4),
  ("external_signed_Joule_Thomson_inscriptions_retained",negative.length==9 && signedSource.length-negative.length==4)]⟩
def fractionText (value : Rat) : String :=
 let numerator := match value.num with
  | .ofNat n => toString n
  | .negSucc n => Text.append "-" (toString (n+1))
 if value.den==1 then numerator else Text.intercalate "" [numerator,"/",toString value.den]
end SFT.Chemistry.InternalEnergyCompositionSource
