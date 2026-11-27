from pathlib import Path
import os,json,subprocess,concurrent.futures,hashlib
w=Path('work');r=w/'turn1064_recovery';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']))
rows=json.load(open(w/'addition1502_witness_graphs.json'))
def run(row):
 p=r/(row['module'].replace('.','/')+'.lean');log=w/('addition1502_graph_'+row['name']+'.log');h=hashlib.sha256(p.read_bytes()).hexdigest();receipt=w/('addition1502_graph_'+row['name']+'.json')
 if receipt.exists():
  old=json.load(open(receipt))
  if old['status']=='PASS'and old['sha256']==h and p.with_suffix('.olean').exists():return old
 with log.open('w')as out:q=subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=out,stderr=subprocess.STDOUT)
 s=log.read_text();out={'module':row['module'],'name':row['name'],'sha256':h,'status':'PASS'if q.returncode==0 and 'depends on axioms'not in s else 'FAIL','audited_results':s.count('does not depend on any axioms'),'log':str(log)};receipt.write_text(json.dumps(out,indent=2)+'\n');print(row['name'],out['status'],flush=True);return out
with concurrent.futures.ThreadPoolExecutor(max_workers=6)as pool:results=list(pool.map(run,rows))
(w/'addition1502_graphs_build_report.json').write_text(json.dumps({'status':'PASS'if all(r['status']=='PASS'for r in results)else 'FAIL','results':results},indent=2)+'\n')
