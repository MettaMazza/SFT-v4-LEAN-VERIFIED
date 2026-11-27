from pathlib import Path
import json,re,os,subprocess,hashlib
w=Path('work');r=w/'turn1064_recovery';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0'
files=sorted((r/'SFT/Chemistry').glob('Elimination*.lean'))+sorted((r/'SFT/Chemistry/EliminationWitnessGraphs').glob('*.lean'))+sorted((r/'SFT/Chemistry/EliminationAdditionResults').glob('*.lean'))
names=[];lines=[]
for p in files:
 s=p.read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1];lines.append('import '+str(p.relative_to(r))[:-5].replace('/','.'))
 names += [ns+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)]
assert len(names)==len(set(names));lines+=['#print axioms '+n for n in names];(w/'EliminationFullAudit1503.lean').write_text('\n'.join(lines)+'\n')
env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']))
with(w/'elimination1503_full_audit.log').open('w')as out:q=subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192',str(w/'EliminationFullAudit1503.lean')],env=env,stdout=out,stderr=subprocess.STDOUT)
s=(w/'elimination1503_full_audit.log').read_text();assert q.returncode==0 and 'depends on axioms'not in s and s.count('does not depend on any axioms')==len(names),s[-2000:]
out={'status':'PASS','declarations':names,'count':len(names),'axiom_dependencies':[],'source_sha256':{str(p.relative_to(r)):hashlib.sha256(p.read_bytes()).hexdigest()for p in files},'kernel_witness_equality':'SFT.Chemistry.EliminationWitnessProofs.operationalWitnesses','log':'work/elimination1503_full_audit.log'}
(w/'elimination1503_full_audit_report.json').write_text(json.dumps(out,indent=2)+'\n');print('PASS',len(names),'declarations',len(files),'modules')
