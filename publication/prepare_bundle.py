"""Prepare a complete local review/deposit bundle. Does not access Zenodo or publish."""
from pathlib import Path
import argparse,hashlib,json,shutil,zipfile
p=argparse.ArgumentParser();p.add_argument('output',type=Path);a=p.parse_args();r=Path(__file__).resolve().parents[1];out=a.output.resolve()
if out==r or r in out.parents:raise SystemExit('Output must be outside the repository.')
out.mkdir(parents=True,exist_ok=True)
files=[]
for f in sorted(r.rglob('*')):
 if not f.is_file():continue
 rel=f.relative_to(r)
 if any(s in {'.lake','.git','__pycache__','_v3'} or s.startswith('._') for s in rel.parts):continue
 if rel.as_posix().startswith('verification/current/'):continue
 files.append(f)
manifest=[{'path':f.relative_to(r).as_posix(),'bytes':f.stat().st_size,'sha256':hashlib.sha256(f.read_bytes()).hexdigest()} for f in files]
with zipfile.ZipFile(out/'SFT_FULL_SOURCE_AND_EVIDENCE.zip','w',zipfile.ZIP_DEFLATED) as z:
 for f in files:z.write(f,f.relative_to(r).as_posix())
for name in ['ZENODO_PAPER_DRAFT.txt','TIMELINE.txt','COVERAGE.json','publication/SFT_PAPER.pdf','publication/RELEASE_INDEX.json','publication/ZENODO_METADATA.json','publication/ZENODO_LANDING_PAGE.html','publication/REVIEW_GUIDE.txt']:
 shutil.copy2(r/name,out/Path(name).name)
(out/'REPOSITORY_SHA256_MANIFEST.json').write_text(json.dumps(manifest,indent=2)+'\n')
with zipfile.ZipFile(out/'SFT_FULL_SOURCE_AND_EVIDENCE.zip') as z:
 assert z.testzip() is None
 for entry in manifest:assert hashlib.sha256(z.read(entry['path'])).hexdigest()==entry['sha256']
print(f'Prepared and hash-verified {len(files)} repository files; no upload or publication performed.')
