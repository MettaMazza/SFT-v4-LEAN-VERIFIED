import SFT.Chemistry.ElementaryTransitionRateEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.ElementaryTransitionRateExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001"
def experimentId : String := "SFT-EXP-CHEM-ELEMENTARY-TRANSITION-RATE-001"
def frozenRelation : String := "complete-registered-elementary-transition-carrier__distinct-held-initial-and-terminal-molecular-states__positive-completed-transition-count__positive-reference-tick-count__complete-condition-and-positive-observation-support__exact-transition-count-per-tick-and-observation-support__complete-value-free-46-record-identity-seal__depth-independent-common-event-tick-replication-and-record-append"
def falsification : String := "The claim fails if reaction identity, either molecular endpoint, condition, completed event, tick, observation support or direction is erased; if a prohibited number or imported conventional/fitted law enters; if target content opens before all 46 row identities seal; if any declared NIST page or rate row is omitted; if an Arrhenius tabulation is mislabeled as a raw event count; or if any target is tampered."
def identityPath : String := "experiments/external_sources/chemistry/elementary_transition_rate_target_identities_v1.json"
def identityHash : String := "sha256:e7cfae2a24ff1d52a4fe2d9704b0a608dee95fb15442bb17e5636d20a044cda3"
def targetPath : String := "experiments/external_sources/chemistry/elementary_transition_rate_withheld_targets_v1.json"
def targetHash : String := "sha256:6044024fe4650e8e99c66d992b12aff3cf12d2332b82ff2b6749e967e3499343"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/kin-001-elementary-transition-rate-v1/elementary-transition-rate-primary-records-v1.json"
def primaryHash : String := "sha256:9adbf7bae394a5edc6859973519fd0b4b57f8a50396535a16a18edf9e5d1d766"
def sourceFiles : List (String×String) := [("experiments/external_sources/chemistry/snapshots/kin-001-elementary-transition-rate-v1/nist-srd17-1972tin-koo3-15.html","sha256:68562ee063103f727b882119f3e76c100aa4f59d6bee0aec0da96f26b669b3ba"),("experiments/external_sources/chemistry/snapshots/kin-001-elementary-transition-rate-v1/nist-srd17-1967wil2017-1.html","sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd"),("experiments/external_sources/chemistry/snapshots/kin-001-elementary-transition-rate-v1/nist-srd17-1967avr-kra501-503-1.html","sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6"),("experiments/external_sources/chemistry/snapshots/kin-001-elementary-transition-rate-v1/nist-srd17-1962ash-bur685-691-1.html","sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec")]
def targetIds : List String := ["SFT-CHEM-KIN-001-ELEMENTARY-RATE-0001", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0002", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0003", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0004", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0005", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0006", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0007", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0008", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0009", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0010", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0011", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0012", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0013", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0014", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0015", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0016", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0017", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0018", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0019", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0020", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0021", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0022", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0023", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0024", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0025", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0026", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0027", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0028", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0029", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0030", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0031", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0032", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0033", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0034", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0035", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0036", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0037", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0038", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0039", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0040", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0041", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0042", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0043", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0044", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0045", "SFT-CHEM-KIN-001-ELEMENTARY-RATE-0046"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "KIN-001 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["complete_source_metadata", "reaction", "reaction_order", "temperature_K_external_inscription", "rate_external_inscription", "rate_unit_external_inscription", "rate_expression", "target_payload", "target_payload_hash", "method", "condition"]
 if !sameValue (get document "complete_target_count") (.integer 46) ||
  !sameValue (get document "complete_source_count") (.integer 4) ||
  !sameValue (get document "all_reaction_state_condition_method_expression_temperature_rate_value_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 46 || rows.any (fun row => forbidden.any (hasKey row)) then
  throw "KIN-001 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("source_id","complete-source-identity"),("record_id","record-identity"),("source_row_ordinal","positive-source-row-ordinal"),("locator","source-locator-kind")]
def identityValue (row : Value) (key : String) : Except String String :=
 if Text.equal key "locator" then pure "nist-srd17-complete-rate-table-row"
 else field row key >>= identityString
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "elementary-rate-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← identityValue row key
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let laws := [("carrier-law","registered-elementary-reaction-with-distinct-molecular-endpoints"),("resource-law","positive-completed-transition-per-positive-tick-and-observation-support"),("condition-law","complete-held-condition-record-with-structural-EmptyOne"),("magnitude-law","exact-positive-postseal-rate-support-without-imported-rate-law")]
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
 [instruction "table" "complete-elementary-rate-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-elementary-rate-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "forward_forcing_with_prefetch_value_free_identity_seal"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("complete_raw_sources",.array (sourceFiles.map fun (p,h)=>.array [.text p,.text h])),("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_reaction_state_condition_method_expression_temperature_rate_value_and_target_hash_values_absent",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-declared-elementary-transition-rate-vector"
def dimensions : List (String × List (String × Bool)) := [("carrier",[("detached-rate-number-or-continuum-field",false),("complete-registered-elementary-transition-carrier",true)]),("state",[("endpoint-erased-or-identity-change",false),("distinct-held-initial-and-terminal-molecular-states",true)]),("event",[("continuous-change-primitive-or-uncounted-event",false),("positive-completed-transition-count",true)]),("recurrence",[("clock-free-or-continuum-time-derivative",false),("positive-reference-tick-count",true)]),("boundary",[("condition-or-observation-support-erased",false),("complete-condition-and-positive-observation-support",true)]),("magnitude",[("imported-mass-action-order-arrhenius-fit-or-logarithm",false),("exact-transition-count-per-tick-and-observation-support",true)]),("prediction",[("reaction-condition-method-or-value-readable-before-seal",false),("complete-value-free-46-record-identity-seal",true)]),("extension",[("refit-after-event-resource-replication-or-record-append",false),("depth-independent-common-event-tick-replication-and-record-append",true)])]
def snapshotHashes : List String := ["sha256:68562ee063103f727b882119f3e76c100aa4f59d6bee0aec0da96f26b669b3ba", "sha256:68562ee063103f727b882119f3e76c100aa4f59d6bee0aec0da96f26b669b3ba", "sha256:68562ee063103f727b882119f3e76c100aa4f59d6bee0aec0da96f26b669b3ba", "sha256:68562ee063103f727b882119f3e76c100aa4f59d6bee0aec0da96f26b669b3ba", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:6986b45f216c45e26dbbc1532b94d4005946e83dbf5c2cb5e69f3355bf249ccd", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:8318565032c709a5990eaab78ca570d551bca536b931632990eebee279b8c8c6", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec", "sha256:f41bc74df29304de470c805b3d51a753889da9990e6c4f316168048be23b08ec"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if ElementaryTransitionRateEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array ElementaryTransitionRateEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.ElementaryTransitionRateExperiment
