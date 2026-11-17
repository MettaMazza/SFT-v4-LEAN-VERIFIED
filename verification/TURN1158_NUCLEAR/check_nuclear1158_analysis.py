import pathlib,json,subprocess,os,sys,hashlib
w=pathlib.Path('work');r=w/'turn1064_recovery';targets=w/'pinned1158/experiments/external_sources/chemistry/nuclear_electronic_withheld_targets_v1.json';rows=json.loads(targets.read_text())['rows'];q=lambda x:json.dumps(x,ensure_ascii=False)
ls=[]
for x in rows:ls.append('⟨'+','.join([q(x['target_id']),q(x['species']),q(x['state_cells']),q(x['nuclear_isotope_labels']),q(x['molecular_weight_inscription']),'.null'])+'⟩')
s='''import SFT.Chemistry.NuclearElectronicAnalysis
open SFT.Host SFT.Chemistry.NuclearElectronicAnalysis
set_option maxRecDepth 10000
set_option maxHeartbeats 10000000
def inputRows : List Row := ['''+','.join(ls)+''']
def result : Except String Canonical.Value := do
 let pairs ← pairRows inputRows
 let counts ← cellCounts inputRows
 let ground ← groundAbsence inputRows
 let signed ← signedSourceHeld inputRows
 return .object [("matched_positive_coordinate_pairs",.array pairs),("cell_counts",.object (counts.map fun (k,v) => (k,.integer (Int.ofNat v)))),("three_ground_absences",.boolean ground),("signed_source_not_proof_number",.boolean signed)]
def main : IO Unit := match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (Canonical.render value)
'''
p=w/'NuclearElectronicAnalysisParity1158.lean';p.write_text(s);env=dict(os.environ,LEAN_PATH=str(pathlib.Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean')+':'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');a=subprocess.run([sys.executable,'work/run_lean_guarded.py',str(pathlib.Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'),'-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'nuclearelectronic1158_analysis_parity.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-2000:];actual=json.loads(a.stdout);original=json.loads((w/'nuclearelectronic1158_original_payload.json').read_text());expected={k:original[k]for k in ['matched_positive_coordinate_pairs','cell_counts']};expected.update({k:original['adverse'][k]for k in ['three_ground_absences','signed_source_not_proof_number']});assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();(w/'nuclearelectronic1158_analysis_parity_report.json').write_text(json.dumps(dict(status='PASS',rows=95,cells=1235,pairs=330,source_sha256=H(w/'pinned1158/sft/chemistry/nuclear_electronic_validation_v1.py'),native_sha256=H(r/'SFT/Chemistry/NuclearElectronicAnalysis.lean'),targets_sha256=H(targets)),indent=2)+'\n');print('PASS original330pair records,fivecounts,ground absence and signed inscription controls')
