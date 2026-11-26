"""Check one pinned public archive against Git's complete tree, streaming each member."""
import argparse,hashlib,json,urllib.request,zipfile
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--commit',required=True);p.add_argument('--archive',required=True);p.add_argument('--report',required=True);a=p.parse_args()
url='https://api.github.com/repos/MettaMazza/SFT-v4-LEAN-VERIFIED/git/trees/'+a.commit+'?recursive=1'
with urllib.request.urlopen(url,timeout=60) as f:tree=json.load(f)
assert not tree.get('truncated')
expected={x['path']:x['sha'] for x in tree['tree'] if x['type']=='blob'}
matched=set();total=0;sha256_files=[]
with zipfile.ZipFile(a.archive) as z:
 for info in z.infolist():
  if info.is_dir():continue
  rel=info.filename.split('/',1)[1]
  assert rel in expected,rel
  assert rel not in matched,rel
  h=hashlib.sha1(b'blob '+str(info.file_size).encode()+b'\0'); h256=hashlib.sha256()
  with z.open(info) as f:
   for block in iter(lambda:f.read(1024*1024),b''):h.update(block);h256.update(block)
  assert h.hexdigest()==expected[rel],rel
  matched.add(rel);total+=info.file_size;sha256_files.append(dict(path=rel,bytes=info.file_size,sha256=h256.hexdigest(),git_blob_sha1=expected[rel]))
assert matched==set(expected),sorted(set(expected)-matched)[:10]
report=dict(status='PASS',commit=a.commit,files=len(matched),uncompressed_bytes=total,method='Every archive member streamed through Git blob SHA-1 and matched to nontruncated public commit tree; zip CRC checked during reads')
Path(a.report).write_text(json.dumps(report,indent=2)+'\n');print(report)

Path('work/release1000/REVIEW_ARCHIVE_MANIFEST.json').write_text(json.dumps(dict(version='0.5',review_snapshot_commit=a.commit,scope='Exact contents of the immutable GitHub review snapshot archive, including its retained historical publication artifacts',files=sha256_files),indent=2)+'\n')
