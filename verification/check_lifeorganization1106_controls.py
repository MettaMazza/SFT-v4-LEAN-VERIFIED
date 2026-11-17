from pathlib import Path
import subprocess,os,json,re,hashlib,sys
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192'];source=r/'SFT/Biology/LifeOrganizationSource.lean'
names=['SFT.Biology.LifeOrganizationSource.'+n for n in re.findall(r'^def (\w+)',source.read_text(),re.M)]
p=w/'LifeOrganizationSourceAudit1106.lean';p.write_text('import SFT.Biology.LifeOrganizationSource\n'+''.join('#print axioms '+n+'\n'for n in names))
with(w/'lifeorganization1106_source_audit.log').open('w')as log:subprocess.run(cmd+[str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
log=(w/'lifeorganization1106_source_audit.log').read_text();assert log.count('does not depend on any axioms')==len(names) and 'depends on axioms:'not in log
with(w/'lifeorganization1106_controls_output.json').open('w')as out,(w/'lifeorganization1106_controls_execution.log').open('w')as err:subprocess.run(cmd+['--run','work/LifeOrganizationSourceProgram1106.lean','controls'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'lifeorganization1106_controls_output.json').read_text());expected=json.loads((w/'lifeorganization1106_source_expected.json').read_text());assert a=={k:expected[k]for k in a}
report=dict(status='PASS',decode_cases=len(a['decode']),corpus_cases=len(a['corpus']),declarations=names,axioms=[],source_sha256=hashlib.sha256(source.read_bytes()).hexdigest());(w/'lifeorganization1106_controls_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS',len(a['decode']),'decoding cases and',len(a['corpus']),'corpus controls;',len(names),'empty-axiom declarations')
