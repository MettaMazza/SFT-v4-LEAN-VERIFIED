import os,subprocess,json,re,hashlib
from pathlib import Path
root=Path('work/turn1064_recovery');env=dict(os.environ);env['LEAN_PATH']=':'.join([str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean'),str(root.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'])
lean=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean')
with open('work/streaming_reuse1499_audit.log','w')as f:subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','work/StreamingReuseAudit1499.lean'],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
s=Path('work/streaming_reuse1499_audit.log').read_text();assert 'does not depend on any axioms'in s and 'depends on axioms'not in s;print('Existing streaming equivalence: empty axiom dependencies')
