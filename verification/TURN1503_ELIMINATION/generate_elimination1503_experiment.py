from pathlib import Path
import sys,json,re
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned_elimination1503/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.elimination_reaction_batch_v1 import ELIMINATION_REACTION_SPEC as spec
from sft.chemistry.generated_law import prediction_program_document
from sft.chemistry.generated_observational_law import observational_experiment_registration_record
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(tuple,list)):return '.array ['+','.join(cv(y)for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')'for k,v in x.items())+']'
 if isinstance(x,int):return '.integer '+str(x)
 raise TypeError(type(x))
s='''import SFT.Chemistry.EliminationEvidence
import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Chemistry.EliminationExperiment
open SFT.Host SFT.Host.Canonical
'''
for name,value in [('claimId',spec.claim_id),('experimentId',spec.experiment_id),('expectedLabel',spec.expected_observation_label),('falsification',spec.falsification_condition)]:s+='def '+name+' : String := '+q(value)+'\n'
for name,value in [('sourceIds',[x.source_id for x in spec.target_rows]),('targetIds',[x.target_id for x in spec.target_rows]),('snapshotHashes',[x.snapshot_hash for x in spec.target_rows])]:s+='def '+name+' : List String := ['+','.join(q(x)for x in value)+']\n'
s+='def predictionDocument : Value := '+cv(prediction_program_document(spec))+'\n'
s+='def registration : Value := '+cv(observational_experiment_registration_record(spec))+'\n'
s+='''def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
'''
s+='def dimensions : List (String × List (String × Bool)) := ['+','.join('('+q(d.key)+',['+','.join('('+q(c.name)+','+str(c.admitted).lower()+')'for c in d.choices)+'])'for d in spec.dimensions)+']\n'
s+='''def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if EliminationEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if (NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnessRows ← Elimination.witnesses
 if !(witnessRows.all id) then throw "Chemistry operational witness failed"
 return ()
'''
for name in re.findall(r'^def (\w+)',s,re.M):s+='#print axioms '+name+'\n'
s+='end SFT.Chemistry.EliminationExperiment\n'
(w/'turn1064_recovery/SFT/Chemistry/EliminationExperiment.lean').write_text(s)
(w/'elimination1503_original_registration.json').write_text(json.dumps(observational_experiment_registration_record(spec),indent=2)+'\n')
print('Generated exact carrier registration, prediction document, envelope and original spec guards.')
