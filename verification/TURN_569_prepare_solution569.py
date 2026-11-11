from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'solution_spec569.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','solution').replace('Unit','Solution').replace('480','569');(w/('solution_'+part+'569.py')).write_text(s);subprocess.run(['python3',str(w/('solution_'+part+'569.py'))],check=True)
 s=(w/('Solution'+part.capitalize()+'569.lean')).read_text().replace('import «work».SolutionCarrier569','import SFT.Foundation.CommonRefinement').replace('import «work».SolutionGrammar569','import SFT.Chemistry.SolutionGrammar').replace('SFT.Physics.Solution','SFT.Chemistry.Solution')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Solution'+part.capitalize()+'.lean')).write_text(s)
(w/'solution569_spec.json').write_text(json.dumps(values,indent=2))
