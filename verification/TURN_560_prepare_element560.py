from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'element_spec560.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','element').replace('Unit','Element').replace('480','560');(w/('element_'+part+'560.py')).write_text(s);subprocess.run(['python3',str(w/('element_'+part+'560.py'))],check=True)
 s=(w/('Element'+part.capitalize()+'560.lean')).read_text().replace('import «work».ElementCarrier560','import SFT.Chemistry.ElementIdentity\nimport SFT.Foundation.CommonRefinement').replace('import «work».ElementGrammar560','import SFT.Chemistry.ElementGrammar').replace('SFT.Physics.Element','SFT.Chemistry.Element')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Element'+part.capitalize()+'.lean')).write_text(s)
(w/'element560_spec.json').write_text(json.dumps(values,indent=2))
