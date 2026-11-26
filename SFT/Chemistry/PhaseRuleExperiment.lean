import SFT.Chemistry.PhaseRuleEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
import SFT.Chemistry.TemperatureCorrespondenceSource
namespace SFT.Chemistry.PhaseRuleExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-PHASE-RULE-STRUCTURAL-011"
def experimentId : String := "SFT-EXP-CHEM-PHASE-RULE-STRUCTURAL-011"
def frozenRelation : String := "complete-component-phase-coordinate-account__complete-held-independent-component-support__one-exact-coordinate-cancellation-per-coexisting-phase__two-held-environment-coordinate-carriers__exact-carrier-cancellation-relation__structural-EmptyOne-invariant-state__complete-value-free-18-row-identity-seal__depth-independent-joint-component-phase-successor"
def falsification : String := "The claim fails if any component, phase or held environmental carrier is erased; if a phase does not cancel exactly one available carrier; if complete cancellation becomes numerical zero; if an imported phase-rule equation, subtraction, signed count, continuum coordinate, selected diagram or target-derived correction enters; if the joint component/phase successor changes degree support; if any target opens before all 18 identities seal; if any of 18 rows, 14 positive outcomes, four EmptyOne boundaries, full IUPAC term or complete 32-page NIST source is omitted; or if a target degree outcome is tampered."
def identityPath : String := "experiments/external_sources/chemistry/phase_rule_target_identities_v2.json"
def identityHash : String := "sha256:371bbbdfc44c2564fbe3e70534e2fa8cd04efe61fcf1bdf2a3d37e53990a224b"
def targetPath : String := "experiments/external_sources/chemistry/phase_rule_withheld_targets_v2.json"
def targetHash : String := "sha256:512a909e7f7e2b72b15830cf688eadcd73ea5b63ae3418d85d0bd908ebd8774c"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/thermo-011-phase-rule-v2/phase-rule-primary-records-v1.json"
def primaryHash : String := "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6"
def iupacPath : String := "experiments/external_sources/chemistry/snapshots/thermo-011-phase-rule-v2/iupac-goldbook-P04533-phase-rule.html"
def iupacHash : String := "sha256:49cb8a30304e143e190be51be1a9fcd9045e0581718d0da2bc1ebcdd73152477"
def nistPath : String := "experiments/external_sources/chemistry/snapshots/thermo-011-phase-rule-v2/nist-general-discussion-glossary-phase-diagrams.pdf"
def nistHash : String := "sha256:8572fe338cf9256c9510d89cfc0d62b16d272575d69d89e6584e39cb629fc5f6"
def nistTextPath : String := "experiments/external_sources/chemistry/snapshots/thermo-011-phase-rule-v2/nist-phase-diagram-glossary-extracted-pages-v1.json"
def nistTextHash : String := "sha256:f9bf7385989e3434d93e0825ce4b80e4eeae0d1965c5708948fccf85f18b708d"
def targetIds : List String := ["SFT-CHEM-THERMO-011-PHASE-RULE-001", "SFT-CHEM-THERMO-011-PHASE-RULE-002", "SFT-CHEM-THERMO-011-PHASE-RULE-003", "SFT-CHEM-THERMO-011-PHASE-RULE-004", "SFT-CHEM-THERMO-011-PHASE-RULE-005", "SFT-CHEM-THERMO-011-PHASE-RULE-006", "SFT-CHEM-THERMO-011-PHASE-RULE-007", "SFT-CHEM-THERMO-011-PHASE-RULE-008", "SFT-CHEM-THERMO-011-PHASE-RULE-009", "SFT-CHEM-THERMO-011-PHASE-RULE-010", "SFT-CHEM-THERMO-011-PHASE-RULE-011", "SFT-CHEM-THERMO-011-PHASE-RULE-012", "SFT-CHEM-THERMO-011-PHASE-RULE-013", "SFT-CHEM-THERMO-011-PHASE-RULE-014", "SFT-CHEM-THERMO-011-PHASE-RULE-015", "SFT-CHEM-THERMO-011-PHASE-RULE-016", "SFT-CHEM-THERMO-011-PHASE-RULE-017", "SFT-CHEM-THERMO-011-PHASE-RULE-018"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "THERMO-011 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["degree_support_external_inscription","sft_degree_support_state","external_relation_record","iupac_definition_fragments","target_payload","target_payload_hash"]
 if !sameValue (get document "complete_target_count") (.integer 18) ||
  !sameValue (get document "all_degree_support_outcome_source_fragment_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 18 || rows.any (fun row => forbidden.any (hasKey row)) then
  throw "THERMO-011 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("iupac_source_id","iupac-source"),("nist_source_id","nist-source")]
-- The validator's _account has the original constructor guards, without the law witness's host-count precheck.
def validationAccount (components phases : Int) : Except String PhaseRule.PhaseRuleAccount := do
 let cs ← (List.range components.toNat).mapM fun i => PhaseRule.componentLabel (i+1)
 let ps ← (List.range phases.toNat).mapM fun i => PhaseRule.phaseLabel (i+1)
 PhaseRule.makeAccount (cs.map MolecularFormationEnergy.LabelInput.held)
  (ps.map MolecularFormationEnergy.LabelInput.held) (PhaseRule.environment.map MolecularFormationEnergy.LabelInput.held)
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "phase-rule-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let components ← field row "component_count_identity" >>= TemperatureCorrespondenceSource.integer
 let phases ← field row "phase_count_identity" >>= TemperatureCorrespondenceSource.integer
 let account ← validationAccount components phases
 let support ← PhaseRule.independentDegreeSupport (.account account)
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← field row key >>= identityString
  let destination := Text.intercalate "" [rowPrefix,"-source-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let counted ← [("component-count",components),("phase-count",phases)].mapM fun (name,value) => do
  let destination := Text.intercalate "" [rowPrefix,"-",name]
  let inscription ← identityString (.integer value)
  pure (instruction "count" destination [inscription],destination)
 let degreeDestination := Text.append rowPrefix "-degree-support"
 let degree := match support with
  | .emptyOne => instruction "empty_one" degreeDestination ["structural-empty-One"]
  | .positive _ count => instruction "count" degreeDestination [toString count.value]
 let laws := [("phase-rule-law","one-carrier-cancelled-per-coexisting-phase"),("record-law","complete-component-phase-environment-account-retained")]
 let lawRows := laws.zipIdx.map fun ((family,label),index) =>
  let destination := Text.intercalate "" [rowPrefix,"-law-",toString (6+index)]
  (instruction "label" destination [family,label],destination)
 let registers := ["premise"] ++ labeled.map Prod.snd ++ counted.map Prod.snd ++ [degreeDestination] ++ lawRows.map Prod.snd
 pure ([instruction "label" (Text.append rowPrefix "-target") ["target-id",target]] ++ labeled.map Prod.fst ++
  counted.map Prod.fst ++ [degree] ++ lawRows.map Prod.fst ++ [instruction "word" (Text.append rowPrefix "-word") registers],
  [Text.append rowPrefix "-target",Text.append rowPrefix "-word"])
def predictionProgramDocument (identityBytes : ByteArray) (document : Value) : Except String Value := do
 let rows ← identities identityBytes document
 let parts ← rows.zipIdx.mapM fun (row,index) => rowInstructions row (index+1)
 pure (.object [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text (Text.append experimentId "-value-free-complete-vector")),
 ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++ parts.flatMap Prod.fst ++
 [instruction "table" "complete-phase-rule-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-phase-rule-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("iupac_source",.array [.text iupacPath,.text iupacHash]),("nist_source",.array [.text nistPath,.text nistHash]),("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_degree_support_outcome_source_fragment_and_target_hash_values_absent",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-component-phase-degree-support-correspondence"
def dimensions : List (String × List (String × Bool)) := [("carrier",[("unbound-degree-number",false),("complete-component-phase-coordinate-account",true)]),("components",[("bulk-substance-with-erased-independent-components",false),("complete-held-independent-component-support",true)]),("phases",[("phase-label-without-coexistence-constraint",false),("one-exact-coordinate-cancellation-per-coexisting-phase",true)]),("environment",[("free-or-continuum-intensive-coordinate-space",false),("two-held-environment-coordinate-carriers",true)]),("relation",[("imported-subtractive-phase-rule-equation",false),("exact-carrier-cancellation-relation",true)]),("absence",[("numerical-zero-degree-count",false),("structural-EmptyOne-invariant-state",true)]),("observation",[("degree-outcome-readable-before-seal",false),("complete-value-free-18-row-identity-seal",true)]),("extension",[("recalculate-with-free-exception",false),("depth-independent-joint-component-phase-successor",true)])]
def snapshotHashes : List String := ["sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6", "sha256:a679c64cba292806c4eed580f763c16f092c115b6952fd83809eba1f814f2bf6"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if PhaseRuleEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array PhaseRuleEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.PhaseRuleExperiment
