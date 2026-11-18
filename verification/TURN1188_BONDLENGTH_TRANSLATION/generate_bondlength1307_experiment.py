from pathlib import Path
import json
w=Path('work');r=w/'turn1064_recovery';spec=json.loads((w/'bondlength1307_spec.json').read_text());q=lambda x:json.dumps(x,ensure_ascii=False)
base=w/'pinned1307/experiments/external_sources/chemistry';paths=[('identity','equilibrium_bond_length_target_identities_v1.json'),('scale','equilibrium_bond_length_scale_input_v1.json'),('target','equilibrium_bond_length_withheld_targets_v1.json')]
import hashlib
s='''import SFT.Chemistry.EquilibriumBondLength
import SFT.Chemistry.EquilibriumBondLengthEvidence
import SFT.Host.Canonical
namespace SFT.Chemistry.EquilibriumBondLengthExperiment
open SFT.Host SFT.Host.Canonical
set_option maxRecDepth 20000
'''
for name,value in [('claimId',spec['claim_id']),('experimentId',spec['experiment_id']),('frozenRelation',spec['statement']),('falsification',spec['falsification_condition'])]:s+='def '+name+' : String := '+q(value)+'\n'
for key,name in paths:
 s+='def '+key+'Path : String := '+q('experiments/external_sources/chemistry/'+name)+'\n';s+='def '+key+'Hash : String := '+q('sha256:'+hashlib.sha256((base/name).read_bytes()).hexdigest())+'\n'
s+='def targetIds : List String := '+ '['+','.join(q(x['target_id'])for x in spec['target_rows'])+']\n'
s+='''def instruction (opcode destination : String) (arguments : List String) : Value :=
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
'''
(r/'SFT/Chemistry/EquilibriumBondLengthExperiment.lean').write_text(s)
p=w/'build_bondlength1307.py';t=p.read_text();t=t.replace("'EquilibriumBondLengthEvidence']","'EquilibriumBondLengthEvidence','EquilibriumBondLengthExperiment']");p.write_text(t)
print('Translated original14instruction prediction document and12field experiment registration from computed multipliers and exact registered bindings; native build pending.')
