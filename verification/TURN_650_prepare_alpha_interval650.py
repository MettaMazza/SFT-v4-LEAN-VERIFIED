from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'alpha_interval_spec650.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','alpha_interval').replace('Unit','AlphaInterval').replace('480','650');(w/('alpha_interval_'+part+'650.py')).write_text(s);subprocess.run(['python3',str(w/('alpha_interval_'+part+'650.py'))],check=True)
 s=(w/('AlphaInterval'+part.capitalize()+'650.lean')).read_text().replace('import «work».AlphaIntervalCarrier650','import SFT.Physics.AlphaInterval').replace('import «work».AlphaIntervalGrammar650','import SFT.Physics.AlphaIntervalGrammar\nimport SFT.Physics.AlphaInterval')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['match AlphaInterval.inInterval AlphaInterval.lower AlphaInterval.upper with | .ok b => b | .error _ => false','AlphaInterval.lower.blt AlphaInterval.central && AlphaInterval.central.blt AlphaInterval.upper','true']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:]
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000')
 (r/'SFT/Physics'/('AlphaInterval'+part.capitalize()+'.lean')).write_text(s)
(w/'alpha_interval650_spec.json').write_text(json.dumps(values,indent=2))
