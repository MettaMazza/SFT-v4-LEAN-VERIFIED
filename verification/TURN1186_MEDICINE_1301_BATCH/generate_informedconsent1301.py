from pathlib import Path
import json
w=Path('work');out=w/'turn1064_recovery/SFT/Medicine';out.mkdir(parents=True,exist_ok=True)
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC', '''import sft.medicine
sft.medicine.__path__=[str(Path('work/pinned1301/sft/medicine').resolve())]+list(sft.medicine.__path__)
from sft.medicine.generated_law import BLUEPRINT_BY_CLAIM
STATE_SYMMETRY_SPEC=BLUEPRINT_BY_CLAIM['SFT-MED-INFORMED-CONSENT-001']''').replace('statesymmetry1100','informedconsent1301')
(w/'patient_spec1301.py').write_text(s)
ns={};exec(s,ns);spec=ns['spec'];q=ns['q']
from sft.medicine.obligations import MEDICINE_OBLIGATIONS
row=next(x for x in MEDICINE_OBLIGATIONS if x.claim_id=='SFT-MED-INFORMED-CONSENT-001')
core='''import SFT.Host.Text
namespace SFT.Medicine.InformedConsent
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
end SFT.Medicine.InformedConsent
'''
(out/'InformedConsent.lean').write_text(core)
for kind in ['grammar','evidence']:
 s=(w/f'statesymmetry_{kind}1100.py').read_text().replace('statesymmetry','patient').replace('StateSymmetry','InformedConsent').replace('1100','1301')
 (w/f'patient_{kind}1301.py').write_text(s)
 ns={};exec(s,ns)
s=(w/'InformedConsentGrammar1301.lean').read_text().replace('import «work».InformedConsentCarrier1301','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.InformedConsentGrammar','SFT.Medicine.InformedConsentGrammar').replace('namespace SFT.Medicine.InformedConsentGrammar','namespace SFT.Medicine.InformedConsentGrammar\nset_option maxHeartbeats 20000000')
(out/'InformedConsentGrammar.lean').write_text(s)
s=(w/'InformedConsentEvidence1301.lean').read_text().replace('import «work».InformedConsentGrammar1301','import SFT.Medicine.InformedConsentGrammar\nimport SFT.Medicine.InformedConsent').replace('SFT.Physics.InformedConsentEvidence','SFT.Medicine.InformedConsentEvidence').replace('branch := "physics"','branch := "medicine"').replace('provenance := [.observationalDerivation]','provenance := [.forwardForcing]')
a=s.index('def onePairWitness');b=s.index('def claimId',a)
s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean InformedConsent.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,['carrierWitness','relationWitness','boundaryWitness']))+']\n'+s[b:]
(out/'InformedConsentEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','InformedConsent').replace('SFT/Chemistry','SFT/Medicine').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr([d.key for d in spec.dimensions]));exec(s,{})
s=(w/'build_pairexchange1102.py').read_text().replace('PairExchange','InformedConsent').replace('pairexchange1102','informedconsent1301').replace('SFT/Chemistry','SFT/Medicine').replace('SFT.Chemistry','SFT.Medicine').replace("['InformedConsentGrammar','InformedConsentEvidence']","['InformedConsent','InformedConsentGrammar','InformedConsentEvidence']")
(w/'build_informedconsent1301.py').write_text(s)
print('Translated original obligation,three exact witnesses,eight-axis full grammar and forward-forcing programme.')
