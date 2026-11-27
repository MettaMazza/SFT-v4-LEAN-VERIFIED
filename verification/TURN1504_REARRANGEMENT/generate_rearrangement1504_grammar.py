from pathlib import Path
import re
w=Path('work');out=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC','''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned_rearrangement1504/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.rearrangement_reaction_batch_v1 import REARRANGEMENT_REACTION_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','rearrangement1504');(w/'rearrangement_spec1504.py').write_text(s)
for kind in ['grammar','evidence']:
 s=(w/f'coordgeometry_{kind}1446.py').read_text().replace('coordgeometry','rearrangement').replace('CoordinationGeometry','Rearrangement').replace('1446','1504')
 (w/f'rearrangement_{kind}1504.py').write_text(s);ns={};exec(s,ns)
s=(w/'RearrangementGrammar1504.lean').read_text().replace('import «work».RearrangementCarrier1504','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.RearrangementGrammar','SFT.Chemistry.RearrangementGrammar').replace('namespace SFT.Chemistry.RearrangementGrammar','namespace SFT.Chemistry.RearrangementGrammar\nset_option maxHeartbeats 20000000');(out/'RearrangementGrammar.lean').write_text(s)
s=(w/'RearrangementEvidence1504.lean').read_text().replace('import «work».RearrangementGrammar1504','import SFT.Chemistry.RearrangementGrammar\nimport SFT.Chemistry.RearrangementWitnesses').replace('SFT.Physics.RearrangementEvidence','SFT.Chemistry.RearrangementEvidence').replace('branch := "physics"','branch := "chemistry"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);spec=ns['spec'];q=ns['q'];assert len(spec.operational_witnesses)==11
s=s[:a]+'''def witnessPassed (n : Nat) : Bool := match RearrangementWitnesses.witnesses with
 | .error _ => false
 | .ok rows => (rows.drop n).headD false
'''+ 'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean (witnessPassed '+str(i)+')]'for i,(n,e,_)in enumerate(spec.operational_witnesses))+']\n'+s[b:]
(out/'RearrangementEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','Rearrangement').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr([d.key for d in spec.dimensions]));exec(s,{})
print('Generated all256 original Rearrangement alternatives; evidence uses eleven computed original witnesses')
