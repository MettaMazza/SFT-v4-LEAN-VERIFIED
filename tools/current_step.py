#!/usr/bin/env python3
"""Read-only continuation check. File identity is not a scientific proof."""
import argparse,hashlib,json,sys
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--workspace',type=Path,default=Path.cwd());a=p.parse_args()
root=Path(__file__).resolve().parent.parent
s=json.loads((root/'CONTINUATION_STATE.json').read_text())
assert s['schema']==1 and len(s['steps'])==18
ids=[x['id'] for x in s['steps']];assert len(set(ids))==18 and s['active_step'] in ids
bases={'canonical':root,'retained':a.workspace/'work/constants-recovery'}
changed=[];seen=set()
for item in s['snapshot']:
 k=(item['root'],item['path']);seen.add(k);f=bases[item['root']]/item['path']
 if not f.is_file():changed.append({'root':k[0],'path':k[1],'reason':'missing'});continue
 if hashlib.sha256(f.read_bytes()).hexdigest()!=item['sha256']:changed.append({'root':k[0],'path':k[1],'reason':'changed'})
for label,base in bases.items():
 for f in (base/'SFT').rglob('*.lean'):
  if not f.name.startswith('._') and (label,str(f.relative_to(base))) not in seen:changed.append({'root':label,'path':str(f.relative_to(base)),'reason':'new'})
active=next(x for x in s['steps'] if x['id']==s['active_step'])
print(json.dumps({'goal_state':s['goal_state'],'phase':s['phase'],'active_step':active,'changed_sources':changed,'live_jobs_to_check':s['live_jobs'],'instruction':'Resume only the recorded action when authorized. Inspect changes once; do not infer proof completion or failure from this identity check.'},indent=2))
sys.exit(2 if changed else 0)
