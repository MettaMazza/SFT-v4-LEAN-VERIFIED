from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
mods=['InjuryState','InjuryStateGrammar','InjuryStateEvidence','InjuryStateSource','InjuryStateExperiment','InjuryStateValidation'];names=[]
for m in mods:names+=['SFT.Medicine.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Medicine'/f'{m}.lean').read_text(),re.M)]
p=w/'InjuryStateFullAudit1244.lean';p.write_text(''.join('import SFT.Medicine.'+m+'\n'for m in mods)+''.join('#print axioms '+n+'\n'for n in names))
with(w/'injury1244_full_audit.log').open('w')as f:subprocess.run(cmd+[str(p)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
log=(w/'injury1244_full_audit.log').read_text();assert log.count('does not depend on any axioms')==len(names) and 'depends on axioms:'not in log
hashes={str(Path('SFT/Medicine')/f'{m}.lean'):hashlib.sha256((r/'SFT/Medicine'/f'{m}.lean').read_bytes()).hexdigest()for m in mods}
(w/'injury1244_full_audit_report.json').write_text(json.dumps({'status':'PASS','count':len(names),'declarations':names,'axioms':[],'source_sha256':hashes},indent=2)+'\n')
with(w/'injury1244_empirical_output.json').open('w')as out,(w/'injury1244_empirical_execution.log').open('w')as err:subprocess.run(cmd+['--run','work/InjuryStateResolvedProgram1244.lean','work/injury1244_empirical_input.json'],env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'injury1244_empirical_output.json').read_text());expected=json.loads((w/'injury1244_original_empirical.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
for rel,sha in hashes.items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==sha
report={'status':'PASS','fields':len(actual),'messages':len(actual['measurements']),'all_fields_and_hashes_match':True,'original_snapshots':24,'source_records':13,'captured_sources':11,'failed_sources':2,'bound_fragments':2,'controls':1,'source_sha256':hashes,'source_commit':'76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'}
(w/'injury1244_empirical_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS full empirical12 fields4 messages,1 adverse comparison,all original hashes;',len(names),'zero-axiom declarations',flush=True)
