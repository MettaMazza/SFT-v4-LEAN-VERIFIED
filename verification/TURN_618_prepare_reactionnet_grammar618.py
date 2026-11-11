from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'reactionnet_spec618.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','reactionnet').replace('Unit','ReactionNet').replace('480','618');(w/('reactionnet_'+part+'618.py')).write_text(s);subprocess.run(['python3',str(w/('reactionnet_'+part+'618.py'))],check=True)
 s=(w/('ReactionNet'+part.capitalize()+'618.lean')).read_text().replace('import «work».ReactionNetCarrier618','import SFT.Foundation.CommonRefinement').replace('import «work».ReactionNetGrammar618','import SFT.Chemistry.ReactionNetGrammar').replace('SFT.Physics.ReactionNet','SFT.Chemistry.ReactionNet')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with identity :=','with identity :=').replace('memMap _ extension _ hextension','memMap _ extra _ hextra')
 import re
 pieces=re.split(r'("(?:[^"\\]|\\.)*")',s)
 s=''.join(x if i%2 else x.replace('Unequal-bond','UnequalBond').replace('Equal-bond','EqualBond').replace('unequal-bond','unequalBond').replace('equal-bond','equalBond').replace('Acid-response','AcidResponse').replace('Base-response','BaseResponse').replace('acid-response','acidResponse').replace('base-response','baseResponse').replace('Acid-role','AcidRole').replace('Base-role','BaseRole').replace('acid-role','acidRole').replace('base-role','baseRole') for i,x in enumerate(pieces))
 (r/'SFT/Chemistry'/('ReactionNet'+part.capitalize()+'.lean')).write_text(s)
(w/'reactionnet618_spec.json').write_text(json.dumps(values,indent=2))
