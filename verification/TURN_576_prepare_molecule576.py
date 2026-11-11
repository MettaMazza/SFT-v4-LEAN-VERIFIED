from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'molecule_spec576.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','molecule').replace('Unit','Molecule').replace('480','576');(w/('molecule_'+part+'576.py')).write_text(s);subprocess.run(['python3',str(w/('molecule_'+part+'576.py'))],check=True)
 s=(w/('Molecule'+part.capitalize()+'576.lean')).read_text().replace('import «work».MoleculeCarrier576','import SFT.Foundation.CommonRefinement').replace('import «work».MoleculeGrammar576','import SFT.Chemistry.MoleculeGrammar').replace('SFT.Physics.Molecule','SFT.Chemistry.Molecule')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with carrier :=','with cardinality :=')
 (r/'SFT/Chemistry'/('Molecule'+part.capitalize()+'.lean')).write_text(s)
(w/'molecule576_spec.json').write_text(json.dumps(values,indent=2))
