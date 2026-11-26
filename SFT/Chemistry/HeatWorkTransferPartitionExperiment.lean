import SFT.Chemistry.HeatWorkTransferPartitionEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.HeatWorkTransferPartitionExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004"
def experimentId : String := "SFT-EXP-CHEM-HEAT-WORK-TRANSFER-PARTITION-004"
def frozenRelation : String := "complete-held-chemical-transfer-path__observation-forced-closed-or-held-carrier-class__held-direction-plus-exact-positive-content__disjoint-exhaustive-heat-work-path-partition__per-class-positive-composition-plus-EmptyOne-absence__complete-value-free-transfer-identity-seal__complete-13-row-joint-calorimetric-expansion-vector__depth-independent-append-only-transfer-successor"
def falsification : String := "The claim fails if one transfer requires an arbitrary rather than observation-forced heat/work class; if a transfer occurs in both or neither class; if direction requires a negative proof value; if an absent class requires numerical zero; if appending a transfer changes a prior record; if any target opens before all identities seal; if any returned row or column is omitted; if any direct calorimetric or expansion-work magnitude is not positive; if the independently recorded enthalpy/internal-energy separation and pressure-volume work do not agree within their exact displayed-resolution bounds; or if target values select the law."
def identityPath : String := "experiments/external_sources/chemistry/thermophysical_state_target_identities_v1.json"
def identityHash : String := "sha256:1161a9a8913ddedd309110077bcdab883fbb1f7046a59e279e8972f435602025"
def targetPath : String := "experiments/external_sources/chemistry/thermophysical_state_withheld_targets_v1.json"
def targetHash : String := "sha256:707f5005e6a47197f320e98977d2a2c000dfa4bc2877f81c6e38b1a6c7d637ad"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/thermo-shared-water-isobar-v1/thermophysical-state-primary-records-v1.json"
def primaryHash : String := "sha256:48d25011fb7b87017a06e8b0e89d3f4a8d9928ef74625008cd2f7cba9a124c95"
def snapshotPath : String := "experiments/external_sources/chemistry/snapshots/thermo-shared-water-isobar-v1/nist-webbook-water-isobar-1bar-300-400K.html"
def snapshotHash : String := "sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c"
def targetIds : List String := ["SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0001","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0002","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0003","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0004","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0005","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0006","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0007","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0008","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0009","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0010","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0011","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0012","SFT-CHEM-THERMO-SHARED-WATER-ISOBAR-0013"]
def valueColumns : List String := ["temperature-kelvin","pressure-bar","density-mole-per-litre","volume-litre-per-mole","internal-energy-kilojoule-per-mole","enthalpy-kilojoule-per-mole","entropy-joule-per-mole-kelvin","isochoric-heat-capacity-joule-per-mole-kelvin","isobaric-heat-capacity-joule-per-mole-kelvin","sound-speed-metre-per-second","joule-thomson-kelvin-per-bar","viscosity-micropascal-second","thermal-conductivity-watt-per-metre-kelvin","phase-identity"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "THERMO-003 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := valueColumns ++ ["snapshot_hash","target_payload","target_payload_hash"]
 if !sameValue (get document "schema") (.text "sft-v3-thermophysical-state-identities/1") ||
  !sameValue (get document "complete_query_identity_count") (.integer 13) ||
  !sameValue (get document "all_returned_temperatures_phases_and_property_values_absent") (.boolean true) ||
  rows.length != 13 || rows.any (fun row => forbidden.any (hasKey row)) then
  throw "THERMO-003 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("source_class","external-record-class"),
 ("source_id","external-source-identity"),("source_row_ordinal","positive-source-row-ordinal"),
 ("chemical_composition_identity","chemical-composition"),("query_identity","declared-query-identity")]
def columnHash (row : Value) : Except String String := do
 let columns ← field row "column_identities" >>= RunningConvergenceMeasurement.array
 pure (identity (.array columns))
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "heat-work-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← field row key >>= identityString
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let columns ← columnHash row
 let schemaRegister := Text.append rowPrefix "-columns"
 let schemaInstruction := instruction "label" schemaRegister ["column-identity-schema-hash",columns]
 let laws := [("heat-law","carrier-label-closed-by-receiving-macro-observation"),
  ("work-law","organized-source-response-label-retained"),
  ("partition-law","disjoint-exhaustive-heat-work-path-partition"),
  ("composition-law","per-class-positive-composition-plus-EmptyOne-absence")]
 let lawRows := laws.zipIdx.map fun ((family,label),index) =>
  let destination := Text.intercalate "" [rowPrefix,"-law-",toString (7+index)]
  (instruction "label" destination [family,label],destination)
 let registers := ["premise"] ++ labeled.map Prod.snd ++ [schemaRegister] ++ lawRows.map Prod.snd
 pure ([instruction "label" (Text.append rowPrefix "-target") ["target-id",target]] ++ labeled.map Prod.fst ++
  [schemaInstruction] ++ lawRows.map Prod.fst ++ [instruction "word" (Text.append rowPrefix "-word") registers],
  [Text.append rowPrefix "-target",Text.append rowPrefix "-word"])
def predictionProgramDocument (identityBytes : ByteArray) (document : Value) : Except String Value := do
 let rows ← identities identityBytes document
 let parts ← rows.zipIdx.mapM fun (row,index) => rowInstructions row (index+1)
 pure (.object [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text (Text.append experimentId "-value-free-complete-vector")),
 ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++ parts.flatMap Prod.fst ++
 [instruction "table" "complete-heat-work-state-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-heat-work-state-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),("NIST_snapshot",.array [.text snapshotPath,.text snapshotHash]),
 ("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_calorimetric_expansion_work_and_state_values_absent_from_prediction",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-chemical-heat-work-transfer-partition"
def dimensions : List (String × List (String × Bool)) := [("carrier",[("answer-only-signed-net-energy",false),("complete-held-chemical-transfer-path",true)]),("class",[("imported-or-arbitrary-heat-work-label",false),("observation-forced-closed-or-held-carrier-class",true)]),("orientation",[("negative-or-signed-transfer-content",false),("held-direction-plus-exact-positive-content",true)]),("partition",[("merged-or-overlapping-transfer-classes",false),("disjoint-exhaustive-heat-work-path-partition",true)]),("composition",[("signed-net-cancellation-or-numerical-zero",false),("per-class-positive-composition-plus-EmptyOne-absence",true)]),("prediction",[("calorimetric-or-work-target-readable-before-seal",false),("complete-value-free-transfer-identity-seal",true)]),("record",[("selected-calorimetric-or-expansion-row",false),("complete-13-row-joint-calorimetric-expansion-vector",true)]),("extension",[("repartition-prior-path-after-successor",false),("depth-independent-append-only-transfer-successor",true)])]
def snapshotHashes : List String := ["sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c","sha256:fe25279cb2c8f54a749b503dc17249656e8ac773be0b273aa3f99d283d15050c"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if HeatWorkTransferPartitionEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array HeatWorkTransferPartitionEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.HeatWorkTransferPartitionExperiment
