from pathlib import Path
import json,shutil,hashlib
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');out=Path('work/checkpoint500');out.mkdir(exist_ok=True);paths=json.load(open('work/checkpoint500_paths.json'));manifest=[]
for rel in paths:
 data=(r/rel).read_bytes();p=out/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data)
 sha=hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest();manifest.append(dict(path=rel,sha=sha,size=len(data)))
Path('work/checkpoint500_manifest.json').write_text(json.dumps(manifest,indent=2)+'\n');print(len(manifest),'files',sum(x['size'] for x in manifest),'bytes')
