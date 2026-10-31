from pathlib import Path
import json,re,hashlib,subprocess,os
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery').resolve();native=json.load(open('work/vacuum498_native_config.json'));old=r/'verification/TURN_385_VACUUM_DENSITY';cfg=json.loads((old/'vacuum_density385_audit_config.json').read_text())
for m in native['modules']:assert hashlib.sha256((rec/'SFT/Physics'/f'{m}.lean').read_bytes()).hexdigest()==native['source_sha256'][m],m
for m in cfg['modules']:assert (old/'SFT/Physics'/f'{m}.lean').read_bytes()==(rec/'SFT/Physics'/f'{m}.lean').read_bytes(),m
for m in ['VacuumLedgerProofs','VacuumScaleProofs']:assert (r/'verification/TURN_378_NATIVE_BATCH/SFT/Physics'/f'{m}.lean').read_bytes()==(rec/'SFT/Physics'/f'{m}.lean').read_bytes(),m
mods=native['modules']+['VacuumLedgerProofs','VacuumScaleProofs'];names=[];ths=[];defs=[];hashes={}
for m in mods:
 s=(rec/'SFT/Physics'/f'{m}.lean').read_text();hashes[m]=hashlib.sha256(s.encode()).hexdigest();ns=re.search(r'^namespace (\S+)',s,re.M)[1]
 for kind,n in re.findall(r'^(?:@\[[^\n]+\]\s*)?(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M):
  full=ns+'.'+n;names.append(full)
  if kind=='theorem':ths.append(full)
  if kind in ['def','theorem']:defs.append(full)
prior='\n'.join(p.read_text() for p in [old/'vacuum_density385_audit.log',Path('work/vacuum_ledger378_audit.log'),Path('work/vacuum_scale378_audit.log'),Path('work/vacuum_batch_audit.log')])
missing=[n for n in names if "'"+n+"' does not depend on any axioms" not in prior]
a=Path('work/AuditVacuumMissing515.lean').resolve();a.write_text('\n'.join('import SFT.Physics.'+m for m in ['VacuumDensityEvidence','VacuumScaleProofs','VacuumSpectrum'])+'\n'+'\n'.join('#print axioms '+n for n in missing)+'\n')
p=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(a)],cwd=rec,env=dict(os.environ,LEAN_PATH=str(rec/'.lake/build/lib/lean')),text=True,capture_output=True);Path('work/vacuum515_missing_audit.log').write_text(p.stdout+p.stderr);assert p.returncode==0
for n in missing:assert "'"+n+"' does not depend on any axioms" in p.stdout,n
combined=prior+'\n'+p.stdout;Path('work/audit_vacuum_entry515.log').write_text(combined)
config=dict(modules=mods,declarations=names,theorems=ths,definitions_and_theorems=defs,source_sha256=hashes,extra_modules=[],status='PASS',reused_matching_source_declarations=len(names)-len(missing),newly_audited_declarations=missing)
Path('work/auditvacuum515_config.json').write_text(json.dumps({'VacuumDensity':config},indent=2)+'\n')
print('VACUUM RECONCILED',len(names),'declarations;',len(missing),'missing core audit records checked; unchanged proof/census work reused')
