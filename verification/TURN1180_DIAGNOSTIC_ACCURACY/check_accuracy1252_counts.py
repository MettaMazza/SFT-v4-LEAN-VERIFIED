from pathlib import Path
import sys,json,subprocess,os,hashlib
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.medicine;sft.medicine.__path__=[str((w/'pinned1252/sft/medicine').resolve())]+list(sft.medicine.__path__)
from sft.medicine.structural_counts import diagnostic_table_certificate,two_arm_outcome_certificate,exact_share
from sft.engine.canonical import canonical_value
xs=[(-1,1),(0,1),(1,0),(2,1),(1,1),(1,2),(2,4),(100000000000000000000,100000000000000000001)];rows=[]
for a,b in xs:
 try:rows.append(['ok',*exact_share(a,b)])
 except ValueError as e:rows.append(['error',str(e)])
expected=canonical_value(dict(diagnostic=diagnostic_table_certificate(),arms=two_arm_outcome_certificate(),shares=rows));(w/'accuracy1252_counts_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/DiagnosticCountsProgram1252.lean']
with(w/'accuracy1252_counts_actual.json').open('w')as out,(w/'accuracy1252_counts_execution.log').open('w')as err:subprocess.run(cmd,env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'accuracy1252_counts_actual.json').read_text());assert actual==expected
report=dict(status='PASS',certificate_fields_each=6,ordered_cells_each=4,share_cases=len(xs),source_sha256={'SFT/Medicine/StructuralCounts.lean':hashlib.sha256((r/'SFT/Medicine/StructuralCounts.lean').read_bytes()).hexdigest()},source='sft/medicine/structural_counts.py',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1');(w/'accuracy1252_counts_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS both complete source certificates and8exact_share guard/preservation cases')
