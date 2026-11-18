from pathlib import Path
import json,sys,os,subprocess,hashlib
from html.parser import HTMLParser
w=Path('work');r=w/'turn1064_recovery';stage=w/'pinned1313';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry;sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import bond_angle_validation_v1 as src
class Events(HTMLParser):
 def __init__(self):super().__init__();self.events=[]
 def handle_starttag(self,tag,attrs):self.events.append(['start',tag,attrs])
 def handle_endtag(self,tag):self.events.append(['end',tag])
 def handle_data(self,data):self.events.append(['data',data])
html=['','text outside','<td>orphan</td>','<tr></tr>','<tr><td></td></tr>','<TR><TH> a  b </TH><TD> 2 </TD></TR>','<tr><td>a <b>b</b> c</td></tr>','<tr><td>open','<tr><td>old<tr><td>new</td></tr>','<tr><td>old<tr>new</td></tr>','<tr><td>&amp; &#160; x</td></tr>','<tr><th>\t α\n β </th></tr>','<table><tr><td>a</td></tr></table><tr><td>b</td></tr>','<tr><td>a</td></td><th>b</th></tr>','<tr><td>a</tr>outside</td>']
for p in [src.BF3_PATH,src.XEF2_PATH,src.XEF4_PATH]:html.append((stage/p).read_text(encoding='utf-8',errors='replace'))
inputs=[];expected=[]
for s in html:
 parser=Events();parser.feed(s);inputs.append(parser.events)
 p=src._TableParser();p.feed(s);expected.append(p.rows)
(w/'bondangle1313_table_input.json').write_text(json.dumps(inputs));(w/'bondangle1313_table_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
header=(w/'MolecularBondAngleValidationProgram1313.lean').read_text().split('def main : IO Unit')[0]
(w/'MolecularBondAngleTables1313.lean').write_text(header+'''def main : IO Unit := do
 let raw ← IO.FS.readFile "work/bondangle1313_table_input.json"
 let j ← IO.ofExcept (Lean.Json.parse raw)
 let cases ← IO.ofExcept j.getArr?
 let results ← cases.toList.mapM fun row => do
  let events ← IO.ofExcept (row.getArr? >>= fun a => a.toList.mapM htmlEvent)
  pure (SFT.Host.Canonical.Value.array ((MolecularBondAngleSource.tableRows events).map fun row => .array (row.map SFT.Host.Canonical.Value.text)))
 IO.println (SFT.Host.Canonical.render (.array results))
''')
(w/'MolecularBondAngleExperiment1313.lean').write_text('''import SFT.Chemistry.MolecularBondAngleExperiment
open SFT.Chemistry.MolecularBondAngleExperiment SFT.Host.Canonical
def main : IO Unit := do
 let program ← IO.ofExcept predictionProgramDocument
 let registration ← IO.ofExcept experimentRegistrationRecord
 IO.println (render (.object [("program",program),("registration",registration)]))
''')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run']
for name,driver,expected in [('table','MolecularBondAngleTables1313.lean',expected),('experiment','MolecularBondAngleExperiment1313.lean',dict(program=src.prediction_program_document(),registration=src.experiment_registration_record()))]:
 p=subprocess.run(cmd+['work/'+driver],env=env,capture_output=True,text=True);(w/('bondangle1313_'+name+'_execution.log')).write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1600:]+p.stderr[-500:]
 actual=json.loads(p.stdout);expected=json.loads(json.dumps(expected));assert actual==expected,name
 (w/('bondangle1313_'+name+'_output.json')).write_text(json.dumps(actual,indent=2)+'\n')
 (w/('bondangle1313_'+name+'_report.json')).write_text(json.dumps(dict(status='PASS',case_count=len(expected)if name=='table'else 43,source_sha256={str(p.relative_to(r)):hashlib.sha256(p.read_bytes()).hexdigest()for p in (r/'SFT/Chemistry').glob('MolecularBondAngle*.lean')}),indent=2)+'\n')
 print('PASS original/native '+name,flush=True)
