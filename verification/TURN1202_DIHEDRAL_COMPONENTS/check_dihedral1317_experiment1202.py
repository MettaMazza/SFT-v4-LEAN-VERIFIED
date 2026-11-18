from pathlib import Path
import os,subprocess,json,hashlib,time
w=Path('work');r=w/'turn1064_recovery'
while True:
 try:os.kill(21576,0)
 except ProcessLookupError:break
 time.sleep(3)
a=json.loads((w/'dihedral1317_full_audit_report.json').read_text());assert 'SFT/Chemistry/DihedralTorsionExperiment.lean' in a['source_sha256']
for p,h in a['source_sha256'].items():assert hashlib.sha256((r/p).read_bytes()).hexdigest()==h
p=w/'DihedralTorsionExperiment1317.lean';p.write_text('''import SFT.Chemistry.DihedralTorsionExperiment
open SFT.Chemistry.DihedralTorsionExperiment SFT.Host.Canonical
def main : IO Unit := do
 let program ← IO.ofExcept predictionProgramDocument
 let registration ← IO.ofExcept experimentRegistrationRecord
 IO.println (render (.object [("program",program),("registration",registration)]))
''')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
p=subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True)
(w/'dihedral1317_experiment_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1800:]+p.stderr[-500:]
actual=json.loads(p.stdout);expected=json.loads((w/'dihedral1317_experiment_expected.json').read_text());assert actual==expected
(w/'dihedral1317_experiment_output.json').write_text(json.dumps(actual,indent=2)+'\n')
(w/'dihedral1317_experiment_report.json').write_text(json.dumps(dict(status='PASS',instructions=853,registration_fields=10,source_sha256=a['source_sha256']),indent=2)+'\n');print('PASS full853instruction prediction and10field registration',flush=True)
