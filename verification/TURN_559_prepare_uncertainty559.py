from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'uncertainty_spec559.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','uncertainty').replace('Unit','Uncertainty').replace('480','559');(w/('uncertainty_'+part+'559.py')).write_text(s);subprocess.run(['python3',str(w/('uncertainty_'+part+'559.py'))],check=True)
 s=(w/('Uncertainty'+part.capitalize()+'559.lean')).read_text().replace('import «work».UncertaintyCarrier559','import SFT.Chemistry.UncertaintyRecord\nimport SFT.Foundation.CommonRefinement').replace('import «work».UncertaintyGrammar559','import SFT.Chemistry.UncertaintyGrammar').replace('SFT.Physics.Uncertainty','SFT.Chemistry.Uncertainty')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Uncertainty'+part.capitalize()+'.lean')).write_text(s)
(w/'uncertainty559_spec.json').write_text(json.dumps(values,indent=2))
