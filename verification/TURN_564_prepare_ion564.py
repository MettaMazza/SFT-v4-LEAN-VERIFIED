from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'ion_spec564.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','ion').replace('Unit','Ion').replace('480','564');(w/('ion_'+part+'564.py')).write_text(s);subprocess.run(['python3',str(w/('ion_'+part+'564.py'))],check=True)
 s=(w/('Ion'+part.capitalize()+'564.lean')).read_text().replace('import «work».IonCarrier564','import SFT.Chemistry.IonTransfer\nimport SFT.Foundation.CommonRefinement').replace('import «work».IonGrammar564','import SFT.Chemistry.IonGrammar').replace('SFT.Physics.Ion','SFT.Chemistry.Ion')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Ion'+part.capitalize()+'.lean')).write_text(s)
(w/'ion564_spec.json').write_text(json.dumps(values,indent=2))
