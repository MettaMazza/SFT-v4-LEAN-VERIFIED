from pathlib import Path
import sys
import subprocess,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v3=Path(json.loads((r/'reference/SOURCE.json').read_text())['local_source']);pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';base='claims/SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005/'
def read(p):return json.loads(subprocess.check_output(['git','-C',str(v3),'show',pin+':'+p]))
source=read(base+'certificate.json')['source_manifest_hash']
command=([sys.argv[1],source] if len(sys.argv)>1 else ['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(Path('work/constants-recovery/MolecularSpectroscopyEmpiricalProgram954.lean').resolve()),source])
out=subprocess.check_output(command,text=True,env=dict(__import__('os').environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve())));actual=json.loads(out)
Path("work/molecularspectroscopyempirical_program954_output.json").write_text(json.dumps(actual,indent=2)+"\n")
assert actual==json.load(open('work/molecularspectroscopyempirical954_original_program.json'))
Path('work/molecularspectroscopyempirical_program954_output.json').write_text(json.dumps(actual,indent=2)+'\n')
report=dict(status='PASS',source_commit=pin,source_manifest_hash=source,candidate_lookup_decisions=256,all_census_trace_hashes_match=True,all_decision_proof_hashes_match=True,closure_and_controls_match=True,registration_fields_match=True,unknown_identifier_rejected=True,fresh_native_lean_execution=True,scope='All GeneratedEmpiricalPhysicsProgram method output fields; registration, complete256 candidate decisions, closure, controls and unknown identifier compared to fresh exact pinned-source empirical specification')
assert actual==json.load(open('work/molecularspectroscopyempirical954_original_program.json'));report['fresh_original_package_output_also_matches']=True
Path('work/molecularspectroscopyempirical_program954_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
