from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'acidbase_spec582.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','acidbase').replace('Unit','Acidbase').replace('480','582');(w/('acidbase_'+part+'582.py')).write_text(s);subprocess.run(['python3',str(w/('acidbase_'+part+'582.py'))],check=True)
 s=(w/('Acidbase'+part.capitalize()+'582.lean')).read_text().replace('import «work».AcidbaseCarrier582','import SFT.Foundation.CommonRefinement').replace('import «work».AcidbaseGrammar582','import SFT.Chemistry.AcidbaseGrammar').replace('SFT.Physics.Acidbase','SFT.Chemistry.Acidbase')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with carrier :=','with pair :=')
 import re
 pieces=re.split(r'("(?:[^"\\]|\\.)*")',s)
 s=''.join(x if i%2 else x.replace('Acid-role','AcidRole').replace('Base-role','BaseRole').replace('acid-role','acidRole').replace('base-role','baseRole') for i,x in enumerate(pieces))
 (r/'SFT/Chemistry'/('Acidbase'+part.capitalize()+'.lean')).write_text(s)
(w/'acidbase582_spec.json').write_text(json.dumps(values,indent=2))
