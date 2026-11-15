from pathlib import Path
import sys,json,subprocess,os,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import proton_radius_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
expected=[];expr=[]
def check(f,args,name,out):
 try:expected.append({'ok':canonical_value(f(*args))})
 except ValueError as e:expected.append({'error':str(e)})
 expr.append('out '+out+' ('+name+' '+ ' '.join(json.dumps(a) for a in args)+')')
for original,native,out in [('proton_inner_site','protonInnerSite','rational'),('proton_edge_share','protonEdgeShare','rational'),('colour_fibre_support','colourFibreSupport','natValue'),('leading_radius_multiplier','leadingRadiusMultiplier','rational'),('complete_charge_support','completeChargeSupport','natValue'),('terminal_alpha','terminalAlpha','rational'),('terminal_radius_retention','terminalRadiusRetention','rational'),('terminal_radius_coefficient','terminalRadiusCoefficient','rational'),('structural_formula_census','structuralFormulaCensus','rowsValue')]:check(getattr(src,original),[],native,out)
s='''import SFT.Physics.ProtonRadius
import SFT.Host.Canonical
open SFT.Physics.ProtonRadius SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def natValue (n : Nat) : Value := .integer (.ofNat n)
def rowValue (r : FormulaRow) : Value := .object [("charge_support",natValue r.chargeSupport),("transport_order",.text r.transportOrder),("coefficient",rational r.coefficient),("structurally_selected",.boolean r.structurallySelected)]
def rowsValue (rows : List FormulaRow) : Value := .array (rows.map rowValue)
def out (f : α → Value) : Except String α → Value
 | .ok x => .object [("ok",f x)]
 | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n';p=w/'constants-recovery/ProtonRadius1012.lean';p.write_text(s);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'proton_radius1012_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
p=r/'SFT/Physics/ProtonRadius.lean';s=p.read_text();names=['SFT.Physics.ProtonRadius.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)];q=w/'proton_radius1012_core_audit.lean';q.write_text('import SFT.Physics.ProtonRadius\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run([lean,str(q)],env=env,capture_output=True,text=True);(w/'proton_radius1012_core_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'proton_radius1012_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,source_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),scope='Original tripling edge,six paths,leading multiplier,ten charge cells,terminal alpha retention,coefficient and all9 source formula rows;exact guards and unique selected row'),indent=2));print('PASS',len(expected),'fresh original outputs;',len(names),'empty-axiom declarations')
