from pathlib import Path
import sys,json,subprocess,os,hashlib,copy
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500'
for suffix in ['','_validation','_execution']:(root/('sft/physics/common_scale_measured_value_successor'+suffix+'_v1.py')).write_bytes((w/('commonmeasured1056'+suffix+'.py')).read_bytes())
sys.path.insert(0,str(root.resolve()));from sft.physics.common_scale_measured_value_successor_validation_v1 import exact_common_scale_analysis
original=json.load(open(w/'commonmeasured1056_record.json'))['registered_target'];cases=[original]
for group in ['scheme_rows','low_transfer_rows']:
 for i in range(4):
  for key,value in [('center','0'),('center','-1'),('center','1/3'),('standard_uncertainty','0'),('center','0.22000')]:
   t=copy.deepcopy(original);t[group][i][key]=value;cases.append(t)
 for mode in ['duplicate','omit','append']:
  t=copy.deepcopy(original)
  if mode=='duplicate':t[group].append({**t[group][0],'center':'0.24000'})
  if mode=='omit':t[group]=t[group][1:]
  if mode=='append':t[group].append({**t[group][0],('scheme' if group=='scheme_rows' else 'row_id'):'extra'})
  cases.append(t)
for k in list(original)[3:]:
 t=copy.deepcopy(original);t[k]=False;cases.append(t)
t=copy.deepcopy(original);t['low_transfer_rows'][3]['center']='0.2300';t['low_transfer_rows'][3]['standard_uncertainty']='0.0001';cases.append(t)
t=copy.deepcopy(original);t['displayed_measurement_classes']=[];cases.append(t)
def cv(v):
 if isinstance(v,Fraction):return [v.numerator,v.denominator]
 if isinstance(v,tuple):return [cv(x)for x in v]
 if isinstance(v,dict):return {k:cv(x)for k,x in v.items()}
 return v
def rat(v):
 f=Fraction(v);return f'(normalize ({f.numerator}) {f.denominator} (by decide))'
def rows(t,group,key):return '['+','.join('⟨'+json.dumps(row[key])+','+rat(row['center'])+','+rat(row['standard_uncertainty'])+'⟩'for row in t[group])+']'
s='''import SFT.Physics.CommonMeasuredAnalysis
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.CommonMeasuredAnalysis SFT.Physics.LeptonIntervals SFT.Host.Canonical
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ratio (v : Rat) : Value := .array [.integer v.num,.integer (.ofNat v.den)]
def pair (v : Rat × Rat) : Value := .array [ratio v.1,ratio v.2]
def intervals (v : Intervals) : Value := .object (v.map (fun (k,b)=>(k,pair b)))
def enc : Except String Analysis → Value
 | .error e => .object [("error",.text e)]
 | .ok a => .object [("ok",.object [
 ("scheme_intervals",intervals a.schemeIntervals),
 ("low_transfer_intervals",intervals a.lowTransferIntervals),
 ("terminal_inside_on_shell_interval",.boolean a.terminalInsideOnShell),
 ("support_eight_inside_APV_interval",.boolean a.supportEightInsideAPV),
 ("E158_interval_above_MS_Z",.boolean a.e158AboveMSZ),
 ("APV_interval_above_MS_Z",.boolean a.apvAboveMSZ),
 ("eDIS_interval_overlaps_MS_Z",.boolean a.edisOverlapsMSZ),
 ("complete_scheme_rows",.boolean a.completeSchemes),
 ("complete_low_transfer_rows",.boolean a.completeLowTransfer),
 ("complete_displayed_classes",.boolean a.completeDisplayedClasses),
 ("threshold_boundary_retained",.boolean a.thresholdBoundary),
 ("strong_EM_receipt_retained",.boolean a.strongEMReceipt),
 ("NuTeV_extraction_retained",.boolean a.nuTeVRetained),
 ("NuTeV_not_rewarded_as_mismatch",.boolean a.nuTeVNotMismatch),
 ("all_source_rows_retained",.boolean a.allRowsRetained)])]
''';expected=[]
for t in cases:
 try:expected.append({'ok':cv(exact_common_scale_analysis(t))})
 except (ValueError,KeyError)as e:expected.append({'error':str(e)})
 v=[rows(t,'scheme_rows','scheme'),rows(t,'low_transfer_rows','row_id'),json.dumps(t['displayed_measurement_classes'])]+[str(t[k]).lower()for k in list(original)[3:]]
 s+='#eval IO.println (render (enc (exactAnalysis ⟨'+','.join(v)+'⟩)))\n'
p=w/'commonmeasured1056_analysis_cases.lean';p.write_text(s);x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'commonmeasured1056_analysis_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=[json.loads(t)for t in x.stdout.splitlines()];assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:1]
(w/'commonmeasured1056_analysis_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),source_operation='exact_common_scale_analysis after Fraction conversion',all_fifteen_fields=True,source_sha256=hashlib.sha256((w/'commonmeasured1056_validation.py').read_bytes()).hexdigest(),lean_sha256=hashlib.sha256((r/'SFT/Physics/CommonMeasuredAnalysis.lean').read_bytes()).hexdigest()),indent=2));print('PASS',len(cases),'complete analysis records/errors')
