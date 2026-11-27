from pathlib import Path
import re
w=Path('work');out=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC','''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned_conformerpopulation1495/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.conformer_population_ordering_batch_v1 import CONFORMER_POPULATION_ORDERING_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','conformerpopulation1495');(w/'conformerpopulation_spec1495.py').write_text(s)
for kind in ['grammar','evidence']:
 s=(w/f'coordgeometry_{kind}1446.py').read_text().replace('coordgeometry','conformerpopulation').replace('CoordinationGeometry','ConformerPopulation').replace('1446','1495')
 (w/f'conformerpopulation_{kind}1495.py').write_text(s);ns={};exec(s,ns)
s=(w/'ConformerPopulationGrammar1495.lean').read_text().replace('import «work».ConformerPopulationCarrier1495','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.ConformerPopulationGrammar','SFT.Chemistry.ConformerPopulationGrammar').replace('namespace SFT.Chemistry.ConformerPopulationGrammar','namespace SFT.Chemistry.ConformerPopulationGrammar\nset_option maxHeartbeats 20000000');(out/'ConformerPopulationGrammar.lean').write_text(s)
s=(w/'ConformerPopulationEvidence1495.lean').read_text().replace('import «work».ConformerPopulationGrammar1495','import SFT.Chemistry.ConformerPopulationGrammar\nimport SFT.Chemistry.ConformerPopulationWitnesses').replace('SFT.Physics.ConformerPopulationEvidence','SFT.Chemistry.ConformerPopulationEvidence').replace('branch := "physics"','branch := "chemistry"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);spec=ns['spec'];q=ns['q'];names=['populationWitness','censusWitness','energyWitness','orderWitness','successorWitness','reverseTakeWitness','foreignWitness'];assert len(spec.operational_witnesses)==7
s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean ConformerPopulationWitnesses.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,names))+']\n'+s[b:]
s=s.replace('returnName c.return','returnsName c.returns').replace('className','classAxisName');s=re.sub(r'\bc\.class\b','c.classAxis',s);(out/'ConformerPopulationEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','ConformerPopulation').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr(['returns' if d.key=='return' else ('classAxis' if d.key=='class' else d.key) for d in spec.dimensions])).replace("types=[f.capitalize()for f in fields]","types=[('Return' if f=='returns' else ('Class' if f=='classAxis' else f.capitalize()))for f in fields]");exec(s,{})
s=(w/'build_pairexchange1102.py').read_text().replace('PairExchange','ConformerPopulation').replace('pairexchange1102','conformerpopulation_grammar1495');(w/'build_conformerpopulation_grammar1495.py').write_text(s)
(w/'turn1064_recovery/ConformerPopulationProgram1495.lean').write_text((w/'turn1064_recovery/PairExchangeProgram1102.lean').read_text().replace('PairExchange','ConformerPopulation'))
print('Generated original256alternatives and evidence bound to all7 proved original witnesses')
