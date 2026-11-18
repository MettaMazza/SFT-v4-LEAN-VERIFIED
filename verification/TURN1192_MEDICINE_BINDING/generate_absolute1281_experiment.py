from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.medicine
sft.medicine.__path__=[str((w/'pinned1281/sft/medicine').resolve())]+list(sft.medicine.__path__)
from sft.medicine.empirical_program import MEDICINE_SPECS,prediction_program_document,experiment_registration_record
spec=next(x for x in MEDICINE_SPECS if x.claim_id=='SFT-MED-ABSOLUTE-RELATIVE-EFFECT-001');record=experiment_registration_record(w/'pinned1281',spec);q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(tuple,list)):return '.array ['+','.join(cv(y)for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')'for k,v in x.items())+']'
 if isinstance(x,int):return '.integer '+str(x)
 raise TypeError(type(x))
s='''import SFT.Medicine.AbsoluteRelativeEffectEvidence
import SFT.Medicine.PatientIdentitySeal\nimport SFT.Medicine.AbsoluteRelativeEffectSource
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Medicine.AbsoluteRelativeEffectExperiment
open SFT.Host SFT.Host.Canonical
'''
for name,value in [('claimId',spec.claim_id),('experimentId',spec.experiment_id),('targetId',spec.target_id),('expectedLabel',spec.expected_observation_label),('falsification',spec.falsification_condition),('exactResult',spec.exact_result)]:s+='def '+name+' : String := '+q(value)+'\n'
s+='def sourceIds : List String := ['+','.join(q(x)for x in spec.source_ids)+']\n'
s+='def predictionDocument : Value := '+cv(prediction_program_document(spec))+'\n'
s+='def programFields : List (String × Value) := match predictionDocument with\n | .object fs => fs\n | .null | .text _ | .boolean _ | .integer _ | .array _ => []\n'
s+='def registration (preSourceSeal : String) : Value := .object ['+','.join('('+q(k)+','+('.text preSourceSeal'if k=='pre_source_seal_hash'else cv(v))+')'for k,v in record.items())+']\n'
s+='''def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
'''
s+='def dimensions : List (String × List (String × Bool)) := ['+','.join('('+q(d.key)+',['+','.join('('+q(c.name)+','+str(c.admitted).lower()+')'for c in d.choices)+'])'for d in spec.dimensions)+']\n'
s+='''def witnesses : List Bool := [AbsoluteRelativeEffect.carrierWitness,AbsoluteRelativeEffect.relationWitness,AbsoluteRelativeEffect.boundaryWitness]
def admittedName (d : String × List (String × Bool)) : Except String String :=
 match d.2.filter Prod.snd with
 | [(name,_)] => .ok name
 | [] | _::_::_ => .error (Text.intercalate "" ["dimension ",d.1," requires one preserving form"])
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-MED-").isPrefixOf (Text.chars claimId) || !(Text.chars "SFT-EXP-MED-").isPrefixOf (Text.chars experimentId) then
  throw "invalid Medicine identity"
 if dimensions.length != 8 || !(SFT.Biology.LifeOrganizationSource.distinctIds (dimensions.map Prod.fst)) then
  throw "Medicine blueprint requires eight distinct dimensions"
 if !(dimensions.all (fun d => d.2.length==2)) then throw "each Medicine dimension must exhaust two registered forms"
 let names ← dimensions.mapM admittedName
 if !Text.equal exactResult (Text.intercalate "__" names) then throw "Medicine exact result is not the unique preservation survivor"
 if AbsoluteRelativeEffectEvidence.dependencies.isEmpty || !(SFT.Biology.LifeOrganizationSource.distinctIds AbsoluteRelativeEffectEvidence.dependencies) then
  throw "Medicine dependencies are empty or repeated"
 if !(witnesses.all id) then throw "Medicine operational witness failed"
 let expected := (AbsoluteRelativeEffectSource.requirements.map (fun requirement => requirement.sourceId)).foldl
  (fun acc value => if acc.any (Text.equal value) then acc else acc++[value]) []
 if sourceIds.isEmpty || !(Text.equal (Canonical.render (.array (sourceIds.map Value.text))) (Canonical.render (.array (expected.map Value.text)))) then
  throw "Medicine source identities differ from the registered binding"
 if !Text.equal targetId "sft-med-absolute-relative-effect-001-authority-correspondence" then throw "Medicine target identity is invalid"
 return ()
'''
import re
for name in re.findall(r'^def (\w+)',s,re.M):s+='#print axioms '+name+'\n'
s+='end SFT.Medicine.AbsoluteRelativeEffectExperiment\n';(w/'turn1064_recovery/SFT/Medicine/AbsoluteRelativeEffectExperiment.lean').write_text(s);(w/'absolute1281_original_registration.json').write_text(json.dumps(record,indent=2)+'\n');print('Exact original medicine registration,prediction document,envelope and spec guards generated.')
