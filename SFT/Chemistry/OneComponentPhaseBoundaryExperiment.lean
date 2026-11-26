import SFT.Chemistry.OneComponentPhaseBoundaryEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
import SFT.Chemistry.TemperatureCorrespondenceSource
namespace SFT.Chemistry.OneComponentPhaseBoundaryExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-ONE-COMPONENT-PHASE-BOUNDARY-012"
def experimentId : String := "SFT-EXP-CHEM-ONE-COMPONENT-PHASE-BOUNDARY-012"
def frozenRelation : String := "complete-one-component-two-phase-point__two-distinct-held-coexisting-phases__exact-component-exchange-support-balance__one-independent-held-coordinate-support__exact-positive-temperature-pressure-co-order__finite-ordered-coexistence-word__complete-value-free-15-point-identity-seal__depth-independent-append-and-common-replication"
def falsification : String := "The claim fails if a point loses component, phase, temperature, pressure or exchange-support identity; if the phase pair is not distinct or exchange balanced; if one-component two-phase support does not leave one independent carrier; if a later stable liquid-vapor point does not preserve exact temperature-pressure co-order; if any differential equation, equation of state, interpolation, fit, selected compound/interval or target-derived correction enters; if targets open before all fifteen identities seal; if either compound, any of three datasets, fifteen points, twelve adjacent successions, uncertainties, methods or the complete parent source is omitted; or if any measured coordinate is tampered."
def identityPath : String := "experiments/external_sources/chemistry/one_component_phase_boundary_target_identities_v1.json"
def identityHash : String := "sha256:3f37dd294e65daa566d55f8d27d1d891a46d9375666038becd68ae955b884293"
def targetPath : String := "experiments/external_sources/chemistry/one_component_phase_boundary_withheld_targets_v1.json"
def targetHash : String := "sha256:9310be78aa44c9ee932df8ee4afc96835ffce84c76e204893467cef98a61e39b"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/thermo-012-one-component-phase-boundary-v1/one-component-phase-boundary-primary-records-v1.json"
def primaryHash : String := "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017"
def rawPath : String := "experiments/external_sources/chemistry/snapshots/thermo-010-real-gas-equilibrium-v1/nist-trc-thermoml-fpe-2019-485-145-152.json"
def rawHash : String := "sha256:fdaaa9d89f1a324610ae9c5d77b4b129207b6a291e586c3bc3c42c17043724dc"
def targetIds : List String := ["SFT-CHEM-THERMO-012-COEXISTENCE-001", "SFT-CHEM-THERMO-012-COEXISTENCE-002", "SFT-CHEM-THERMO-012-COEXISTENCE-003", "SFT-CHEM-THERMO-012-COEXISTENCE-004", "SFT-CHEM-THERMO-012-COEXISTENCE-005", "SFT-CHEM-THERMO-012-COEXISTENCE-006", "SFT-CHEM-THERMO-012-COEXISTENCE-007", "SFT-CHEM-THERMO-012-COEXISTENCE-008", "SFT-CHEM-THERMO-012-COEXISTENCE-009", "SFT-CHEM-THERMO-012-COEXISTENCE-010", "SFT-CHEM-THERMO-012-COEXISTENCE-011", "SFT-CHEM-THERMO-012-COEXISTENCE-012", "SFT-CHEM-THERMO-012-COEXISTENCE-013", "SFT-CHEM-THERMO-012-COEXISTENCE-014", "SFT-CHEM-THERMO-012-COEXISTENCE-015"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "THERMO-012 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["component_orgnum","complete_component_record","temperature_K_external_inscription","pressure_kPa_external_inscription","phase_boundary_class","pressure_uncertainty","target_payload","target_payload_hash"]
 if !sameValue (get document "complete_target_count") (.integer 15) ||
  !sameValue (get document "all_compound_temperature_pressure_phase_uncertainty_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 15 || rows.any (fun row => forbidden.any (hasKey row)) then
  throw "THERMO-012 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("doi","source-doi"),("source_id","complete-source-identity"),("dataset_ordinal","dataset-ordinal"),("source_point_ordinal","positive-source-point-ordinal")]
def successionLabel (row : Value) : Except String String := do
 let point ← field row "source_point_ordinal" >>= TemperatureCorrespondenceSource.integer
 pure (if @decide (point=1) (Int.decEq _ _) then "least-coexistence-point" else "exact-ordered-coexistence-successor")
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "one-component-boundary-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← field row key >>= identityString
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let succession ← successionLabel row
 let laws := [("exchange-law","exact-component-exchange-support-balance"),("degree-law","one-independent-held-coordinate-support"),("boundary-law",succession),("record-law","complete-held-temperature-pressure-point")]
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
 [instruction "table" "complete-one-component-boundary-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-one-component-boundary-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation_reusing_prior_byte_sealed_authority"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("parent_raw_source",.array [.text rawPath,.text rawHash]),("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_compound_temperature_pressure_phase_uncertainty_and_target_hash_values_absent",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-one-component-finite-coexistence-boundary"
def dimensions : List (String × List (String × Bool)) := [("carrier",[("unbound-temperature-pressure-pair",false),("complete-one-component-two-phase-point",true)]),("phase",[("single-phase-state-or-erased-phase-pair",false),("two-distinct-held-coexisting-phases",true)]),("balance",[("assumed-equilibrium-or-target-derived-equality",false),("exact-component-exchange-support-balance",true)]),("degree",[("free-two-coordinate-continuum",false),("one-independent-held-coordinate-support",true)]),("response",[("imported-differential-equation-or-fitted-slope",false),("exact-positive-temperature-pressure-co-order",true)]),("boundary",[("interpolated-continuum-curve",false),("finite-ordered-coexistence-word",true)]),("prediction",[("coexistence-values-readable-before-seal",false),("complete-value-free-15-point-identity-seal",true)]),("extension",[("refit-after-appending-or-replication",false),("depth-independent-append-and-common-replication",true)])]
def snapshotHashes : List String := ["sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017", "sha256:33789b36e4fc91ade528aba22b9d9b27bc666fd74e6b82be65a0ea451381b017"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if OneComponentPhaseBoundaryEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array OneComponentPhaseBoundaryEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.OneComponentPhaseBoundaryExperiment
