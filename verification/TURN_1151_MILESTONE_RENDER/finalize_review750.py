"""Assemble review PDF metadata/bookmarks; does not declare publication QA complete."""
from pathlib import Path
import hashlib, json, re, shutil
from pypdf import PdfReader, PdfWriter
r=Path('work/turn1064_recovery'); pub=r/'publication'; work=Path('work/pdf1145')
coverage=json.loads((r/'COVERAGE.json').read_text())
assert sum(c['lean_status']=='complete' for c in coverage['claims'])==750
index=json.loads((pub/'RELEASE_INDEX.json').read_text())
assert index['completed_entries']==750 and index['publication_approval_required']
heads=json.loads(Path('work/headings1145.json').read_text())
pages=json.loads((work/'page_map.json').read_text())
report=json.loads((work/'page_mapping_report.json').read_text())
assert not report['missing'] and not report['duplicates']
assert len(heads)==len(pages)==report['mapped']
reader=PdfReader(work/'render.pdf'); writer=PdfWriter(); writer.clone_document_from_reader(reader)
assert len(reader.pages)==report['pages']
parents={}
for heading in heads:
 key=re.match(r'^(\d+(?:\.\d+)*)\.',heading)[1]
 item=writer.add_outline_item(heading,pages[key]-1,parent=parents.get(key.split('.')[0]) if '.' in key else None)
 if '.' not in key: parents[key]=item
writer.add_metadata({'/Title':(r/'ZENODO_PAPER_DRAFT.txt').read_text().splitlines()[0],'/Author':'Maria Smith','/Subject':'750-entry author review edition 0.4; unpublished','/Keywords':'SFT, zero axioms, zero free parameters, Lean 4, fine-structure constant, unified constants'})
with (pub/'SFT_PAPER.pdf').open('wb') as out: writer.write(out)
shutil.copyfile(pub/'SFT_PAPER.pdf',pub/'SFT_REVIEW.pdf')
def digest(p):
 h=hashlib.sha256()
 with p.open('rb') as f:
  for block in iter(lambda:f.read(1024*1024),b''):h.update(block)
 return h.hexdigest()
index.update(status='PREPARING_AUTHOR_REVIEW',review_status='Final rendered PDF inspection and release-bundle verification pending',pages=len(reader.pages),review_pdf_sha256=digest(pub/'SFT_REVIEW.pdf'),manuscript_sha256=digest(r/'ZENODO_PAPER_DRAFT.txt'))
(pub/'RELEASE_INDEX.json').write_text(json.dumps(index,indent=2)+'\n')
print(json.dumps({'pages':len(reader.pages),'bookmarks':len(heads),'pdf_sha256':index['review_pdf_sha256'],'status':index['status']}))
