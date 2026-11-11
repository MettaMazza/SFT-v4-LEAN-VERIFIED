from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'geometry_spec577.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','geometry').replace('Unit','Geometry').replace('480','577');(w/('geometry_'+part+'577.py')).write_text(s);subprocess.run(['python3',str(w/('geometry_'+part+'577.py'))],check=True)
 s=(w/('Geometry'+part.capitalize()+'577.lean')).read_text().replace('import «work».GeometryCarrier577','import SFT.Foundation.CommonRefinement').replace('import «work».GeometryGrammar577','import SFT.Chemistry.GeometryGrammar').replace('SFT.Physics.Geometry','SFT.Chemistry.Geometry')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Geometry'+part.capitalize()+'.lean')).write_text(s)
(w/'geometry577_spec.json').write_text(json.dumps(values,indent=2))
