from pathlib import Path
import ast,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'quantumsupport1051_law.py').read_text();tree=ast.parse(src)
keep=[n for n in tree.body if isinstance(n,(ast.Import,ast.ImportFrom)) and not (isinstance(n,ast.ImportFrom) and n.module and n.module.startswith('sft')) or isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef)) or isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id in ['HELD','RETURNED','EMPTY_ONE','CLAIM_ID'] for t in n.targets)]
ns={};exec(compile(ast.Module(body=keep,type_ignores=[]),'pinned049','exec'),ns)
def word(ws):return '['+','.join(json.dumps(x) for x in ws)+']'
expected=[];cases=[]
for d in range(1,5):
 ws=ns['binary_words'](d)
 for x in ws:
  for y in ws:
   h=sum(ns['walsh_phase'](x,k)==ns['walsh_phase'](y,k) for k in ws)
   rr=len(ws)-h;expected.append([h,rr]);cases.append(f'({d},{word(x)},{word(y)})')
p=w/'quantumsupport1052_general_cases.lean';p.write_text('''import SFT.Physics.QuantumSupportOrthogonalityNative
import Lean
open SFT.Physics.QuantumSupportPreparation SFT.Physics.QuantumSupportOrthogonalityInduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def cases : List (Nat × Word × Word) := ['''+','.join(cases)+''']
#eval Lean.Json.compress (Lean.toJson (cases.map fun (d,x,y) =>
 let rows := agreementRows x y (words d)
 [heldCount rows,returnedCount rows]))
''')
ev={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288',str(p)],env=ev,capture_output=True,text=True);(w/'quantumsupport1052_general_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(json.loads(x.stdout));
if actual!=expected:
 print([(i,a,b) for i,(a,b) in enumerate(zip(actual,expected)) if a!=b][:5]);raise AssertionError("source row mismatch")
names=[];mods=['QuantumSupportParity','QuantumSupportOrthogonalityInduction','QuantumSupportOrthogonalityNative'];audits=''.join((w/f'quantumsupport1052_{a}_audit.log').read_text() for a in ['general','native'])
for m in mods:
 for n in re.findall(r'^(?:def|theorem) (\w+)',(r/f'SFT/Physics/{m}.lean').read_text(),re.M):
  full=f'SFT.Physics.{m}.{n}';assert "'"+full+"' does not depend on any axioms" in audits;names.append(full)
report=dict(status='PASS',original_pair_rows=len(expected),source_sha256=hashlib.sha256(src.encode()).hexdigest(),source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_operation='walsh_phase and orthogonality_certificate',declarations=names,axioms=[],modules={m:hashlib.sha256((r/f'SFT/Physics/{m}.lean').read_bytes()).hexdigest() for m in mods},scope='General every-depth native phase correspondence and complete orthogonality; full original tables through depth4 also compared. Parseval/support-product composition andentry completion not yet registered.')
(w/'quantumsupport1052_general_report.json').write_text(json.dumps(report,indent=2));print('PASS',len(expected),'source rows,',len(names),'empty-axiom declarations')
