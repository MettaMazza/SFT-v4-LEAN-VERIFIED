from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
eq=json.loads((w/'chunked_solvation1442_source_correspondence.json').read_text());assert eq['status']=='EQUIVALENCE_AUDIT_PASS'
assert H(r/'SFT/Host/Canonical.lean')==eq['unchanged_original_canonical']
assert H(r/'SFT/Host/SHA256Chunks.lean')==eq['equivalence_source_sha256']
assert H(w/'solvation_chunked1442_source/SFT/Host/Canonical.lean')==eq['isolated_canonical']
assert (w/'chunked_hash1442_audit.log').read_text().count('does not depend on any axioms')==2
s=(w/'prepare_thermal1345_empirical_native1413.py').read_text()
s=s.replace('thermal1345_empirical_native1413','thermal1345_chunked1453').replace('thermal1345_empirical_native_build1413','thermal1345_chunked_build1453').replace('ThermalConductivityValidationProgram1345','ThermalConductivityValidationProgram1453')
old="p=r/(rel+'.lean');p=p if p.exists()else c/(rel+'.lean');assert p.exists(),p"
new="p=(w/'solvation_chunked1442_source'/(rel+'.lean')) if m=='SFT.Host.Canonical' else r/(rel+'.lean');p=p if p.exists()else c/(rel+'.lean');assert p.exists(),p"
assert old in s;s=s.replace(old,new)
s=s.replace("'thermal1345_program_native_build1413.json']","'thermal1345_program_native_build1413.json','thermal1345_empirical_native_build1413.json','solvation1342_chunked_build1442.json']")
(w/'prepare_thermal1345_chunked1453.py').write_text(s)
p=(w/'ThermalConductivityValidationProgram1345.lean').read_text();assert 'thermal1345_empirical_input.json' in p
(w/'ThermalConductivityValidationProgram1453.lean').write_text(p.replace('thermal1345_empirical_input.json','thermal1345_chunked1453_input.json'))
s=(w/'check_thermal1345_empirical_native1413.py').read_text()
for a,b in [('thermal1345_empirical_native_build1413','thermal1345_chunked_build1453'),('thermal1345_empirical_native1413','thermal1345_chunked1453'),('thermal1345_native1413_original_empirical_current','thermal1345_chunked1453_original_empirical_current'),('thermal1345_empirical_input','thermal1345_chunked1453_input'),('ThermalConductivityValidationProgram1345','ThermalConductivityValidationProgram1453')]:s=s.replace(a,b)
(w/'check_thermal1345_chunked1453.py').write_text(s)
s=(w/'adopt_solvation_chunked1442.py').read_text()
for a,b in [('solvation1342','thermal1345'),('chunked1442_report','chunked1453_report'),('chunked1442_output','chunked1453_output'),('chunked1442_original','chunked1453_original'),('chunked1442_execution','chunked1453_execution'),('chunked_build1442','chunked_build1453'),('pre_chunked1442','pre_chunked1453'),('chunked_adoption1442','chunked_adoption1453'),('86616','5521'),('89740','9103'),('SolvationDissolutionValidationProgram1342','ThermalConductivityValidationProgram1345')]:s=s.replace(a,b)
(w/'adopt_thermal_chunked1453.py').write_text(s)
print('Reused hash proof and compiled Canonical; exact original Thermal checker retained with isolated IO.')
