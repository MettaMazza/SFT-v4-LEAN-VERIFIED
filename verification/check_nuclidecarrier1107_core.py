from pathlib import Path
import os,sys,subprocess,json,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192'];p=r/'SFT/Chemistry/NuclideChemicalCarrier.lean'
with(w/'nuclidecarrier1107_build.log').open('w')as f:subprocess.run(cmd+['-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
names=['SFT.Chemistry.NuclideChemicalCarrier.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',p.read_text(),re.M)];audit=w/'NuclideCarrierAudit1107.lean';audit.write_text('import SFT.Chemistry.NuclideChemicalCarrier\n'+''.join('#print axioms '+n+'\n'for n in names))
with(w/'nuclidecarrier1107_audit.log').open('w')as f:subprocess.run(cmd+[str(audit)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
s=(w/'nuclidecarrier1107_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names) and 'depends on axioms:'not in s
with(w/'nuclidecarrier1107_output.json').open('w')as out,(w/'nuclidecarrier1107_execution.log').open('w')as err:subprocess.run(cmd+['--run','work/NuclideCarrierProgram1107.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'nuclidecarrier1107_output.json').read_text());e=json.loads((w/'nuclidecarrier1107_expected.json').read_text());assert a==e
(w/'nuclidecarrier1107_core_report.json').write_text(json.dumps({'status':'PASS','constructor_cases':len(a['cases']),'operational_witnesses':len(a['witnesses']),'axioms':[],'declarations':names,'source_sha256':hashlib.sha256(p.read_bytes()).hexdigest()},indent=2)+'\n');print('PASS64 original carrier cases,8 witnesses,',len(names),'zero-axiom declarations.')
