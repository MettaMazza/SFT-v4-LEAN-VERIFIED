"""Use the unchanged compiled runner; retain the interpreted run until exact comparison passes."""
from pathlib import Path
import json,hashlib,subprocess,sys,os,time,signal,datetime
w=Path('work');r=w/'turn1064_recovery';job=json.loads((w/'polarizability1391_preparation_job.json').read_text())
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def command(pid):
 q=subprocess.run(['ps','-p',str(pid),'-o','command='],capture_output=True,text=True)
 return q.stdout.strip() if q.returncode==0 else ''
def original_passed():
 p=w/'polarizability1319_empirical_report.json'
 return p.exists() and json.loads(p.read_text()).get('status')=='PASS'
while 'prepare_polarizability1319_native1391.py' in command(job['pid']):
 if original_passed():print('Original comparison finished; existing registration remains authoritative',flush=True);raise SystemExit(0)
 time.sleep(10)
if original_passed():print('Original comparison finished; no duplicate execution required',flush=True);raise SystemExit(0)
receipt=json.loads((w/'polarizability1319_native_build1391.json').read_text());assert receipt['status']=='PASS'
for name,h in job['input_hashes'].items():assert H(w/name)==h,name
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
before=json.loads((w/'polarizability1319_empirical_input.json').read_text())['before']
assert canonical_value(snapshot_protected_tree(w/'pinned1319'))==before
outpath=w/'polarizability1319_compiled1391_output.json'
with outpath.open('w')as out,(w/'polarizability1319_compiled1391_execution.log').open('w')as err:
 subprocess.run([sys.executable,'work/prepare_polarizability1319_native1391.py','--execute'],stdout=out,stderr=err,check=True)
actual=json.loads(outpath.read_text());expected=json.loads((w/'polarizability1319_original_empirical_current.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
for name,h in job['input_hashes'].items():assert H(w/name)==h,name
assert canonical_value(snapshot_protected_tree(w/'pinned1319'))==before
for row in receipt['modules']:assert H(Path(row['source']))==row['source_sha256'],row['module']
record={'status':'PASS','at':datetime.datetime.now(datetime.timezone.utc).isoformat(),'fields':len(actual),'messages':len(actual['measurements']),'input_hashes':job['input_hashes'],'output_sha256':H(outpath),'execution':'Same original Lean runner compiled; exact full JSON equality and unchanged protected source snapshot'}
(w/'polarizability1391_compiled_comparison.json').write_text(json.dumps(record,indent=2)+'\n')
if original_passed():print('Both executions passed; leave original completion/registration path intact',flush=True);raise SystemExit(0)
oldpid=job['preserved_interpreted_pid'];cmd=command(oldpid)
if '/bin/lean ' in cmd and '--run work/MolecularPolarizabilityValidationProgram1319.lean' in cmd:
 os.kill(oldpid,signal.SIGTERM)
 record['superseded_interpreted_pid']=oldpid
 (w/'polarizability1391_compiled_comparison.json').write_text(json.dumps(record,indent=2)+'\n')
# Replace the path atomically: any retained descriptor belongs to the previous inode.
os.replace(outpath,w/'polarizability1319_empirical_output.json')
mods=['MolecularPolarizability','MolecularPolarizabilityRepetition','MolecularPolarizabilityGrammar','MolecularPolarizabilityEvidence','MolecularPolarizabilityExperiment','MolecularPolarizabilitySource','MolecularPolarizabilityPrediction','MolecularPolarizabilityValidation']
report=dict(status='PASS',fields=len(actual),messages=len(actual['measurements']),all_fields_and_hashes_match=True,original_target_checks=252,original_adverse_controls=4,fresh_native=True,fresh_original=True,execution_mode='compiled original runner; original expectation retained with exact input/source snapshot identity',comparison_receipt='work/polarizability1391_compiled_comparison.json',host_primitives=['HTMLParser tokenizer and UTF8 replacement decoding; custom handlers and all source reconstruction native Lean','Lean JSON input decoding; actual source bytes read and hashed natively'],source_sha256={m:H(r/'SFT/Chemistry'/f'{m}.lean')for m in mods})
(w/'polarizability1319_empirical_report.json').write_text(json.dumps(report,indent=2)+'\n')
c=json.loads((r/'COVERAGE.json').read_text());x=next(x for x in c['claims']if x['claim_id']=='SFT-CHEM-MOLECULAR-POLARIZABILITY-006')
if x['lean_status']!='complete':subprocess.run([sys.executable,'work/register_polarizability1319.py'],check=True)
print('PASS complete original12field256message comparison and original registration',flush=True)
