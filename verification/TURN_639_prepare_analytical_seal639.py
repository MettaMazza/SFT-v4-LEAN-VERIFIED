from pathlib import Path
import sys,json,re
sys.path.insert(0,'work')
from analytical_sample_spec639 import namespace,raw,q
r=Path('work/constants-recovery/SFT/Chemistry')
s=(r/'CatalystSeal.lean').read_text().replace('CatalystSeal','AnalyticalSeal').replace('catalysis/interfaces','analytical/spectroscopic')
s=re.sub(r'def derivationHash : String := .*',lambda m:'def derivationHash : String := '+q(namespace['DERIVATION_HASH']),s)
s=re.sub(r'def payloadHash : String := .*',lambda m:'def payloadHash : String := '+q(namespace['PRE_SOURCE_PAYLOAD_HASH']),s)
rows=namespace['ANALYTICAL_SPECTROSCOPIC_BLUEPRINTS']
pred='['+','.join('('+','.join(map(q,[b.claim_id,b.exact_result,b.predicted_observation_label]))+')' for b in rows)+']'
s=re.sub(r'def predictions : List \(String × String × String\) := .*',lambda m:'def predictions : List (String × String × String) := '+pred,s)
(r/'AnalyticalSeal.lean').write_text(s)
def val(v):
 if isinstance(v,str):return '.text '+q(v)
 if v is None:return '.null'
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,int):return '.integer '+str(v)
 if isinstance(v,list):return '.array ['+','.join(map(val,v))+']'
 return '.object ['+','.join('('+q(k)+','+val(x)+')' for k,x in v.items())+']'
(r/'AnalyticalSealInputs.lean').write_text('import SFT.Chemistry.AnalyticalSeal\nnamespace SFT.Chemistry.AnalyticalSealInputs\nopen SFT.Host.Canonical\nset_option maxRecDepth 20000\ndef derivation : String := '+q(raw(namespace['DERIVATION_PATH']))+'\ndef sealedRecord : Value := '+val(json.loads(raw(namespace['PRE_SOURCE_SEAL_PATH'])))+'\ndef validate : Except String Unit := AnalyticalSeal.validate derivation.toUTF8 sealedRecord\nend SFT.Chemistry.AnalyticalSealInputs\n')
