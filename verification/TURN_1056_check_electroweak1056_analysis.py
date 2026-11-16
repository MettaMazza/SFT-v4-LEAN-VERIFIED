from pathlib import Path
import sys,json,subprocess,os,hashlib
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.electroweak_measured_value_successor_validation_v1 import exact_electroweak_analysis,interval
original=json.load(open(w/'weakobservation1056_record.json'))['registered_target'];cases=[original]
keys=list(original)[:8]
for k in keys:
 for v in ['0','-1','1/3','100','0.000001']:
  t=original.copy();t[k]=v;cases.append(t)
for k in list(original)[8:]:
 t=original.copy();t[k]=False;cases.append(t)
for k,v in [('on_shell_sin_squared_center','0.22000'),('compatible_w_mass_GeV','81')]:
 t=original.copy();t[k]=v;cases.append(t)
def cv(v):
 if isinstance(v,Fraction):return [v.numerator,v.denominator]
 if isinstance(v,tuple):return [cv(x)for x in v]
 if isinstance(v,dict):return {k:cv(x)for k,x in v.items()}
 return v
def rat(v):
 f=Fraction(v);return f'(normalize ({f.numerator}) {f.denominator} (by decide))'
s='''import SFT.Physics.ElectroweakMeasuredAnalysis
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.ElectroweakMeasuredAnalysis SFT.Physics.LeptonIntervals SFT.Host.Canonical
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ratio (v : Rat) : Value := .array [.integer v.num,.integer (.ofNat v.den)]
def pair (v : Rat × Rat) : Value := .array [ratio v.1,ratio v.2]
def enc : Except String Analysis → Value
 | .error e => .object [("error",.text e)]
 | .ok a => .object [("ok",.object [
 ("direct_on_shell_interval",pair a.directOnShellInterval),
 ("compatible_WZ_squared_interval",pair a.compatibleWZSquaredInterval),
 ("all_input_WZ_squared_method_record",pair a.allInputWZSquaredMethodRecord),
 ("forced_sine_inside_direct_interval",.boolean a.forcedSineInsideDirectInterval),
 ("forced_cosine_inside_compatible_WZ_interval",.boolean a.forcedCosineInsideCompatibleWZInterval),
 ("exact_partition",.boolean a.exactPartition),
 ("incompatible_input_disclosure_retained",.boolean a.incompatibleInputDisclosureRetained),
 ("poor_consistency_disclosure_retained",.boolean a.poorConsistencyDisclosureRetained),
 ("inconsistent_aggregate_not_used_as_target",.boolean a.inconsistentAggregateNotUsedAsTarget),
 ("all_source_rows_retained",.boolean a.allSourceRowsRetained)])]
''';expected=[]
for t in cases:
 try:expected.append({'ok':cv(exact_electroweak_analysis(t))})
 except ValueError as e:expected.append({'error':str(e)})
 values=[rat(t[k]) for k in keys]+[str(t[k]).lower() for k in list(original)[8:]]
 s+='#eval IO.println (render (enc (exactAnalysis ⟨'+','.join(values)+'⟩)))\n'
p=w/'electroweak1056_analysis_cases.lean';p.write_text(s);x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'electroweak1056_analysis_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=[json.loads(t)for t in x.stdout.splitlines()];assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:1]
(w/'electroweak1056_analysis_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),source_operation='exact_electroweak_analysis after Fraction conversion',all_ten_fields=True,source_sha256=hashlib.sha256((w/'weakobservation1056_validation.py').read_bytes()).hexdigest(),lean_sha256=hashlib.sha256((r/'SFT/Physics/ElectroweakMeasuredAnalysis.lean').read_bytes()).hexdigest()),indent=2));print('PASS',len(cases),'complete analysis records/errors')
