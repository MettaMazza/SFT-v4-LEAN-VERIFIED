from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'periodicrecurrence_spec562.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','periodicrecurrence').replace('Unit','PeriodicRecurrence').replace('480','562');(w/('periodicrecurrence_'+part+'562.py')).write_text(s);subprocess.run(['python3',str(w/('periodicrecurrence_'+part+'562.py'))],check=True)
 s=(w/('PeriodicRecurrence'+part.capitalize()+'562.lean')).read_text().replace('import «work».PeriodicRecurrenceCarrier562','import SFT.Chemistry.PeriodicRecurrenceTrace\nimport SFT.Foundation.CommonRefinement').replace('import «work».PeriodicRecurrenceGrammar562','import SFT.Chemistry.PeriodicRecurrenceGrammar').replace('SFT.Physics.PeriodicRecurrence','SFT.Chemistry.PeriodicRecurrence')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('PeriodicRecurrence'+part.capitalize()+'.lean')).write_text(s)
(w/'periodicrecurrence562_spec.json').write_text(json.dumps(values,indent=2))
