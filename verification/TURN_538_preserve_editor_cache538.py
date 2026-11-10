from pathlib import Path
import hashlib,json,shutil,os
root=Path('/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build');active=Path('work/constants-recovery/.lake/build');backup=Path('work/turn538_preserved_editor_cache').resolve();manifest=[]
for q in backup.rglob("*") if backup.exists() else []:
 if q.is_file() and not (root/q.relative_to(backup)).exists():
  data=q.read_bytes();manifest.append(dict(path=str(q.relative_to(backup)),bytes=len(data),sha256=hashlib.sha256(data).hexdigest(),recovered_prior_move=True))
files=[p for p in root.rglob('*') if p.is_file() and not p.name.startswith('._') and (p.name.endswith('.ilean') or p.name.endswith('.ilean.hash'))]
for p in files:
 rel=p.relative_to(root);q=backup/rel;q.parent.mkdir(parents=True,exist_ok=True);data=p.read_bytes();digest=hashlib.sha256(data).hexdigest()
 if q.exists():assert hashlib.sha256(q.read_bytes()).hexdigest()==digest
 else:q.write_bytes(data)
 assert hashlib.sha256(q.read_bytes()).hexdigest()==digest
 a=active/rel;retargeted=False
 if a.is_symlink() and a.resolve()==p.resolve():
  a.unlink();a.symlink_to(q);retargeted=True
 p.unlink();manifest.append(dict(path=str(rel),bytes=len(data),sha256=digest,active_editor_link_retargeted=retargeted))
Path('work/turn538_editor_cache_preservation.json').write_text(json.dumps(dict(files=manifest,scope='Generated editor metadata and its hashes only; all .olean interfaces, native libraries, source and verification evidence retained on canonical drive',backup=str(backup)),indent=2));print('Preserved and verified',len(manifest),'generated editor-cache files;',sum(x['bytes'] for x in manifest),'logical bytes relocated.')
