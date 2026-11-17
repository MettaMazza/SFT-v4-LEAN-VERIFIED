from pathlib import Path
import xml.etree.ElementTree as E,json,hashlib
p=Path('work/pdf1145/allpages1152.html');pages=0;words=0;errors=[];headers={'SFT','v4','|','Maria','Smith','Working','manuscript','toward750','toward','750','750-entry','author','review','Edition','0.4'};footers={'Working','manuscript','|','Not','published','Author','review'}
for event,e in E.iterparse(p,events=('start','end')):
 tag=e.tag.split('}')[-1]
 if event=='start'and tag=='page':pages+=1
 if event!='end':continue
 if tag=='word':
  words+=1;t=e.text or '';x0=float(e.attrib['xMin']);x1=float(e.attrib['xMax']);y0=float(e.attrib['yMin']);y1=float(e.attrib['yMax'])
  reason=None
  if x0<44 or x1>552:reason='horizontal margin'
  elif y0<35 and t not in headers:reason='header region'
  elif y1>812 and t not in footers and not t.isdigit():reason='footer region'
  if reason:errors.append(dict(page=pages,text=t,x0=x0,x1=x1,y0=y0,y1=y1,reason=reason))
 if tag in ['word','line','block','flow','page']:e.clear()
report=dict(pages=pages,words_checked=words,flagged_words=len(errors),flags=errors,pdf_sha256=hashlib.sha256(Path('work/turn1064_recovery/publication/SFT_PAPER.pdf').read_bytes()).hexdigest(),scope='Final review PDF page-coordinate check; flags require visual review, not automatic mathematical conclusions.')
Path('work/pdf1145/bounds1152_report.json').write_text(json.dumps(report,indent=2)+'\n');print(pages,'pages;',words,'words;',len(errors),'flags');print(errors[:8])
