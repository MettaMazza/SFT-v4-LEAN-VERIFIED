import SFT.Chemistry.TemperatureDependenceEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.TemperatureDependenceExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003"
def experimentId : String := "SFT-EXP-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003"
def frozenRelation : String := "held-registered-reaction-identity-per-row__exact-positive-temperature-support-per-row__exact-positive-elementary-rate-response-per-row__complete-held-density-bath-method-and-uncertainty-record__complete-two-reaction-source-ordered-row-census__exact-condition-bound-temperature-rate-table__complete-value-free-19-target-identity-seal__depth-independent-complete-row-append-with-prior-trace-preserved"
def falsification : String := "The claim fails if reaction, temperature, rate, density, bath gas, method, uncertainty, structural absence, source row or adverse response is erased; if an imported/fitted form or prohibited value enters; if targets open before all nineteen identities seal; if any measured Table 1 row or column is omitted; or if tampering is accepted."
def identityPath : String := "experiments/external_sources/chemistry/temperature_dependence_target_identities_v1.json"
def identityHash : String := "sha256:f611fde45610cabb5e2558a1e3afd42e4127ec7ddb618aa87e6ccb7999b7e6e9"
def targetPath : String := "experiments/external_sources/chemistry/temperature_dependence_withheld_targets_v1.json"
def targetHash : String := "sha256:cfafdb9ede18d0cf9eea985ce7ec9d9e43da418f4bb288634b54d0836a54475b"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/kin-003-temperature-dependence-v1/temperature-dependence-primary-records-v1.json"
def primaryHash : String := "sha256:5ddb819a17cd233f6c80bc2b1da03a50e30e5d7bc14c7b549ae852e6d8c8fb1c"
def sourceFiles : List (String×String) := [("experiments/external_sources/chemistry/snapshots/kin-003-temperature-dependence-v1/jp505790m-primary-accepted-manuscript.pdf","sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c")]
def targetIds : List String := ["SFT-CHEM-KIN-003-TEMPERATURE-RATE-0001", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0002", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0003", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0004", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0005", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0006", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0007", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0008", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0009", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0010", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0011", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0012", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0013", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0014", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0015", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0016", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0017", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0018", "SFT-CHEM-KIN-003-TEMPERATURE-RATE-0019"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "KIN-003 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["reaction_identity", "measurement_method", "temperature_K_external_inscription", "total_density_1e16_molecule_cm_minus3_external_inscription", "rate_coefficient_molecule_minus1_cm3_s_minus1_external_inscription", "target_payload", "target_payload_hash"]
 if !sameValue (get document "complete_target_count") (.integer 19) ||
  !sameValue (get document "complete_condition_row_count") (.integer 14) ||
  !sameValue (get document "all_temperature_rate_density_uncertainty_method_note_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 19 || rows.any (fun row => forbidden.any (hasKey row)) then
  throw "KIN-003 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("source_id","complete-source-identity"),("table_number","table-number"),("source_condition_row_ordinal","positive-source-condition-row-ordinal"),("reaction_key","registered-reaction-key")]
def identityValue (row : Value) (key : String) : Except String String := field row key >>= identityString
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "temperature-rate-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← identityValue row key
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let laws := [("reaction-law","held-registered-reaction-per-row"),("intervention-law","exact-positive-temperature-with-complete-condition-record"),("response-law","exact-positive-elementary-rate-with-all-adverse-rows-retained"),("relation-law","complete-source-ordered-table-without-imported-or-fitted-form")]
 let lawRows := laws.zipIdx.map fun ((family,label),index) =>
  let destination := Text.intercalate "" [rowPrefix,"-law-",toString (5+index)]
  (instruction "label" destination [family,label],destination)
 let registers := ["premise"] ++ labeled.map Prod.snd ++ lawRows.map Prod.snd
 pure ([instruction "label" (Text.append rowPrefix "-target") ["target-id",target]] ++ labeled.map Prod.fst ++
  lawRows.map Prod.fst ++ [instruction "word" (Text.append rowPrefix "-word") registers],
  [Text.append rowPrefix "-target",Text.append rowPrefix "-word"])
def predictionProgramDocument (identityBytes : ByteArray) (document : Value) : Except String Value := do
 let rows ← identities identityBytes document
 let parts ← rows.zipIdx.mapM fun (row,index) => rowInstructions row (index+1)
 pure (.object [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text (Text.append experimentId "-value-free-complete-vector")),
 ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++ parts.flatMap Prod.fst ++
 [instruction "table" "complete-temperature-rate-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-temperature-rate-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "forward_forcing_with_prefetch_value_free_identity_seal"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("complete_primary_pdf",.array [.text "experiments/external_sources/chemistry/snapshots/kin-003-temperature-dependence-v1/jp505790m-primary-accepted-manuscript.pdf",.text "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c"]),("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_temperature_rate_density_uncertainty_method_note_and_target_hash_values_absent",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-two-reaction-condition-bound-temperature-rate-table-vector"
def dimensions : List (String × List (String × Bool)) := [("reaction",[("anonymous-collapsed-or-changing-reaction",false),("held-registered-reaction-identity-per-row",true)]),("temperature",[("temperature-erased-signed-or-continuum-variable",false),("exact-positive-temperature-support-per-row",true)]),("response",[("answer-only-rate-or-unregistered-change",false),("exact-positive-elementary-rate-response-per-row",true)]),("condition",[("density-bath-method-or-uncertainty-collapsed",false),("complete-held-density-bath-method-and-uncertainty-record",true)]),("completeness",[("selected-favorable-rows-reaction-or-averaged-answer",false),("complete-two-reaction-source-ordered-row-census",true)]),("relation",[("imported-arrhenius-exponential-logarithm-prefactor-or-activation-fit",false),("exact-condition-bound-temperature-rate-table",true)]),("prediction",[("temperature-density-rate-or-target-value-readable-before-seal",false),("complete-value-free-19-target-identity-seal",true)]),("extension",[("refit-after-complete-row-append",false),("depth-independent-complete-row-append-with-prior-trace-preserved",true)])]
def snapshotHashes : List String := ["sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c", "sha256:72514fc7892a6fb04a2b1ced7c8ec5c46f114cc76d1a88aeac09ca111f26817c"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if TemperatureDependenceEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array TemperatureDependenceEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.TemperatureDependenceExperiment
