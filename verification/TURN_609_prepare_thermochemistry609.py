from pathlib import Path
import sys,ast,json,subprocess
sys.path.insert(0,'work')
w=Path('work');r=w/'constants-recovery/SFT/Chemistry'
for m in ['ThermochemistryGrammar','ThermochemistryEvidence','ThermochemistryExperiment','ThermochemistryValidation','ThermochemistrySeal','ThermochemistrySealInputs']:
 assert not (r/(m+'.lean')).exists(),m
s=(w/'equilibrium_spec608.py').read_text().replace('from affinity_spec587 import raw,namespace as redox_namespace','from equilibrium_spec608 import raw,namespace as redox_namespace').replace('reaction_kinetics_derivation.py','thermochemistry_derivation.py').replace('reaction_kinetics_batch_1.py','thermochemistry_batch_1.py').replace("['REACTION_KINETICS_BLUEPRINTS'][6]","['THERMOCHEMISTRY_BLUEPRINTS'][0]")
(w/'thermochemistry_spec609.py').write_text(s)
s=(w/'prepare_equilibrium608.py').read_text().replace('equilibrium','thermochemistry').replace('Equilibrium','Thermochemistry').replace('608','609')
(w/'prepare_thermochemistry_grammar609.py').write_text(s)
subprocess.run(['python3',str(w/'prepare_thermochemistry_grammar609.py')],check=True)
s=(r/'ThermochemistryEvidence.lean').read_text().replace('with carrier :=','with reaction :=')
(r/'ThermochemistryEvidence.lean').write_text(s)
s=(w/'prepare_equilibrium_experiment608.py').read_text().replace('equilibrium','thermochemistry').replace('Equilibrium','Thermochemistry').replace('608','609');(w/'prepare_thermochemistry_experiment609.py').write_text(s)
subprocess.run(['python3',str(w/'prepare_thermochemistry_experiment609.py')],check=True)
from thermochemistry_spec609 import namespace,raw,q
s=(r/'ReactionSeal.lean').read_text().replace('ReactionSeal','ThermochemistrySeal').replace('reaction/kinetics','thermochemistry')
import re
s=re.sub(r'def derivationHash : String := .*', 'def derivationHash : String := '+q(namespace['DERIVATION_HASH']),s)
s=re.sub(r'def payloadHash : String := .*', 'def payloadHash : String := '+q(namespace['PRE_SOURCE_PAYLOAD_HASH']),s)
rows=namespace['THERMOCHEMISTRY_BLUEPRINTS']
pred='['+','.join('('+','.join(map(q,[b.claim_id,b.exact_result,b.predicted_observation_label]))+')' for b in rows)+']'
s=re.sub(r'def predictions : List \(String × String × String\) := .*','def predictions : List (String × String × String) := '+pred,s)
(r/'ThermochemistrySeal.lean').write_text(s)
def val(v):
 if isinstance(v,str):return '.text '+q(v)
 if v is None:return '.null'
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,int):return '.integer '+str(v)
 if isinstance(v,list):return '.array ['+','.join(map(val,v))+']'
 return '.object ['+','.join('('+q(k)+','+val(x)+')' for k,x in v.items())+']'
(r/'ThermochemistrySealInputs.lean').write_text('import SFT.Chemistry.ThermochemistrySeal\nnamespace SFT.Chemistry.ThermochemistrySealInputs\nopen SFT.Host.Canonical\nset_option maxRecDepth 20000\ndef derivation : String := '+q(raw(namespace['DERIVATION_PATH']))+'\ndef sealedRecord : Value := '+val(json.loads(raw(namespace['PRE_SOURCE_SEAL_PATH'])))+'\ndef validate : Except String Unit := ThermochemistrySeal.validate derivation.toUTF8 sealedRecord\nend SFT.Chemistry.ThermochemistrySealInputs\n')
for old,new in [('audit_equilibrium608.py','audit_thermochemistry609.py'),('run_equilibrium608.py','run_thermochemistry609.py'),('check_equilibrium_validation608.py','check_thermochemistry_validation609.py'),('check_chemistry_independent608.py','check_chemistry_independent609.py')]:
 s=(w/old).read_text().replace('ChemicalEquilibrium','ReactionThermochemistry').replace('Equilibrium','Thermochemistry').replace('equilibrium','thermochemistry').replace('608','609').replace('SFT-CHEM-EQ-CHEMICAL-001','SFT-CHEM-THERMO-REACTION-001').replace('ReactionSeal','ThermochemistrySeal')
 if old.startswith('audit_'):s=s.replace("'ThermochemistryValidation']","'ThermochemistryValidation','ThermochemistrySeal','ThermochemistrySealInputs']")
 (w/new).write_text(s)
print('Prepared exact grammar, program, validator and five-prediction seal.')
