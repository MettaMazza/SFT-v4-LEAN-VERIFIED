from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'isomer_spec578.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','isomer').replace('Unit','Isomer').replace('480','578');(w/('isomer_'+part+'578.py')).write_text(s);subprocess.run(['python3',str(w/('isomer_'+part+'578.py'))],check=True)
 s=(w/('Isomer'+part.capitalize()+'578.lean')).read_text().replace('import «work».IsomerCarrier578','import SFT.Foundation.CommonRefinement').replace('import «work».IsomerGrammar578','import SFT.Chemistry.IsomerGrammar').replace('SFT.Physics.Isomer','SFT.Chemistry.Isomer')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with carrier :=','with pair :=').replace('c.structure','c.structural')
 if part=='grammar':
  import re
  parts=re.split(r'("(?:[^"\\]|\\.)*")',s)
  s=''.join(x if i%2 else re.sub(r'\bstructure\b','structural',x) for i,x in enumerate(parts)).replace('structural Candidate where','structure Candidate where')
 (r/'SFT/Chemistry'/('Isomer'+part.capitalize()+'.lean')).write_text(s)
(w/'isomer578_spec.json').write_text(json.dumps(values,indent=2))
