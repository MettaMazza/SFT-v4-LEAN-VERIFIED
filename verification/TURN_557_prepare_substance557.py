from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'substance_spec557.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','substance').replace('Unit','Substance').replace('480','557');(w/('substance_'+part+'557.py')).write_text(s);subprocess.run(['python3',str(w/('substance_'+part+'557.py'))],check=True)
 s=(w/('Substance'+part.capitalize()+'557.lean')).read_text().replace('import «work».SubstanceCarrier557','import SFT.Chemistry.SubstanceIdentity\nimport SFT.Foundation.CommonRefinement').replace('import «work».SubstanceGrammar557','import SFT.Chemistry.SubstanceGrammar').replace('SFT.Physics.Substance','SFT.Chemistry.Substance')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"').replace('with carrier := .rejected','with composition := .rejected')
 (r/'SFT/Chemistry'/('Substance'+part.capitalize()+'.lean')).write_text(s)
(w/'substance557_spec.json').write_text(json.dumps(values,indent=2))
