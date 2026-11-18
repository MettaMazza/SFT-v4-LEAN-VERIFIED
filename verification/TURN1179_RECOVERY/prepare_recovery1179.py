from pathlib import Path
import json,hashlib,re,ast
w=Path('work');r=w/'turn1064_recovery'
for tag in ['evolution1183','gene1192','boxes1191','alphabet1189','codon1190']:
 for kind in ['full_audit','empirical']:
  a=json.loads((w/(tag+'_'+kind+'_report.json')).read_text());assert a['status']=='PASS'
  for rel,h in a['source_sha256'].items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h,(tag,rel)
 print('Retained applicable',tag,'audit/empirical')
for tag in ['quantum1235','xray1163']:
 a=json.loads((w/(tag+'_full_audit_report.json')).read_text());assert a['status']=='PASS'
 for rel,h in a.get('source_sha256',{}).items():
  p=r/rel
  if not p.exists():p=r/'SFT/Chemistry'/(rel+'.lean')
  assert hashlib.sha256(p.read_bytes()).hexdigest()==h,(tag,rel)
 print('Retained applicable',tag,'audit')
def commands(driver,after=None):
 s=(w/driver).read_text();entries=ast.literal_eval(re.search(r'^entries=(.*)$',s,re.M)[1]);out=[]
 if after:entries=entries[next(i for i,x in enumerate(entries)if x[0]==after)+1:]
 for tag,cid in entries:
  out += ['prepare_'+tag+'_reuse.py','build_'+tag+'.py','build_'+tag+'_interfaces.py','check_'+tag+'_resolved.py','check_'+tag+'_program.py']
 return out
chains={
 'quantum':['check_quantum1235_empirical.py','check_quantum1235_program.py','register_quantum1235.py','build_patient1234_all.py','check_patient1234_program.py','check_patient1234_empirical.py'],
 'xray':['check_xray1163_empirical.py'],
 'evolution':['check_evolution1183_program.py']+commands('run_evolution1183_checks.py','evolution1183'),
 'gene':['check_gene1192_program.py']+commands('run_gene_protein1189_checks.py','gene1192')+commands('run_cell1201_checks.py')+commands('run_organism1208_checks.py')+commands('run_ecology1220_checks.py')}
for name in ['medicine1236_entries.json','medicine1241_entries.json']:
 for tag,mod,cid in json.loads((w/name).read_text()):chains['quantum']+=['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']
for lane,cmds in chains.items():
 for f in cmds:
  if not (w/f).is_file():
   assert f.endswith('_resolved.py'),f
   tag=f[len('check_'):-len('_resolved.py')]
   assert f in (w/('prepare_'+tag+'_reuse.py')).read_text(),f
 p=w/('resume1179_'+lane+'.py');p.write_text("from pathlib import Path\nimport subprocess,json,datetime\nw=Path('work')\ncommands="+repr(cmds)+"\nfor name in commands:\n print('START '+name,flush=True)\n (w/'resume1179_"+lane+"_cursor.json').write_text(json.dumps(dict(command=name,started=datetime.datetime.now(datetime.timezone.utc).isoformat())))\n subprocess.run(['python3','work/'+name],check=True)\n print('PASS '+name,flush=True)\n")
(w/'resume1179_plan.json').write_text(json.dumps(chains,indent=2)+'\n')
print('Four exact recovery chains; passed checks retained; no old PID waits or additional compiler workers.')
