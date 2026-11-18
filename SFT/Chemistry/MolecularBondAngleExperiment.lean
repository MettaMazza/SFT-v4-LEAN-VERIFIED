import SFT.Chemistry.MolecularBondAngleEvidence
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.MolecularBondAngleExperiment
open SFT.Host SFT.Host.Canonical MolecularBondAngle
set_option maxRecDepth 20000
abbrev instruction := BondDissociationEnergyExperiment.instruction
def claimId : String := "SFT-CHEM-MOLECULAR-BOND-ANGLE-003"
def experimentId : String := "SFT-EXP-CHEM-MOLECULAR-BOND-ANGLE-003"
def frozenRelation : String := "A closed molecular turn divided into n symmetry-indistinguishable positive ligand sectors has no lawful unequal-sector form: unequal parts would introduce an ungenerated distinction. Each sector is therefore exactly 1/n turn and a retained k-sector separation is exactly k/n turn. The structural fractions seal without degrees; only afterward are all four NIST CCCBDB BF3, XeF2 and XeF4 angle rows opened."
def falsification : String := "The claim fails if any sealed turn fraction translated after release does not equal its source-bound degree inscription at the registered observation resolution; if any of the four rows or its species, state, geometry, angle definition, method/condition or comment is erased; if a degree value is readable before prediction sealing; if a displaced, swapped, wrong-count or unsupported-geometry control is accepted; or if a fitted correction or continuum construction is introduced."
def identityPath : String := "experiments/external_sources/chemistry/bond_angle_target_identities_v1.json"
def identityHash : String := "sha256:3d3c67505120a588c014f1417f518edda10295cfd9eb55a84530e50fd2f2cbcc"
def targetPath : String := "experiments/external_sources/chemistry/bond_angle_withheld_targets_v1.json"
def targetHash : String := "sha256:f6f614ad7ee9f7d992a80cf61b9b49443b7f1fe8d14cd186a33566f759f06b7e"
def targetIds : List String := ["NIST-CCCBDB-BF3-FBF-ADJACENT","NIST-CCCBDB-XEF2-FXEF-OPPOSITE","NIST-CCCBDB-XEF4-FXEF-ADJACENT","NIST-CCCBDB-XEF4-FXEF-OPPOSITE"]
def registerPrefix (ordinal : Nat) : String := Text.append "angle-" (toString (ordinal+1))
def labels (carrier : MolecularAngleCarrier) : List (String × String) :=
 [("target-id",carrier.targetId),(carrier.species.family,carrier.species.label),
 (carrier.molecularState.family,carrier.molecularState.label),(carrier.geometry.family,carrier.geometry.label),
 (carrier.coordinate.family,carrier.coordinate.label),(carrier.angleRole.family,carrier.angleRole.label)]
def carrierInstructions (ordinal : Nat) (carrier : MolecularAngleCarrier) : Except String (List Value) := do
 let turn ← turnFraction carrier
 let key := registerPrefix ordinal
 let destination := fun n => Text.intercalate "" [key,"-label-",toString (n+1)]
 let indexed := (labels carrier).zipIdx
 let labelRows := indexed.map fun ((family,label),n) => instruction "label" (destination n) [family,label]
 let countName := Text.append key "-sector-count"
 let separationName := Text.append key "-sector-separation"
 let fractionName := Text.append key "-turn-fraction"
 let registers := ("premise" :: indexed.map (fun (_,n) => destination n)) ++ [countName,separationName,fractionName]
 pure (labelRows ++ [instruction "count" countName [toString carrier.sectorCount.value],
  instruction "count" separationName [toString carrier.sectorSeparation.value],
  instruction "ratio" fractionName [toString turn.numerator,toString turn.denominator],
  instruction "word" (Text.append key "-carrier") registers])
def predictionProgramDocument : Except String Value := do
 let indexed := molecularAngleVector.zipIdx
 let rows ← indexed.mapM fun (carrier,ordinal) => carrierInstructions ordinal carrier
 let arguments := indexed.flatMap fun (_,ordinal) =>
  [Text.append (registerPrefix ordinal) "-label-1",Text.append (registerPrefix ordinal) "-carrier"]
 let instructions := [instruction "input" "premise" ["registered-premise"]] ++ rows.flatten ++
  [instruction "table" "molecular-angle-vector" arguments,instruction "emit" "" ["molecular-angle-vector"]]
 pure (.object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text (Text.append experimentId "-value-free-turn-fraction-prediction")),("instructions",.array instructions)])
def experimentRegistrationRecord : Except String Value := do
 let document ← predictionProgramDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_measurement_registry",.array [.text targetPath,.text targetHash]),
 ("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_degree_values_absent_from_law_and_prediction",.boolean true),
 ("postseal_unit_translation",.text "one complete turn translated to the external degree inscription only after release"),
 ("falsification_condition",.text falsification)])
theorem completePredictionConstructed : predictionProgramDocument.isOk = true := rfl
theorem completeRegistrationConstructed : experimentRegistrationRecord.isOk = true := rfl

def expectedLabel : String := "exact-equal-sector-turn-fraction-across-complete-four-angle-vector"
def dimensions : List (String × List (String × Bool)) := [("carrier",[("answer-only-angle-scalar",false),("named-state-geometry-sector-carrier",true)]),("order",[("unordered-ligand-cloud",false),("exact-generated-cyclic-order",true)]),("partition",[("unequal-or-fitted-sectors",false),("symmetry-forced-equal-sectors",true)]),("relation",[("continuum-trigonometric-angle",false),("positive-sector-separation-over-count",true)]),("prediction",[("degree-target-in-prediction",false),("value-free-exact-turn-fraction",true)]),("measurement",[("target-open-before-seal",false),("all-angle-values-open-post-seal",true)]),("record",[("selected-species-or-angle-role",false),("complete-three-species-four-angle-vector",true)]),("extension",[("species-correction-or-angle-exception",false),("one-law-no-extra-rule",true)])]
def snapshotHashes : List String := ["sha256:3585dfdfe7551bce657c377a96f7800759e027325a0b5bac96c264591ba01181","sha256:39e69a157c1bda28a8aa1dc48e39e0e9550ecb79c396cd543bc4aaf728938df4","sha256:26ca18c0606aca4acb21c8e5555d1a6bc2a263c22510776e7834a22783ea3426","sha256:26ca18c0606aca4acb21c8e5555d1a6bc2a263c22510776e7834a22783ea3426"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if MolecularBondAngleEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([MolecularBondAngle.exactVectorWitness,MolecularBondAngle.geometryCountWitness,MolecularBondAngle.continuumBoundaryWitness].all id) then throw "Chemistry operational witness failed"
 return ()
theorem registeredSpecValid : validateSpec = .ok () := rfl
end SFT.Chemistry.MolecularBondAngleExperiment
