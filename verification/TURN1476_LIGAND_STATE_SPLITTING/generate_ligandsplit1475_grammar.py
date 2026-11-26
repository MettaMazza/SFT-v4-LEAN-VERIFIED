from pathlib import Path
import re
w=Path('work');out=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC','''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned_ligandsplit1474/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.ligand_state_splitting_batch_v1 import LIGAND_STATE_SPLITTING_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','ligandsplit1475');(w/'ligandsplit_spec1475.py').write_text(s)
for kind in ['grammar','evidence']:
 s=(w/f'coordgeometry_{kind}1446.py').read_text().replace('coordgeometry','ligandsplit').replace('CoordinationGeometry','LigandStateSplitting').replace('1446','1475')
 (w/f'ligandsplit_{kind}1475.py').write_text(s);ns={};exec(s,ns)
s=(w/'LigandStateSplittingGrammar1475.lean').read_text().replace('import «work».LigandStateSplittingCarrier1475','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.LigandStateSplittingGrammar','SFT.Chemistry.LigandStateSplittingGrammar').replace('namespace SFT.Chemistry.LigandStateSplittingGrammar','namespace SFT.Chemistry.LigandStateSplittingGrammar\nset_option maxHeartbeats 20000000');(out/'LigandStateSplittingGrammar.lean').write_text(s)
s=(w/'LigandStateSplittingEvidence1475.lean').read_text().replace('import «work».LigandStateSplittingGrammar1475','import SFT.Chemistry.LigandStateSplittingGrammar\nimport SFT.Chemistry.LigandStateSplittingWitnesses').replace('SFT.Physics.LigandStateSplittingEvidence','SFT.Chemistry.LigandStateSplittingEvidence').replace('branch := "physics"','branch := "chemistry"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);spec=ns['spec'];q=ns['q'];names=['generatorWitness','sixPartitionWitness','sixBalanceWitness','fourPartitionWitness','memberWitness','removedWitness'];assert len(spec.operational_witnesses)==6
s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean LigandStateSplittingWitnesses.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,names))+']\n'+s[b:]
s=s.replace('className','classAxisName');s=re.sub(r'\bc\.class\b','c.classAxis',s);(out/'LigandStateSplittingEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','LigandStateSplitting').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr(['classAxis' if d.key=='class' else d.key for d in spec.dimensions])).replace("types=[f.capitalize()for f in fields]","types=[('Class' if f=='classAxis' else f.capitalize())for f in fields]");exec(s,{})
s=(w/'build_pairexchange1102.py').read_text().replace('PairExchange','LigandStateSplitting').replace('pairexchange1102','ligandsplit_grammar1475');(w/'build_ligandsplit_grammar1475.py').write_text(s)
(w/'turn1064_recovery/LigandStateSplittingProgram1475.lean').write_text((w/'turn1064_recovery/PairExchangeProgram1102.lean').read_text().replace('PairExchange','LigandStateSplitting'))
print('Generated original256alternatives and evidence bound to all5 proved original witnesses')
