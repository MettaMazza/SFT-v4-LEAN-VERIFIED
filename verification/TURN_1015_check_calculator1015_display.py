from pathlib import Path
import sys,json,subprocess,os,re,hashlib,itertools
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator import values as v,operations_v3 as o,gui
parts=[Fraction(-8),Fraction(-3,2),Fraction(-1,3),Fraction(0),Fraction(1,3),Fraction(2),Fraction(22,7)]
sc=[v.scalar_from_projection(x) for x in parts];ivs=[v.CertifiedInterval(sc[a],sc[b],(f'case{a}_{b}',)) for a,b in [(0,0),(0,2),(2,4),(4,5),(5,6)]];values=sc+ivs+[v.ComplexFibre(sc[0],sc[4]),v.ComplexFibre(sc[3],sc[3])]
def rs(q):return '(SFT.Physics.LeptonIntervals.normalize ('+str(q.numerator)+') '+str(q.denominator)+' (by decide))'
def ss(x):return '(← scalarFromProjection '+rs(v.scalar_to_fraction_for_projection(x))+')'
def ii(x):return '(← certifiedInterval '+ss(x.lower)+' '+ss(x.upper)+' '+json.dumps(list(x.certificate))+')'
def vv(x):
 if isinstance(x,v.CertifiedInterval):return '.interval '+ii(x)
 if isinstance(x,v.ComplexFibre):return '.complex ⟨'+ss(x.real)+','+ss(x.orthogonal)+'⟩'
 return '.scalar '+ss(x)
def canon(x):return [v.exact_text(x.lower),v.exact_text(x.upper),list(x.certificate)]
expected=[];expressions=[]
for x,p in itertools.product(values,[-8,0,1,3,16]):
 try:expected.append({'ok':gui._friendly(x,p)})
 except (v.CalculatorHalt,ValueError) as e:expected.append({'error':'ValueError' if isinstance(e,ValueError) else str(e)})
 expressions.append('result (do pure (.text (← friendly ('+vv(x)+') ('+str(p)+'))))')
for size in range(4):
 for xs in itertools.product(ivs[:3],repeat=size):
  try:expected.append({'ok':canon(o._interval_hull(*xs,certificate='hull'))})
  except ValueError as e:expected.append({'error':str(e)})
  expressions.append('result (do pure (interval (← intervalHull ['+','.join(ii(x) for x in xs)+'] "hull")))')
for a,b in itertools.product(sc,repeat=2):
 for cert in [(),('test',)]:
  try:expected.append({'ok':canon(o._ordered_interval(a,b,cert))})
  except v.CalculatorHalt as e:expected.append({'error':str(e)})
  expressions.append('result (do pure (interval (← orderedInterval '+ss(a)+' '+ss(b)+' '+json.dumps(list(cert))+')))')
header='''import SFT.Mathematics.CalculatorDisplay
open SFT.Mathematics SFT.Host CalculatorDisplay CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def interval (v : CertifiedInterval) : Canonical.Value := .array [.text (exactText v.lower),.text (exactText v.upper),.array (v.certificate.map Canonical.Value.text)]
def result : Except String Canonical.Value → Canonical.Value | .ok x => .object [("ok",x)] | .error e => .object [("error",.text e)]
'''
header+='#eval IO.println (Canonical.render (.array ['+',\n'.join(expressions)+']))\n'
header+='#eval IO.println (Canonical.render (.array [.array (buttonRows.map (fun row => .array (row.map Canonical.Value.text))),.array (insertions.map (fun (a,b) => .array [.text a,.text b])),.text guideText]))\n'
p=w/'constants-recovery/CalculatorDisplay1015.lean';p.write_text(header);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1015_display_output.log').write_text(x.stdout+x.stderr);assert x.returncode==0,(x.returncode,x.stdout[-1000:]);lines=x.stdout.splitlines();actual=json.loads(lines[0]);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:5];assert json.loads(lines[1])==[[list(row) for row in gui.BUTTON_ROWS],[list(kv) for kv in gui.INSERTIONS.items()],gui.GUIDE_TEXT]
s=(r/'SFT/Mathematics/CalculatorDisplay.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1015_display_audit.lean';p.write_text('import SFT.Mathematics.CalculatorDisplay\n'+''.join('#print axioms SFT.Mathematics.CalculatorDisplay.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1015_display_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
report=dict(status='PASS',cases=len(expected)+3,declarations=names,axioms=[],source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='AlloriginalGUIbuttonrows,insertions,guide,andfriendlyprojection;orderedinterval/hullsourceoutputs.');(w/'calculator1015_display_report.json').write_text(json.dumps(report,indent=2));print('PASS',report['cases'],'source outputs;',len(names),'emptyaxioms')
