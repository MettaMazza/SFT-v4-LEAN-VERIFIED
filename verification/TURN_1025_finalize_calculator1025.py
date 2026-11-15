from pathlib import Path
import json,re,hashlib,subprocess,os
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
checks=['calculator1022_periodic_report.json']+['calculator1023_'+x+'_report.json'for x in ['machine','session','controller','boundaries']]+['calculator1024_'+x+'_report.json'for x in ['evidence','explorer','boundaries','grammar','witness','catalog']]+['calculator1025_'+x+'_report.json'for x in ['terminal','gui','layout','sync','routes','launchers','evidence','program','fresh']]
for name in checks:assert json.loads((w/name).read_text())['status']=='PASS',name
cases=json.loads((w/'calculator1025_independent_report.json').read_text());assert len(cases)==4 and all(x['expected']==x['actual']['passed']for x in cases)
mods=sorted(p.stem for p in (r/'SFT/Mathematics').glob('CalculatorComplete*.lean'))+['CalculatorExpressionCensus'];decl=[];th=[];defs=[];hashes={}
for mod in mods:
 p=r/f'SFT/Mathematics/{mod}.lean';s=p.read_text();assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M);ns=re.search(r'^namespace (\S+)',s,re.M)[1];hashes[mod]=hashlib.sha256(p.read_bytes()).hexdigest()
 for kind,name in re.findall(r'^\s*(def|theorem|abbrev|structure|inductive) (\w+)',s,re.M):
  full=ns+'.'+name;decl.append(full)
  if kind=='theorem':th.append(full)
  if kind in ['def','theorem','abbrev']:defs.append(full)
p=w/'AuditCalculator1025.lean';p.write_text(''.join('import SFT.Mathematics.'+m+'\n'for m in mods)+''.join('#print axioms '+n+'\n'for n in decl));x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'calculator1025_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and all("'"+n+"' does not depend on any axioms"in x.stdout for n in decl),x.stdout[-2000:]
(w/'calculator1025_proofs_config.json').write_text(json.dumps(dict(modules=mods,declarations=decl,theorems=th,definitions_and_theorems=defs,source_sha256=hashes,checks=checks,check_sha256={name:hashlib.sha256((w/name).read_bytes()).hexdigest()for name in checks}),indent=2));print('PASS',len(mods),'modules;',len(decl),'emptyaxiom declarations;',len(th),'theorems')
