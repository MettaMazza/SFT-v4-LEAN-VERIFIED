import json,sys,os,subprocess,re,hashlib
from pathlib import Path
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry.orbital_support_validation_v1 import _resolved_targets,TERM_PATTERN,ORBITAL_PATTERN
targets=_resolved_targets(root);texts=[r['state_record']for r in targets]
texts += [prefix+body for prefix in ['', 'a','9','_', 'Ω',' ']for body in ['1sσ','2p\u00a0π^2','01sσ','3dδ^0','1sσ2pπ','2gφ^12']]
texts += ['^1Σ','^12Π','^0Σ','^01Δ','^2Σ^3Π','^2σ','^٢Σ','^1Σx^2Φ','1Sσ','1xσ','1sΣ','1sσ^01','1sσ^2pπ','1sσ^2 2pπ']
expected=[[[[int(m[1]),m[2]]for m in TERM_PATTERN.finditer(s)],[[int(m[1]),m[2],m[3],int(m[4])if m[4]else 1]for m in ORBITAL_PATTERN.finditer(s)]]for s in texts]
inp=w/'orbital1075_assignments_input.jsonl';inp.write_text(''.join(json.dumps(s)+'\n'for s in texts))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with inp.open()as src,(w/'orbital1075_assignments_output.jsonl').open('w')as out,(w/'orbital1075_assignments_execution.log').open('w')as err:r=subprocess.run(cmd+['--run','work/orbital1075_assignments_check.lean'],env=env,stdin=src,stdout=out,stderr=err)
assert r.returncode==0,r.returncode
actual=[json.loads(line)for line in (w/'orbital1075_assignments_output.jsonl').read_text().splitlines()];assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:3]
assert sum(len(x[0])for x in actual[:360])==362 and sum(len(x[1])for x in actual[:360])==87
p=w/'turn1064_recovery/SFT/Chemistry/OrbitalAssignments.lean';names=['SFT.Chemistry.OrbitalAssignments.'+n for n in re.findall(r'^def (\w+)',p.read_text(),re.M)];audit=w/'orbital1075_assignments_audit.lean';audit.write_text('import SFT.Chemistry.OrbitalAssignments\n'+''.join('#print axioms '+n+'\n'for n in names));a=subprocess.run(cmd+[str(audit)],env=env,capture_output=True,text=True);(w/'orbital1075_assignments_audit.log').write_text(a.stdout+a.stderr);assert a.returncode==0 and a.stdout.count('does not depend on any axioms')==len(names),a.stdout
(w/'orbital1075_assignments_report.json').write_text(json.dumps(dict(status='PASS',cases=len(texts),registered_rows=360,term_assignments=362,configuration_assignments=87,axioms=[],declarations=names,source_sha256=hashlib.sha256(p.read_bytes()).hexdigest()),indent=2)+'\n');print('PASS',len(texts),'source regex cases;360 rows,362 terms,87 configurations;',len(names),'zero-axiom declarations')
