import SFT.Chemistry.TransitionBoundaryEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
import SFT.Chemistry.FiniteMicrostateSupportSource
namespace SFT.Chemistry.TransitionBoundaryExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-TRANSITION-STATE-EQUIVALENT-BOUNDARY-005"
def experimentId : String := "SFT-EXP-CHEM-TRANSITION-STATE-EQUIVALENT-BOUNDARY-005"
def frozenRelation : String := "finite-generated-path-boundary-carrier__held-reaction-path-and-isotopologue-identities__unique-greatest-exact-positive-path-support__complete-entry-boundary-exit-partition__positive-magnitude-plus-held-orientation__complete-H2-D2-signature-uncertainty-and-adverse-record__experimental-targets-separated-from-calculated-and-fitted-records__value-free-complete-isotopologue-identity-seal-and-depth-independent-append"
def falsification : String := "The claim fails if the finite boundary is not unique, any generated state or held identity is erased, a signed source inscription becomes a negative SFT number, H2 or D2 is selected away, experimental and calculated provenance are mixed, any article/supplement record is omitted, targets open before both identities seal, or tampering is accepted."
def identityPath : String := "experiments/external_sources/chemistry/transition_boundary_target_identities_v1.json"
def identityHash : String := "sha256:b19fb80b1f280d631741ffa1d4844e547bd05b457b18a8cd350fbc922ad6cfa0"
def targetPath : String := "experiments/external_sources/chemistry/transition_boundary_withheld_targets_v1.json"
def targetHash : String := "sha256:f009c1056a7e91b36c1700c0e0bc80f55f7210c30f68ebadfb9790ee1cb7cf5c"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/transition-boundary-primary-records-v1.json"
def primaryHash : String := "sha256:49d32db171dc7b58496cf844dd322658eda8da613b73dfef5bef4c7b3c166a4f"
def sourceFiles : List (String×String) := [("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/PMC4073644-full-text.xml","sha256:c720f78b391fa130033271136ba5da57802027165fc0fa9180d758b8f22bb345"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/PMC4073644-supplementary-files.zip","sha256:87d04d5ccf5a3f8f3579c188e349308ffd0e743473cd3c39dca56e13a0a747b3"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn500703k_si_001.txt","sha256:10700936f73d5dfb785bf4c154efec5320482bf4e081e4a43a33ae9bd45e023d"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0004.gif","sha256:32f14d96fd6098240b1b0fb98564cd1efe41064f595235c6f29f2467393359e7"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0006.gif","sha256:6bd3931252f1065af039237e3e16662f7e6d03bf54765d7406c09bb9da56bc20"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0003.gif","sha256:44d821a961df38063d86fda0c578344087fbc3ee6d99cf680819c25b52877e68"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn500703k_si_001.pdf","sha256:89aa70668159e758862f8bc656b26237053012b806b0a1dd53634de1efc089f3"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0002.gif","sha256:7442e084bb73b4dba219fcd6c52600c63fff94745f2f503fdfed74274aa5d578"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0001.jpg","sha256:3a090a4cfff65588533a6c37d46a0ee2206d5819c09a20268e3e3bb860dabab3"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0002.jpg","sha256:70b9e2160dfdee825c08920a07c03fdb5706a2f4daf1ebab847e21eb8c0bcf6b"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0005.gif","sha256:cb80911084961904305480189679d1caecd3573294a0b2680e647ab3420fcf44"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0006.jpg","sha256:d8a2641586b17f4ec8931b31cdf044597a41ca0b91013bb788847d796cd91786"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0004.jpg","sha256:0e7f318c17adaf703144894cae3645cce3bf6656b8a7ba4607bd7c2e81349129"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0001.gif","sha256:2b60868be652f26efc2e1c5c486ff82b4ce341125157b28e4f42e2ee586e5b92"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0005.jpg","sha256:19c2a8ceb4be1c38463a0f2d223258214de4c30f1b58ea4331b60cb45b039355"),("experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/nn-2014-00703k_0003.jpg","sha256:257eb218ed8c551f050c1a1ab1658f9abfaeda3acafd89495a19e1a9ddb5d1b0")]
def targetIds : List String := ["KIN-005-H2-EXPERIMENTAL-BOUNDARY-SIGNATURE", "KIN-005-D2-EXPERIMENTAL-BOUNDARY-SIGNATURE"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "KIN-005 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["surface_coverage_external_inscription_ML", "temperature_range_K_external_inscription", "exposure_L_external_inscription", "uptake_temperature_order_signature", "apparent_barrier_external_signed_inscription_eV", "apparent_barrier_external_magnitude_exact_fraction_eV", "apparent_barrier_orientation", "uncertainty_external_inscription_eV", "uncertainty_exact_fraction_eV", "target_payload", "target_payload_hash", "snapshot_hash"]
 let serialized := FiniteMicrostateSupportSource.spacedRender (.array rows)
 if !sameValue (get document "complete_experimental_isotopologue_count") (.integer 2) ||
  !sameValue (get document "all_isotope_barrier_rate_temperature_exposure_uncertainty_caption_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 2 || rows.any (fun row=>forbidden.any (hasKey row)) ||
  ["0.01","0.023","0.045","0.005","75","193"].any (Text.contains serialized) then
  throw "KIN-005 value-free identity boundary changed"
 let isotopes ← rows.mapM fun row=>field row "isotopologue_identity"
 if !(match isotopes with | [a,b]=>sameValue a (.text "H2") && sameValue b (.text "D2") | [] | [_] | _::_::_::_=>false) then
  throw "KIN-005 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("source_id","complete-source-identity"),("article_doi","source-article-identity"),("material_system_identity","material-system-identity"),("experimental_method_identity","experimental-method-identity"),("source_figure_identity","source-figure-identity"),("isotopologue_identity","held-isotopologue-identity"),("exposure_identity","exposure-record-identity")]
def identityValue (row : Value) (key : String) : Except String String := field row key >>= identityString
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "transition-boundary-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← identityValue row key
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let laws := [("boundary-law","finite-generated-path-unique-greatest-support-boundary"),("partition-law","complete-entry-boundary-exit-state-retention"),("orientation-law","positive-magnitude-plus-held-orientation-without-negative-number"),("provenance-law","experimental-targets-separated-from-calculated-and-fitted-disclosures")]
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
 [instruction "table" "complete-transition-boundary-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-transition-boundary-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "forward_forcing_with_prefetch_value_free_identity_seal"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("complete_article_snapshot",.array [.text "experiments/external_sources/chemistry/snapshots/kin-005-transition-boundary-v1/PMC4073644-full-text.xml",.text "sha256:c720f78b391fa130033271136ba5da57802027165fc0fa9180d758b8f22bb345"]),("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_isotope_barrier_rate_temperature_exposure_uncertainty_coverage_and_target_hash_values_absent",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-measured-H2-D2-transition-boundary-signature-vector"
def dimensions : List (String × List (String × Bool)) := [("carrier",[("saddle-point-or-continuum-transition-state-premise",false),("finite-generated-path-boundary-carrier",true)]),("identity",[("isotopologue-or-reaction-identity-collapsed",false),("held-reaction-path-and-isotopologue-identities",true)]),("location",[("arbitrary-named-state-or-fitted-coordinate",false),("unique-greatest-exact-positive-path-support",true)]),("partition",[("endpoint-only-or-boundary-answer-only",false),("complete-entry-boundary-exit-partition",true)]),("orientation",[("signed-or-negative-proof-scalar",false),("positive-magnitude-plus-held-orientation",true)]),("observation",[("single-favorable-isotope-or-barrier-only",false),("complete-H2-D2-signature-uncertainty-and-adverse-record",true)]),("provenance",[("experimental-calculated-fitted-records-mixed",false),("experimental-targets-separated-from-calculated-and-fitted-records",true)]),("prediction",[("conventional-KIE-equation-target-access-or-refit",false),("value-free-complete-isotopologue-identity-seal-and-depth-independent-append",true)])]
def snapshotHashes : List String := ["sha256:c720f78b391fa130033271136ba5da57802027165fc0fa9180d758b8f22bb345", "sha256:c720f78b391fa130033271136ba5da57802027165fc0fa9180d758b8f22bb345"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if TransitionBoundaryEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array TransitionBoundaryEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.TransitionBoundaryExperiment
