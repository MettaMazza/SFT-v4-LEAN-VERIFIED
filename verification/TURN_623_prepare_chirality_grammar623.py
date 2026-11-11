from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'chirality_spec623.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','chirality').replace('Unit','Chirality').replace('480','623');(w/('chirality_'+part+'623.py')).write_text(s);subprocess.run(['python3',str(w/('chirality_'+part+'623.py'))],check=True)
 s=(w/('Chirality'+part.capitalize()+'623.lean')).read_text().replace('import «work».ChiralityCarrier623','import SFT.Foundation.CommonRefinement').replace('import «work».ChiralityGrammar623','import SFT.Chemistry.ChiralityGrammar').replace('SFT.Physics.Chirality','SFT.Chemistry.Chirality')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with identity :=','with identity :=').replace('memMap _ extension _ hextension','memMap _ extra _ hextra')
 import re
 pieces=re.split(r'("(?:[^"\\]|\\.)*")',s)
 s=''.join(x if i%2 else x.replace('Unequal-bond','UnequalBond').replace('Equal-bond','EqualBond').replace('unequal-bond','unequalBond').replace('equal-bond','equalBond').replace('Acid-response','AcidResponse').replace('Base-response','BaseResponse').replace('acid-response','acidResponse').replace('base-response','baseResponse').replace('Acid-role','AcidRole').replace('Base-role','BaseRole').replace('acid-role','acidRole').replace('base-role','baseRole') for i,x in enumerate(pieces))
 (r/'SFT/Chemistry'/('Chirality'+part.capitalize()+'.lean')).write_text(s)
(w/'chirality623_spec.json').write_text(json.dumps(values,indent=2))
