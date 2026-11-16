from pathlib import Path
import ast,json,subprocess,os,hashlib,re,copy
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'quantumobservation1054_validation.py').read_text();tree=ast.parse(src);funcs=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in ['exact_quantum_support_bell_analysis']];ns={};exec(compile(ast.Module(body=funcs,type_ignores=[]),'original-criticality-analysis','exec'),ns)
base=json.loads((w/'quantumobservation1054_source_record.json').read_text())['registered_target'];cases=[base]
fields=json.loads((w/'quantumobservation1054_analysis_fields.json').read_text())
for k in fields['ints']:
 for n in [-1,0,1,2,19900,11100,True,False,'22','  +108  ']:cases.append({**base,k:n})
for k in fields['flags']:
 for n in [True,False,1,0,'true',None]:cases.append({**base,k:n})
cases += [{**base,'bell_parameter_center':19900},{**base,'trial_duration_nanoseconds_center_hundredths':11100}]
def lean(v):
 if v is None:return '.null'
 if type(v)==bool:return '.boolean '+str(v).lower()
 if type(v)==int:return '.integer ('+str(v)+')'
 if type(v)==str:return '.text '+json.dumps(v)
 if isinstance(v,(list,tuple)):return '.array ['+','.join(lean(x)for x in v)+']'
 if type(v)==dict:return '.object ['+','.join('('+json.dumps(k)+','+lean(x)+')'for k,x in v.items())+']'
expected=[json.loads(json.dumps(ns['exact_quantum_support_bell_analysis'](t)))for t in cases];module=r/'SFT/Physics/QuantumSupportObservationMeasurement.lean';body=module.read_text()
if 'def originalTarget' not in body:
 body=body.replace('end SFT.Physics.QuantumSupportObservationMeasurement','def originalTarget : Value := '+lean(base)+'\ntheorem originalCompleteAnalysis : exactQuantumSupportBellAnalysis originalTarget=.ok ('+lean(expected[0])+') := rfl\nend SFT.Physics.QuantumSupportObservationMeasurement');module.write_text(body)
 x=subprocess.run(['/Users/dolltrading/.elan/bin/lake','build','SFT.Physics.QuantumSupportObservationMeasurement'],cwd=r,text=True,capture_output=True);(w/'quantumobservation1054_target_build.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:]
lines=['import SFT.Physics.QuantumSupportObservationMeasurement','open SFT.Physics.QuantumSupportObservationMeasurement SFT.Host.Canonical','set_option maxRecDepth 100000','set_option maxHeartbeats 100000000']
for t in cases:lines.append('#eval (exactQuantumSupportBellAnalysis ('+lean(t)+')).map render')
p=w/'quantumobservation1054_analysis_cases.lean';p.write_text('\n'.join(lines)+'\n');ev={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=ev,capture_output=True,text=True);(w/'quantumobservation1054_analysis_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=[json.loads(json.loads(line[len('Except.ok '):]))for line in x.stdout.splitlines()if line.startswith('Except.ok ')];assert actual==expected,(len(actual),len(expected),[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:1])
body=module.read_text();names=['SFT.Physics.QuantumSupportObservationMeasurement.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M)];p=w/'quantumobservation1054_analysis_audit.lean';p.write_text('import SFT.Physics.QuantumSupportObservationMeasurement\n'+''.join('#print axioms '+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=ev,capture_output=True,text=True);(w/'quantumobservation1054_analysis_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and all("'"+n+"' does not depend on any axioms"in x.stdout for n in names),x.stdout
(w/'quantumobservation1054_analysis_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),fields=14,declarations=names,axioms=[],source_sha256={'QuantumSupportObservationMeasurement':hashlib.sha256(body.encode()).hexdigest()},original_analysis_sha256=hashlib.sha256(src.encode()).hexdigest(),scope='Complete original fourteen-field analysis and target equality; integer conversion inputs, literal-Boolean identities, exact interval/timing boundaries and both original tampering controls'),indent=2));print('PASS',len(cases),'complete14fieldoutputs;',len(names),'zeroaxiomdeclarations')
