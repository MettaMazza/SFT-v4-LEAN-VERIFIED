from pathlib import Path
import json,subprocess,os,sys,hashlib
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';source='sft/physics/cosmic_budget_law.py';raw=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+source]);runtime=Path('work/v3-runtime500');assert (runtime/source).read_bytes()==raw
sys.path.insert(0,str(runtime.resolve()));from sft.physics.cosmic_budget_law import cosmic_budget_structure
from fractions import Fraction
expected={k:[v.numerator,v.denominator] if isinstance(v,Fraction) else v for k,v in cosmic_budget_structure().items()}
fields=[('depth','depth'),('support','support'),('pinned','pinned'),('free','free'),('matter','matter'),('vacuum','vacuum'),('baryon_within_matter','baryonWithinMatter'),('dark_within_matter','darkWithinMatter'),('baryon','baryon'),('cold_dark','coldDark')]
s='''import SFT.Physics.CosmoCompleteBudget
import Lean
open SFT.Physics
def ratioJson (q : Rat) : Lean.Json := .arr #[Lean.toJson q.num,Lean.toJson q.den]
def main : IO Unit := do
 match CosmoCompleteBudget.cosmicBudgetStructure with
 | .error e => throw (IO.userError e)
 | .ok b => IO.println ((Lean.Json.mkObj [
'''+',\n'.join('  ("'+key+'",'+('Lean.toJson' if i<4 else 'ratioJson')+' b.'+name+')' for i,(key,name) in enumerate(fields))+']).compress)\n'
p=Path('work/constants-recovery/BudgetFields515.lean');p.write_text(s);env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));r=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M2048','--run',str(p)],env=env,text=True,capture_output=True);Path('work/budget_fields515.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr;actual=json.loads(r.stdout);assert actual==expected,(actual,expected)
report=dict(status='PASS',source_commit=pin,source_path=source,source_sha256=hashlib.sha256(raw).hexdigest(),source_fields=len(expected),actual=actual,scope='All ten native returned fields compared directly with the unchanged pinned V3 cosmic_budget_structure function, retaining exact rational numerator/denominator pairs.')
Path('work/budget_fields515_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS all10 original fields')
