from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'limiting_spec568.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','limiting').replace('Unit','Limiting').replace('480','568');(w/('limiting_'+part+'568.py')).write_text(s);subprocess.run(['python3',str(w/('limiting_'+part+'568.py'))],check=True)
 s=(w/('Limiting'+part.capitalize()+'568.lean')).read_text().replace('import «work».LimitingCarrier568','import SFT.Foundation.CommonRefinement').replace('import «work».LimitingGrammar568','import SFT.Chemistry.LimitingGrammar').replace('SFT.Physics.Limiting','SFT.Chemistry.Limiting')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Limiting'+part.capitalize()+'.lean')).write_text(s)
(w/'limiting568_spec.json').write_text(json.dumps(values,indent=2))
