from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'composition_spec565.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','composition').replace('Unit','Composition').replace('480','565');(w/('composition_'+part+'565.py')).write_text(s);subprocess.run(['python3',str(w/('composition_'+part+'565.py'))],check=True)
 s=(w/('Composition'+part.capitalize()+'565.lean')).read_text().replace('import «work».CompositionCarrier565','import SFT.Foundation.CommonRefinement').replace('import «work».CompositionGrammar565','import SFT.Chemistry.CompositionGrammar').replace('SFT.Physics.Composition','SFT.Chemistry.Composition')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Composition'+part.capitalize()+'.lean')).write_text(s)
(w/'composition565_spec.json').write_text(json.dumps(values,indent=2))
