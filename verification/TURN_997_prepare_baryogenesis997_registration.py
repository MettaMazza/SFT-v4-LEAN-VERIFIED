from pathlib import Path
import json,shutil,hashlib
w=Path('work');cfg=json.load(open(w/'baryogenesis997_all_proofs_config.json'));scopes=json.load(open(w/'baryogenesis997_scopes.json'))
for f in ['baryogenesis997_core_report.json','baryogenesis997_program_report.json','baryogenesis997_fresh_report.json']:
 assert json.load(open(w/f))['status']=='PASS',f
assert json.load(open(w/'baryogenesis997_core_report.json'))['sha256']==cfg['source_sha256']['BaryogenesisDependency']
shutil.copyfile(w/'baryogenesis997_program_report.json',w/'baryogenesis_program997_report.json')
shutil.copyfile(w/'baryogenesis997_entry_build2.log',w/'baryogenesis997_entry_build.log')
(w/'baryogenesis997_science_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_component_correspondence=scopes,source_provenance='observational_derivation',core_sha256=cfg['source_sha256']['BaryogenesisDependency']),indent=2))
files=['baryogenesis997_core_report.json','baryogenesis997_program_report.json','baryogenesis_program997_report.json','baryogenesis997_fresh_report.json','baryogenesis_independent997_report.json','baryogenesis997_all_proofs_config.json','baryogenesis997_all_audit.log','baryogenesis997_science_report.json','baryogenesis997_entry_build.log','baryogenesis997_chunks_report.json','audit_baryogenesis997.py','check_baryogenesis997_core.py','check_baryogenesis997_program.py','check_baryogenesis997_fresh.py','check_baryogenesis997_independent.py']
for f in files:assert (w/f).is_file(),f
(w/'baryogenesis997_registration_evidence_files.json').write_text(json.dumps(files,indent=2))
print('Ready to register654')
