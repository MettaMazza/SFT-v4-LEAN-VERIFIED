from pathlib import Path
import sys,ast,json,subprocess
sys.path.insert(0,'work')
w=Path('work');r=w/'constants-recovery/SFT/Chemistry'
for m in ['CatalystGrammar','CatalystEvidence','CatalystExperiment','CatalystValidation','CatalystSeal','CatalystSealInputs']:
 assert not (r/(m+'.lean')).exists(),m
s=(w/'equilibrium_spec608.py').read_text().replace('from affinity_spec587 import raw,namespace as redox_namespace','from equilibrium_spec608 import raw,namespace as redox_namespace').replace('reaction_kinetics_derivation.py','catalysis_interfaces_derivation.py').replace('reaction_kinetics_batch_1.py','catalysis_interfaces_batch_1.py').replace("['REACTION_KINETICS_BLUEPRINTS'][6]","['CATALYSIS_INTERFACE_BLUEPRINTS'][0]")
(w/'catalyst_spec614.py').write_text(s)
s=(w/'prepare_equilibrium608.py').read_text().replace('equilibrium','catalyst').replace('Equilibrium','Catalyst').replace('608','614')
(w/'prepare_catalyst_grammar614.py').write_text(s)
subprocess.run(['python3',str(w/'prepare_catalyst_grammar614.py')],check=True)
s=(r/'CatalystEvidence.lean').read_text().replace('with carrier :=','with role :=')
(r/'CatalystEvidence.lean').write_text(s)
s=(w/'prepare_equilibrium_experiment608.py').read_text().replace('equilibrium','catalyst').replace('Equilibrium','Catalyst').replace('608','614');(w/'prepare_catalyst_experiment614.py').write_text(s)
subprocess.run(['python3',str(w/'prepare_catalyst_experiment614.py')],check=True)
from catalyst_spec614 import namespace,raw,q
s=(r/'ReactionSeal.lean').read_text().replace('ReactionSeal','CatalystSeal').replace('reaction/kinetics','catalysis/interfaces')
import re
s=re.sub(r'def derivationHash : String := .*', 'def derivationHash : String := '+q(namespace['DERIVATION_HASH']),s)
s=re.sub(r'def payloadHash : String := .*', 'def payloadHash : String := '+q(namespace['PRE_SOURCE_PAYLOAD_HASH']),s)
rows=namespace['CATALYSIS_INTERFACE_BLUEPRINTS']
pred='['+','.join('('+','.join(map(q,[b.claim_id,b.exact_result,b.predicted_observation_label]))+')' for b in rows)+']'
s=re.sub(r'def predictions : List \(String × String × String\) := .*','def predictions : List (String × String × String) := '+pred,s)
(r/'CatalystSeal.lean').write_text(s)
def val(v):
 if isinstance(v,str):return '.text '+q(v)
 if v is None:return '.null'
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,int):return '.integer '+str(v)
 if isinstance(v,list):return '.array ['+','.join(map(val,v))+']'
 return '.object ['+','.join('('+q(k)+','+val(x)+')' for k,x in v.items())+']'
(r/'CatalystSealInputs.lean').write_text('import SFT.Chemistry.CatalystSeal\nnamespace SFT.Chemistry.CatalystSealInputs\nopen SFT.Host.Canonical\nset_option maxRecDepth 20000\ndef derivation : String := '+q(raw(namespace['DERIVATION_PATH']))+'\ndef sealedRecord : Value := '+val(json.loads(raw(namespace['PRE_SOURCE_SEAL_PATH'])))+'\ndef validate : Except String Unit := CatalystSeal.validate derivation.toUTF8 sealedRecord\nend SFT.Chemistry.CatalystSealInputs\n')
for old,new in [('audit_equilibrium608.py','audit_catalyst614.py'),('run_equilibrium608.py','run_catalyst614.py'),('check_equilibrium_validation608.py','check_catalyst_validation614.py'),('check_chemistry_independent608.py','check_chemistry_independent614.py')]:
 s=(w/old).read_text().replace('ChemicalEquilibrium','CatalystCycle').replace('Equilibrium','Catalyst').replace('equilibrium','catalyst').replace('608','614').replace('SFT-CHEM-EQ-CHEMICAL-001','SFT-CHEM-CAT-CATALYST-001').replace('ReactionSeal','CatalystSeal')
 if old.startswith('audit_'):s=s.replace("'CatalystValidation']","'CatalystValidation','CatalystSeal','CatalystSealInputs']")
 (w/new).write_text(s)
print('Prepared exact grammar, program, validator and eight-prediction seal.')
