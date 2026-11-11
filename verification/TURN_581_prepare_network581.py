from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'network_spec581.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','network').replace('Unit','Network').replace('480','581');(w/('network_'+part+'581.py')).write_text(s);subprocess.run(['python3',str(w/('network_'+part+'581.py'))],check=True)
 s=(w/('Network'+part.capitalize()+'581.lean')).read_text().replace('import «work».NetworkCarrier581','import SFT.Foundation.CommonRefinement').replace('import «work».NetworkGrammar581','import SFT.Chemistry.NetworkGrammar').replace('SFT.Physics.Network','SFT.Chemistry.Network')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with carrier :=','with nodes :=')
 (r/'SFT/Chemistry'/('Network'+part.capitalize()+'.lean')).write_text(s)
(w/'network581_spec.json').write_text(json.dumps(values,indent=2))
