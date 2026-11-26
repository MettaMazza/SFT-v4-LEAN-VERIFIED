import SFT.Chemistry.ConcentrationDependenceEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.ConcentrationDependenceExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002"
def experimentId : String := "SFT-EXP-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002"
def frozenRelation : String := "one-held-registered-reactant-identity__exact-positive-concentration-support-per-row__exact-positive-elementary-rate-response-per-row__complete-held-condition-method-and-uncertainty-record__complete-source-ordered-row-census__exact-condition-bound-concentration-rate-table__complete-value-free-9-row-identity-seal__depth-independent-complete-row-append-with-prior-trace-preserved"
def falsification : String := "The claim fails if reactant, concentration, rate, condition, method, uncertainty, row or adverse response is erased; if a conventional/fitted law or prohibited value enters; if targets open before all nine identities seal; if any Table 2 row, column, uncertainty or note is omitted; or if tampering is accepted."
def identityPath : String := "experiments/external_sources/chemistry/concentration_dependence_target_identities_v1.json"
def identityHash : String := "sha256:d266ebece950622f6e9d7ec4a8ecac19c6c3e4ca0fa6c1b32b732ace88101f87"
def targetPath : String := "experiments/external_sources/chemistry/concentration_dependence_withheld_targets_v1.json"
def targetHash : String := "sha256:e174583b18628890cbcd36da6d95fc7ffb6dd1d91c4964c393b0f0095f0f84a4"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/kin-002-concentration-dependence-v1/concentration-dependence-primary-records-v1.json"
def primaryHash : String := "sha256:de0d8d963114e2f74535fa5a08d3c31a77005d6e62c2adaa1ae65868ec2b4af9"
def sourceFiles : List (String×String) := [("experiments/external_sources/chemistry/snapshots/kin-002-concentration-dependence-v1/c3cp54664k-primary-article.pdf","sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb")]
def targetIds : List String := ["SFT-CHEM-KIN-002-CONCENTRATION-RATE-0001", "SFT-CHEM-KIN-002-CONCENTRATION-RATE-0002", "SFT-CHEM-KIN-002-CONCENTRATION-RATE-0003", "SFT-CHEM-KIN-002-CONCENTRATION-RATE-0004", "SFT-CHEM-KIN-002-CONCENTRATION-RATE-0005", "SFT-CHEM-KIN-002-CONCENTRATION-RATE-0006", "SFT-CHEM-KIN-002-CONCENTRATION-RATE-0007", "SFT-CHEM-KIN-002-CONCENTRATION-RATE-0008", "SFT-CHEM-KIN-002-CONCENTRATION-RATE-0009"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "KIN-002 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["reaction_identity", "measurement_method", "temperature_K_external_inscription", "flow_density_1e16_molecule_cm_minus3_external_inscription", "rate_coefficient_molecule_minus1_cm3_s_minus1_external_inscription", "target_payload", "target_payload_hash"]
 if !sameValue (get document "complete_target_count") (.integer 9) ||
  !sameValue (get document "all_species_temperature_density_rate_uncertainty_method_note_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 9 || rows.any (fun row => forbidden.any (hasKey row)) then
  throw "KIN-002 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("source_id","complete-source-identity"),("table_number","table-number"),("source_row_ordinal","positive-source-row-ordinal"),("locator","source-locator-kind")]
def identityValue (row : Value) (key : String) : Except String String :=
 if Text.equal key "locator" then pure "complete-primary-concentration-rate-table-row"
 else field row key >>= identityString
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "concentration-rate-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← identityValue row key
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let laws := [("reactant-law","one-held-registered-reactant"),("intervention-law","exact-positive-concentration-with-complete-condition-record"),("response-law","exact-positive-elementary-rate-with-all-adverse-rows-retained"),("relation-law","complete-source-ordered-table-without-fitted-exponent")]
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
 [instruction "table" "complete-concentration-rate-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-concentration-rate-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "forward_forcing_with_prefetch_value_free_identity_seal"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("complete_primary_pdf",.array [.text "experiments/external_sources/chemistry/snapshots/kin-002-concentration-dependence-v1/c3cp54664k-primary-article.pdf",.text "sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb"]),("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_species_temperature_density_rate_uncertainty_method_note_and_target_hash_values_absent",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-condition-bound-concentration-rate-table-vector"
def dimensions : List (String × List (String × Bool)) := [("reactant",[("anonymous-or-changing-reactant",false),("one-held-registered-reactant-identity",true)]),("intervention",[("concentration-erased-or-continuum-variable",false),("exact-positive-concentration-support-per-row",true)]),("response",[("answer-only-rate-or-unregistered-change",false),("exact-positive-elementary-rate-response-per-row",true)]),("condition",[("temperature-method-or-uncertainty-collapsed",false),("complete-held-condition-method-and-uncertainty-record",true)]),("completeness",[("selected-favorable-rows-or-averaged-answer",false),("complete-source-ordered-row-census",true)]),("relation",[("imported-mass-action-power-order-fit-or-logarithm",false),("exact-condition-bound-concentration-rate-table",true)]),("prediction",[("species-condition-density-rate-or-value-readable-before-seal",false),("complete-value-free-9-row-identity-seal",true)]),("extension",[("refit-after-complete-row-append",false),("depth-independent-complete-row-append-with-prior-trace-preserved",true)])]
def snapshotHashes : List String := ["sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb", "sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb", "sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb", "sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb", "sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb", "sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb", "sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb", "sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb", "sha256:26b1d1696587cb669f5d8761c78046ad280d73ab7b0653b2dea39461e78f8acb"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if ConcentrationDependenceEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array ConcentrationDependenceEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.ConcentrationDependenceExperiment
