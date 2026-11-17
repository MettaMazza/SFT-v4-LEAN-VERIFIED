from pathlib import Path
import sys,json
from html.parser import HTMLParser
w=Path('work');stage=w/'pinned1126';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import multicentre_support_validation_v1 as v
class Events(HTMLParser):
 def __init__(self):super().__init__();self.events=[]
 def handle_starttag(self,tag,attrs):self.events.append(['start',tag])
 def handle_endtag(self,tag):self.events.append(['end',tag])
 def handle_data(self,data):self.events.append(['data',data])
cases=[(stage/p).read_text()for p in [v.DIBORANE_PATH,v.BENZENE_PATH]]+['','a &amp; b','<sub>2</sub>','<tr><td> a  b </td><th>c<sub>2</sub></th></tr>','<td>x</td>','<tr><td>x<tr><td>y</td></tr>','<tr></tr>','<tr><td>unclosed','<tr><td>&amp;amp;\t\n</td></tr>','<tr><td>x</tr></td>']
inputs=[];expected=[]
for raw in cases:
 p=v._IndependentHTMLSurface();p.feed(raw);e=Events();e.feed(raw);inputs.append(e.events);expected.append(dict(in_cell=p.in_cell,in_row=p.in_row,cell=p.cell,row=p.row,rows=p.rows,all_parts=p.all_parts,text=p.text))
(w/'multicentresurface1127_input.json').write_text(json.dumps(inputs,ensure_ascii=False));(w/'multicentresurface1127_expected.json').write_text(json.dumps(expected,ensure_ascii=False));print('Prepared',len(inputs),'documents',sum(map(len,inputs)),'events')
