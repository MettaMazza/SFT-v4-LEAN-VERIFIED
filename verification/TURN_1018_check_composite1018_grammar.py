from pathlib import Path
import sys,os,subprocess,json,concurrent.futures,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.composite_confining_sector_terminal_law_v1 import SPEC
from sft.physics.structural_constants import candidate_rows,decision_reason,survivor_id
rows=candidate_rows(SPEC);expected=[dict(id=x['candidate_id'],form=x['exact_form'],survives=x['candidate_id']==survivor_id(SPEC),reason=decision_reason(SPEC,x)) for x in rows]
header='''import SFT.Physics.CompositeConfiningGrammarBase
import SFT.Host.Canonical
open SFT.Physics.CompositeConfiningGrammar SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def row (c : Candidate) : Value := .object [("id",.text (candidateId c)),("form",.text (exactForm c)),("survives",.boolean (survives c)),("reason",.text (decisionReason c))]
'''
def run(start):
 p=w/f'CompositeGrammar1018_{start}.lean';p.write_text(header+f'#eval IO.println (render (.array (((candidates.drop {start}).take 64).map row)))\n');x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/f'composite1018_grammar_comparison{start}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1000:];return json.loads(x.stdout)
with concurrent.futures.ThreadPoolExecutor(max_workers=12) as pool:actual=[a for rs in pool.map(run,range(0,len(rows),64)) for a in rs]
assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:1]
report=dict(status='PASS',candidates=len(rows),fields=['candidate_id','exact_form','survives','reason'],order_preserved=True,source_sha256=hashlib.sha256((r/'SFT/Physics/CompositeConfiningGrammarBase.lean').read_bytes()).hexdigest());(w/'composite1018_grammar_comparison.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))
