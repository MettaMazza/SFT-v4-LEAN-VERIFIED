import SFT.Chemistry.SequentialMechanismEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
import SFT.Chemistry.FiniteMicrostateSupportSource
namespace SFT.Chemistry.SequentialMechanismExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007"
def experimentId : String := "SFT-EXP-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007"
def frozenRelation : String := "complete-source-ordered-state-and-transition-support__exact-entry-exit-boundary-matching-for-every-edge__every-intermediate-occurrence-retained-explicitly__finite-exact-ordered-edge-composition__held-state-and-transition-condition-boundaries__favorable-adverse-unresolved-and-parallel-status-retained__complete-article-supplement-PDB-raw-custody-and-control-record__value-free-seventeen-record-identity-seal-and-depth-independent-successor"
def falsification : String := "The claim fails if any state, elementary edge, intermediate, condition, PDB record, power column, late record, favorable control, adverse contamination record or unresolved disclosure is omitted; if adjacent edge boundaries fail; if an imported evolution law, fit, interpolation, steady state or target correction enters; if experimental and calculated records mix; if targets open before all seventeen identities seal; or if tampering passes."
def identityPath : String := "experiments/external_sources/chemistry/sequential_mechanism_target_identities_v1.json"
def identityHash : String := "sha256:0022b0988832e714876f66ad53c6dc5d4f5324866be0ebfdc59f98e14dae5872"
def targetPath : String := "experiments/external_sources/chemistry/sequential_mechanism_withheld_targets_v1.json"
def targetHash : String := "sha256:9b3e5d1319daf7571d7f95c839c17cc44d03e7663c82f0a404aa564e44d24e33"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/sequential-mechanism-primary-records-v1.json"
def primaryHash : String := "sha256:66bca327c4ef641d83b160a29692cc8bb60dfbcb0f3dcf88930c1ef013f90211"
def sourceFiles : List (String×String) := [("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/PMC11217357-full-text.xml","sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/PMC11217357-supplementary-files.zip","sha256:b8c96995e08632587a626e02b3cdcc92e3b71121307b2daa77a3b4e92caad044"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/cxidb-221-custody-record-v1.json","sha256:424dcf3f9b642a7b573e2be5339ac1c7e139fc0d32f01cf6b95e07bafb82362a"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig1_HTML.jpg","sha256:23bc5a4a4d34ba9d275c456234ceb29b39df24db1c8ebf9e6f0a09cb518c78e6"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig3_HTML.jpg","sha256:e4b91693b462f379d1063c85c4fed04736268dd0c34e8dfb3fea20075794e2e6"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig2_HTML.jpg","sha256:2ecb72814c74789e2584a4f29973cdd627e5973cac4937a905a43bb190089733"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig5_HTML.gif","sha256:1e825f9b1a8212018e95964adba34ef1283e91694d0ebdd470db4d668fa5ac06"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM2_ESM.pdf","sha256:b80cb46f0c0a900802214007a24dd82f628064de304355d2098a74351c364b58"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig4_HTML.jpg","sha256:fc0900b4b4455dc3c47cac5f57e6c589417426bd959ec6e01c31d36b4736f822"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig2_HTML.gif","sha256:10eb2970a4a41b14765fff001b4c14240885625abc1623c07bbe99fa0e0ab7bb"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig1_HTML.gif","sha256:1749c8e294b33d40123bee7e9a87916187205c0886221daffbeca2437129acc5"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig4_HTML.gif","sha256:5f203bdf53f6e550f41b38ad0bd9ca8dd93cbe210842820a53dc68e4ae274c30"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM1_ESM.pdf","sha256:6f642e499fe03dab216c751a716b7e11bc27eea7e12eba4d676f043eb902983d"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig3_HTML.gif","sha256:1b833d4e5f158e7dd6b4c53b0598ce9e539227c78db991e9872c1de08cd4e56e"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig5_HTML.jpg","sha256:95b4dcf7e161c56c0d89625fc5fb69bc583a2b868bc013c9abb2d915c2eaa428"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM3_ESM.pdf","sha256:dbb273705d7d1398da47316240c3367cb2af13532742067498902901094a6311"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM2_ESM.txt","sha256:77fbfba5b3000ff01880af8608b954d026dd70f31cfe8035fcf4297e5e26e6eb"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM1_ESM.txt","sha256:7d8684858eb86c2f7e72796d0022e1673d8c63d34762cb6786a3822d0c34ebb7"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM3_ESM.txt","sha256:a64eadbb3e83cdb6b7f51f23a4c8b6daea2d2b3555f46f1dfa21dfb018195563"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZF.cif","sha256:ae6306d3e302241ed78b10cba639c5a683256ac3155b5626d253c435f74d3476"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZF-rcsb-entry.json","sha256:e3745d85368887172b08f4c196947813676a42cce48ae1e457a00749fb744eaf"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZG.cif","sha256:83cd933f99b434f38887fbbbc36066a89a6e9ee0942cb7fc412eac7439e754f8"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZG-rcsb-entry.json","sha256:05ac670bffa2db1da606a4347304a209223d65c74dd7d91a5cc80d51f4ad7e7f"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZR.cif","sha256:08ab45983087f5f302fda405a5e31a9d1e8f68f28c5dd2e9a61139f2e6afc5d6"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZR-rcsb-entry.json","sha256:97983e4f11fe64c82a9b1263b6d2908764f04272d38580c4114ef5c74ff8e1a8"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZT.cif","sha256:af553f286cf2372b8b57309e5f87aa9987d76ad6780faed3d232d2844eb4deb7"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZT-rcsb-entry.json","sha256:274d7bc7f5a34e0275b8f7f9fa87864e025b9f65faca4474f09f22dacbc18be6"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZV.cif","sha256:d44fde0511cfa38b23777ebfd5f04decc27a011da3e58b9cc5039ab4ab8f2769"),("experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZV-rcsb-entry.json","sha256:6097f6f451bf234a9388d048b7470a964255fc91fa75b68a8ed12549bc176cc7")]
def targetIds : List String := ["KIN-007-SEQUENTIAL-RECORD-01", "KIN-007-SEQUENTIAL-RECORD-02", "KIN-007-SEQUENTIAL-RECORD-03", "KIN-007-SEQUENTIAL-RECORD-04", "KIN-007-SEQUENTIAL-RECORD-05", "KIN-007-SEQUENTIAL-RECORD-06", "KIN-007-SEQUENTIAL-RECORD-07", "KIN-007-SEQUENTIAL-RECORD-08", "KIN-007-SEQUENTIAL-RECORD-09", "KIN-007-SEQUENTIAL-RECORD-10", "KIN-007-SEQUENTIAL-RECORD-11", "KIN-007-SEQUENTIAL-RECORD-12", "KIN-007-SEQUENTIAL-RECORD-13", "KIN-007-SEQUENTIAL-RECORD-14", "KIN-007-SEQUENTIAL-RECORD-15", "KIN-007-SEQUENTIAL-RECORD-16", "KIN-007-SEQUENTIAL-RECORD-17"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "KIN-007 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["source_condition_external_inscription", "elapsed_second_exact_fraction", "delay_external_inscription", "power_external_inscription", "power_joule_exact_fraction", "resolution_angstrom_exact_fraction", "XTX_component_exact_atom_counts", "XTX_component_exact_occupancy", "experimentally_retained_state_identity", "measured_difference_density_features", "observed_state", "assignment_status", "observed_adverse_result", "source_disclosure", "target_payload", "target_payload_hash", "snapshot_hash"]
 if !sameValue (get document "complete_registered_target_count") (.integer 17) ||
  !sameValue (get document "target_values_or_hashes_present") (.boolean false) ||
  !sameValue (get document "all_time_power_coordinate_occupancy_density_resolution_statistic_intermediate_assignment_target_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 17 || rows.any (fun row=>forbidden.any (hasKey row)) then
  throw "KIN-007 value-free identity boundary changed"
 let ordinals ← rows.mapM fun row=>field row "source_row"
 let ids ← rows.mapM fun row=>field row "target_id"
 if !(ordinals.zipIdx.all fun (v,i)=>sameValue v (.integer (i+1))) ||
  (ids.foldl (fun found x=>if found.any (sameValue x) then found else found++[x]) []).length != 17 then
  throw "KIN-007 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("source_id","complete-source-identity"),("article_doi","source-article-identity"),("reaction_identity","registered-reaction-identity"),("measurement_identity","measurement-identity"),("pdb_identity","deposited-model-or-EmptyOne-identity"),("source_record_class","source-record-class"),("source_row","positive-source-row")]
def identityValue (row : Value) (key : String) : Except String String := field row key >>= identityString
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "sequential-mechanism-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← identityValue row key
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let laws := [("complete-mechanism-law","all-distinct-states-edges-and-intermediates-retained-in-order"),("composition-law","exact-adjacent-boundary-composition-without-imported-evolution-equation"),("status-law","conditions-favorable-adverse-unresolved-and-parallel-records-retained"),("provenance-law","complete-article-supplements-PDB-custody-and-control-vector-retained")]
 let lawRows := laws.zipIdx.map fun ((family,label),index) =>
  let destination := Text.intercalate "" [rowPrefix,"-law-",toString (8+index)]
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
 [instruction "table" "complete-sequential-mechanism-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-sequential-mechanism-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "forward_forcing_with_prefetch_and_value_free_seventeen_record_identity_seals"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("complete_article_snapshot",.array [.text "experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/PMC11217357-full-text.xml",.text "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952"]),("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_time_power_coordinate_occupancy_density_resolution_statistic_intermediate_assignment_target_and_target_hash_values_absent",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-time-resolved-intermediate-and-control-vector"
def dimensions : List (String × List (String × Bool)) := [("support",[("endpoint-only-or-selected-snapshot-support",false),("complete-source-ordered-state-and-transition-support",true)]),("adjacency",[("aggregate-start-to-finish-jump",false),("exact-entry-exit-boundary-matching-for-every-edge",true)]),("intermediate",[("implicit-eliminated-or-fitted-intermediate",false),("every-intermediate-occurrence-retained-explicitly",true)]),("composition",[("imported-differential-exponential-or-lifetime-law",false),("finite-exact-ordered-edge-composition",true)]),("condition",[("condition-time-or-dose-collapsed",false),("held-state-and-transition-condition-boundaries",true)]),("status",[("adverse-unresolved-or-parallel-record-omitted",false),("favorable-adverse-unresolved-and-parallel-status-retained",true)]),("provenance",[("structure-answer-without-source-custody",false),("complete-article-supplement-PDB-raw-custody-and-control-record",true)]),("prediction",[("time-coordinate-occupancy-or-target-readable-before-seal",false),("value-free-seventeen-record-identity-seal-and-depth-independent-successor",true)])]
def snapshotHashes : List String := ["sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952", "sha256:214ac0642f5f59ed2e8a6e8944e957715facbec55d824a6c22f688767ec11952"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if SequentialMechanismEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array SequentialMechanismEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.SequentialMechanismExperiment
