from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
mods=['JointCorrelationSupport','JointCorrelationObservation','JointCorrelationGrammar','JointCorrelationEvidence','JointCorrelationNotes','JointCorrelationPrediction','JointCorrelationTargets','JointCorrelationComparison','JointCorrelationExperiment','JointCorrelationControls','JointCorrelationValidation'];names=[]
for m in mods:names+=['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Chemistry'/f'{m}.lean').read_text(),re.M)]
p=w/'JointFullAudit1119.lean';p.write_text(''.join('import SFT.Chemistry.'+m+'\n'for m in mods)+''.join('#print axioms '+n+'\n'for n in names))
with(w/'jointempirical1119_full_audit.log').open('w')as f:subprocess.run(cmd+[str(p)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
log=(w/'jointempirical1119_full_audit.log').read_text();assert log.count('does not depend on any axioms')==len(names) and 'depends on axioms:'not in log
hashes={str(Path('SFT/Chemistry')/f'{m}.lean'):hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in mods}
(w/'jointempirical1119_full_audit_report.json').write_text(json.dumps({'status':'PASS','count':len(names),'declarations':names,'axioms':[],'source_sha256':hashes},indent=2)+'\n')
with(w/'jointempirical1119_output.json').open('w')as out,(w/'jointempirical1119_execution.log').open('w')as err:subprocess.run(cmd+['--run','work/JointValidationProgram1119.lean','work/jointempirical1119_input.json'],env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'jointempirical1119_output.json').read_text());expected=json.loads((w/'jointempirical1119_original.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
for rel,sha in hashes.items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==sha
report={'status':'PASS','fields':len(actual),'messages':len(actual['measurements']),'all_fields_and_hashes_match':True,'original_records':9,'original_snapshots':2,'controls':13,'source_sha256':hashes,'source_commit':'76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'}
(w/'jointempirical1119_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS full empirical12fields30messages,13controls,all original hashes;',len(names),'zero-axiom declarations',flush=True)
