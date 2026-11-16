from pathlib import Path
import json,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');a=json.load(open(w/'thermalobservation1034_full_report.json'));checks=['thermalobservation1034_'+s+'_report.json' for s in ['analysis','records','measurement','grammar','metadata','program','fresh','empirical']]
for f in checks:assert json.load(open(w/f))['status']=='PASS',f
cfg=dict(modules=a['modules'],declarations=a['declarations'],source_sha256=a['source_sha256'],checks=checks,check_sha256={f:hashlib.sha256((w/f).read_bytes()).hexdigest()for f in checks});cfg['theorems']=[];cfg['definitions_and_theorems']=[]
for m in a['modules']:
 body=(r/f'SFT/Physics/{m}.lean').read_text();assert hashlib.sha256(body.encode()).hexdigest()==a['source_sha256'][m]
 cfg['theorems']+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',body,re.M)]
 cfg['definitions_and_theorems']+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',body,re.M)]
(w/'thermalobservation1034_proofs_config.json').write_text(json.dumps(cfg,indent=2)+'\n');print('All source-specific checks PASS; ready for registration')
