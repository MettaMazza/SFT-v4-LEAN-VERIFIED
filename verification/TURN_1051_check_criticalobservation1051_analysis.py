from pathlib import Path
import ast,json,subprocess,os,hashlib,re,copy
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'criticalobservation1051_validation.py').read_text();tree=ast.parse(src);funcs=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in ['_positive_whole','_contains','exact_criticality_turbulence_analysis']];ns={};exec(compile(ast.Module(body=funcs,type_ignores=[]),'original-criticality-analysis','exec'),ns)
base=json.load(open('/Volumes/One Touch/ernos-labs-sft-platform/experiments/external_sources/physics/snapshots/criticality-universality-turbulence-postseal-source-record.json'))['registered_target'];cases=[base]
for k,v in base.items():
 if type(v)==int:
  for n in [-1,0,1,2,620,720]:cases.append({**base,k:n})
 if type(v)==bool:
  for n in [True,False,1,0,'true',None]:cases.append({**base,k:n})
for i,row in enumerate(base['manganite_rows']):
 for k,v in row.items():
  if type(v)==int:
   for n in [0,-1,v+100]:
    t=copy.deepcopy(base);t['manganite_rows'][i][k]=n;cases.append(t)
for rows in [[],base['manganite_rows'][:-1],list(reversed(base['manganite_rows'])),base['manganite_rows']+[base['manganite_rows'][0]],base['manganite_rows']+[dict(base['manganite_rows'][0],gamma_center=5000)]]:cases.append({**base,'manganite_rows':rows})
cases += [{**base,'manganite_expected_complete_vector_matches':['La00','La02','La04','La06','La08']},{**base,'turbulence_spectrum_orientation':'rising'},{**base,'manganite_expected_nonmatching_control':'absent'}]
def lean(v):
 if v is None:return '.null'
 if type(v)==bool:return '.boolean '+str(v).lower()
 if type(v)==int:return '.integer ('+str(v)+')'
 if type(v)==str:return '.text '+json.dumps(v)
 if isinstance(v,(list,tuple)):return '.array ['+','.join(lean(x)for x in v)+']'
 if type(v)==dict:return '.object ['+','.join('('+json.dumps(k)+','+lean(x)+')'for k,x in v.items())+']'
expected=[json.loads(json.dumps(ns['exact_criticality_turbulence_analysis'](t)))for t in cases];module=r/'SFT/Physics/CriticalObservationMeasurement.lean';body=module.read_text()
if 'def originalTarget' not in body:
 body=body.replace('end SFT.Physics.CriticalObservationMeasurement','def originalTarget : Value := '+lean(base)+'\ntheorem originalCompleteAnalysis : exactCriticalityAnalysis originalTarget=.ok ('+lean(expected[0])+') := rfl\nend SFT.Physics.CriticalObservationMeasurement');module.write_text(body)
 x=subprocess.run(['/Users/dolltrading/.elan/bin/lake','build','SFT.Physics.CriticalObservationMeasurement'],cwd=r,text=True,capture_output=True);(w/'criticalobservation1051_target_build.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:]
lines=['import SFT.Physics.CriticalObservationMeasurement','open SFT.Physics.CriticalObservationMeasurement SFT.Host.Canonical','set_option maxRecDepth 100000','set_option maxHeartbeats 100000000']
for t in cases:lines.append('#eval (exactCriticalityAnalysis ('+lean(t)+')).map render')
p=w/'criticalobservation1051_analysis_cases.lean';p.write_text('\n'.join(lines)+'\n');ev={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=ev,capture_output=True,text=True);(w/'criticalobservation1051_analysis_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=[json.loads(json.loads(line[len('Except.ok '):]))for line in x.stdout.splitlines()if line.startswith('Except.ok ')];assert actual==expected,(len(actual),len(expected),[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:1])
body=module.read_text();names=['SFT.Physics.CriticalObservationMeasurement.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M)];p=w/'criticalobservation1051_analysis_audit.lean';p.write_text('import SFT.Physics.CriticalObservationMeasurement\n'+''.join('#print axioms '+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=ev,capture_output=True,text=True);(w/'criticalobservation1051_analysis_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and all("'"+n+"' does not depend on any axioms"in x.stdout for n in names),x.stdout
(w/'criticalobservation1051_analysis_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),fields=24,declarations=names,axioms=[],source_sha256={'CriticalObservationMeasurement':hashlib.sha256(body.encode()).hexdigest()},original_analysis_sha256=hashlib.sha256(src.encode()).hexdigest(),scope='Complete original analysis and target equality, numerical/Boolean mutations, all five row components, duplicate replacement/order, removed/reversed rows and all original adverse controls'),indent=2));print('PASS',len(cases),'complete24fieldoutputs;',len(names),'zeroaxiomdeclarations')
