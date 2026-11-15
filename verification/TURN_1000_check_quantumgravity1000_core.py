from pathlib import Path
import sys,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import finite_quantum_gravity_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
expected=[];expr=[]
def count(n):return '.boolean '+str(n).lower() if isinstance(n,bool) else '.integer ('+str(n)+')'
def run(f,args,e):
 try:v={'ok':canonical_value(f(*args))}
 except ValueError as ex:v={'error':str(ex)}
 expected.append(v);expr.append(e)
for a in [False,True,-2,0,1,2,4,10]:
 for b in [False,True,-1,0,1,2,4,10]:run(src.positive_take_whole,[a,b],f'out Value.integer (positiveTakeWhole ({count(a)}) ({count(b)}))')
for n in [False,True,-3,0,*range(1,17),24,32]:
 run(src.finite_loop_sum,[n],f'out rational (finiteLoopSum ({count(n)}))')
 run(src.finite_quantum_gravity_model,[n],f'out modelValue (finiteQuantumGravityModel ({count(n)}))')
 run(src.successor_preserves_model,[n],f'out Value.boolean (successorPreservesModel ({count(n)}))')
s='''import SFT.Physics.FiniteQuantumGravity
import SFT.Host.Canonical
open SFT.Physics.FiniteQuantumGravity SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def natValue (n : Nat) : Value := .integer (.ofNat n)
def out (f : α → Value) : Except String α → Value
 | .ok x => .object [("ok",f x)]
 | .error e => .object [("error",.text e)]
def modelValue (m : Model) : Value := .object [
 ("carrier",.text m.carrier),("depth",natValue m.depth),("spatial_directions",natValue m.spatialDirections),
 ("coordinate_count",natValue m.coordinateCount),("symmetric_rank",natValue m.symmetricRank),
 ("symmetric_slots",natValue m.symmetricSlots),("conservation_constraints",natValue m.conservationConstraints),
 ("coordinate_shift_redundancies",natValue m.coordinateShiftRedundancies),("physical_polarizations",.integer m.physicalPolarizations),
 ("mass_record",.array (m.massRecord.map Value.text)),("causal_advance",rational m.causalAdvance),
 ("quantum_support",natValue m.quantumSupport),("distance_floor",rational m.distanceFloor),("loop_sum",rational m.loopSum),
 ("horizon_area_cells",natValue m.horizonAreaCells),("horizon_records",rational m.horizonRecords),
 ("horizon_quarter_law",.boolean m.horizonQuarterLaw),("extra_spatial_direction_record",.array (m.extraSpatialDirectionRecord.map Value.text)),
 ("completed_infinity_used",.boolean m.completedInfinityUsed)]
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n';p=w/'constants-recovery/QuantumGravity1000.lean';p.write_text(s);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'quantumgravity1000_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
code=(r/'SFT/Physics/FiniteQuantumGravity.lean').read_text();names=['SFT.Physics.FiniteQuantumGravity.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',code,re.M)];p=w/'quantumgravity1000_core_audit.lean';p.write_text('import SFT.Physics.FiniteQuantumGravity\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'quantumgravity1000_core_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'quantumgravity1000_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'freshsourceoutputs;',len(names),'emptyaxiomdeclarations')
