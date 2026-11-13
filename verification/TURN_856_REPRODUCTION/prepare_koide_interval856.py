from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'koide_interval_spec856.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 subprocess.run(['python3',str(w/('koide_interval_'+part+'856.py'))],check=True)
 s=(w/('KoideInterval'+part.capitalize()+'856.lean')).read_text().replace('import «work».KoideIntervalCarrier856','import SFT.Physics.KoideComparison').replace('import «work».KoideIntervalGrammar856','import SFT.Physics.KoideIntervalGrammar\nimport SFT.Physics.KoideComparison')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['(LeptonIntervals.normalize 0 1 (by decide)).blt (LeptonIntervals.normalize 2 3 (by decide))','true','true']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:]
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000')
 (r/'SFT/Physics'/('KoideInterval'+part.capitalize()+'.lean')).write_text(s)
(w/'koide_interval856_spec.json').write_text(json.dumps(values,indent=2))
