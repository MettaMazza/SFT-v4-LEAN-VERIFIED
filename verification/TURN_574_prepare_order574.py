from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'order_spec574.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','order').replace('Unit','Order').replace('480','574');(w/('order_'+part+'574.py')).write_text(s);subprocess.run(['python3',str(w/('order_'+part+'574.py'))],check=True)
 s=(w/('Order'+part.capitalize()+'574.lean')).read_text().replace('import «work».OrderCarrier574','import SFT.Foundation.CommonRefinement').replace('import «work».OrderGrammar574','import SFT.Chemistry.OrderGrammar').replace('SFT.Physics.Order','SFT.Chemistry.Order')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Order'+part.capitalize()+'.lean')).write_text(s)
(w/'order574_spec.json').write_text(json.dumps(values,indent=2))
