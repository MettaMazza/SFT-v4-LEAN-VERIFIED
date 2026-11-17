from pathlib import Path
import sys,json,ast
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.medicine;sft.medicine.__path__=[str((w/'pinned1234/sft/medicine').resolve())]+list(sft.medicine.__path__)
from sft.medicine.empirical_program import MEDICINE_SPECS,validate_pre_source_seal
seal=validate_pre_source_seal(w/'pinned1234');q=lambda x:json.dumps(x,ensure_ascii=False)
s=(r/'SFT/Biology/LifeOrganizationSeal.lean').read_text();a=s.index('def predictionSet');b=s.index('def validate',a)
s=s[:a]+'def predictionSet : Value := .array ['+','.join('.array [.text '+q(x.claim_id)+',.text '+q(x.exact_result)+',.text '+q(x.expected_observation_label)+']'for x in MEDICINE_SPECS)+']\n'+s[b:]
s=s.replace('SFT.Biology.LifeOrganizationSource','SFT.Medicine.PatientIdentitySource').replace('SFT.Biology.LifeOrganizationSeal','SFT.Medicine.PatientIdentitySeal').replace('Biology','Medicine').replace('sealed_payload_hash','complete_branch_pre_source_seal_hash').replace('external_target_content_opened','external_outcomes_opened').replace(' 75)',' 72)').replace('(75*256)','(72*256)').replace('[("inventory_path","inventory_hash"),("structural_counts_path","structural_counts_hash"),("derivation_path","derivation_hash")]','[("inventory_path","inventory_file_hash"),("obligations_path","obligations_hash"),("generated_law_path","generated_law_hash"),("structural_counts_path","structural_counts_hash")]')
(r/'SFT/Medicine/PatientIdentitySeal.lean').write_text(s)
for kind in ['experiment','validation']:
 s=(w/f'generate_death1161_{kind}.py').read_text().replace('death1161','patient1234').replace('LifeDeath','PatientIdentity').replace('1161','1234').replace('SFT-BIO-LIFE-DEATH-001','SFT-MED-PATIENT-IDENTITY-001').replace('BIOLOGY_SPECS','MEDICINE_SPECS').replace('Biology','Medicine').replace('biology','medicine').replace('from sft.medicine.generated_law import','from sft.medicine.empirical_program import').replace('LifeOrganizationSeal','PatientIdentitySeal').replace('SFT-BIO-','SFT-MED-').replace('SFT-EXP-BIO-','SFT-EXP-MED-').replace('sft-bio-life-death-001-authority-correspondence','sft-med-patient-identity-001-authority-correspondence')
 ast.parse(s);(w/f'generate_patient1234_{kind}.py').write_text(s);exec(compile(s,kind,'exec'),{})
p=r/'SFT/Medicine/PatientIdentityExperiment.lean';s=p.read_text().replace('PatientIdentitySource.distinctIds','SFT.Biology.LifeOrganizationSource.distinctIds');p.write_text(s)
print('Original Medicine72-entry pre-source seal validated:',seal)
print('Translated original experiment/validation interfaces; seven native modules staged, not yet compiled.')
