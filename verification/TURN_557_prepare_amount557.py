from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'amount_spec557.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','amount').replace('Unit','Amount').replace('480','557');(w/('amount_'+part+'557.py')).write_text(s);subprocess.run(['python3',str(w/('amount_'+part+'557.py'))],check=True)
 s=(w/('Amount'+part.capitalize()+'557.lean')).read_text().replace('import «work».AmountCarrier557','import SFT.Chemistry.AmountCount\nimport SFT.Foundation.CommonRefinement').replace('import «work».AmountGrammar557','import SFT.Chemistry.AmountGrammar').replace('SFT.Physics.Amount','SFT.Chemistry.Amount')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Amount'+part.capitalize()+'.lean')).write_text(s)
(w/'amount557_spec.json').write_text(json.dumps(values,indent=2))
