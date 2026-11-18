import SFT.Chemistry.BondDissociationEnergyEvidence
import SFT.Host.Canonical
import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.BondDissociationEnergyExperiment
open SFT.Host SFT.Host.Canonical
set_option maxRecDepth 20000
def claimId : String := "SFT-CHEM-BOND-DISSOCIATION-ENERGY-002"
def experimentId : String := "SFT-EXP-CHEM-BOND-DISSOCIATION-ENERGY-002"
def frozenRelation : String := "For each registered H2 or D2 channel, the B-prime threshold terminates in one ground-state atom and one 2s atom, while X-state ground dissociation terminates in two ground-state atoms. Their shared ground-atom prefix cancels structurally, so D0(M2) is exactly the B-prime threshold after the held atomic 1S-2S separation is Taken. This relation is sealed without measured values; only afterward does the complete threshold, atomic and historical/later ground-dissociation vector test it exactly."
def falsification : String := "The claim fails if either post-seal threshold Take atomic interval does not overlap every registered historical and later ground-dissociation interval for its isotopologue; if any of eight measurement rows, a state, product channel, condition, source or uncertainty is erased; if any measured number is readable before the relation seal; if a deliberately displaced interval is accepted; or if a fitted coefficient or correction is introduced."
def identityPath : String := "experiments/external_sources/chemistry/bond_dissociation_energy_target_identities_v1.json"
def identityHash : String := "sha256:d1ed3e22aac37011c4e957cbc8f022cf3098ca96b1a8c30ee954196c8a6b8f74"
def targetPath : String := "experiments/external_sources/chemistry/bond_dissociation_energy_withheld_targets_v1.json"
def targetHash : String := "sha256:03eb76d1aeb6dc4a2066236e24f03d5529e9b247a62294db03837077de87cb9c"
def targetIds : List String := ["PATH-H2-BPRIME-THRESHOLD","PATH-H-ATOMIC-1S2S","APS-1994-H2-X-GROUND-D0","CURRENT-H2-X-GROUND-D0","PATH-D2-BPRIME-THRESHOLD","PATH-D-ATOMIC-1S2S","APS-1994-D2-X-GROUND-D0","CURRENT-D2-X-GROUND-D0"]
def instruction (opcode destination : String) (arguments : List String) : Value :=
 .object [("opcode",.text opcode),("destination",.text destination),("arguments",.array (arguments.map Value.text))]
def speciesLabels (species atom : String) : List (String × String) :=
 [("isotopologue",species),("molecular-origin","X-1Sigma-g-plus-ground"),
 ("threshold-state","B-prime-1Sigma-u-plus"),
 ("threshold-channel",Text.intercalate "" [atom,"-1s-plus-",atom,"-2s"]),
 ("ground-channel",Text.intercalate "" [atom,"-1s-plus-",atom,"-1s"]),
 ("path-operation","ordered-positive-held-Take"),
 ("measurement-custody","all-values-open-after-relation-seal")]
def speciesInstructions (species atom : String) : List Value :=
 let key := Text.lowerAscii species
 let indexed := (speciesLabels species atom).zipIdx
 let destination := fun n => Text.intercalate "" [key,"-label-",render (.integer (Int.ofNat (n+1)))]
 let labels := indexed.map fun ((family,label),n) => instruction "label" (destination n) [family,label]
 let registers := "premise" :: indexed.map (fun (_,n) => destination n)
 labels ++ [instruction "word" (Text.append key "-relation") registers]
def predictionProgramDocument : Value :=
 let species := [("H2","H"),("D2","D")]
 let rows := species.flatMap fun (name,atom) => speciesInstructions name atom
 let arguments := species.flatMap fun (name,_) =>
  let key := Text.lowerAscii name
  [Text.append key "-label-1",Text.append key "-relation"]
 let instructions := [instruction "input" "premise" ["registered-premise"]] ++ rows ++
  [instruction "table" "structural-relation-vector" arguments,
   instruction "emit" "" ["structural-relation-vector"]]
 .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text (Text.append experimentId "-value-free-relation-prediction")),("instructions",.array instructions)]
def experimentRegistrationRecord : Value :=
 .object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_measurement_registry",.array [.text targetPath,.text targetHash]),
 ("prediction_program",predictionProgramDocument),("target_ids",.array (targetIds.map Value.text)),
 ("all_measured_values_absent_from_law_and_prediction",.boolean true),("all_eight_rows_required",.boolean true),
 ("falsification_condition",.text falsification)]
def expectedLabel : String := "exact-H2-D2-state-path-Take-relation-across-complete-measurement-vector"
def dimensions : List (String × List (String × Bool)) := [("identity",[("generic-molecule-with-erased-isotope",false),("named-isotopologue-and-X-state",true)]),("channel",[("dissociation-products-erased",false),("both-product-channels-held",true)]),("path",[("answer-only-energy-lookup",false),("shared-prefix-path-composition",true)]),("operation",[("signed-or-floating-subtraction",false),("ordered-positive-held-Take",true)]),("input",[("measured-value-used-as-prediction-input",false),("all-measurements-opened-post-seal",true)]),("measurement",[("dissociation-target-readable-before-seal",false),("target-inaccessible-until-prediction-seal",true)]),("record",[("selected-historical-or-current-row",false),("complete-historical-and-current-vector",true)]),("extension",[("species-coefficient-or-correction",false),("typed-two-row-exhaustion-no-extra-rule",true)])]
def snapshotHashes : List String := ["sha256:9c41d01395090b18b2eb8b1223e9cb430d9309f79d1a0324b092a5ed8c1b6953","sha256:a6da423edfe31be4666d56eb6b83864512e5583760b016fce00d2b825a173267","sha256:9c41d01395090b18b2eb8b1223e9cb430d9309f79d1a0324b092a5ed8c1b6953","sha256:304c92c783621b12706ce1ba92a3c2dc9b6426f884fb8ab3001523c65cbbfc80","sha256:9c41d01395090b18b2eb8b1223e9cb430d9309f79d1a0324b092a5ed8c1b6953","sha256:a6da423edfe31be4666d56eb6b83864512e5583760b016fce00d2b825a173267","sha256:9c41d01395090b18b2eb8b1223e9cb430d9309f79d1a0324b092a5ed8c1b6953","sha256:304c92c783621b12706ce1ba92a3c2dc9b6426f884fb8ab3001523c65cbbfc80"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if BondDissociationEnergyEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([BondDissociationEnergy.exactPathWitness,BondDissociationEnergy.orientationWitness,BondDissociationEnergy.sameLawWitness].all id) then throw "Chemistry operational witness failed"
 return ()
theorem registeredSpecValid : validateSpec = .ok () := rfl
end SFT.Chemistry.BondDissociationEnergyExperiment
