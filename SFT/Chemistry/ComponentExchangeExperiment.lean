import SFT.Chemistry.ComponentExchangeEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.ComponentExchangeExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-CHEMICAL-POTENTIAL-EQUIVALENT-COMPONENT-008"
def experimentId : String := "SFT-EXP-CHEM-CHEMICAL-POTENTIAL-EQUIVALENT-COMPONENT-008"
def frozenRelation : String := "complete-distinct-phase-component-addition-accounts__same-held-component-and-fixed-environment__paired-one-component-exchange-conserving-total-carrier__exact-positive-energy-and-closed-distinction-increments__strict-product-order-with-EmptyOne-equilibrium__complete-value-free-74-row-identity-seal__complete-four-system-74-row-VLE-vector-with-eight-endpoints__depth-independent-common-context-successor"
def falsification : String := "The claim fails if a component changes identity during exchange; if donor and receiver do not share one finite environment; if total component carrier is not conserved; if direction requires a signed scalar, logarithm, fitted activity coefficient or arbitrary tie-break; if equal complete accounts do not yield equilibrium or are incorrectly required to have equal bulk compositions; if a common context changes the relation; if any target opens before all 74 identities seal; if any of four systems, 74 matched interiors, eight unmatched endpoints, source conditions or uncertainties is omitted; or if measured values select the law."
def identityPath : String := "experiments/external_sources/chemistry/component_exchange_target_identities_v1.json"
def identityHash : String := "sha256:8fb540f04200401d83abd4b24ffdb62b916947e4217d2555dbde1987a37954af"
def targetPath : String := "experiments/external_sources/chemistry/component_exchange_withheld_targets_v1.json"
def targetHash : String := "sha256:5299ca7bcc6e4d16a84321422fd170ef3f471a23acc4033873c26bfb8bc5f789"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/thermo-008-component-exchange-v1/component-exchange-primary-records-v1.json"
def primaryHash : String := "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f"
def rawPath : String := "experiments/external_sources/chemistry/snapshots/thermo-008-component-exchange-v1/nist-trc-thermoml-jced-2019-9b00414.json"
def rawHash : String := "sha256:8bf7ce04c1a08434807489d29a9d6a0c366200b042c08d8ba6edfd61f25c675b"
def targetIds : List String := ["SFT-CHEM-THERMO-008-VLE-0001", "SFT-CHEM-THERMO-008-VLE-0002", "SFT-CHEM-THERMO-008-VLE-0003", "SFT-CHEM-THERMO-008-VLE-0004", "SFT-CHEM-THERMO-008-VLE-0005", "SFT-CHEM-THERMO-008-VLE-0006", "SFT-CHEM-THERMO-008-VLE-0007", "SFT-CHEM-THERMO-008-VLE-0008", "SFT-CHEM-THERMO-008-VLE-0009", "SFT-CHEM-THERMO-008-VLE-0010", "SFT-CHEM-THERMO-008-VLE-0011", "SFT-CHEM-THERMO-008-VLE-0012", "SFT-CHEM-THERMO-008-VLE-0013", "SFT-CHEM-THERMO-008-VLE-0014", "SFT-CHEM-THERMO-008-VLE-0015", "SFT-CHEM-THERMO-008-VLE-0016", "SFT-CHEM-THERMO-008-VLE-0017", "SFT-CHEM-THERMO-008-VLE-0018", "SFT-CHEM-THERMO-008-VLE-0019", "SFT-CHEM-THERMO-008-VLE-0020", "SFT-CHEM-THERMO-008-VLE-0021", "SFT-CHEM-THERMO-008-VLE-0022", "SFT-CHEM-THERMO-008-VLE-0023", "SFT-CHEM-THERMO-008-VLE-0024", "SFT-CHEM-THERMO-008-VLE-0025", "SFT-CHEM-THERMO-008-VLE-0026", "SFT-CHEM-THERMO-008-VLE-0027", "SFT-CHEM-THERMO-008-VLE-0028", "SFT-CHEM-THERMO-008-VLE-0029", "SFT-CHEM-THERMO-008-VLE-0030", "SFT-CHEM-THERMO-008-VLE-0031", "SFT-CHEM-THERMO-008-VLE-0032", "SFT-CHEM-THERMO-008-VLE-0033", "SFT-CHEM-THERMO-008-VLE-0034", "SFT-CHEM-THERMO-008-VLE-0035", "SFT-CHEM-THERMO-008-VLE-0036", "SFT-CHEM-THERMO-008-VLE-0037", "SFT-CHEM-THERMO-008-VLE-0038", "SFT-CHEM-THERMO-008-VLE-0039", "SFT-CHEM-THERMO-008-VLE-0040", "SFT-CHEM-THERMO-008-VLE-0041", "SFT-CHEM-THERMO-008-VLE-0042", "SFT-CHEM-THERMO-008-VLE-0043", "SFT-CHEM-THERMO-008-VLE-0044", "SFT-CHEM-THERMO-008-VLE-0045", "SFT-CHEM-THERMO-008-VLE-0046", "SFT-CHEM-THERMO-008-VLE-0047", "SFT-CHEM-THERMO-008-VLE-0048", "SFT-CHEM-THERMO-008-VLE-0049", "SFT-CHEM-THERMO-008-VLE-0050", "SFT-CHEM-THERMO-008-VLE-0051", "SFT-CHEM-THERMO-008-VLE-0052", "SFT-CHEM-THERMO-008-VLE-0053", "SFT-CHEM-THERMO-008-VLE-0054", "SFT-CHEM-THERMO-008-VLE-0055", "SFT-CHEM-THERMO-008-VLE-0056", "SFT-CHEM-THERMO-008-VLE-0057", "SFT-CHEM-THERMO-008-VLE-0058", "SFT-CHEM-THERMO-008-VLE-0059", "SFT-CHEM-THERMO-008-VLE-0060", "SFT-CHEM-THERMO-008-VLE-0061", "SFT-CHEM-THERMO-008-VLE-0062", "SFT-CHEM-THERMO-008-VLE-0063", "SFT-CHEM-THERMO-008-VLE-0064", "SFT-CHEM-THERMO-008-VLE-0065", "SFT-CHEM-THERMO-008-VLE-0066", "SFT-CHEM-THERMO-008-VLE-0067", "SFT-CHEM-THERMO-008-VLE-0068", "SFT-CHEM-THERMO-008-VLE-0069", "SFT-CHEM-THERMO-008-VLE-0070", "SFT-CHEM-THERMO-008-VLE-0071", "SFT-CHEM-THERMO-008-VLE-0072", "SFT-CHEM-THERMO-008-VLE-0073", "SFT-CHEM-THERMO-008-VLE-0074"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "THERMO-008 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["ordered_component_orgnums","complete_component_records","variable_component_orgnum","complementary_component_orgnum","pressure_kPa_external_inscription","temperature_K_external_inscription","liquid_variable_component_part_external_inscription","gas_variable_component_part_external_inscription","external_phase_classification","target_payload","target_payload_hash"]
 if !sameValue (get document "complete_target_count") (.integer 74) ||
  !sameValue (get document "all_compound_temperature_pressure_composition_equilibrium_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 74 || rows.any (fun row => forbidden.any (hasKey row)) then
  throw "THERMO-008 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("doi","source-doi"),("source_id","complete-source-identity"),("system_ordinal","positive-system-ordinal"),("temperature_dataset_ordinal","temperature-dataset-ordinal"),("composition_dataset_ordinal","composition-dataset-ordinal"),("common_interior_point_ordinal","positive-common-point-ordinal")]
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "component-exchange-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← field row key >>= identityString
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let laws := [("component-law","same-held-component-across-distinct-phases"),("environment-law","one-fixed-finite-environment"),("marginal-law","exact-positive-energy-and-distinction-addition-account"),("relation-law","strict-product-order-with-EmptyOne-equilibrium")]
 let lawRows := laws.zipIdx.map fun ((family,label),index) =>
  let destination := Text.intercalate "" [rowPrefix,"-law-",toString (7+index)]
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
 [instruction "table" "complete-component-exchange-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-component-exchange-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("raw_source",.array [.text rawPath,.text rawHash]),("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_compound_temperature_pressure_composition_equilibrium_and_target_hash_values_absent",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-chemical-potential-equivalent-component-exchange-account"
def dimensions : List (String × List (String × Bool)) := [("accounts",[("bulk-phase-value-or-answer-only-potential",false),("complete-distinct-phase-component-addition-accounts",true)]),("identity",[("changed-component-or-unheld-environment",false),("same-held-component-and-fixed-environment",true)]),("exchange",[("created-erased-or-unpaired-component",false),("paired-one-component-exchange-conserving-total-carrier",true)]),("support",[("signed-logarithmic-or-fitted-chemical-potential",false),("exact-positive-energy-and-closed-distinction-increments",true)]),("relation",[("weighted-sum-tie-break-or-equal-composition-rule",false),("strict-product-order-with-EmptyOne-equilibrium",true)]),("prediction",[("compound-condition-or-composition-readable-before-seal",false),("complete-value-free-74-row-identity-seal",true)]),("record",[("selected-mixture-row-or-deleted-endpoint",false),("complete-four-system-74-row-VLE-vector-with-eight-endpoints",true)]),("extension",[("refit-after-common-context-successor",false),("depth-independent-common-context-successor",true)])]
def snapshotHashes : List String := ["sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f", "sha256:006956947701247b87e566e762c4e3e0286df79e25137d7ed1daacbc9faa158f"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if ComponentExchangeEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array ComponentExchangeEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.ComponentExchangeExperiment
