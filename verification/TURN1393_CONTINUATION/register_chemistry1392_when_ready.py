from pathlib import Path
import ast,json,subprocess,sys,time
w=Path('work');r=w/'turn1064_recovery';rows=json.loads((w/'chemistry1392_native_preparation.json').read_text())
for row in rows:
 tag=row['tag'];script=w/('register_'+tag+'.py');tree=ast.parse(script.read_text());reports=None;cid=None
 for a in ast.walk(tree):
  if isinstance(a,ast.Assign):
   for t in a.targets:
    if isinstance(t,ast.Name)and t.id=='reports':reports=ast.literal_eval(a.value)
    if isinstance(t,ast.Name)and t.id=='cid':cid=ast.literal_eval(a.value)
 assert reports and cid,(tag,'original registrar bindings')
 while True:
  c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
  if x['lean_status']=='complete':break
  if c['summary']['fully_reconstructed_claims']>=1000:print('1000 review milestone reached; retain remaining results',flush=True);raise SystemExit(0)
  ready=all((w/n).exists()and json.loads((w/n).read_text()).get('status')=='PASS'for n in reports)
  if ready and all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
   print('ORIGINAL REGISTER',tag,flush=True);subprocess.run([sys.executable,str(script)],check=True);break
  time.sleep(15)
print('Original chemistry registration batch complete',flush=True)
