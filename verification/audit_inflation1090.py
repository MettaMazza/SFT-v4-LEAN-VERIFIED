from pathlib import Path
import re,json,hashlib,os,subprocess
w=Path('work');r=w/'turn1064_recovery';modules=['QuasicrystalInflation','QuasicrystalInflationCertificate','QuasicrystalInflationGrammar','QuasicrystalInflationEvidence','QuasicrystalInflationSource','QuasicrystalInflationExperiment','QuasicrystalInflationValidation'];names=[];hashes={}
for m in modules:
 p=r/'SFT/Materials'/(m+'.lean');s=p.read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1];names.extend(ns+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M));hashes['SFT/Materials/'+m+'.lean']=hashlib.sha256(p.read_bytes()).hexdigest()
assert len(names)==126,len(names)
p=w/'InflationFullAudit1090.lean';p.write_text(''.join('import SFT.Materials.'+m+'\n'for m in modules)+''.join('#print axioms '+n+'\n'for n in names))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'inflation1090_full_audit.log').open('w')as out:subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192',str(p)],env=env,stdout=out,stderr=subprocess.STDOUT,check=True)
log=(w/'inflation1090_full_audit.log').read_text();assert log.count('does not depend on any axioms')==126 and'depends on axioms:'not in log
(w/'inflation1090_full_audit_report.json').write_text(json.dumps(dict(status='PASS',count=126,declarations=names,source_sha256=hashes,axioms=[]),indent=2)+'\n');print('PASS126 declarations, empty axioms')
