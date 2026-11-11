from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'conservation_spec566.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','conservation').replace('Unit','Conservation').replace('480','566');(w/('conservation_'+part+'566.py')).write_text(s);subprocess.run(['python3',str(w/('conservation_'+part+'566.py'))],check=True)
 s=(w/('Conservation'+part.capitalize()+'566.lean')).read_text().replace('import «work».ConservationCarrier566','import SFT.Foundation.CommonRefinement').replace('import «work».ConservationGrammar566','import SFT.Chemistry.ConservationGrammar').replace('SFT.Physics.Conservation','SFT.Chemistry.Conservation')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Conservation'+part.capitalize()+'.lean')).write_text(s)
(w/'conservation566_spec.json').write_text(json.dumps(values,indent=2))
