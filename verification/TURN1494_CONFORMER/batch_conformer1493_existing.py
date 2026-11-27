from pathlib import Path
import json,hashlib,re,subprocess,os,sys
w=Path('work');r=w/'turn1064_recovery';base=r/'SFT/Chemistry';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']))
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();sources={p.stem:p for p in base.glob('Conformer*.lean')};order=[];seen=set()
def visit(name):
 if name in seen:return
 seen.add(name)
 for dep in re.findall(r'^import SFT.Chemistry.(Conformer\w+)',sources[name].read_text(),re.M):
  if dep in sources:visit(dep)
 order.append(name)
for name in sorted(sources):visit(name)
verified={}
for p in w.glob('conformer1447*entry_audit_report.json'):
 d=json.loads(p.read_text())
 if d.get('status')=='PASS':
  for m,h in d.get('source_sha256',{}).items():
   if m in sources and H(sources[m])==h and sources[m].with_suffix('.olean').exists():verified[m]=h
previous=json.loads((w/'conformer1493_existing_batch.json').read_text())['modules'] if '--resume' in sys.argv else {}
for m,row in previous.items():
 if row['status'] in ['PASS','REUSED_HASH_BOUND_PASS'] and m in sources and row['source_sha256']==H(sources[m]):verified[m]=row['source_sha256']
for audit in ['conformer1493_repairs_audit_report.json'] + [p.name for p in w.glob('conformer1494_*_audit_report.json')]:
 d=json.loads((w/audit).read_text())
 assert d['status']=='PASS'
 for m,h in d['source_sha256'].items():
  if m in sources and H(sources[m])==h:verified[m]=h
results={};command=[sys.executable,'work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192']
for name in order:
 p=sources[name];dependencies=re.findall(r'^import SFT.Chemistry.(Conformer\w+)',p.read_text(),re.M)
 if any(results.get(dep,{}).get('status')not in ['PASS','REUSED_HASH_BOUND_PASS']for dep in dependencies if dep in sources):
  results[name]={'status':'DEPENDENCY_FAILED','dependencies':dependencies,'source_sha256':H(p)}
 elif name in verified:results[name]={'status':'REUSED_HASH_BOUND_PASS','source_sha256':H(p)}
 elif name in previous and previous[name]['status'] in ['BUILD_FAILED','AUDIT_FAILED'] and previous[name]['source_sha256']==H(p):results[name]=previous[name]
 else:
  log=w/(name+'1493_build.log')
  with log.open('w')as f:q=subprocess.run(command+['-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=f,stderr=subprocess.STDOUT)
  result={'status':'BUILD_FAILED','source_sha256':H(p),'build_log':str(log),'exit':q.returncode}
  if q.returncode==0:
   names=['SFT.Chemistry.'+name+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',p.read_text(),re.M)]
   audit=w/(name+'1493Audit.lean');audit.write_text('import SFT.Chemistry.'+name+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
   alog=w/(name+'1493_audit.log')
   with alog.open('w')as f:q=subprocess.run(command+[str(audit)],env=env,stdout=f,stderr=subprocess.STDOUT)
   output=alog.read_text();result.update(status='PASS'if q.returncode==0 and output.count('does not depend on any axioms')==len(names) and 'depends on axioms'not in output else'AUDIT_FAILED',declarations=names,audit_log=str(alog))
  results[name]=result
 print(name,results[name]['status'],flush=True)
 (w/'conformer1493_existing_batch.json').write_text(json.dumps(dict(order=order,modules=results),indent=2)+'\n')
print('BATCH FINISHED',flush=True)
