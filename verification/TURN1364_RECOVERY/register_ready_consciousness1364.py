from pathlib import Path
import json,re,ast,subprocess,hashlib
w=Path('work');r=w/'turn1064_recovery';scripts={}
for p in w.glob('register_*.py'):
 if 'when_ready'in p.name:continue
 s=p.read_text();m=re.search(r"cid\s*=\s*['\"](SFT-CONSC-[^'\"]+)['\"]",s)
 if not m or 'source_component_correspondence'not in s:continue
 cid=m[1]
 if cid in scripts:raise AssertionError((cid,p,scripts[cid]))
 scripts[cid]=p
initial=json.loads((r/'COVERAGE.json').read_text());order=[x['claim_id']for x in initial['claims']if x['claim_id'].startswith('SFT-CONSC-')];summary=[]
for cid in order:
 c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
 if x['lean_status']=='complete':continue
 if c['summary']['fully_reconstructed_claims']>=1000:break
 if cid not in scripts:summary.append({'claim':cid,'state':'no existing registrar identified'});continue
 if not all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):summary.append({'claim':cid,'state':'prerequisite not yet registered'});continue
 p=scripts[cid];tree=ast.parse(p.read_text());vals=[n.value for n in tree.body if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='reports'for t in n.targets)];assert len(vals)==1
 names=ast.literal_eval(vals[0]);missing=[n for n in names if not(w/n).exists()]
 if missing:summary.append({'claim':cid,'state':'required retained check absent','files':missing});continue
 for n in names:
  a=json.loads((w/n).read_text());assert a['status']=='PASS',(cid,n)
  for path,h in a.get('source_sha256',{}).items():
   rel=path if path.startswith('SFT/')else'SFT/Consciousness/'+path+'.lean';assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h,(cid,n,rel)
 print('REGISTER',cid,flush=True);result=subprocess.run(['python3',str(p)],capture_output=True,text=True)
 (w/(p.stem+'_1364.log')).write_text(result.stdout+result.stderr)
 if result.returncode:raise RuntimeError((p,result.stdout[-1000:],result.stderr[-1000:]))
 after=json.loads((r/'COVERAGE.json').read_text());assert next(y for y in after['claims']if y['claim_id']==cid)['lean_status']=='complete';summary.append({'claim':cid,'state':'registered complete','count':after['summary']['fully_reconstructed_claims']});print('COMPLETE',after['summary']['fully_reconstructed_claims'],flush=True)
(w/'consciousness_registration1364_results.json').write_text(json.dumps(summary,indent=2)+'\n');print('Registered',sum(x['state']=='registered complete'for x in summary),'existing verified entries',flush=True)
