from pathlib import Path
import json
w=Path('work');r=w/'constants-recovery'
for name in ['collective548_entries.json','collective548_metadata.json']:(w/name.replace('548','552')).write_bytes((w/name).read_bytes())
for part in ['program','validation','independent']:
 p=w/f'superconductivity_{part}548.py';(w/p.name.replace('548','552')).write_text(p.read_text().replace('548','552'))
for tail in ['Program','ValidationProgram']:
 p=r/f'Superconductivity{tail}548.lean';(r/p.name.replace('548','552')).write_text(p.read_text().replace('548','552'))
s=(w/'build_collective548.py').read_text().replace('548','552').replace("['CollectiveSuperconductivity','SuperconductivityGrammar'","['SuperconductivityLabelClosure','SuperconductivityRecurrenceProofs','CollectiveSuperconductivity','SuperconductivityJointHistory','SuperconductivityGrammar'")
(w/'build_collective552.py').write_text(s)
s=(w/'run_collective548.py').read_text().replace('548','552')
s=s.replace("common = list(dict.fromkeys(common +", "common += ['SFT/Physics/SuperconductivityLabelClosure','SFT/Physics/SuperconductivityRecurrenceProofs']\ncommon = list(dict.fromkeys(common +")
s=s.replace("modules=[stem+t for t in ['Grammar','Evidence','Experiment','Validation','ValidationProofs']]", "modules=['SuperconductivityLabelClosure','SuperconductivityRecurrenceProofs','SuperconductivityJointHistory']+[stem+t for t in ['Grammar','Evidence','Experiment','Validation','ValidationProofs']]")
(w/'run_collective552.py').write_text(s)
print('Prepared affected build/audit and original program checks; source grammar/validator definitions unchanged.')
