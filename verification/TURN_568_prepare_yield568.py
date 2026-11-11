from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'yield_spec568.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','yield').replace('Unit','Yield').replace('480','568');(w/('yield_'+part+'568.py')).write_text(s);subprocess.run(['python3',str(w/('yield_'+part+'568.py'))],check=True)
 s=(w/('Yield'+part.capitalize()+'568.lean')).read_text().replace('import «work».YieldCarrier568','import SFT.Foundation.CommonRefinement').replace('import «work».YieldGrammar568','import SFT.Chemistry.YieldGrammar').replace('SFT.Physics.Yield','SFT.Chemistry.Yield')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Yield'+part.capitalize()+'.lean')).write_text(s)
(w/'yield568_spec.json').write_text(json.dumps(values,indent=2))
