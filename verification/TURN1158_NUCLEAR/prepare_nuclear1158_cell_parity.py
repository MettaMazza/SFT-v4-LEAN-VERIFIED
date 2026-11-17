import ast,json,pathlib,subprocess,os,re,sys,hashlib,dataclasses
from fractions import Fraction
w=pathlib.Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.claim_evidence import PositiveRatio
from sft.claim_evidence.fold_language import EMPTY_ONE
from sft.engine.exact import HeldLabel
src=w/'pinned1158/sft/chemistry/nuclear_electronic_validation_v1.py'
tree=ast.parse(src.read_text());fun=next(n for n in tree.body if isinstance(n,ast.FunctionDef)and n.name=='_cell_form')
ns=dict(Fraction=Fraction,PositiveRatio=PositiveRatio,EMPTY_ONE=EMPTY_ONE,HeldLabel=HeldLabel,VALUE_PATTERN=re.compile(r'^[\[\(]?\s*~?\s*([+-]?[0-9]+(?:\.[0-9_]*)?)'))
exec(compile(ast.Module(body=[fun],type_ignores=[]),str(src),'exec'),ns)
p=w/'pinned1158/experiments/external_sources/chemistry/nuclear_electronic_withheld_targets_v1.json';rows=json.loads(p.read_text())['rows'];cells=[c for row in rows for c in row['state_cells']]
cells+=['','0','-0','+0.00','-1.25','[ ~ -12.0_5 suffix','( +3.','  ~2.0_','1e4','nonnumeric','[1','2__','+2.','-0.0001']
expected=[]
for cell in cells:
 try:
  tag,value=ns['_cell_form'](cell);expected.append([tag,dataclasses.asdict(value)])
 except Exception as e:expected.append({'error':str(e)})
q=lambda x:json.dumps(x,ensure_ascii=False)
lean='''import SFT.Chemistry.NuclearElectronicCell
set_option maxRecDepth 10000
set_option maxHeartbeats 10000000
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.NuclearElectronicCell
def main : IO Unit := do
'''
for cell in cells:
 lean+=' match cellForm '+q(cell)+' with\n | .error e => IO.println (Canonical.render (.object [("error",.text e)]))\n | .ok (tag,value) => IO.println (Canonical.render (.array [.text tag,canonical value]))\n'
test=w/'NuclearElectronicCellParity1158.lean';test.write_text(lean)
env=dict(os.environ,LEAN_PATH=str(pathlib.Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean')+':'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
a=subprocess.run([sys.executable,'work/run_lean_guarded.py',str(pathlib.Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'),'-j1','-M8192','--run',str(test)],env=env,capture_output=True,text=True);(w/'nuclearelectronic1158_cells.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-2000:];actual=[json.loads(line)for line in a.stdout.splitlines()];assert actual==expected,[(i,cells[i],x,y)for i,(x,y)in enumerate(zip(actual,expected))if x!=y][:3]
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();(w/'nuclearelectronic1158_cells_report.json').write_text(json.dumps(dict(status='PASS',source_cells=1235,additional_cases=len(cells)-1235,native_sha256=H(r/'SFT/Chemistry/NuclearElectronicCell.lean'),source_sha256=H(src),targets_sha256=H(p)),indent=2)+'\n');print('PASS',len(cells),'exact original cell forms')
