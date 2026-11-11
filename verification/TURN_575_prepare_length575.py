from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'length_spec575.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','length').replace('Unit','Length').replace('480','575');(w/('length_'+part+'575.py')).write_text(s);subprocess.run(['python3',str(w/('length_'+part+'575.py'))],check=True)
 s=(w/('Length'+part.capitalize()+'575.lean')).read_text().replace('import «work».LengthCarrier575','import SFT.Foundation.CommonRefinement').replace('import «work».LengthGrammar575','import SFT.Chemistry.LengthGrammar').replace('SFT.Physics.Length','SFT.Chemistry.Length')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Length'+part.capitalize()+'.lean')).write_text(s)
(w/'length575_spec.json').write_text(json.dumps(values,indent=2))
