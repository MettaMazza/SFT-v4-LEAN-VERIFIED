from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'entity_spec554.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','entity').replace('Unit','Entity').replace('480','554');(w/('entity_'+part+'554.py')).write_text(s);subprocess.run(['python3',str(w/('entity_'+part+'554.py'))],check=True)
 s=(w/('Entity'+part.capitalize()+'554.lean')).read_text().replace('import «work».EntityCarrier554','import SFT.Chemistry.EntityIdentity\nimport SFT.Foundation.CommonRefinement').replace('import «work».EntityGrammar554','import SFT.Chemistry.EntityGrammar').replace('SFT.Physics.Entity','SFT.Chemistry.Entity')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Entity'+part.capitalize()+'.lean')).write_text(s)
(w/'entity554_spec.json').write_text(json.dumps(values,indent=2))
