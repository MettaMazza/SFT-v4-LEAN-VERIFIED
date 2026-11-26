import SFT.Chemistry.CompetingChannelEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
import SFT.Chemistry.FiniteMicrostateSupportSource
namespace SFT.Chemistry.CompetingChannelExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-COMPETING-CHANNEL-BRANCHING-006"
def experimentId : String := "SFT-EXP-CHEM-COMPETING-CHANNEL-BRANCHING-006"
def frozenRelation : String := "complete-registered-product-channel-support__exact-sum-of-complete-retained-support__exact-channel-support-over-complete-support__held-reaction-condition-product-and-source-row-identities__structural-EmptyOne-channel-retained-without-invented-value__complete-source-ordered-support-share-uncertainty-and-adverse-record__experimental-vector-separated-from-calculated-and-analysis-disclosures__value-free-complete-eight-channel-identity-seal-and-depth-independent-successor"
def falsification : String := "The claim fails if a registered channel, weak product, uncertainty, source row or adverse disclosure is erased; if shares do not reconstruct One exactly; if an imported normalization, fit, renormalization or selected channel enters; if experimental and calculated columns mix; if targets open before all eight identities seal; or if tampering passes."
def identityPath : String := "experiments/external_sources/chemistry/competing_channel_target_identities_v1.json"
def identityHash : String := "sha256:80fdbf5003e8b82398383c99ce4a127202affd21e6935f08514461e16d56b8b4"
def targetPath : String := "experiments/external_sources/chemistry/competing_channel_withheld_targets_v1.json"
def targetHash : String := "sha256:05f1926ad452280d03920c92cb49088784198d300883757f7439021db57315e7"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/competing-channel-primary-records-v1.json"
def primaryHash : String := "sha256:c099cc768960967362267fbb1821156426374c3e5cda7b6ee91b1c664d24baf6"
def sourceFiles : List (String×String) := [("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/PMC11245511-full-text.xml","sha256:ed762002b7f739d41f750e55f053fa2943498da7f01253880cab9f2d61525763"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/PMC11245511-supplementary-files.zip","sha256:c889230356f4dfd83429a3ce31bef50c4e11dac91ecc6b7243421c83091c01ac"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig1_HTML.gif","sha256:e2db9d8e916d1af8b8e30a035e984136c64949d3b78daa85ddf5b04e5f4bc727"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig1_HTML.jpg","sha256:18e75312a768913d2d8df877375b6eb6cdc1a0f2a8c6de97b650190df9f3c17e"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Article_Equ4.gif","sha256:5c60cb282fdd3cd36aaa370b43fa8b9bcccef8baf0340b2b5c96c6529a025ce7"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig4_HTML.gif","sha256:6172496c9e3baa62ca452a505a02b23942d2a56ec765cd63955553c9f98f1ceb"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Article_Equ1.gif","sha256:71437cf0393d20c66fb5301eacc159c44f1e4b8d38a92389d1ccb2017e20e46d"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig5_HTML.gif","sha256:bb61ae9a72aef76491d4ead0ae21c60e637e0bf4b64200aa1fdb4de9abb9a475"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig4_HTML.jpg","sha256:98188371935d5b0f686922dc6bedfc379191642d4557910c18c8b70a3a8c7290"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Article_Equ3.gif","sha256:05498162434a2997317e79683c96fe8829c1729b2dec3c1df70c8c3fcb19f944"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Article_Equ5.gif","sha256:d1b2903924823117147736d283013f0de2d43de5e0d8f418c9f7e9e1efbde990"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig5_HTML.jpg","sha256:2a937aedc189abd7dbbb33a5f83daf6c7c2feb6058b571286f8d8d01835325f1"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig6_HTML.gif","sha256:63a15aaa3d9375ab7d7a18aafa2122bcd93ff7d3e58a2e5b249e3e5f1a9c84d1"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig2_HTML.jpg","sha256:38297d32e85c6a1b7a3ce6c341369eff876af701834f727c9133e4d4fe3db99f"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig3_HTML.jpg","sha256:6463b4bbe63a96be5d83102d5258d23400d88cd8d9a16b4e00a61d470e2f5e6d"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_MOESM2_ESM.pdf","sha256:378a40920ac001b71fb702825d4636f90ce46165cff77ec758f44325180d39eb"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_MOESM1_ESM.pdf","sha256:fb75abfa752e3a37d77096f05e481b426dd4ab60ce123db266ad7cf4d6ebd908"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig6_HTML.jpg","sha256:57cb0e27e3a85bfec1f1ceccc772fdb2246fa907573b0c2df8304aa28a8b9624"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Article_Equ2.gif","sha256:d77dbcd9147b90ad7b8574b447b6c994932cf6538d1befb92a9483edf3ef013d"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig2_HTML.gif","sha256:2e8a03693ba4975e9e287262801adadf98068c0ebc3c083c9072ddf1b490b9c9"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_Fig3_HTML.gif","sha256:b4e0b6b619e3b5d258f4a0a6de448a08fb0ddc5dc8daed9e0378568239cb6113"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_MOESM2_ESM.txt","sha256:62b4005f75f0effa6ba044e5e27b55130006a8e2a113efd4b209dc90e45080da"),("experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/42004_2024_1239_MOESM1_ESM.txt","sha256:fc590aaeaea9a90fdb2c93733fdd17503ec95033be8fa8f582f35e7ad3d98c74")]
def targetIds : List String := ["KIN-006-PRODUCT-CHANNEL-01", "KIN-006-PRODUCT-CHANNEL-02", "KIN-006-PRODUCT-CHANNEL-03", "KIN-006-PRODUCT-CHANNEL-04", "KIN-006-PRODUCT-CHANNEL-05", "KIN-006-PRODUCT-CHANNEL-06", "KIN-006-PRODUCT-CHANNEL-07", "KIN-006-PRODUCT-CHANNEL-08"]
def hasKey (row : Value) (key : String) : Bool := match row with
 | .object fields => fields.any fun (name,_) => Text.equal name key
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "KIN-006 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 let forbidden := ["pressure_external_inscription_mbar", "temperature_external_inscription", "experimental_branching_percent_external_inscription", "experimental_branching_exact_fraction_of_complete_support", "experimental_uncertainty_percent_external_inscription", "experimental_uncertainty_exact_fraction", "calculated_comparison_percent_external_inscription", "calculated_comparison_exact_fraction", "target_payload", "target_payload_hash", "snapshot_hash"]
 if !sameValue (get document "complete_registered_product_channel_count") (.integer 8) ||
  !sameValue (get document "all_branching_condition_spectrum_uncertainty_analysis_and_target_hash_values_absent") (.boolean true) ||
  rows.length != 8 || rows.any (fun row=>forbidden.any (hasKey row)) then
  throw "KIN-006 value-free identity boundary changed"
 let ordinals ← rows.mapM fun row=>field row "source_product_row"
 let products ← rows.mapM fun row=>field row "product_channel_identity"
 if !(ordinals.zipIdx.all fun (v,i)=>sameValue v (.integer (i+1))) ||
  (products.foldl (fun found x=>if found.any (sameValue x) then found else found++[x]) []).length != 8 then
  throw "KIN-006 value-free identity boundary changed"
 pure rows
def identityString (value : Value) : Except String String := match value with
 | .text s => pure s
 | .integer (.ofNat n) => pure (toString n)
 | .integer (.negSucc n) => pure (Text.append "-" (toString (n+1)))
 | .boolean b => pure (if b then "True" else "False")
 | .null => pure "None"
 | .array _ | .object _ => throw "registered finite-microstate identity field is not scalar"
def identityFields : List (String × String) := [("source_id","complete-source-identity"),("article_doi","source-article-identity"),("reaction_identity","registered-reaction-identity"),("measurement_identity","measurement-identity"),("condition_identity","held-condition-identity"),("source_table_identity","source-table-identity"),("source_product_row","positive-source-product-row"),("product_channel_identity","registered-product-channel-identity")]
def identityValue (row : Value) (key : String) : Except String String := field row key >>= identityString
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "competing-channel-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← identityValue row key
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let laws := [("complete-support-law","all-registered-product-channels-retained-in-source-order"),("branch-relation-law","exact-channel-support-over-exact-complete-support"),("absence-law","unfavorable-and-EmptyOne-channels-retained-without-invention"),("provenance-law","experimental-vector-separated-from-calculated-and-analysis-disclosures")]
 let lawRows := laws.zipIdx.map fun ((family,label),index) =>
  let destination := Text.intercalate "" [rowPrefix,"-law-",toString (9+index)]
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
 [instruction "table" "complete-competing-channel-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["complete-competing-channel-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "forward_forcing_with_prefetch_value_free_identity_seal"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
 ("primary_source_record",.array [.text primaryPath,.text primaryHash]),
 ("complete_article_snapshot",.array [.text "experiments/external_sources/chemistry/snapshots/kin-006-competing-channel-v1/PMC11245511-full-text.xml",.text "sha256:ed762002b7f739d41f750e55f053fa2943498da7f01253880cab9f2d61525763"]),("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_branching_condition_spectrum_uncertainty_analysis_and_target_hash_values_absent",.boolean true),
 ("falsification_condition",.text falsification)])
def expectedLabel : String := "complete-experimental-eight-product-branching-vector"
def dimensions : List (String × List (String × Bool)) := [("support",[("selected-dominant-or-favorable-channel-subset",false),("complete-registered-product-channel-support",true)]),("whole",[("imported-probability-normalization-axiom",false),("exact-sum-of-complete-retained-support",true)]),("relation",[("fitted-or-free-branching-ratio",false),("exact-channel-support-over-complete-support",true)]),("identity",[("reaction-condition-or-product-identity-collapsed",false),("held-reaction-condition-product-and-source-row-identities",true)]),("absence",[("unfavorable-null-or-unresolved-channel-omitted",false),("structural-EmptyOne-channel-retained-without-invented-value",true)]),("record",[("ratio-answer-only-or-renormalized-table",false),("complete-source-ordered-support-share-uncertainty-and-adverse-record",true)]),("provenance",[("experimental-and-calculated-columns-mixed",false),("experimental-vector-separated-from-calculated-and-analysis-disclosures",true)]),("prediction",[("branch-value-readable-before-seal-or-corrected-after-release",false),("value-free-complete-eight-channel-identity-seal-and-depth-independent-successor",true)])]
def snapshotHashes : List String := ["sha256:ed762002b7f739d41f750e55f053fa2943498da7f01253880cab9f2d61525763", "sha256:ed762002b7f739d41f750e55f053fa2943498da7f01253880cab9f2d61525763", "sha256:ed762002b7f739d41f750e55f053fa2943498da7f01253880cab9f2d61525763", "sha256:ed762002b7f739d41f750e55f053fa2943498da7f01253880cab9f2d61525763", "sha256:ed762002b7f739d41f750e55f053fa2943498da7f01253880cab9f2d61525763", "sha256:ed762002b7f739d41f750e55f053fa2943498da7f01253880cab9f2d61525763", "sha256:ed762002b7f739d41f750e55f053fa2943498da7f01253880cab9f2d61525763", "sha256:ed762002b7f739d41f750e55f053fa2943498da7f01253880cab9f2d61525763"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if CompetingChannelEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array CompetingChannelEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
end SFT.Chemistry.CompetingChannelExperiment
