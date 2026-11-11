from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'buffer_spec586.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','buffer').replace('Unit','Buffer').replace('480','586');(w/('buffer_'+part+'586.py')).write_text(s);subprocess.run(['python3',str(w/('buffer_'+part+'586.py'))],check=True)
 s=(w/('Buffer'+part.capitalize()+'586.lean')).read_text().replace('import «work».BufferCarrier586','import SFT.Foundation.CommonRefinement').replace('import «work».BufferGrammar586','import SFT.Chemistry.BufferGrammar').replace('SFT.Physics.Buffer','SFT.Chemistry.Buffer')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with carrier :=','with components :=')
 import re
 pieces=re.split(r'("(?:[^"\\]|\\.)*")',s)
 s=''.join(x if i%2 else x.replace('Acid-response','AcidResponse').replace('Base-response','BaseResponse').replace('acid-response','acidResponse').replace('base-response','baseResponse').replace('Acid-role','AcidRole').replace('Base-role','BaseRole').replace('acid-role','acidRole').replace('base-role','baseRole') for i,x in enumerate(pieces))
 (r/'SFT/Chemistry'/('Buffer'+part.capitalize()+'.lean')).write_text(s)
(w/'buffer586_spec.json').write_text(json.dumps(values,indent=2))
