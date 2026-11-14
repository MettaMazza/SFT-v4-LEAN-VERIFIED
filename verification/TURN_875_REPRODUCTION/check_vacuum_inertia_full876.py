from pathlib import Path
import json,hashlib,shutil,subprocess
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');cfg=json.loads((w/'vacuuminertia876_proofs_config.json').read_text());audit=(w/'vacuuminertia876_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in cfg['declarations'])
for m in cfg['modules']:
 p=r/'SFT/Physics'/f'{m}.lean';assert hashlib.sha256(p.read_bytes()).hexdigest()==cfg['source_sha256'][m];shutil.copy2(p,c/'SFT/Physics'/p.name)
print('PASS',len(cfg['declarations']),'empty axiom declarations',flush=True)
with (w/'vacuum_inertia876_canonical_build.log').open('w') as f:subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lake','build','SFT.Physics.VacuumInertiaEvidence'],cwd=c,stdout=f,stderr=subprocess.STDOUT,check=True)
print('PASS canonical build',flush=True)
for script in ['prepare_vacuuminertia_native876.py','check_vacuuminertia_program876.py','check_vacuuminertia_independent876.py']:
 cmd=['python3',str(w/script)]
 if script=='check_vacuuminertia_program876.py':cmd.append(str((w/'circuit866_native_objects/VacuumInertiaProgram876').resolve()))
 subprocess.run(cmd,check=True)
a=json.loads((w/'vacuuminertia_program876_output.json').read_text());b=json.loads((w/'vacuuminertia876_original_program.json').read_text());assert a==b
p=w/'vacuuminertia_program876_report.json';report=json.loads(p.read_text());report['fresh_original_package_output_also_matches']=True;p.write_text(json.dumps(report,indent=2));print('PASS all source-specific vacuum inertia checks',flush=True)
