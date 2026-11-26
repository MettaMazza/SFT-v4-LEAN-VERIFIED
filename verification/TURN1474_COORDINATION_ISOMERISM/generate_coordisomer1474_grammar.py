from pathlib import Path
import re
w=Path('work');out=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC','''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned_coordisomer1473/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.coordination_isomerism_batch_v1 import COORDINATION_ISOMERISM_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','coordisomer1474');(w/'coordisomer_spec1474.py').write_text(s)
for kind in ['grammar','evidence']:
 s=(w/f'coordgeometry_{kind}1446.py').read_text().replace('coordgeometry','coordisomer').replace('CoordinationGeometry','CoordinationIsomerism').replace('1446','1474')
 (w/f'coordisomer_{kind}1474.py').write_text(s);ns={};exec(s,ns)
s=(w/'CoordinationIsomerismGrammar1474.lean').read_text().replace('import «work».CoordinationIsomerismCarrier1474','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.CoordinationIsomerismGrammar','SFT.Chemistry.CoordinationIsomerismGrammar').replace('namespace SFT.Chemistry.CoordinationIsomerismGrammar','namespace SFT.Chemistry.CoordinationIsomerismGrammar\nset_option maxHeartbeats 20000000');(out/'CoordinationIsomerismGrammar.lean').write_text(s)
s=(w/'CoordinationIsomerismEvidence1474.lean').read_text().replace('import «work».CoordinationIsomerismGrammar1474','import SFT.Chemistry.CoordinationIsomerismGrammar\nimport SFT.Chemistry.CoordinationIsomerismWitnesses').replace('SFT.Physics.CoordinationIsomerismEvidence','SFT.Chemistry.CoordinationIsomerismEvidence').replace('branch := "physics"','branch := "chemistry"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);spec=ns['spec'];q=ns['q'];names=['equivalenceWitness','attachmentWitness','mirrorWitness','orientationWitness','successorWitness'];assert len(spec.operational_witnesses)==5
s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean CoordinationIsomerismWitnesses.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,names))+']\n'+s[b:]
s=s.replace('className','classAxisName');s=re.sub(r'\bc\.class\b','c.classAxis',s);(out/'CoordinationIsomerismEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','CoordinationIsomerism').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr(['classAxis' if d.key=='class' else d.key for d in spec.dimensions])).replace("types=[f.capitalize()for f in fields]","types=[('Class' if f=='classAxis' else f.capitalize())for f in fields]");exec(s,{})
s=(w/'build_pairexchange1102.py').read_text().replace('PairExchange','CoordinationIsomerism').replace('pairexchange1102','coordisomer_grammar1474');(w/'build_coordisomer_grammar1474.py').write_text(s)
(w/'turn1064_recovery/CoordinationIsomerismProgram1474.lean').write_text((w/'turn1064_recovery/PairExchangeProgram1102.lean').read_text().replace('PairExchange','CoordinationIsomerism'))
print('Generated original256alternatives and evidence bound to all5 proved original witnesses')
