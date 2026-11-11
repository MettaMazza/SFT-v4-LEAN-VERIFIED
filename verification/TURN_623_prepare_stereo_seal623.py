from pathlib import Path
import sys,json,re
sys.path.insert(0,'work')
from chirality_spec623 import namespace,raw,q
r=Path('work/constants-recovery/SFT/Chemistry')
s=(r/'CatalystSeal.lean').read_text().replace('CatalystSeal','StereoSeal').replace('catalysis/interfaces','stereochemistry/organic/polymer')
s=re.sub(r'def derivationHash : String := .*',lambda m:'def derivationHash : String := '+q(namespace['DERIVATION_HASH']),s)
s=re.sub(r'def payloadHash : String := .*',lambda m:'def payloadHash : String := '+q(namespace['PRE_SOURCE_PAYLOAD_HASH']),s)
rows=namespace['STEREOCHEMISTRY_ORGANIC_POLYMER_BLUEPRINTS']
pred='['+','.join('('+','.join(map(q,[b.claim_id,b.exact_result,b.predicted_observation_label]))+')' for b in rows)+']'
s=re.sub(r'def predictions : List \(String × String × String\) := .*',lambda m:'def predictions : List (String × String × String) := '+pred,s)
(r/'StereoSeal.lean').write_text(s)
def val(v):
 if isinstance(v,str):return '.text '+q(v)
 if v is None:return '.null'
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,int):return '.integer '+str(v)
 if isinstance(v,list):return '.array ['+','.join(map(val,v))+']'
 return '.object ['+','.join('('+q(k)+','+val(x)+')' for k,x in v.items())+']'
(r/'StereoSealInputs.lean').write_text('import SFT.Chemistry.StereoSeal\nnamespace SFT.Chemistry.StereoSealInputs\nopen SFT.Host.Canonical\nset_option maxRecDepth 20000\ndef derivation : String := '+q(raw(namespace['DERIVATION_PATH']))+'\ndef sealedRecord : Value := '+val(json.loads(raw(namespace['PRE_SOURCE_SEAL_PATH'])))+'\ndef validate : Except String Unit := StereoSeal.validate derivation.toUTF8 sealedRecord\nend SFT.Chemistry.StereoSealInputs\n')
for src,dst in [('run_catalyst614.py','run_chirality623.py'),('check_interfacetransfer_validation622.py','check_chirality_validation623.py'),('check_chemistry_independent622.py','check_chemistry_independent623.py')]:
 s=Path('work',src).read_text().replace('Catalyst','Chirality').replace('catalyst','chirality').replace('614','623').replace('ChiralitySeal','StereoSeal').replace('SFT-CHEM-CAT-CATALYST-001','SFT-CHEM-STEREO-CHIRALITY-001').replace('InterfaceTransfer','Chirality').replace('interfacetransfer','chirality').replace('622','623').replace('SFT-CHEM-INTERFACE-TRANSFER-001','SFT-CHEM-STEREO-CHIRALITY-001')
 Path('work',dst).write_text(s)
print('Stereo seal and current program checks prepared.')
