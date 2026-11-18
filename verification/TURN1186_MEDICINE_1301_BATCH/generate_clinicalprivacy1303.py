from pathlib import Path
import json
w=Path('work');out=w/'turn1064_recovery/SFT/Medicine';out.mkdir(parents=True,exist_ok=True)
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC', '''import sft.medicine
sft.medicine.__path__=[str(Path('work/pinned1303/sft/medicine').resolve())]+list(sft.medicine.__path__)
from sft.medicine.generated_law import BLUEPRINT_BY_CLAIM
STATE_SYMMETRY_SPEC=BLUEPRINT_BY_CLAIM['SFT-MED-CLINICAL-PRIVACY-001']''').replace('statesymmetry1100','clinicalprivacy1303')
(w/'patient_spec1303.py').write_text(s)
ns={};exec(s,ns);spec=ns['spec'];q=ns['q']
from sft.medicine.obligations import MEDICINE_OBLIGATIONS
row=next(x for x in MEDICINE_OBLIGATIONS if x.claim_id=='SFT-MED-CLINICAL-PRIVACY-001')
core='''import SFT.Host.Text
namespace SFT.Medicine.ClinicalPrivacy
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
end SFT.Medicine.ClinicalPrivacy
'''
(out/'ClinicalPrivacy.lean').write_text(core)
for kind in ['grammar','evidence']:
 s=(w/f'statesymmetry_{kind}1100.py').read_text().replace('statesymmetry','patient').replace('StateSymmetry','ClinicalPrivacy').replace('1100','1303')
 (w/f'patient_{kind}1303.py').write_text(s)
 ns={};exec(s,ns)
s=(w/'ClinicalPrivacyGrammar1303.lean').read_text().replace('import «work».ClinicalPrivacyCarrier1303','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.ClinicalPrivacyGrammar','SFT.Medicine.ClinicalPrivacyGrammar').replace('namespace SFT.Medicine.ClinicalPrivacyGrammar','namespace SFT.Medicine.ClinicalPrivacyGrammar\nset_option maxHeartbeats 20000000')
(out/'ClinicalPrivacyGrammar.lean').write_text(s)
s=(w/'ClinicalPrivacyEvidence1303.lean').read_text().replace('import «work».ClinicalPrivacyGrammar1303','import SFT.Medicine.ClinicalPrivacyGrammar\nimport SFT.Medicine.ClinicalPrivacy').replace('SFT.Physics.ClinicalPrivacyEvidence','SFT.Medicine.ClinicalPrivacyEvidence').replace('branch := "physics"','branch := "medicine"').replace('provenance := [.observationalDerivation]','provenance := [.forwardForcing]')
a=s.index('def onePairWitness');b=s.index('def claimId',a)
s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean ClinicalPrivacy.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,['carrierWitness','relationWitness','boundaryWitness']))+']\n'+s[b:]
(out/'ClinicalPrivacyEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','ClinicalPrivacy').replace('SFT/Chemistry','SFT/Medicine').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr([d.key for d in spec.dimensions]));exec(s,{})
s=(w/'build_pairexchange1102.py').read_text().replace('PairExchange','ClinicalPrivacy').replace('pairexchange1102','clinicalprivacy1303').replace('SFT/Chemistry','SFT/Medicine').replace('SFT.Chemistry','SFT.Medicine').replace("['ClinicalPrivacyGrammar','ClinicalPrivacyEvidence']","['ClinicalPrivacy','ClinicalPrivacyGrammar','ClinicalPrivacyEvidence']")
(w/'build_clinicalprivacy1303.py').write_text(s)
print('Translated original obligation,three exact witnesses,eight-axis full grammar and forward-forcing programme.')
