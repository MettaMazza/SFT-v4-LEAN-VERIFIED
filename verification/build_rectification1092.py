import os,subprocess,json,re,hashlib
from pathlib import Path
r=Path('work/turn1064_recovery');env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');lean=['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
for m in ['RectificationSourceBinding','RectificationSourceExperiment','RectificationSourceValidation']:
 p=r/'SFT/Materials'/(m+'.lean')
 with open('work/'+m+'1092_build.log','w')as f:subprocess.run(lean+['-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
 print(m+' compiled',flush=True)
mods=['RectificationSource','RectificationSourceGrammar','RectificationSourceEvidence','RectificationSourceBinding','RectificationSourceExperiment','RectificationSourceValidation'];names=[];hashes={}
for m in mods:
 p=r/'SFT/Materials'/(m+'.lean');s=p.read_text();names+=['SFT.Materials.'+m+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',s,re.M)];hashes[str(p.relative_to(r))]=hashlib.sha256(p.read_bytes()).hexdigest()
p=Path('work/RectificationFullAudit1092.lean');p.write_text('\n'.join('import SFT.Materials.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
with open('work/rectification1092_full_audit.log','w')as f:subprocess.run(lean+[str(p)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
s=Path('work/rectification1092_full_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names)and'depends on axioms:'not in s
Path('work/rectification1092_full_audit_report.json').write_text(json.dumps(dict(status='PASS',count=len(names),declarations=names,axioms=[],source_sha256=hashes),indent=2)+'\n');print('PASS',len(names),'empty-axiom declarations',flush=True)
