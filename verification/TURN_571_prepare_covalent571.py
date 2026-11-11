from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'covalent_spec571.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','covalent').replace('Unit','Covalent').replace('480','571');(w/('covalent_'+part+'571.py')).write_text(s);subprocess.run(['python3',str(w/('covalent_'+part+'571.py'))],check=True)
 s=(w/('Covalent'+part.capitalize()+'571.lean')).read_text().replace('import «work».CovalentCarrier571','import SFT.Foundation.CommonRefinement').replace('import «work».CovalentGrammar571','import SFT.Chemistry.CovalentGrammar').replace('SFT.Physics.Covalent','SFT.Chemistry.Covalent')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Covalent'+part.capitalize()+'.lean')).write_text(s)
(w/'covalent571_spec.json').write_text(json.dumps(values,indent=2))
