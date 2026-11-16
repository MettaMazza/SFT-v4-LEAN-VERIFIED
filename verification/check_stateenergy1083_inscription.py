from pathlib import Path
import json,sys,subprocess,os,hashlib,itertools
from fractions import Fraction
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry.state_energy_order_validation_v1 import VALUE_PATTERN
rows=json.loads((w/'v3-runtime500/experiments/external_sources/chemistry/state_energy_order_withheld_targets_v1.json').read_text())['rows'];texts=[x['energy_inscription']for x in rows]
texts += [a+b+c for a,b,c in itertools.product(['','[','(',' [','[ ','[~','[ ~ ','\u00a0~ '],['0','123','12.','12.__','12.3_4','-1','.5','١٢'],['','eV',' cm^-1'])]
expected=[]
for t in texts:
 m=VALUE_PATTERN.search(t)
 if m is None or 'eV' in t:expected.append({'error':'ELEC-004 source row is not orderable in the registered unit'})
 else:
  f=Fraction(m.group(1).replace('_',''));expected.append({'ok':[f.numerator,f.denominator]})
inputp=w/'stateenergy1083_inscription_input.jsonl';inputp.write_text(''.join(json.dumps(t)+'\n'for t in texts))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/StateEnergyInscriptionProgram1083.lean']
with inputp.open()as inp,(w/'stateenergy1083_inscription_output.jsonl').open('w')as out,(w/'stateenergy1083_inscription_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdin=inp,stdout=out,stderr=err)
assert run.returncode==0
actual=[json.loads(x)for x in(w/'stateenergy1083_inscription_output.jsonl').read_text().splitlines()];assert actual==expected,[(t,a,e)for t,a,e in zip(texts,actual,expected)if a!=e][:3]
for row,actual in zip(rows,actual):assert actual=={'ok':[row['exact_value_numerator'],row['exact_value_denominator']]}
report=dict(status='PASS',cases=len(texts),original_energy_rows=len(rows),axioms=[],source_sha256=hashlib.sha256((r/'SFT/Chemistry/StateEnergyInscription.lean').read_bytes()).hexdigest());(w/'stateenergy1083_inscription_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
