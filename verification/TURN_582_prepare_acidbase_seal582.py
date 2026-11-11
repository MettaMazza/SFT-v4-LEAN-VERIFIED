from pathlib import Path
import sys,json
sys.path.insert(0,'work')
from acidbase_spec582 import raw,namespace,q
r=Path('work/constants-recovery/SFT/Chemistry')
s=(r/'MolecularSeal.lean').read_text().replace('MolecularSeal','AcidbaseSeal')
a=s.index('def derivationHash');b=s.index('def objectSize')
predictions=[(x.claim_id,x.exact_result,x.predicted_observation_label) for x in namespace['ACID_BASE_BLUEPRINTS']]
s=s[:a]+'def derivationHash : String := '+q(namespace['DERIVATION_HASH'])+'\ndef payloadHash : String := '+q(namespace['PRE_SOURCE_PAYLOAD_HASH'])+'\ndef predictions : List (String × String × String) := ['+','.join('('+','.join(map(q,x))+')' for x in predictions)+']\n'+s[b:]
a=s.index('def resolveDependency');b=s.index('def validate',a);s=s[:a]+s[b:]
s=s.replace('(sealedRecord amendment : Value)','(sealedRecord : Value)').replace('molecular','acid/base')
a=s.index(' if !isFalse');b=s.index(' pure ()',a)
s=s[:a]+''' if !isFalse (field sealedRecord "external_source_identities_selected") || !isFalse (field sealedRecord "external_target_content_opened") then
  throw "acid/base derivation was not sealed before source selection"
'''+s[b:]
a=s.index('theorem positionAlias');s=s[:a]+'end SFT.Chemistry.AcidbaseSeal\n';(r/'AcidbaseSeal.lean').write_text(s)
def cv(v):
 if v is None:return '.null'
 if isinstance(v,str):return '.text '+q(v)
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,int):return '.integer '+str(v)
 if isinstance(v,list):return '.array ['+','.join(map(cv,v))+']'
 if isinstance(v,dict):return '.object ['+','.join('('+q(k)+','+cv(x)+')' for k,x in v.items())+']'
 raise TypeError(v)
(r/'AcidbaseSealInputs.lean').write_text('import SFT.Chemistry.AcidbaseSeal\nnamespace SFT.Chemistry.AcidbaseSealInputs\nopen SFT.Host.Canonical\nset_option maxRecDepth 20000\ndef derivation : String := '+q(raw(namespace['DERIVATION_PATH']))+'\ndef sealedRecord : Value := '+cv(json.loads(raw(namespace['PRE_SOURCE_SEAL_PATH'])))+'\ndef validate : Except String Unit := AcidbaseSeal.validate derivation.toUTF8 sealedRecord\nend SFT.Chemistry.AcidbaseSealInputs\n')
