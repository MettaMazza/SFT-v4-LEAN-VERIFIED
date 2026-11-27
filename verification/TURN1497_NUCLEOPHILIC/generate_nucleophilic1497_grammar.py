from pathlib import Path
import re
w=Path('work');out=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC','''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned_nucleophilic1496/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.nucleophilic_substitution_batch_v1 import NUCLEOPHILIC_SUBSTITUTION_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','nucleophilic1497');(w/'nucleophilic_spec1497.py').write_text(s)
for kind in ['grammar','evidence']:
 s=(w/f'coordgeometry_{kind}1446.py').read_text().replace('coordgeometry','nucleophilic').replace('CoordinationGeometry','Nucleophilic').replace('1446','1497')
 (w/f'nucleophilic_{kind}1497.py').write_text(s);ns={};exec(s,ns)
s=(w/'NucleophilicGrammar1497.lean').read_text().replace('import «work».NucleophilicCarrier1497','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.NucleophilicGrammar','SFT.Chemistry.NucleophilicGrammar').replace('namespace SFT.Chemistry.NucleophilicGrammar','namespace SFT.Chemistry.NucleophilicGrammar\nset_option maxHeartbeats 20000000');(out/'NucleophilicGrammar.lean').write_text(s)
s=(w/'NucleophilicEvidence1497.lean').read_text().replace('import «work».NucleophilicGrammar1497','import SFT.Chemistry.NucleophilicGrammar\nimport SFT.Chemistry.NucleophilicWitnesses').replace('SFT.Physics.NucleophilicEvidence','SFT.Chemistry.NucleophilicEvidence').replace('branch := "physics"','branch := "chemistry"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);spec=ns['spec'];q=ns['q'];names=['completeCarrier','minimalChange','pairRetention','completeFamily','formationFirst','pairCollapse','successor'];assert len(spec.operational_witnesses)==7
s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean NucleophilicWitnesses.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,names))+']\n'+s[b:]
s=s.replace('returnName c.return','returnsName c.returns').replace('className','classAxisName');s=re.sub(r'\bc\.class\b','c.classAxis',s);(out/'NucleophilicEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','Nucleophilic').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr(['returns' if d.key=='return' else ('classAxis' if d.key=='class' else d.key) for d in spec.dimensions])).replace("types=[f.capitalize()for f in fields]","types=[('Return' if f=='returns' else ('Class' if f=='classAxis' else f.capitalize()))for f in fields]");exec(s,{})
s=(w/'build_pairexchange1102.py').read_text().replace('PairExchange','Nucleophilic').replace('pairexchange1102','nucleophilic_grammar1497');(w/'build_nucleophilic_grammar1497.py').write_text(s)
(w/'turn1064_recovery/NucleophilicProgram1497.lean').write_text((w/'turn1064_recovery/PairExchangeProgram1102.lean').read_text().replace('PairExchange','Nucleophilic'))
print('Generated original256alternatives and evidence bound to all7 proved original witnesses')
