import SFT.Chemistry.TemperatureCorrespondenceEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.TemperatureCorrespondenceExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002"
def experimentId : String := "SFT-EXP-CHEM-TEMPERATURE-CORRESPONDENCE-002"
def frozenRelation : String := "chemistry-consumes-admitted-physics-temperature-carrier__held-chemical-composition-identity__held-phase-and-equilibrium-reference__identity-preserving-temperature-correspondence__one-common-carrier-across-equilibrated-routes__complete-value-free-thermometric-identity-seal__complete-three-row-two-route-value-vector__append-only-composition-consequence-with-common-carrier"
def falsification : String := "The claim fails if Chemistry requires a different temperature carrier, composition-dependent scale or route-specific correction; if adding a composition changes the common carrier; if any target value opens before all three identities seal; if the exact SI carrier lies outside either complete measured interval; if argon, gas phase, TPW reference, kinetic-temperature relation, Johnson response, uncertainty endpoint or source limitation is omitted; or if target values select the law."
def identityPath : String := "experiments/external_sources/chemistry/chemical_temperature_target_identities_v1.json"
def identityHash : String := "sha256:ccfce4f71bb3eb8edfc96e2b9b7b6e68e54643c83bce87c6beb98e8b94c907ea"
def targetPath : String := "experiments/external_sources/chemistry/chemical_temperature_withheld_targets_v1.json"
def targetHash : String := "sha256:93819764e02927c5f15ac2b52f58219d4b2429c24621f9f38e017f07c0223d70"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/thermo-002-temperature-correspondence-v1/chemical-temperature-primary-records-v1.json"
def primaryHash : String := "sha256:a20431a2644dbb5c41dd009472fd1c57b597611904739d118c64cbb07caf1bb9"
def physicsPath : String := "experiments/external_sources/physics/snapshots/thermal-equilibrium-postseal-source-record.json"
def physicsHash : String := "sha256:8048a2397c064290a0b948b4238b4133c1a2e5c76a72ecf0c47222c9a951d7b5"
def targetIds : List String := ["SFT-CHEM-THERMO-002-COMMON-CARRIER-0001","SFT-CHEM-THERMO-002-ACOUSTIC-ARGON-0002","SFT-CHEM-THERMO-002-ELECTRONIC-0003"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "THERMO-002 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["exact_si_common_carrier_scaled_numerator","common_scale_denominator",
  "measured_center_scaled_numerator","measured_standard_uncertainty_scaled_numerator",
  "measured_interval_lower_scaled_numerator","measured_interval_upper_scaled_numerator",
  "relative_standard_uncertainty_parts_per_million","relative_combined_uncertainty_parts_per_million",
  "temperature_measures_average_kinetic_energy","noise_power_depends_on_resistance_and_temperature",
  "reported_relation_accuracy_parts_per_million"]
 if !sameValue (get document "schema") (.text "sft-v3-chemical-temperature-identities/1") ||
  !sameValue (get document "complete_target_count") (.integer 3) ||
  !sameValue (get document "complete_physically_distinct_route_count") (.integer 2) ||
  !sameValue (get document "all_values_uncertainties_intervals_and_relation_flags_absent") (.boolean true) ||
  rows.length != 3 || rows.any (fun row => forbidden.any (hasKey row)) then
  throw "THERMO-002 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("source_class","external-record-class"),
 ("source_id","external-source-identity"),("route_identity","thermometric-route"),
 ("chemical_composition_identity","chemical-composition"),("phase_identity","phase-identity"),
 ("equilibrium_reference_identity","thermal-equilibrium-reference")]
def identityValue (row : Value) (key : String) : Value :=
 if hasKey row key then get row key else .text "held-not-applicable-to-common-carrier-definition"
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "chemical-temperature-row-" (toString ordinal)
 let target ← field row "target_id" >>= identityString
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← identityString (identityValue row key)
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let laws := [("authority-law","chemistry-consumes-admitted-physics-temperature-carrier"),
  ("correspondence-law","identity-preserving-temperature-correspondence"),
  ("equilibrium-law","one-common-carrier-across-equilibrated-routes")]
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
 [instruction "table" "complete-chemical-temperature-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-chemical-temperature-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),("physics_source_record",.array [.text physicsPath,.text physicsHash]),
 ("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_values_uncertainties_intervals_and_relation_flags_absent_from_prediction",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "one-unchanged-physics-temperature-carrier-across-held-chemical-compositions-and-equilibrated-routes"
def dimensions : List (String × List (String × Bool)) := [("authority",[("chemistry-redefines-temperature",false),("chemistry-consumes-admitted-physics-temperature-carrier",true)]),("composition",[("composition-erased-temperature-scalar",false),("held-chemical-composition-identity",true)]),("condition",[("phase-and-equilibrium-reference-erased",false),("held-phase-and-equilibrium-reference",true)]),("relation",[("fitted-chemical-temperature-conversion",false),("identity-preserving-temperature-correspondence",true)]),("equilibrium",[("route-or-composition-specific-temperature",false),("one-common-carrier-across-equilibrated-routes",true)]),("prediction",[("thermometric-values-readable-before-seal",false),("complete-value-free-thermometric-identity-seal",true)]),("record",[("selected-thermometry-route",false),("complete-three-row-two-route-value-vector",true)]),("extension",[("composition-dependent-rescaling",false),("append-only-composition-consequence-with-common-carrier",true)])]
def snapshotHashes : List String := ["sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67","sha256:1cbb21f0e5817270b5e028105aa79fea22017fd84130c2c4b79d1492fb37e418","sha256:187066b5390d57a3c058e0a34f6c7803a659045ba714ca4b25eed7b84b212bbb"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if TemperatureCorrespondenceEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array TemperatureCorrespondenceEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.TemperatureCorrespondenceExperiment
