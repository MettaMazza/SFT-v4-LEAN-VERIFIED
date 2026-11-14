from pathlib import Path
import subprocess,json,hashlib,sys
w=Path('work');v=w/'v3-runtime500';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';record='experiments/external_sources/physics/snapshots/matter-flavour-source-record.json'
def read(p):return subprocess.check_output(['git','-C',repo,'show',pin+':'+p])
b=read(record);payload=json.loads(b);paths=[record,'sft/physics/matter_flavour_validation_v1.py']+[x['snapshot_path'] for x in payload['sources'] if x.get('snapshot_path')];identity={}
for path in dict.fromkeys(paths):
 data=read(path);p=v/path;p.parent.mkdir(parents=True,exist_ok=True)
 if not p.exists():p.write_bytes(data)
 assert p.read_bytes()==data,path
 identity[path]=hashlib.sha256(data).hexdigest()
(w/'mattervalidation926_source_identity.json').write_text(json.dumps(identity,indent=2));sys.path.insert(0,str(v.resolve()))
from sft.physics import matter_flavour_validation_v1 as src
p=src.authoritative_record(v.resolve());assert p==payload
(w/'mattervalidation926_original_record.json').write_text(json.dumps(p,indent=2));(w/'mattervalidation926_original_classifications.json').write_text(json.dumps(src._classifications,indent=2))
print('PASS pinned authoritative record,all source/component identities and5 fresh original classifications')
