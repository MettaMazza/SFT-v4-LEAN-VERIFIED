from pathlib import Path
w=Path('work');out=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC','''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned1309/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.anal_performance_batch_v1 import PRECISION_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','precision1309');(w/'precision_spec1309.py').write_text(s)
for kind in ['grammar','evidence']:
 s=(w/f'statesymmetry_{kind}1100.py').read_text().replace('statesymmetry','precision').replace('StateSymmetry','AnalyticalPrecision').replace('1100','1309');(w/f'precision_{kind}1309.py').write_text(s)
 ns={};exec(s,ns)
s=(w/'AnalyticalPrecisionGrammar1309.lean').read_text().replace('import «work».AnalyticalPrecisionCarrier1309','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.AnalyticalPrecisionGrammar','SFT.Chemistry.AnalyticalPrecisionGrammar').replace('namespace SFT.Chemistry.AnalyticalPrecisionGrammar','namespace SFT.Chemistry.AnalyticalPrecisionGrammar\nset_option maxHeartbeats 20000000');(out/'AnalyticalPrecisionGrammar.lean').write_text(s)
s=(w/'AnalyticalPrecisionEvidence1309.lean').read_text().replace('import «work».AnalyticalPrecisionGrammar1309','import SFT.Chemistry.AnalyticalPrecisionGrammar\nimport SFT.Chemistry.AnalyticalPrecision').replace('SFT.Physics.AnalyticalPrecisionEvidence','SFT.Chemistry.AnalyticalPrecisionEvidence').replace('branch := "physics"','branch := "chemistry"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);spec=ns['spec'];q=ns['q'];names=['identityWitness','conditionsWitness','supportWitness','comparisonWitness','spreadWitness','classWitness','adverseWitness','successorWitness'];assert len(spec.operational_witnesses)==len(names)
s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean AnalyticalPrecision.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,names))+']\n'+s[b:];(out/'AnalyticalPrecisionEvidence.lean').write_text(s.replace('{survivor with carrier := .rejected}','{survivor with identity := .rejected}'))
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','AnalyticalPrecision').replace('types=[f.capitalize()for f in fields]',"types=['Class' if f=='classAxis' else f.capitalize()for f in fields]").replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr(['classAxis' if d.key=='class' else d.key for d in spec.dimensions]));exec(s,{})
s=(w/'build_pairexchange1102.py').read_text().replace('PairExchange','AnalyticalPrecision').replace('pairexchange1102','precision_grammar1309');(w/'build_precision_grammar1309.py').write_text(s)
(w/'turn1064_recovery/AnalyticalPrecisionProgram1309.lean').write_text((w/'turn1064_recovery/PairExchangeProgram1102.lean').read_text().replace('PairExchange','AnalyticalPrecision'))
print('Staged the original256-form precision grammar,observational programme and8source witnesses; native verification is pending.')
