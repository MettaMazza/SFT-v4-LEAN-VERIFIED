from pathlib import Path
import json,hashlib,subprocess,os,re,sys
w=Path('work');r=w/'turn1064_recovery';pins={'successor_structural_counts.py':'040a89ee58c12fa62141870c740372b6350e8d20','successor_derivation.py':'34f683f959e62855dfb64c95f2dce6fef9a2f24e','successor_obligations.py':'b3b45e9094091ec756fc30121a71704a2c0c240a'}
for n,h in pins.items():
 b=(w/'v3-runtime500/sft/materials'/n).read_bytes();assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==h,n
source=w/'constants-recovery/SFT/Materials/QuasicrystalInflation.lean';p=r/'SFT/Materials/QuasicrystalInflation.lean';p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(source.read_bytes());s=p.read_text();names=['SFT.Materials.QuasicrystalInflation.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)]
audit=w/'QuasicrystalRetainedAudit1089.lean';audit.write_text('import SFT.Materials.QuasicrystalInflation\n'+''.join('#print axioms '+n+'\n'for n in names))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');cmd=['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with(w/'quasicrystal1089_retained_build.log').open('w')as f:subprocess.run(cmd+['-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
with(w/'quasicrystal1089_retained_audit.log').open('w')as f:subprocess.run(cmd+[str(audit)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
log=(w/'quasicrystal1089_retained_audit.log').read_text();assert log.count('does not depend on any axioms')==len(names)and'depends on axioms:'not in log
(w/'quasicrystal1089_retained_report.json').write_text(json.dumps(dict(status='PASS',reused_without_scientific_changes=True,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_git_blobs=pins,lean_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),declarations=names,axioms=[]),indent=2)+'\n');print('PASS',len(names),'retained declarations; source unchanged; empty axioms',flush=True)
