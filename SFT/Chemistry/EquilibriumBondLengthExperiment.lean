import SFT.Chemistry.EquilibriumBondLength
import SFT.Chemistry.EquilibriumBondLengthEvidence
import SFT.Host.Canonical
namespace SFT.Chemistry.EquilibriumBondLengthExperiment
open SFT.Host SFT.Host.Canonical
set_option maxRecDepth 20000
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
end SFT.Chemistry.EquilibriumBondLengthExperiment
