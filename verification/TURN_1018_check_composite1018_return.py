from pathlib import Path
import sys,subprocess,os,json,concurrent.futures,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import composite_confining_sector_terminal_law_v1 as source
from sft.engine.canonical import canonical_value
cases=[(s,k) for s in range(4,66,2) for k in source.standing_mode_labels(s)]
expected=[{'period':len(source.orbit_from_label(k,s)),'orbit':list(source.orbit_from_label(k,s))} for s,k in cases]
header='''import SFT.Physics.CompositeConfiningReturn
import SFT.Host.Canonical
open SFT.Physics.CompositeConfiningDerivation SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result (s k : Nat) : Value :=
 match originalReturnThrough (s-1) k (s-2) with
 | none => .null
 | some p => .object [("period",.integer (.ofNat p)),("orbit",.array ((List.range p).map (fun n => .integer (.ofNat (originalTicks (s-1) k n)))))]
'''
def run(start):
 q=w/f'CompositeReturn1018_{start}.lean';q.write_text(header+'#eval IO.println (render (.array ['+','.join(f'result {s} {k}' for s,k in cases[start:start+64])+']))\n');x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(q)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/f'composite1018_return_batch{start}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1000:];return json.loads(x.stdout)
with concurrent.futures.ThreadPoolExecutor(max_workers=12) as pool:actual=[a for rows in pool.map(run,range(0,len(cases),64)) for a in rows]
assert actual==expected
report=dict(status='PASS',cases=len(cases),comparison='Full ordered source orbit and first-return count for every label in even sectors4through64',source_sha256=hashlib.sha256((r/'SFT/Physics/CompositeConfiningReturn.lean').read_bytes()).hexdigest())
(w/'composite1018_return_comparison.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))
