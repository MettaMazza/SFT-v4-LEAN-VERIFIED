import SFT.Chemistry.EquilibriumBondLength
import SFT.Chemistry.EquilibriumBondLengthEvidence
import SFT.Host.Canonical
import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.EquilibriumBondLengthExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def claimId : String := "SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001"
def experimentId : String := "SFT-EXP-CHEM-EQUILIBRIUM-BOND-LENGTH-001"
def frozenRelation : String := "For the complete registered gas-phase H2/D2 X-state boundary, the common Fold electronic base is seven-fifths of the held atomic-length carrier. The binary-order alpha return adds twenty-one alpha squared for H2 and twenty-four alpha squared for D2. Thus r_e(H2)/a0=7/5+21 alpha^2 and r_e(D2)/a0=7/5+24 alpha^2 before either NIST distance target is released."
def falsification : String := "The claim fails if either exact sealed physical interval does not overlap its complete NIST displayed equilibrium-distance interval; if species, isotopologue, X state, gas-phase condition, CODATA scale provenance or source uncertainty is erased; if either target is readable before sealing; if any extra coefficient or species rule is appended; or if a deliberately displaced interval is accepted."
def identityPath : String := "experiments/external_sources/chemistry/equilibrium_bond_length_target_identities_v1.json"
def identityHash : String := "sha256:539cefd200cd81a2cd3a9d8986f7c4b531999bdf1b633b621eaecf4fecb75cd8"
def scalePath : String := "experiments/external_sources/chemistry/equilibrium_bond_length_scale_input_v1.json"
def scaleHash : String := "sha256:c29c269b522c73f2bdc08dc10ac2bf9599de5ce35edd4b5992fb27e2b874af53"
def targetPath : String := "experiments/external_sources/chemistry/equilibrium_bond_length_withheld_targets_v1.json"
def targetHash : String := "sha256:2223ed429a82a16bf2945235ba19941aea7553238fbf9c990f4f37662d5c6f9f"
def targetIds : List String := ["NIST-H2-X1SIGMA-G-EQUILIBRIUM-DISTANCE","NIST-D2-X1SIGMA-G-EQUILIBRIUM-DISTANCE"]
def instruction (opcode destination : String) (arguments : List String) : Value :=
 .object [("opcode",.text opcode),("destination",.text destination),("arguments",.array (arguments.map Value.text))]
def predictionProgramDocument : Except String Value := do
 let multipliers ← EquilibriumBondLength.equilibriumLengthVector
 let rows := multipliers.map fun (species,multiplier) =>
  let key := Text.lowerAscii species
  [instruction "label" (Text.append key "-key") ["molecular-isotopologue",species],
   instruction "ratio" (Text.append key "-multiplier") [render (.integer multiplier.num),render (.integer (Int.ofNat multiplier.den))],
   instruction "product" (Text.append key "-lower") ["atomic-lower",Text.append key "-multiplier"],
   instruction "product" (Text.append key "-upper") ["atomic-upper",Text.append key "-multiplier"],
   instruction "pair" (Text.append key "-interval") [Text.append key "-lower",Text.append key "-upper"]]
 let tableArguments := multipliers.flatMap fun (species,_) =>
  let key := Text.lowerAscii species
  [Text.append key "-key",Text.append key "-interval"]
 let instructions := [instruction "input" "atomic-lower" ["atomic-lower"],
  instruction "input" "atomic-upper" ["atomic-upper"]] ++ rows.flatten ++
  [instruction "table" "equilibrium-length-vector" tableArguments,
   instruction "emit" "" ["equilibrium-length-vector"]]
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text (Text.append experimentId "-exact-interval-prediction")),("instructions",.array instructions)]
def experimentRegistrationRecord : Except String Value := do
 return .object [("experiment_id",.text experimentId),("claim_id",.text claimId),
  ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
  ("identity_registry",.array [.text identityPath,.text identityHash]),
  ("public_scale_input",.array [.text scalePath,.text scaleHash]),
  ("withheld_target_registry",.array [.text targetPath,.text targetHash]),
  ("prediction_program",← predictionProgramDocument),("target_ids",.array (targetIds.map Value.text)),
  ("target_content_absent_from_law_and_scale_input",.boolean true),("all_rows_required",.boolean true),
  ("falsification_condition",.text falsification)]
def expectedLabel : String := "exact-H2-D2-equilibrium-length-interval-vector-contained"
def dimensions : List (String × List (String × Bool)) := [("identity",[("generic-diatomic-with-erased-state",false),("named-isotopologue-state-and-condition",true)]),("equilibrium",[("arbitrary-distance-sample",false),("configuration-minimum-distance",true)]),("scale",[("free-angstrom-scale",false),("held-atomic-length-reference",true)]),("base",[("free-leading-ratio",false),("up-support-over-down-support",true)]),("correction",[("linear-or-open-correction-series",false),("binary-order-alpha-return",true)]),("isotope",[("one-universal-isotope-correction",false),("distinct-light-and-heavy-typed-routes",true)]),("measurement",[("target-readable-or-selected-value",false),("sealed-exact-interval-transport",true)]),("extension",[("free-species-term-or-fit",false),("finite-typed-vector-exhaustion",true)])]
def snapshotHashes : List String := ["sha256:18036a188088f880122249544ceb6b384fabfba93b300b4f9f0fa01aa0ed9b24","sha256:790276cd493dbede03fc9e83db95bc0808a36838eb31473aaf923493b4749936"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if EquilibriumBondLengthEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !CapabilityValues.nonblank expectedLabel || !CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([EquilibriumBondLength.commonBaseWitness.toOption.getD false,EquilibriumBondLength.typedCorrectionsWitness.toOption.getD false,EquilibriumBondLength.positiveOrderWitness.toOption.getD false].all id) then throw "Chemistry operational witness failed"
 return ()
theorem registeredSpecValid : validateSpec = .ok () := rfl
end SFT.Chemistry.EquilibriumBondLengthExperiment
