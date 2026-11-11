from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'intermolecular_spec579.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','intermolecular').replace('Unit','Intermolecular').replace('480','579');(w/('intermolecular_'+part+'579.py')).write_text(s);subprocess.run(['python3',str(w/('intermolecular_'+part+'579.py'))],check=True)
 s=(w/('Intermolecular'+part.capitalize()+'579.lean')).read_text().replace('import «work».IntermolecularCarrier579','import SFT.Foundation.CommonRefinement').replace('import «work».IntermolecularGrammar579','import SFT.Chemistry.IntermolecularGrammar').replace('SFT.Physics.Intermolecular','SFT.Chemistry.Intermolecular')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with carrier :=','with carriers :=')
 (r/'SFT/Chemistry'/('Intermolecular'+part.capitalize()+'.lean')).write_text(s)
(w/'intermolecular579_spec.json').write_text(json.dumps(values,indent=2))
