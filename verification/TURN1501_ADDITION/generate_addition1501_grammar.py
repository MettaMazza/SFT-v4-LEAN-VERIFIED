from pathlib import Path
import re
w=Path('work');out=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC','''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned_addition1499/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.addition_reaction_batch_v3 import ADDITION_REACTION_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','addition1501');(w/'addition_spec1501.py').write_text(s)
for kind in ['grammar','evidence']:
 s=(w/f'coordgeometry_{kind}1446.py').read_text().replace('coordgeometry','addition').replace('CoordinationGeometry','Addition').replace('1446','1501')
 (w/f'addition_{kind}1501.py').write_text(s);ns={};exec(s,ns)
s=(w/'AdditionGrammar1501.lean').read_text().replace('import «work».AdditionCarrier1501','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.AdditionGrammar','SFT.Chemistry.AdditionGrammar').replace('namespace SFT.Chemistry.AdditionGrammar','namespace SFT.Chemistry.AdditionGrammar\nset_option maxHeartbeats 20000000');(out/'AdditionGrammar.lean').write_text(s)
s=(w/'AdditionEvidence1501.lean').read_text().replace('import «work».AdditionGrammar1501','import SFT.Chemistry.AdditionGrammar\nimport SFT.Chemistry.AdditionWitnesses').replace('SFT.Physics.AdditionEvidence','SFT.Chemistry.AdditionEvidence').replace('branch := "physics"','branch := "chemistry"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);spec=ns['spec'];q=ns['q'];assert len(spec.operational_witnesses)==9
s=s[:a]+'''def witnessPassed (n : Nat) : Bool := match AdditionWitnesses.witnesses with
 | .error _ => false
 | .ok rows => (rows.drop n).headD false
'''+ 'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean (witnessPassed '+str(i)+')]'for i,(n,e,_)in enumerate(spec.operational_witnesses))+']\n'+s[b:]
(out/'AdditionEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','Addition').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr([d.key for d in spec.dimensions]));exec(s,{})
print('Generated all256 original Addition alternatives; evidence uses nine computed original witnesses')
