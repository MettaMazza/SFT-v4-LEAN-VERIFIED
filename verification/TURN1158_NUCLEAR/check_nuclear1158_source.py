import pathlib,json,subprocess,os,sys,hashlib,ast,re
from html.parser import HTMLParser
from html import unescape
w=pathlib.Path('work');r=w/'turn1064_recovery';stage=w/'pinned1158';src=stage/'sft/chemistry/nuclear_electronic_validation_v1.py';tree=ast.parse(src.read_text());parser=next(n for n in tree.body if isinstance(n,ast.ClassDef)and n.name=='IndependentParser');ns=dict(HTMLParser=HTMLParser,unescape=unescape);exec(compile(ast.Module(body=[parser],type_ignores=[]),str(src),'exec'),ns)
ids=json.loads((stage/'experiments/external_sources/chemistry/nuclear_electronic_target_identities_v1.json').read_text())['rows'];paths=list(dict.fromkeys(x['snapshot_path']for x in ids));q=lambda x:json.dumps(x,ensure_ascii=False)
class Events(HTMLParser):
 def __init__(self):super().__init__();self.events=[]
 def handle_starttag(self,tag,attrs):self.events.append('.startTag '+q(tag)+' ['+','.join('('+q(k)+','+('none'if v is None else 'some '+q(v))+')'for k,v in attrs)+']')
 def handle_endtag(self,tag):self.events.append('.endTag '+q(tag))
 def handle_data(self,data):self.events.append('.data '+q(data))
expected=[];decls=[]
for i,path in enumerate(paths):
 text=(stage/path).read_text();o=ns['IndependentParser']();o.feed(text);rows=[list(row)for row in o.rows if len(row)==13 and re.search(r'\^[1-9][0-9]*(?:Σ|Π|Δ|Φ)',row[0])];weight=re.search(r'Molecular weight.*?</a>:</strong>\s*([^<]+)',text,re.S).group(1).strip();expected.append({'rows':rows,'weight':weight});ev=Events();ev.feed(text);decls+=['def events'+str(i)+' : List ElectronSpinHtml.Event := ['+','.join(ev.events)+']','def html'+str(i)+' : String := '+q(text)]
s='''import SFT.Chemistry.NuclearElectronicSource
open SFT.Host SFT.Chemistry SFT.Chemistry.NuclearElectronicSource
set_option maxRecDepth 100000
set_option maxHeartbeats 10000000
'''+ '\n'.join(decls)+'''
def result (events : List ElectronSpinHtml.Event) (html : String) : Except String Canonical.Value := do
 let weight ← molecularWeight html
 return .object [("rows",.array ((stateRows events).map fun row => .array (row.map Canonical.Value.text))),("weight",.text weight)]
def main : IO Unit := do
'''
for i in range(len(paths)):s+=' match result events'+str(i)+' html'+str(i)+' with\n | .error e => throw (IO.userError e)\n | .ok value => IO.println (Canonical.render value)\n'
p=w/'NuclearElectronicSourceParity1158.lean';p.write_text(s);env=dict(os.environ,LEAN_PATH=str(pathlib.Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean')+':'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');a=subprocess.run([sys.executable,'work/run_lean_guarded.py',str(pathlib.Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'),'-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'nuclearelectronic1158_source_parity.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-2000:];actual=[json.loads(l)for l in a.stdout.splitlines()];assert actual==expected,[(i,[k for k in x if x[k]!=y[k]])for i,(x,y)in enumerate(zip(actual,expected))if x!=y];H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();(w/'nuclearelectronic1158_source_parity_report.json').write_text(json.dumps(dict(status='PASS',snapshots=len(paths),rows=sum(len(x['rows'])for x in actual),source_sha256=H(src),native_sha256=H(r/'SFT/Chemistry/NuclearElectronicSource.lean'),snapshots_sha256={p:H(stage/p)for p in paths}),indent=2)+'\n');print('PASS three original snapshots,95complete rows and all molecular weight inscriptions')
