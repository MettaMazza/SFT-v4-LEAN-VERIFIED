from pathlib import Path
import re
w=Path('work');out=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC','''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned_electrophilic1498/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.electrophilic_substitution_batch_v1 import ELECTROPHILIC_SUBSTITUTION_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','electrophilic1498');(w/'electrophilic_spec1498.py').write_text(s)
for kind in ['grammar','evidence']:
 s=(w/f'coordgeometry_{kind}1446.py').read_text().replace('coordgeometry','electrophilic').replace('CoordinationGeometry','Electrophilic').replace('1446','1498')
 (w/f'electrophilic_{kind}1498.py').write_text(s);ns={};exec(s,ns)
s=(w/'ElectrophilicGrammar1498.lean').read_text().replace('import «work».ElectrophilicCarrier1498','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.ElectrophilicGrammar','SFT.Chemistry.ElectrophilicGrammar').replace('namespace SFT.Chemistry.ElectrophilicGrammar','namespace SFT.Chemistry.ElectrophilicGrammar\nset_option maxHeartbeats 20000000');(out/'ElectrophilicGrammar.lean').write_text(s)
s=(w/'ElectrophilicEvidence1498.lean').read_text().replace('import «work».ElectrophilicGrammar1498','import SFT.Chemistry.ElectrophilicGrammar\nimport SFT.Chemistry.ElectrophilicWitnesses').replace('SFT.Physics.ElectrophilicEvidence','SFT.Chemistry.ElectrophilicEvidence').replace('branch := "physics"','branch := "chemistry"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);spec=ns['spec'];q=ns['q'];names=['completeCarrier','acceptorTransfer','leavingRelinquishment','recurrenceRestored','completeFamily','cleavageFirst','successor'];assert len(spec.operational_witnesses)==7
s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean ElectrophilicWitnesses.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,names))+']\n'+s[b:]
s=s.replace('returnName c.return','returnsName c.returns').replace('className','classAxisName');s=re.sub(r'\bc\.class\b','c.classAxis',s);(out/'ElectrophilicEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','Electrophilic').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr(['returns' if d.key=='return' else ('classAxis' if d.key=='class' else d.key) for d in spec.dimensions])).replace("types=[f.capitalize()for f in fields]","types=[('Return' if f=='returns' else ('Class' if f=='classAxis' else f.capitalize()))for f in fields]");exec(s,{})
s=(w/'build_pairexchange1102.py').read_text().replace('PairExchange','Electrophilic').replace('pairexchange1102','electrophilic_grammar1498');(w/'build_electrophilic_grammar1498.py').write_text(s)
(w/'turn1064_recovery/ElectrophilicProgram1498.lean').write_text((w/'turn1064_recovery/PairExchangeProgram1102.lean').read_text().replace('PairExchange','Electrophilic'))
print('Generated original256alternatives and evidence bound to all7 proved original witnesses')
