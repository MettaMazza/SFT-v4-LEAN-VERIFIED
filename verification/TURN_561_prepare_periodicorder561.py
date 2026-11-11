from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'periodicorder_spec561.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','periodicorder').replace('Unit','PeriodicOrder').replace('480','561');(w/('periodicorder_'+part+'561.py')).write_text(s);subprocess.run(['python3',str(w/('periodicorder_'+part+'561.py'))],check=True)
 s=(w/('PeriodicOrder'+part.capitalize()+'561.lean')).read_text().replace('import «work».PeriodicOrderCarrier561','import SFT.Chemistry.PeriodicOrderTrace\nimport SFT.Foundation.CommonRefinement').replace('import «work».PeriodicOrderGrammar561','import SFT.Chemistry.PeriodicOrderGrammar').replace('SFT.Physics.PeriodicOrder','SFT.Chemistry.PeriodicOrder')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('PeriodicOrder'+part.capitalize()+'.lean')).write_text(s)
(w/'periodicorder561_spec.json').write_text(json.dumps(values,indent=2))
