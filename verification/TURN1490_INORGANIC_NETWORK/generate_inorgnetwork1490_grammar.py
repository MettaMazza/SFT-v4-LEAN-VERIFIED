from pathlib import Path
import re
w=Path('work');out=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC','''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned_inorgnetwork1490/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.inorganic_acid_base_redox_network_batch_v1 import INORGANIC_ACID_BASE_REDOX_NETWORK_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','inorgnetwork1490');(w/'inorgnetwork_spec1490.py').write_text(s)
for kind in ['grammar','evidence']:
 s=(w/f'coordgeometry_{kind}1446.py').read_text().replace('coordgeometry','inorgnetwork').replace('CoordinationGeometry','InorganicNetwork').replace('1446','1490')
 s=s.replace("else x)","else ('acidBase' if x=='acid-base' else x))").replace("key.capitalize()","('AcidBase' if key=='acid-base' else key.capitalize())");(w/f'inorgnetwork_{kind}1490.py').write_text(s);ns={};exec(s,ns)
s=(w/'InorganicNetworkGrammar1490.lean').read_text().replace('import «work».InorganicNetworkCarrier1490','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.InorganicNetworkGrammar','SFT.Chemistry.InorganicNetworkGrammar').replace('namespace SFT.Chemistry.InorganicNetworkGrammar','namespace SFT.Chemistry.InorganicNetworkGrammar\nset_option maxHeartbeats 20000000');(out/'InorganicNetworkGrammar.lean').write_text(s)
s=(w/'InorganicNetworkEvidence1490.lean').read_text().replace('import «work».InorganicNetworkGrammar1490','import SFT.Chemistry.InorganicNetworkGrammar\nimport SFT.Chemistry.InorganicNetworkWitnesses').replace('SFT.Physics.InorganicNetworkEvidence','SFT.Chemistry.InorganicNetworkEvidence').replace('branch := "physics"','branch := "chemistry"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);spec=ns['spec'];q=ns['q'];names=['lewisWitness','redoxWitness','reverseWitness','successorWitness','speciesWitness'];assert len(spec.operational_witnesses)==5
s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean InorganicNetworkWitnesses.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,names))+']\n'+s[b:]
s=s.replace('acid-baseName c.acid-base','acidBaseName c.acidBase').replace('className','classAxisName');s=re.sub(r'\bc\.class\b','c.classAxis',s);(out/'InorganicNetworkEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','InorganicNetwork').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr(['acidBase' if d.key=='acid-base' else ('classAxis' if d.key=='class' else d.key) for d in spec.dimensions])).replace("types=[f.capitalize()for f in fields]","types=[('AcidBase' if f=='acidBase' else ('Class' if f=='classAxis' else f.capitalize()))for f in fields]");exec(s,{})
s=(w/'build_pairexchange1102.py').read_text().replace('PairExchange','InorganicNetwork').replace('pairexchange1102','inorgnetwork_grammar1490');(w/'build_inorgnetwork_grammar1490.py').write_text(s)
(w/'turn1064_recovery/InorganicNetworkProgram1490.lean').write_text((w/'turn1064_recovery/PairExchangeProgram1102.lean').read_text().replace('PairExchange','InorganicNetwork'))
print('Generated original256alternatives and evidence bound to all4 proved original witnesses')
