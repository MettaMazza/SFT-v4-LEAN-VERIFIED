from pathlib import Path
import re
w=Path('work');out=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC','''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned_elimination1503/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.elimination_reaction_batch_v1 import ELIMINATION_REACTION_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','elimination1503');(w/'elimination_spec1503.py').write_text(s)
for kind in ['grammar','evidence']:
 s=(w/f'coordgeometry_{kind}1446.py').read_text().replace('coordgeometry','elimination').replace('CoordinationGeometry','Elimination').replace('1446','1503')
 (w/f'elimination_{kind}1503.py').write_text(s);ns={};exec(s,ns)
s=(w/'EliminationGrammar1503.lean').read_text().replace('import «work».EliminationCarrier1503','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.EliminationGrammar','SFT.Chemistry.EliminationGrammar').replace('namespace SFT.Chemistry.EliminationGrammar','namespace SFT.Chemistry.EliminationGrammar\nset_option maxHeartbeats 20000000');(out/'EliminationGrammar.lean').write_text(s)
s=(w/'EliminationEvidence1503.lean').read_text().replace('import «work».EliminationGrammar1503','import SFT.Chemistry.EliminationGrammar\nimport SFT.Chemistry.Elimination').replace('SFT.Physics.EliminationEvidence','SFT.Chemistry.EliminationEvidence').replace('branch := "physics"','branch := "chemistry"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);spec=ns['spec'];q=ns['q'];assert len(spec.operational_witnesses)==8
s=s[:a]+'''def witnessPassed (n : Nat) : Bool := match Elimination.witnesses with
 | .error _ => false
 | .ok rows => (rows.drop n).headD false
'''+ 'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean (witnessPassed '+str(i)+')]'for i,(n,e,_)in enumerate(spec.operational_witnesses))+']\n'+s[b:]
(out/'EliminationEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','Elimination').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr([d.key for d in spec.dimensions]));exec(s,{})
print('Generated all256 original Elimination alternatives; evidence uses eight computed original witnesses')
