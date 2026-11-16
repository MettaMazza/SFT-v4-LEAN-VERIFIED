from pathlib import Path
import ast,json,subprocess,os,hashlib,re,copy
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'thermal_history_validation_v11034.py').read_text();fn=next(n for n in ast.parse(src).body if isinstance(n,ast.FunctionDef)and n.name=='exact_thermal_analysis');env={'Fraction':Fraction};exec(compile(ast.Module(body=[fn],type_ignores=[]),'pinned-original-analysis','exec'),env);f=env['exact_thermal_analysis'];base=json.load(open(w/'thermal1034_target.json'))['registered_target'];tests=[base];keys=list(base)[:8];lists=['planck_tt_peak_multipoles','planck_tt_peak_multipole_uncertainties','planck_tt_peak_amplitudes','planck_tt_peak_amplitude_uncertainties']
for i in range(48):
 t=copy.deepcopy(base);t[keys[i%8]]=str(Fraction(i-20,100));tests.append(t)
for k in lists:
 for length in [0,1,6,8]:
  t=copy.deepcopy(base);t[k]=(t[k]+['1'])[:length];tests.append(t)
for k in ['pdg_freezeout_neutron_proton_label','pdg_capture_entry_neutron_proton_label','pdg_analytic_helium_partition_label']:
 t=copy.deepcopy(base);t[k]='altered';tests.append(t)
for count in [0,17,19]:
 t=copy.deepcopy(base);t['planck_detected_peak_count']=count;tests.append(t)
t=copy.deepcopy(base);t['all_registered_rows_retained']=False;tests.append(t)
def rat(v):
 q=Fraction(v);return f'(LeptonIntervals.normalize ({q.numerator} : Int) {q.denominator} (by decide))'
rows=['⟨'+','.join([rat(t[k])for k in keys]+['['+','.join(rat(v)for v in t[k])+']'for k in lists]+[str(t['planck_detected_peak_count'])]+[json.dumps(t[k]) for k in ['pdg_freezeout_neutron_proton_label','pdg_capture_entry_neutron_proton_label','pdg_analytic_helium_partition_label']]+[str(t['all_registered_rows_retained']).lower()])+'⟩'for t in tests]
qs=['temperatureInterval.1','temperatureInterval.2','heliumInterval.1','heliumInterval.2','analyticQuarter','heliumGap','deuteriumInterval.1','deuteriumInterval.2','recombinationInterval.1','recombinationInterval.2'];bs=['oneInside','quarterExcluded','deuteriumMinor','finiteRecombination','completeSeven','finiteEighteen','angularIntegerRejected','freezeoutRetained','quarterLabelRetained','allRowsRetained']
s='import SFT.Physics.ThermalObservationAnalysis\nopen SFT.Physics SFT.Physics.ThermalObservationAnalysis\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\ndef cases : List Target := ['+','.join(rows)+']\ndef rr (q : Rat) : String := toString q.num ++ "/" ++ toString q.den\n#eval cases.map fun t => match exactAnalysis t with | .error _ => ("error",([] : List String),([] : List Bool),([] : List (String × String)),0) | .ok a => ("ok",['+','.join('rr a.'+x for x in qs)+'],['+','.join('a.'+x for x in bs)+'],a.peakIntervals.map (fun (a,b) => (rr a,rr b)),a.detectedCount)\n';p=w/'thermalobservation1034_cases.lean';p.write_text(s);cmd=['/Users/dolltrading/.elan/bin/lean',str(p)];e={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(cmd,env=e,capture_output=True,text=True);(w/'thermalobservation1034_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1200:];actual=ast.literal_eval(x.stdout.replace('true','True').replace('false','False'));expected=[]
rr=lambda q:f'{q.numerator}/{q.denominator}'
for t in tests:
 try:a=f(t)
 except IndexError:expected.append(('error',[],[],[],0));continue
 q=list(a['temperature_exponent_interval'])+list(a['helium_interval'])+[a['analytic_quarter'],a['helium_gap_from_analytic_quarter']]+list(a['deuterium_interval'])+list(a['recombination_interval'])
 b=[a[k]for k in ['exact_one_inside_temperature_interval','exact_quarter_excluded','deuterium_positive_minor_channel','finite_positive_recombination_support','complete_seven_tt_peaks','finite_eighteen_peak_record','angular_integer_multiple_claim_rejected','freezeout_sequence_retained','analytic_quarter_label_retained','all_rows_retained']];expected.append(('ok',list(map(rr,q)),b,[(rr(a),rr(b))for a,b in a['peak_intervals']],a['detected_peak_count']))
assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b]
body=(r/'SFT/Physics/ThermalObservationAnalysis.lean').read_text();names=re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M);p=w/'thermalobservation1034_audit.lean';p.write_text('import SFT.Physics.ThermalObservationAnalysis\n'+''.join('#print axioms SFT.Physics.ThermalObservationAnalysis.'+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=e,capture_output=True,text=True);(w/'thermalobservation1034_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'thermalobservation1034_analysis_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all_eighteen_fields=True,axioms=[],declarations=names,source_sha256=hashlib.sha256(body.encode()).hexdigest()),indent=2));print('PASS',len(tests),'complete original analyses;',len(names),'emptyaxiom declarations')
