from pathlib import Path
import ast,json,subprocess,dataclasses
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def raw(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
namespace={'dataclass':dataclasses.dataclass}
for source,names in [('sft/physics/generated_empirical_law.py',{'LawChoice','LawDimension','ExternalTargetRow','EmpiricalPhysicsSpec','dimension','empirical_dimensions'}),('sft/physics/measurement_laws.py',{'SOURCE_PATH','SOURCE_HASH','SOURCE_ID','BASE_DEPENDENCIES','targets','spec','OBSERVATION_CARRIER'})]:
 tree=ast.parse(raw(source));nodes=[n for n in tree.body if getattr(n,'name',None) in names or (isinstance(n,ast.Assign) and getattr(n.targets[0],'id',None) in names)]
 exec(compile(ast.Module(body=nodes,type_ignores=[]),source,'exec'),namespace)
spec=namespace['OBSERVATION_CARRIER'];spec.validate();values=dataclasses.asdict(spec);cid=spec.claim_id;q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason] for d in spec.dimensions]
kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}

import os,types
ns=namespace
for name in ['prediction_program_document','experiment_registration_record']:
 tree=ast.parse(raw('sft/physics/generated_empirical_law.py'));node=next(n for n in tree.body if getattr(n,'name',None)==name);exec(compile(ast.Module(body=[node],type_ignores=[]),name,'exec'),ns)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(i) for i in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
validator=next(n for n in tree.body if getattr(n,'name',None)=='BlindExternalMeasurementValidator');method=next(n for n in validator.body if getattr(n,'name',None)=='validate');nodes=[n for n in method.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id',None) in ['comparisons','tampered_control','passed']];code=compile(ast.Module(body=nodes,type_ignores=[]),'pinned comparison body','exec')
cases=[]
base={row.target_id:row.observed_label for row in spec.target_rows}
for prediction in [spec.expected_observation_label,'changed-external-observation','different','λ']:
 for mode in ['original','changed','missing']:
  targets=base.copy()
  if mode=='changed':targets[spec.target_rows[-1].target_id]='changed-external-observation'
  if mode=='missing':targets.pop(spec.target_rows[-1].target_id)
  env={'self':types.SimpleNamespace(spec=spec),'prediction':types.SimpleNamespace(label=prediction),'release':types.SimpleNamespace(targets={k:types.SimpleNamespace(label=v) for k,v in targets.items()})}
  try:
   exec(code,env);expected={'comparisons':list(env['comparisons']),'tampered_control':env['tampered_control'],'passed':env['passed']}
  except KeyError as e:expected={'error':'KeyError: '+e.args[0]}
  cases.append((prediction,targets,expected))
s='''import SFT.Physics.ObservationComparison
open SFT.Physics SFT.Host.Canonical
def resultValue (prediction : String) (released : List (String × Value)) : Value :=
 match ObservationComparison.compareRows prediction released ObservationExperiment.targetRows with
 | .error e => .object [("error",.text e)]
 | .ok rows => .object [("comparisons",.array (rows.map ObservationComparison.comparisonValue)),("tampered_control",ObservationComparison.controlValue prediction),("passed",.boolean (ObservationComparison.accepted prediction rows))]
def main : IO Unit := do
 IO.println (render ObservationExperiment.registration)
'''
for prediction,targets,_ in cases:s+=' IO.println (render (resultValue '+q(prediction)+' ['+','.join('('+q(k)+','+cv(dict(family='external-observation',label=v))+')' for k,v in targets.items())+']))\n'
Path('verification/TURN_373_ObservationOperationsProgram.lean').write_text(s)
env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')+':'+str(Path.cwd()))
out=subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','--run','verification/TURN_373_ObservationOperationsProgram.lean'],env=env,text=True);actual=[json.loads(x) for x in out.splitlines()];expected=[ns['experiment_registration_record'](spec)]+[case[2] for case in cases];expected=json.loads(json.dumps(expected));assert actual==expected
Path('verification/TURN_373_OBSERVATION_OPERATIONS_OUTPUT.json').write_text(json.dumps(actual,indent=2)+'\n');report=dict(status='PASS',source_commit=pin,comparison_cases=len(cases),exact_experiment_registration=True,fresh_native_execution=True,scope='Exact pinned registration functions and original validator comparison/control statements, including unfavorable and missing rows; full blind execution/certificates pending.')
Path('verification/TURN_373_OBSERVATION_OPERATIONS_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
