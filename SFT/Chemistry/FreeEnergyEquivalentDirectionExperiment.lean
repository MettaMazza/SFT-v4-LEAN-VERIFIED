import SFT.Chemistry.FreeEnergyEquivalentDirectionEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.FreeEnergyEquivalentDirectionExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007"
def experimentId : String := "SFT-EXP-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007"
def frozenRelation : String := "complete-forward-and-reverse-path-accounts__exact-positive-retained-energy-requirements__exact-positive-closed-distinction-counts__strict-exact-product-support-order__held-forward-reverse-or-EmptyOne-equilibrium__complete-value-free-reaction-state-identity-seal__complete-64-row-two-direction-crossing-vector__depth-independent-common-account-successor"
def falsification : String := "The claim fails if direction requires a fitted scalar trade-off, imported free-energy equation, sign-valued SFT proof or arbitrary tie-break; if exact equal accounts do not yield structural equilibrium; if common extension changes direction; if any target opens before all 64 identities seal; if any common JANAF row or species column is omitted; if Gibbs and log-K records disagree in direction; if all five reverse, all fifty-nine forward or the 300-to-350 K crossing bracket are not retained; or if targets select the law."
def identityPath : String := "experiments/external_sources/chemistry/reaction_direction_target_identities_v1.json"
def identityHash : String := "sha256:7d877d03ccd120c8ccb9019429427d18f230cdd2cc5b7c9f4abc8e460c6aa730"
def targetPath : String := "experiments/external_sources/chemistry/reaction_direction_withheld_targets_v1.json"
def targetHash : String := "sha256:66c0c9a8e35284531eeddc68c7874eda40788a11eddc5075ce27dff375a609bd"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/thermo-007-reaction-direction-v1/reaction-direction-primary-records-v1.json"
def primaryHash : String := "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7"
def targetIds : List String := ["SFT-CHEM-THERMO-007-NO2-N2O4-0001", "SFT-CHEM-THERMO-007-NO2-N2O4-0002", "SFT-CHEM-THERMO-007-NO2-N2O4-0003", "SFT-CHEM-THERMO-007-NO2-N2O4-0004", "SFT-CHEM-THERMO-007-NO2-N2O4-0005", "SFT-CHEM-THERMO-007-NO2-N2O4-0006", "SFT-CHEM-THERMO-007-NO2-N2O4-0007", "SFT-CHEM-THERMO-007-NO2-N2O4-0008", "SFT-CHEM-THERMO-007-NO2-N2O4-0009", "SFT-CHEM-THERMO-007-NO2-N2O4-0010", "SFT-CHEM-THERMO-007-NO2-N2O4-0011", "SFT-CHEM-THERMO-007-NO2-N2O4-0012", "SFT-CHEM-THERMO-007-NO2-N2O4-0013", "SFT-CHEM-THERMO-007-NO2-N2O4-0014", "SFT-CHEM-THERMO-007-NO2-N2O4-0015", "SFT-CHEM-THERMO-007-NO2-N2O4-0016", "SFT-CHEM-THERMO-007-NO2-N2O4-0017", "SFT-CHEM-THERMO-007-NO2-N2O4-0018", "SFT-CHEM-THERMO-007-NO2-N2O4-0019", "SFT-CHEM-THERMO-007-NO2-N2O4-0020", "SFT-CHEM-THERMO-007-NO2-N2O4-0021", "SFT-CHEM-THERMO-007-NO2-N2O4-0022", "SFT-CHEM-THERMO-007-NO2-N2O4-0023", "SFT-CHEM-THERMO-007-NO2-N2O4-0024", "SFT-CHEM-THERMO-007-NO2-N2O4-0025", "SFT-CHEM-THERMO-007-NO2-N2O4-0026", "SFT-CHEM-THERMO-007-NO2-N2O4-0027", "SFT-CHEM-THERMO-007-NO2-N2O4-0028", "SFT-CHEM-THERMO-007-NO2-N2O4-0029", "SFT-CHEM-THERMO-007-NO2-N2O4-0030", "SFT-CHEM-THERMO-007-NO2-N2O4-0031", "SFT-CHEM-THERMO-007-NO2-N2O4-0032", "SFT-CHEM-THERMO-007-NO2-N2O4-0033", "SFT-CHEM-THERMO-007-NO2-N2O4-0034", "SFT-CHEM-THERMO-007-NO2-N2O4-0035", "SFT-CHEM-THERMO-007-NO2-N2O4-0036", "SFT-CHEM-THERMO-007-NO2-N2O4-0037", "SFT-CHEM-THERMO-007-NO2-N2O4-0038", "SFT-CHEM-THERMO-007-NO2-N2O4-0039", "SFT-CHEM-THERMO-007-NO2-N2O4-0040", "SFT-CHEM-THERMO-007-NO2-N2O4-0041", "SFT-CHEM-THERMO-007-NO2-N2O4-0042", "SFT-CHEM-THERMO-007-NO2-N2O4-0043", "SFT-CHEM-THERMO-007-NO2-N2O4-0044", "SFT-CHEM-THERMO-007-NO2-N2O4-0045", "SFT-CHEM-THERMO-007-NO2-N2O4-0046", "SFT-CHEM-THERMO-007-NO2-N2O4-0047", "SFT-CHEM-THERMO-007-NO2-N2O4-0048", "SFT-CHEM-THERMO-007-NO2-N2O4-0049", "SFT-CHEM-THERMO-007-NO2-N2O4-0050", "SFT-CHEM-THERMO-007-NO2-N2O4-0051", "SFT-CHEM-THERMO-007-NO2-N2O4-0052", "SFT-CHEM-THERMO-007-NO2-N2O4-0053", "SFT-CHEM-THERMO-007-NO2-N2O4-0054", "SFT-CHEM-THERMO-007-NO2-N2O4-0055", "SFT-CHEM-THERMO-007-NO2-N2O4-0056", "SFT-CHEM-THERMO-007-NO2-N2O4-0057", "SFT-CHEM-THERMO-007-NO2-N2O4-0058", "SFT-CHEM-THERMO-007-NO2-N2O4-0059", "SFT-CHEM-THERMO-007-NO2-N2O4-0060", "SFT-CHEM-THERMO-007-NO2-N2O4-0061", "SFT-CHEM-THERMO-007-NO2-N2O4-0062", "SFT-CHEM-THERMO-007-NO2-N2O4-0063", "SFT-CHEM-THERMO-007-NO2-N2O4-0064"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "THERMO-007 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["temperature-kelvin","NO2_complete_row","N2O4_complete_row","reaction-gibbs-kilojoule-per-mole-external-signed-inscription","reaction-gibbs-exact-positive-separation-kilojoule-per-mole","reaction-log10-equilibrium-constant-external-signed-inscription","held-reaction-direction","target_payload","target_payload_hash"]
 if !sameValue (get document "complete_target_count") (.integer 64) ||
  !sameValue (get document "all_temperature_thermochemical_direction_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 64 || rows.any (fun row => forbidden.any (hasKey row)) then
  throw "THERMO-007 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("common_source_row_ordinal","positive-common-row-ordinal"),("reaction_identity","reaction-identity"),("stoichiometric_identity","stoichiometric-identity"),("standard_state_pressure","standard-state-pressure")]
def sourcePairHash (row : Value) : Except String String := do
 let columns ← field row "source_ids" >>= RunningConvergenceMeasurement.array
 pure (identity (.array columns))
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "reaction-direction-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← field row key >>= identityString
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let columns ← sourcePairHash row
 let schemaRegister := Text.append rowPrefix "-source-pair"
 let schemaInstruction := instruction "label" schemaRegister ["paired-source-identity-hash",columns]
 let laws := [("path-law","complete-forward-and-reverse-path-accounts"),("account-law","exact-positive-energy-and-distinction-accounts"),("order-law","strict-exact-product-support-order"),("orientation-law","held-forward-reverse-or-EmptyOne-equilibrium")]
 let lawRows := laws.zipIdx.map fun ((family,label),index) =>
  let destination := Text.intercalate "" [rowPrefix,"-law-",toString (6+index)]
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
 [instruction "table" "complete-reaction-direction-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-reaction-direction-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_temperature_Gibbs_logK_direction_and_target_hash_values_absent_from_prediction",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-free-energy-equivalent-reaction-direction-account"
def dimensions : List (String × List (String × Bool)) := [("paths",[("single-path-or-answer-only-direction",false),("complete-forward-and-reverse-path-accounts",true)]),("energy",[("signed-or-fitted-free-energy-scalar",false),("exact-positive-retained-energy-requirements",true)]),("distinctions",[("entropy-logarithm-or-omitted-distinction-cost",false),("exact-positive-closed-distinction-counts",true)]),("order",[("weighted-sum-or-target-selected-comparison",false),("strict-exact-product-support-order",true)]),("orientation",[("negative-direction-value-or-forced-tie-break",false),("held-forward-reverse-or-EmptyOne-equilibrium",true)]),("prediction",[("Gibbs-logK-or-direction-target-readable-before-seal",false),("complete-value-free-reaction-state-identity-seal",true)]),("record",[("selected-temperature-or-single-direction-showcase",false),("complete-64-row-two-direction-crossing-vector",true)]),("extension",[("refit-order-after-shared-successor",false),("depth-independent-common-account-successor",true)])]
def snapshotHashes : List String := ["sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7", "sha256:3666e32ec5237bac12e5a84265da708301e93b910966f0a11c8f2439eea3edf7"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if FreeEnergyEquivalentDirectionEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array FreeEnergyEquivalentDirectionEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.FreeEnergyEquivalentDirectionExperiment
