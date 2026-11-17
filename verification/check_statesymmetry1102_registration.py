from pathlib import Path
import sys,os,json,subprocess,re,hashlib,copy
w=Path('work');r=w/'turn1064_recovery';old=w/'checkpoint1100/SFT/Chemistry/StateSymmetryEvidence.lean';new=r/'SFT/Chemistry/StateSymmetryEvidence.lean'
assert new.read_text()==old.read_text().replace('provenance := [.forwardForcing]','provenance := [.observationalDerivation]')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with (w/'statesymmetry1102_evidence_build.log').open('w') as f:subprocess.run(cmd+['-o',str(new.with_suffix('.olean')),str(new)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
p=w/'StateSymmetryRegistration1102.lean';p.write_text('import SFT.Chemistry.StateSymmetryEvidence\ndef main (args : List String) : IO Unit := IO.println (SFT.Host.Canonical.render (SFT.Chemistry.StateSymmetryEvidence.registration (args.headD "")))\n')
actual=json.loads((w/'statesymmetry1100_program_output.json').read_text());source=actual['registration']['source_hash'];original_sha=hashlib.sha256((w/'statesymmetry1100_program_output.json').read_bytes()).hexdigest()
with (w/'statesymmetry1102_registration_output.json').open('w')as out,(w/'statesymmetry1102_registration_execution.log').open('w')as err:subprocess.run(cmd+['--run',str(p),source],env=env,stdout=out,stderr=err,check=True)
actual['registration']=json.loads((w/'statesymmetry1102_registration_output.json').read_text())
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.engine.canonical import canonical_value
program=GeneratedObservationalChemistryProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c)for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'));assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'statesymmetry1102_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
audit=w/'StateSymmetryAudit1100.lean'
with (w/'statesymmetry1102_entry_audit.log').open('w')as f:subprocess.run(cmd+[str(audit)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
names=re.findall(r'^#print axioms (\S+)',audit.read_text(),re.M);log=(w/'statesymmetry1102_entry_audit.log').read_text();assert len(names)==80 and log.count('does not depend on any axioms')==80 and 'depends on axioms:'not in log
(w/'statesymmetry1102_entry_audit_report.json').write_text(json.dumps({'status':'PASS','declarations':names,'count':len(names),'source_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in ['StateSymmetryGrammar','StateSymmetryEvidence']}},indent=2)+'\n')
validator=(w/'pinned1100/claims'/spec.claim_id/'independent_validator.py').resolve();cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(actual,claim_id=spec.claim_id,seal_hash='native-statesymmetry1102'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 p=w/('statesymmetry1102_independent_'+case+'.json');p.write_text(json.dumps(sealed));out=subprocess.run([sys.executable,str(validator),str(p.resolve())],capture_output=True,text=True,check=True);result=json.loads(out.stdout);assert result['passed']==(case=='original');cases.append({'case':case,'result':result})
(w/'statesymmetry1102_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
(w/'statesymmetry1102_program_report.json').write_text(json.dumps({'status':'PASS','candidates':256,'source_commit':'76f1b34e9e9682989adcbb088797b4ae4ce4fcf1','source_manifest_hash':source,'all_fields_and_hashes':True,'fresh_original':True,'native_evidence':'Affected registration rerun; unchanged complete256 candidate/census/closure/control execution retained from TURN1100','retained_program_output_sha256':original_sha,'only_source_change':'registration provenance forward_forcing -> original observational_derivation','current_evidence_sha256':hashlib.sha256(new.read_bytes()).hexdigest()},indent=2)+'\n')
print('PASS corrected original registration; retained all256 native decisions; complete V3 comparison,80 empty-axiom declarations,independent original+3adverse',flush=True)
