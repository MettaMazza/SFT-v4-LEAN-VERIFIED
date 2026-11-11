from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'bond_spec570.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','bond').replace('Unit','Bond').replace('480','570');(w/('bond_'+part+'570.py')).write_text(s);subprocess.run(['python3',str(w/('bond_'+part+'570.py'))],check=True)
 s=(w/('Bond'+part.capitalize()+'570.lean')).read_text().replace('import «work».BondCarrier570','import SFT.Foundation.CommonRefinement').replace('import «work».BondGrammar570','import SFT.Chemistry.BondGrammar').replace('SFT.Physics.Bond','SFT.Chemistry.Bond')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Bond'+part.capitalize()+'.lean')).write_text(s)
(w/'bond570_spec.json').write_text(json.dumps(values,indent=2))
