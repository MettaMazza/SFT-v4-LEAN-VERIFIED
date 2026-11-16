from pathlib import Path
from fractions import Fraction
import ast,json,subprocess,os,re,hashlib,__future__
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'thermal1032_law.py').read_text();tree=ast.parse(src);env={'Fraction':Fraction,'BINARY':2,'UP_DEPTH':7};exec(compile(ast.Module(body=[n for n in tree.body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'pinned-thermal','exec',flags=__future__.annotations.compiler_flag),env)
def rat(q):
 q=Fraction(q);return f'(LeptonIntervals.normalize ({q.numerator}:Int) {q.denominator} (by decide))'
def rats(qs):return '['+','.join(map(rat,qs))+']'
def expected(fn,*args):
 try:return ('ok',env[fn](*args))
 except ValueError as e:return ('error',str(e))
def canon(x):
 if isinstance(x,Fraction):return f'{x.numerator}/{x.denominator}'
 if isinstance(x,dict):return {k:canon(v)for k,v in x.items()}
 if isinstance(x,(list,tuple)):return [canon(v)for v in x]
 return x
checks=[]
for t in [Fraction(-1),Fraction(0),Fraction(1,7),Fraction(2,3),Fraction(5,2)]:
 for g in [Fraction(-1),Fraction(0),Fraction(1,2),Fraction(2),Fraction(7,3)]:
  checks.append((f'wrap rr (transportedTemperature {rat(t)} {rat(g)})',expected('transported_temperature',t,g)))
  checks.append((f'wrap bb (temperatureScaleInvariant {rat(t)} {rat(g)})',expected('temperature_scale_invariant',t,g)))
for xs in [[],[1],[2,1,3],[Fraction(1,2),Fraction(2,4)],[0,1],[-1,2]]+[[Fraction((i*7)%13+1,14) for i in range(n)]for n in range(1,15)]:
 checks.append((f'wrap (fun xs => .array (xs.map rr)) (orderedThresholds {rats(xs)})',expected('ordered_thresholds',tuple(map(Fraction,xs)))))
checks.append(('wrap capture freezeoutCaptureLedger',expected('freezeout_capture_ledger')))
for n in range(0,25):
 checks.append((f'wrap visibility (visibilityLedger {n})',expected('visibility_ledger',n)))
 checks.append((f'wrap (fun xs => .array (xs.map mode)) (acousticModeLedger {n})',expected('acoustic_mode_ledger',n)))
for fn,lean in [('visibility_ledger','visibilityLedger'),('acoustic_mode_ledger','acousticModeLedger')]:
 for b in [False,True]:checks.append((f'wrap '+('visibility' if fn.startswith('visibility') else '(fun xs => .array (xs.map mode))')+f' ({lean} {int(b)} true)',expected(fn,b)))
for ds,ss in [([],[]),([1],[]),([0],[1]),([1],[-1]),([Fraction(1,8),Fraction(1,4),Fraction(3,8)],[Fraction(1,2),Fraction(2,3),Fraction(3,4)])]+[([Fraction(i+1,7)for i in range(n)],[Fraction(i+2,9)for i in range(n)])for n in range(1,20)]:
 checks.append((f'wrap rr (finiteSoundHorizon {rats(ds)} {rats(ss)})',expected('finite_sound_horizon',tuple(map(Fraction,ds)),tuple(map(Fraction,ss)))))
helpers='''import SFT.Physics.ThermalHistory
open SFT.Physics SFT.Physics.ThermalHistory SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rr (q : Rat) : Value := .text (toString q.num ++ "/" ++ toString q.den)
def bb (b : Bool) : Value := .boolean b
def nn (n : Nat) : Value := .integer (Int.ofNat n)
def wrap {α : Type} (f : α → Value) : Except String α → Value
 | .error e => .array [.text "error",.text e]
 | .ok x => .array [.text "ok",f x]
def capture (r : CaptureLedger) : Value := .object [
 ("orbit",.array (r.orbit.map nn)),("freezeout_neutron_share",rr r.freezeoutNeutronShare),
 ("freezeout_proton_share",rr r.freezeoutProtonShare),("freezeout_neutron_proton_ratio",rr r.freezeoutRatio),
 ("capture_neutron_share",rr r.captureNeutronShare),("capture_proton_share",rr r.captureProtonShare),
 ("capture_neutron_proton_ratio",rr r.captureRatio),("helium_family_mass_share",rr r.heliumShare),
 ("hydrogen_family_mass_share",rr r.hydrogenShare)]
def visibility (r : Visibility) : Value := .object [
 ("radius",nn r.radius),("weights",.array (r.weights.map nn)),("normalized",.array (r.normalized.map rr)),
 ("midpoint_index",nn r.midpointIndex),("unique_midpoint",bb r.uniqueMidpoint),("complete",bb r.complete)]
def mode (r : AcousticMode) : Value := .object [("mode",nn r.mode),("phase_support",rr r.phaseSupport),("loading",.text r.loading)]
'''
p=w/'thermal1032_cases.lean';p.write_text(helpers+'\n#eval IO.println (render (.array ['+','.join(x[0] for x in checks)+']))\n');e={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=e,capture_output=True,text=True);(w/'thermal1032_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);exp=[canon(x[1])for x in checks];assert actual==exp,[(i,a,b)for i,(a,b)in enumerate(zip(actual,exp))if a!=b]
body=(r/'SFT/Physics/ThermalHistory.lean').read_text();names=re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M);p=w/'thermal1032_audit.lean';p.write_text('import SFT.Physics.ThermalHistory\n'+''.join('#print axioms SFT.Physics.ThermalHistory.'+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=e,capture_output=True,text=True);(w/'thermal1032_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'thermal1032_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(checks),source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_operation_file='sft/physics/thermal_history_recombination_terminal_law_v1.py',lean_source_sha256=hashlib.sha256(body.encode()).hexdigest(),declarations=names,axioms=[]),indent=2));print('PASS',len(checks),'whole source operation outputs;',len(names),'empty-axiom declarations')
