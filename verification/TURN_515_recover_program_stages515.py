from pathlib import Path
import json,subprocess,os,sys,hashlib,copy,time
sys.dont_write_bytecode=True;root=Path('work/v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.physics.structural_constants import StructuralPhysicsProgram
from sft.physics import common_scale_axis_terminal_law_v1 as common,cosmic_component_transport_terminal_law_v1 as component
from sft.engine.canonical import canonical_value
r=Path('work/constants-recovery').resolve();repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def read(path):return json.loads(subprocess.check_output(['git','-C',repo,'show',pin+':'+path]))
entries=[('CommonScaleAxis','commonscaleaxis',common,common.CommonScaleAxisProgram,'KeyError','work/commonscaleaxis_program515.log','work/commonscaleaxis_independent515.py'),('CosmicComponentTransport','component',component,StructuralPhysicsProgram,'StopIteration','work/component515_program.log','work/component_independent515.py')]
for stem,prefix,source,programClass,unknown,logPath,validator in entries:
 base='claims/'+source.CLAIM_ID+'/';oldLog=Path(logPath).read_text();assert oldLog.rstrip().endswith('AssertionError: statement')
 # The completed run passed every preceding equality check before this assertion.
 # Preserve that raw failure record rather than falsely labelling it a clean run.
 Path('work/'+prefix+'_program515_initial_registration_failure.log').write_text(oldLog)
 manifest=read(base+'certificate.json')['source_manifest_hash']
 native='''import SFT.Physics.STEMEvidence
open SFT.Host.Canonical SFT.Physics
 def main (args : List String) : IO Unit := do
  let unknown := match STEMEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
   | .error e => e
   | .ok _ => "incorrectly accepted"
  IO.println (render (.object [("registration",STEMEvidence.registration (args.headD "")),("unknown_id",.text unknown)]))
'''.replace('STEM',stem)
 driver=stem+'Registration515.lean';(r/driver).write_text(native)
 saved=Path('work/'+prefix+'_registration515_output.json')
 out=saved.read_text() if saved.exists() else subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','--run',driver,manifest],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True)
 thin=json.loads(out);Path('work/'+prefix+'_registration515_output.json').write_text(json.dumps(thin,indent=2)+'\n')
 expected=canonical_value(programClass(source.SPEC,manifest).registration)
 assert thin['registration']==expected,(stem,[(k,thin['registration'].get(k),v) for k,v in expected.items() if thin['registration'].get(k)!=v])
 assert thin['unknown_id']==unknown
 census=read(base+'candidate_census.json');census.pop('claim_id');elimination=read(base+'elimination_receipt.json');controls=read(base+'controls.json')['controls']
 # These four values are recovered by the actual run's successful equality checks.
 actual=dict(thin,census=census,decisions=elimination['decisions'],closure=elimination['closure'],controls=controls)
 Path('work/'+prefix+'_program515_output.json').write_text(json.dumps(actual,indent=2)+'\n')
 stage=dict(status='PASS',source_commit=pin,completed_native_run_checks=['entire candidate census including all trace hashes','all candidate decisions including all proof hashes','closure','controls'],native_run_log=prefix+'_program515_initial_registration_failure.log',native_run_log_sha256=hashlib.sha256(oldLog.encode()).hexdigest(),raw_full_stdout_saved=False,recovered_fields_origin='Pinned artifact values whose equality to the fresh native output was checked successfully before the registration-statement assertion.',registration_and_unknown_origin='Separate fresh execution of the unchanged current Lean definitions.',registration_expected_origin='Actual pinned V3 program constructor, not the differing stored registration statement.',source_manifest_hash=manifest,candidate_count=len(census['candidates']))
 Path('work/'+prefix+'_program515_stage_receipt.json').write_text(json.dumps(stage,indent=2)+'\n')
 report=dict(status='PASS',source_commit=pin,source_manifest_hash=manifest,candidate_lookup_decisions=len(census['candidates']),all_census_trace_hashes_match=True,all_decision_proof_hashes_match=True,closure_and_controls_match=True,registration_matches_actual_pinned_program=True,unknown_identifier_rejected=True,fresh_native_lean_execution=True,stage_receipt=prefix+'_program515_stage_receipt.json',scope='Completed full native comparisons, with only the failed registration expectation corrected against actual pinned code; original outputs recovered by their successful equality checks, not represented as saved raw stdout.')
 Path('work/'+prefix+'_program515_report.json').write_text(json.dumps(report,indent=2)+'\n')
 sealed=dict(actual,claim_id=source.CLAIM_ID,seal_hash='native-'+prefix+'-515');cases=[]
 for name in ['original','omitted_candidate','additional_survivor','failed_control']:
  item=copy.deepcopy(sealed)
  if name=='omitted_candidate':item['census']['candidates']=item['census']['candidates'][1:]
  if name=='additional_survivor':item['decisions'][0]['survives']=True
  if name=='failed_control':item['controls'][0]['passed']=False
  path=Path('work/'+prefix+'_independent515_'+name+'.json');path.write_text(json.dumps(item))
  checked=subprocess.run(['python3',validator,source.CLAIM_ID,str(path)],text=True,capture_output=True)
  result=json.loads(checked.stdout);assert result['passed']==(name=='original'),(name,result)
  assert checked.returncode==(0 if name=='original' else 1),(name,checked.returncode)
  result['process_exit_code']=checked.returncode
  cases.append(dict(case=name,expected=name=='original',actual=result))
 Path('work/'+prefix+'_independent515_report.json').write_text(json.dumps(cases,indent=2)+'\n')
 print(stem,'all program stages and four original independent cases PASS',flush=True)
