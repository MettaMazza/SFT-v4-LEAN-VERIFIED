from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'species_spec556.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','species').replace('Unit','Species').replace('480','556');(w/('species_'+part+'556.py')).write_text(s);subprocess.run(['python3',str(w/('species_'+part+'556.py'))],check=True)
 s=(w/('Species'+part.capitalize()+'556.lean')).read_text().replace('import «work».SpeciesCarrier556','import SFT.Chemistry.SpeciesClass\nimport SFT.Foundation.CommonRefinement').replace('import «work».SpeciesGrammar556','import SFT.Chemistry.SpeciesGrammar').replace('SFT.Physics.Species','SFT.Chemistry.Species')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Species'+part.capitalize()+'.lean')).write_text(s)
(w/'species556_spec.json').write_text(json.dumps(values,indent=2))
