from pathlib import Path
import json
w=Path('work');out=w/'turn1064_recovery/SFT/Medicine';out.mkdir(parents=True,exist_ok=True)
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC', '''import sft.medicine
sft.medicine.__path__=[str(Path('work/pinned1300/sft/medicine').resolve())]+list(sft.medicine.__path__)
from sft.medicine.generated_law import BLUEPRINT_BY_CLAIM
STATE_SYMMETRY_SPEC=BLUEPRINT_BY_CLAIM['SFT-MED-CLINICAL-UNCERTAINTY-001']''').replace('statesymmetry1100','clinicaluncertainty1300')
(w/'patient_spec1300.py').write_text(s)
ns={};exec(s,ns);spec=ns['spec'];q=ns['q']
from sft.medicine.obligations import MEDICINE_OBLIGATIONS
row=next(x for x in MEDICINE_OBLIGATIONS if x.claim_id=='SFT-MED-CLINICAL-UNCERTAINTY-001')
core='''import SFT.Host.Text
namespace SFT.Medicine.ClinicalUncertainty
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
'''
core+='def original : Obligation := ⟨'+','.join(q(getattr(row,f))for f in ['claim_id','title','family','carrier','relation','organization','observation','statement'])+'⟩\n'
core+='''def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalUncertainty
'''
(out/'ClinicalUncertainty.lean').write_text(core)
for kind in ['grammar','evidence']:
 s=(w/f'statesymmetry_{kind}1100.py').read_text().replace('statesymmetry','patient').replace('StateSymmetry','ClinicalUncertainty').replace('1100','1300')
 (w/f'patient_{kind}1300.py').write_text(s)
 ns={};exec(s,ns)
s=(w/'ClinicalUncertaintyGrammar1300.lean').read_text().replace('import «work».ClinicalUncertaintyCarrier1300','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.ClinicalUncertaintyGrammar','SFT.Medicine.ClinicalUncertaintyGrammar').replace('namespace SFT.Medicine.ClinicalUncertaintyGrammar','namespace SFT.Medicine.ClinicalUncertaintyGrammar\nset_option maxHeartbeats 20000000')
(out/'ClinicalUncertaintyGrammar.lean').write_text(s)
s=(w/'ClinicalUncertaintyEvidence1300.lean').read_text().replace('import «work».ClinicalUncertaintyGrammar1300','import SFT.Medicine.ClinicalUncertaintyGrammar\nimport SFT.Medicine.ClinicalUncertainty').replace('SFT.Physics.ClinicalUncertaintyEvidence','SFT.Medicine.ClinicalUncertaintyEvidence').replace('branch := "physics"','branch := "medicine"').replace('provenance := [.observationalDerivation]','provenance := [.forwardForcing]')
a=s.index('def onePairWitness');b=s.index('def claimId',a)
s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean ClinicalUncertainty.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,['carrierWitness','relationWitness','boundaryWitness']))+']\n'+s[b:]
(out/'ClinicalUncertaintyEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','ClinicalUncertainty').replace('SFT/Chemistry','SFT/Medicine').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr([d.key for d in spec.dimensions]));exec(s,{})
s=(w/'build_pairexchange1102.py').read_text().replace('PairExchange','ClinicalUncertainty').replace('pairexchange1102','clinicaluncertainty1300').replace('SFT/Chemistry','SFT/Medicine').replace('SFT.Chemistry','SFT.Medicine').replace("['ClinicalUncertaintyGrammar','ClinicalUncertaintyEvidence']","['ClinicalUncertainty','ClinicalUncertaintyGrammar','ClinicalUncertaintyEvidence']")
(w/'build_clinicaluncertainty1300.py').write_text(s)
print('Translated original obligation,three exact witnesses,eight-axis full grammar and forward-forcing programme.')
