from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'proton_spec583.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','proton').replace('Unit','Proton').replace('480','583');(w/('proton_'+part+'583.py')).write_text(s);subprocess.run(['python3',str(w/('proton_'+part+'583.py'))],check=True)
 s=(w/('Proton'+part.capitalize()+'583.lean')).read_text().replace('import «work».ProtonCarrier583','import SFT.Foundation.CommonRefinement').replace('import «work».ProtonGrammar583','import SFT.Chemistry.ProtonGrammar').replace('SFT.Physics.Proton','SFT.Chemistry.Proton')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with pair :=','with carrier :=')
 import re
 pieces=re.split(r'("(?:[^"\\]|\\.)*")',s)
 s=''.join(x if i%2 else x.replace('Acid-role','AcidRole').replace('Base-role','BaseRole').replace('acid-role','acidRole').replace('base-role','baseRole') for i,x in enumerate(pieces))
 (r/'SFT/Chemistry'/('Proton'+part.capitalize()+'.lean')).write_text(s)
(w/'proton583_spec.json').write_text(json.dumps(values,indent=2))
