from pathlib import Path
import json,hashlib,subprocess,sys,os,re
w=Path('work');r=w/'turn1064_recovery';digest=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
report=w/'resonance1089_empirical_report.json'
assert report.exists(),'Final empirical report not yet available; preserve its live process.'
e=json.loads(report.read_text());assert e['status']=='PASS'
for module,h in e['source_sha256'].items():assert digest(r/'SFT/Chemistry'/(module+'.lean'))==h,'Retained empirical report is not yet the final corrected-source run.'
scopes=json.loads((w/'resonance1089_scopes.json').read_text());names=[];hashes={}
for module in scopes:
 p=r/'SFT/Chemistry'/(module+'.lean');s=p.read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1];names += [ns+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)];hashes['SFT/Chemistry/'+module+'.lean']=digest(p)
assert len(names)==183,len(names)
audit=w/'resonance1089_full_audit.lean';audit.write_text(''.join('import SFT.Chemistry.'+module+'\n'for module in scopes)+''.join('#print axioms '+n+'\n'for n in names))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'resonance1089_full_audit.log').open('w')as out:run=subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192',str(audit)],env=env,stdout=out,stderr=subprocess.STDOUT)
assert run.returncode==0
log=(w/'resonance1089_full_audit.log').read_text();assert log.count('does not depend on any axioms')==183 and 'depends on axioms:'not in log
(w/'resonance1089_full_audit_report.json').write_text(json.dumps(dict(status='PASS',count=183,declarations=names,source_sha256=hashes,axioms=[]),indent=2)+'\n')
if '--audit-only' not in sys.argv:subprocess.run([sys.executable,'work/register_resonance1089.py'],check=True)
