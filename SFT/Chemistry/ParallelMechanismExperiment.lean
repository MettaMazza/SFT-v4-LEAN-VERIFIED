import SFT.Chemistry.ParallelMechanismEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
import SFT.Chemistry.FiniteMicrostateSupportSource
namespace SFT.Chemistry.ParallelMechanismExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-PARALLEL-MECHANISM-COMPOSITION-008"
def experimentId : String := "SFT-EXP-CHEM-PARALLEL-MECHANISM-COMPOSITION-008"
def frozenRelation : String := "complete-registered-parallel-path-support__exact-common-initial-state-boundary__complete-state-edge-word-for-every-path__finite-source-ordered-parallel-path-composition__shared-boundaries-retained-in-every-path-occurrence__all-path-statuses-and-unresolved-records-retained__complete-article-supplement-and-twenty-eight-sheet-cell-ledger__value-free-twenty-eight-sheet-identity-seal-and-depth-independent-path-successor"
def falsification : String := "The claim fails if any registered path, state, edge, shared boundary, terminal occurrence, product, time, replicate, formula, worksheet cell, weak/adverse/unresolved/unassigned record or source file is omitted; if paths do not meet one common source; if an imported stochastic/rate law, fit, average, interpolation, selection or target correction enters; if values open before all twenty-eight identities seal; or if tampering passes."
def identityPath : String := "experiments/external_sources/chemistry/parallel_mechanism_target_identities_v1.json"
def identityHash : String := "sha256:08d42e20f3e4fa66ff46f98d046e160e5a7375b32f7d6d036debddfe3f1b90ca"
def targetPath : String := "experiments/external_sources/chemistry/parallel_mechanism_withheld_targets_v1.json"
def targetHash : String := "sha256:da263dc7147b66565c6737be47f492fb0c585c6048db078b17f643e037c78443"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/parallel-mechanism-primary-records-v1.json"
def primaryHash : String := "sha256:312655c78972e66b2f1bbe544fc005ce4a883fa6f08f43fdda3470f31db46ff0"
def sourceFiles : List (String×String) := [("experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/article.html","sha256:b3e792d3e9720e524850752cf907b8b76e74517207f7a7c8e725ec46dc2a1507"),("experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/article.pdf","sha256:e31b3a1101c73b22b8c2c3d516deeda00e317a39fd848aae07f01353577abfc1"),("experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/supplementary-information.pdf","sha256:9e891d68cebfe6034f265cd99780d91e5d1d916ebf68bae164b3aceb6e005653"),("experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/transparent-peer-review.pdf","sha256:391303943597d91ebede3be6aba6608046831237c3a04f78e2ea2ff3fcddab68"),("experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/source-data.xlsx","sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095")]
def targetIds : List String := ["SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-001", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-002", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-003", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-004", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-005", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-006", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-007", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-008", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-009", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-010", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-011", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-012", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-013", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-014", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-015", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-016", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-017", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-018", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-019", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-020", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-021", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-022", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-023", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-024", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-025", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-026", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-027", "SFT-CHEM-KIN008-COMPLETE-SOURCE-SHEET-028"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "KIN-008 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["complete_rectangular_cells", "source_numeric_inscription", "source_label", "source_formula_inscription", "exact_positive_fraction", "target_payload", "target_payload_hash", "snapshot_hash"]
 if !sameValue (get document "complete_registered_target_count") (.integer 28) ||
  !sameValue (get document "complete_registered_rectangular_cell_position_count") (.integer 18158) ||
  !sameValue (get document "target_values_or_hashes_present") (.boolean false) ||
  !sameValue (get document "all_sheet_cell_label_time_product_concentration_replicate_uncertainty_status_value_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 28 || rows.any (fun row=>forbidden.any (hasKey row)) then
  throw "KIN-008 value-free identity boundary changed"
 let ordinals ← rows.mapM fun row=>field row "source_sheet_ordinal"
 let ids ← rows.mapM fun row=>field row "target_id"
 if !(ordinals.zipIdx.all fun (v,i)=>sameValue v (.integer (i+1))) ||
  (ids.foldl (fun found x=>if found.any (sameValue x) then found else found++[x]) []).length != 28 then
  throw "KIN-008 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("source_id","complete-source-identity"),("article_doi","source-article-identity"),("reaction_surface_identity","registered-reaction-surface"),("measurement_identity","measurement-identity"),("source_sheet_identity","source-sheet-identity"),("source_sheet_ordinal","positive-source-sheet-ordinal"),("declared_max_row","positive-declared-max-row"),("declared_max_column","positive-declared-max-column"),("source_record_class","source-record-class")]
def identityValue (row : Value) (key : String) : Except String String := field row key >>= identityString
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "parallel-mechanism-sheet-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← identityValue row key
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let laws := [("complete-parallel-support-law","all-distinct-complete-path-words-retained-in-source-order"),("common-boundary-law","every-path-meets-one-retained-initial-state-with-shared-occurrences-explicit"),("status-law","all-products-times-replicates-formulas-weak-adverse-unresolved-and-unassigned-records-retained"),("provenance-law","complete-article-supplement-peer-review-and-twenty-eight-sheet-cell-ledger-retained")]
 let lawRows := laws.zipIdx.map fun ((family,label),index) =>
  let destination := Text.intercalate "" [rowPrefix,"-law-",toString (10+index)]
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
 [instruction "table" "complete-parallel-mechanism-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-parallel-mechanism-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "forward_forcing_with_prefetch_and_value_free_twenty_eight_sheet_identity_seal"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("complete_source_records",.array [.array [.text "experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/article.html",.text "sha256:b3e792d3e9720e524850752cf907b8b76e74517207f7a7c8e725ec46dc2a1507"],.array [.text "experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/article.pdf",.text "sha256:e31b3a1101c73b22b8c2c3d516deeda00e317a39fd848aae07f01353577abfc1"],.array [.text "experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/supplementary-information.pdf",.text "sha256:9e891d68cebfe6034f265cd99780d91e5d1d916ebf68bae164b3aceb6e005653"],.array [.text "experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/transparent-peer-review.pdf",.text "sha256:391303943597d91ebede3be6aba6608046831237c3a04f78e2ea2ff3fcddab68"],.array [.text "experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/source-data.xlsx",.text "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095"],.array [.text "experiments/external_sources/chemistry/snapshots/kin-008-parallel-mechanism-v1/source-inventory-v1.json",.text "sha256:a3c79878aeb0383a64d8bcf9242e9865c791c872ac50f59692348b978cead0d0"]]),("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_sheet_cell_label_time_product_concentration_replicate_uncertainty_status_value_and_target_hash_values_absent",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-twenty-eight-sheet-parallel-product-time-vector"
def dimensions : List (String × List (String × Bool)) := [("support",[("selected-dominant-or-favorable-path-subset",false),("complete-registered-parallel-path-support",true)]),("origin",[("unrelated-or-collapsed-initial-boundary",false),("exact-common-initial-state-boundary",true)]),("path",[("endpoint-only-path-summary",false),("complete-state-edge-word-for-every-path",true)]),("composition",[("imported-stochastic-weight-or-parallel-rate-equation",false),("finite-source-ordered-parallel-path-composition",true)]),("sharing",[("shared-prefix-terminal-or-occurrence-collapsed",false),("shared-boundaries-retained-in-every-path-occurrence",true)]),("status",[("weak-adverse-unresolved-or-unassigned-path-omitted",false),("all-path-statuses-and-unresolved-records-retained",true)]),("provenance",[("selected-plot-mean-or-answer-only-product-table",false),("complete-article-supplement-and-twenty-eight-sheet-cell-ledger",true)]),("prediction",[("product-time-value-readable-before-seal-or-corrected-after-release",false),("value-free-twenty-eight-sheet-identity-seal-and-depth-independent-path-successor",true)])]
def snapshotHashes : List String := ["sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095", "sha256:3f6dbcf377f4780aaec4f5a3c1431d4e758a775271d0a6d301bd74aca9087095"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if ParallelMechanismEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array ParallelMechanismEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.ParallelMechanismExperiment
