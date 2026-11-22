from pathlib import Path
import json,re,unicodedata
from pypdf import PdfReader
pdf=PdfReader('work/pdf_review1000/render.pdf');heads=json.load(open('work/headings_review1000.json'));normalize=lambda s:re.sub(r'\s+',' ',unicodedata.normalize('NFKC',s)).strip();wanted={re.match(r'^(\d+(?:\.\d+)*)\.',h)[1]:normalize(h) for h in heads};found={};duplicates=[]
for i,p in enumerate(pdf.pages,1):
 chunks=[]
 def visit(t,cm,tm,font,size):
  if font and 'Ubuntu-Bold' in str(font.get('/BaseFont','')) and abs(size-18.66)<0.1:chunks.append(t)
 p.extract_text(visitor_text=visit);text=normalize(' '.join(chunks))
 for key,h in wanted.items():
  if re.search(r'(?<![\d.])'+re.escape(key)+r'\.\s',text):
   if key in found:duplicates.append((key,found[key],i))
   found[key]=i
missing=[(k,h) for k,h in wanted.items() if k not in found];Path('work/pdf_review1000/page_map.json').write_text(json.dumps(found,indent=2));Path('work/pdf_review1000/page_mapping_report.json').write_text(json.dumps(dict(pages=len(pdf.pages),mapped=len(found),missing=missing,duplicates=duplicates,method='Exact numbered body heading, Ubuntu-Bold18.66; excludes contents and citations'),indent=2));print('pages',len(pdf.pages),'mapped',len(found),'missing',missing[:10],'duplicates',duplicates);assert not missing and not duplicates
