from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'pathway_spec616.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','pathway').replace('Unit','Pathway').replace('480','616');(w/('pathway_'+part+'616.py')).write_text(s);subprocess.run(['python3',str(w/('pathway_'+part+'616.py'))],check=True)
 s=(w/('Pathway'+part.capitalize()+'616.lean')).read_text().replace('import «work».PathwayCarrier616','import SFT.Foundation.CommonRefinement').replace('import «work».PathwayGrammar616','import SFT.Chemistry.PathwayGrammar').replace('SFT.Physics.Pathway','SFT.Chemistry.Pathway')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with identity :=','with identity :=').replace('memMap _ extension _ hextension','memMap _ extra _ hextra')
 import re
 pieces=re.split(r'("(?:[^"\\]|\\.)*")',s)
 s=''.join(x if i%2 else x.replace('Unequal-bond','UnequalBond').replace('Equal-bond','EqualBond').replace('unequal-bond','unequalBond').replace('equal-bond','equalBond').replace('Acid-response','AcidResponse').replace('Base-response','BaseResponse').replace('acid-response','acidResponse').replace('base-response','baseResponse').replace('Acid-role','AcidRole').replace('Base-role','BaseRole').replace('acid-role','acidRole').replace('base-role','baseRole') for i,x in enumerate(pieces))
 (r/'SFT/Chemistry'/('Pathway'+part.capitalize()+'.lean')).write_text(s)
(w/'pathway616_spec.json').write_text(json.dumps(values,indent=2))
