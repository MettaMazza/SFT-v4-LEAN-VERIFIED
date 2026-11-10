from pathlib import Path
import json,re,subprocess,os,hashlib
w=Path('work').resolve();r=w/'constants-recovery';cfg=json.loads((w/'auditcollective548_config.json').read_text())['Superconductivity'];names=[]
for m in cfg['modules']:
 s=(r/'SFT/Physics'/(m+'.lean')).read_text(); ns=re.search(r'^namespace (\S+)',s,re.M)[1]
 names.extend(ns+'.'+n for _,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M))
a=w/'AuditSuperconductivity549.lean';a.write_text(''.join('import SFT.Physics.'+m+'\n' for m in cfg['modules'])+''.join('#print axioms '+n+'\n' for n in names));cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288',str(a)];p=subprocess.run(cmd,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'),LEAN_NUM_THREADS='1'),text=True,capture_output=True);(w/'superconductivity549_auxiliary_audit.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;assert all("'"+n+"' does not depend on any axioms" in p.stdout for n in names)
report=dict(status='PASS',declarations=names,axiom_dependencies=[],command=cmd,source_sha256={'SFT/Physics/'+m+'.lean':hashlib.sha256((r/'SFT/Physics'/(m+'.lean')).read_bytes()).hexdigest() for m in cfg['modules']},scope='Renamed endpoint-momentum auxiliary lemmas; not a full source derivation receipt. Original program and validator sources unchanged.')
(w/'superconductivity549_auxiliary_report.json').write_text(json.dumps(report,indent=2));print(len(names),'current declarations: zero axioms')
