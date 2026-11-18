"""Set PDF metadata and produce page renders for an explicit visual review."""
from pathlib import Path
import sys,json,hashlib,subprocess
from pypdf import PdfReader,PdfWriter
from PIL import Image,ImageDraw
import pdfplumber
p=Path(sys.argv[1]).resolve();src=p/'SFT_PAPER.pdf';meta=json.loads((p/'ZENODO_METADATA.json').read_text());state=json.loads((p/'ZENODO_STATE.json').read_text());r=PdfReader(src);w=PdfWriter();w.clone_document_from_reader(r);w.add_metadata({'/Title':meta['title'],'/Author':'Maria Smith','/Subject':meta['title']+'; doi:'+state['doi'],'/Keywords':', '.join(meta['keywords']),'/Creator':'Smithian Fold Theory standalone publication series'})
with (p/'metadata.pdf').open('wb') as f:w.write(f)
(p/'metadata.pdf').replace(src);q=p/'qa';q.mkdir(exist_ok=True);bad=[];texts=[]
with pdfplumber.open(src) as pdf:
 for i,page in enumerate(pdf.pages):
  texts.append(page.extract_text())
  for a in page.extract_words():
   if a['x0']<40 or a['x1']>page.width-40 or a['top']<15 or a['bottom']>page.height-15:bad.append({'page':i+1,'text':a['text']})
 pages=len(pdf.pages)
assert not bad,bad
text='\n'.join(texts);assert 'SFTDISPLAY' not in text and 'SFTMATHPLACEHOLDER' not in text
assert 'Maria.smith.sftoe@gmail.com' in text and ('discord.gg/QCNkzq6kZC' in text), 'PDF must include Maria Smith correspondence and Discord invitation'
(q/'text.txt').write_text(text);subprocess.run(['pdftoppm','-scale-to','950','-png',str(src),str(q/'release')],check=True)
sheet=Image.new('RGB',(960,460*((pages+2)//3)),'#ddd')
for i in range(pages):
 f=q/('release-'+str(i+1).zfill(len(str(pages)))+'.png');im=Image.open(f);im.thumbnail((300,425));sheet.paste(im,((i%3)*320+10,(i//3)*460+10));ImageDraw.Draw(sheet).text(((i%3)*320+10,(i//3)*460+440),str(i+1),fill='black')
sheet.save(q/'contact.png');render=json.loads((p/'render_check.json').read_text());qa={'author_contact_verified':True,'pdf_sha256':hashlib.sha256(src.read_bytes()).hexdigest(),'pages':pages,'math_expressions':render['equations'],'render_errors':0,'text_boundary_errors':bad,'visual_review_passed':False,'visual_review':'Pending inspection of rendered page images','arithmetic_checks':json.loads((p/'arithmetic_check.json').read_text())};(p/'PUBLICATION_QA.json').write_text(json.dumps(qa,indent=2)+'\n');print(json.dumps({'pages':pages,'equations':render['equations'],'boundary_errors':len(bad),'contact':str(q/'contact.png')}))
