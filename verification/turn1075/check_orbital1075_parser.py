import json,sys,os,hashlib,subprocess,re
from pathlib import Path
from html.parser import HTMLParser
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry.orbital_support_validation_v1 import _SourceTableParser
class Events(HTMLParser):
 def __init__(self):super().__init__();self.events=[]
 def handle_starttag(self,tag,attrs):self.events.append(['start',tag,attrs])
 def handle_endtag(self,tag):self.events.append(['end',tag])
 def handle_data(self,data):self.events.append(['data',data])
manifest=json.loads((w/'orbital1075_snapshot_manifest.json').read_text());documents=[]
for entry in manifest['files']:
 b=(root/entry['path']).read_bytes();assert 'sha256:'+hashlib.sha256(b).hexdigest()==entry['sha256'];documents.append(b.decode('utf-8'))
documents += ['<table class="data"><tr><td>A<sup>2</sup>\u00a0B</td></tr></table>','<table class="data"><table class="data"><tr><td>inner</td></tr></table><tr><td>outer</td></tr></table>','<table class="data"><table><tr><td>nested</td></tr></table><tr><td>tail</td></tr></table>','<table class="data"><tr><td>&amp;amp;<sub>x</sub>','<table class="data"><tr></tr></table><tr><td>outside</td></tr>']
expected=[]
with (w/'orbital1075_parser_input.jsonl').open('w')as f:
 for body in documents:
  tokens=Events();tokens.feed(body);p=_SourceTableParser();p.feed(body)
  f.write(json.dumps(dict(kind='events',events=tokens.events))+'\n')
  expected.append(dict(depth=p.depth,in_row=p.in_row,in_cell=p.in_cell,cell=p.cell,row=p.row,rows=[list(x)for x in p.rows]))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with (w/'orbital1075_parser_input.jsonl').open()as inp,(w/'orbital1075_parser_output.jsonl').open('w')as out,(w/'orbital1075_parser_execution.log').open('w')as err:r=subprocess.run(cmd+['--run','work/orbital1075_parser_check.lean'],env=env,stdin=inp,stdout=out,stderr=err)
assert r.returncode==0,r.returncode
actual=[json.loads(json.loads(line))for line in (w/'orbital1075_parser_output.jsonl').read_text().splitlines()];assert actual==expected,[i for i,(a,b)in enumerate(zip(actual,expected))if a!=b]
p=w/'turn1064_recovery/SFT/Chemistry/OrbitalSourceTables.lean';names=['SFT.Chemistry.OrbitalSourceTables.'+n for n in re.findall(r'^def (\w+)',p.read_text(),re.M)];audit=w/'orbital1075_parser_audit.lean';audit.write_text('import SFT.Chemistry.OrbitalSourceTables\n'+''.join('#print axioms '+n+'\n'for n in names));a=subprocess.run(cmd+[str(audit)],env=env,capture_output=True,text=True);(w/'orbital1075_parser_audit.log').write_text(a.stdout+a.stderr);assert a.returncode==0 and a.stdout.count('does not depend on any axioms')==len(names),a.stdout
(w/'orbital1075_parser_report.json').write_text(json.dumps(dict(status='PASS',cases=len(documents),registered_snapshots=22,all_parser_state_fields=True,axioms=[],declarations=names,source_sha256=hashlib.sha256(p.read_bytes()).hexdigest()),indent=2)+'\n');print('PASS22 registered snapshots and five parser edge cases; all parser state fields;',len(names),'zero-axiom declarations')
