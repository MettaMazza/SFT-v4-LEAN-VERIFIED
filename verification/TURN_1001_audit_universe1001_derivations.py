from pathlib import Path
import json,re,hashlib,subprocess,os
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');cfg=json.load(open(w/'universe1001_all_proofs_config.json'));added=[]
mods=['FoldUniverseTransportDynamics','FoldUniverseTransportComposition','FoldUniverseTransportPeriod','FoldUniverseTransportSource']
for m in mods:
 p=r/f'SFT/Physics/{m}.lean';s=p.read_text();names=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',s,re.M)];added+=names;cfg['modules'].append(m);cfg['declarations']+=names;cfg['theorems']+=names;cfg['definitions_and_theorems']+=names;cfg['source_sha256'][m]=hashlib.sha256(p.read_bytes()).hexdigest()
p=w/'universe1001_derivations_audit.lean';p.write_text('import SFT.Physics.FoldUniverseTransportDynamics\nimport SFT.Physics.FoldUniverseTransportSource\n'+''.join('#print axioms '+n+'\n' for n in added));x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);audit=x.stdout+x.stderr;(w/'universe1001_derivations_audit.log').write_text(audit);assert x.returncode==0 and all("'"+n+"' does not depend on any axioms" in audit for n in added),audit
(w/'universe1001_complete_proofs_config.json').write_text(json.dumps(cfg,indent=2));(w/'universe1001_complete_audit.log').write_text((w/'universe1001_all_audit.log').read_text()+audit);print('PASS',len(added),'new general theorems;',len(cfg['declarations']),'entry declarations; empty axioms')
