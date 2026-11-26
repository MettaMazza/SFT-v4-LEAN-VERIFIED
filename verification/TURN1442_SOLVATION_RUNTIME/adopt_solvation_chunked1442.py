from pathlib import Path
import json,hashlib,subprocess,os,signal,shutil,datetime
w=Path('work');r=w/'turn1064_recovery';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
a=json.loads((w/'solvation1342_chunked1442_report.json').read_text());assert a['status']=='PASS'
eq=json.loads((w/'chunked_solvation1442_source_correspondence.json').read_text());assert eq['status']=='EQUIVALENCE_AUDIT_PASS'
assert H(r/'SFT/Host/Canonical.lean')==eq['unchanged_original_canonical'];assert H(r/'SFT/Host/SHA256Chunks.lean')==eq['equivalence_source_sha256']
assert H(w/'solvation_chunked1442_source/SFT/Host/Canonical.lean')==eq['isolated_canonical']
s=(w/'chunked_hash1442_audit.log').read_text();assert s.count('does not depend on any axioms')==2 and 'depends on axioms' not in s
for m,h in a['source_sha256'].items():assert H(r/'SFT/Chemistry'/f'{m}.lean')==h
assert json.loads((w/'solvation1342_chunked1442_output.json').read_text())==json.loads((w/'solvation1342_chunked1442_original_empirical_current.json').read_text())
b=json.loads((w/'solvation1342_chunked_build1442.json').read_text());assert b['status']=='PASS';assert H(Path(b['executable']))==b['executable_sha256']
for row in b['modules']:assert H(Path(row['source']))==row['source_sha256']
# Stop only explicitly identified superseded executions, after full comparison PASS.
rows={int(x[0]):x[1]for l in subprocess.check_output(['ps','-axo','pid,command'],text=True).splitlines()[1:]if len(x:=l.strip().split(None,1))==2};stopped=[]
for pid in [86616,89740]:
 cmd=rows.get(pid,'')
 if (pid==86616 and '--run work/SolvationDissolutionValidationProgram1342.lean' in cmd) or (pid==89740 and cmd.endswith('/solvation1342_empirical_native1413/SolvationDissolutionValidationProgram1342')):
  os.kill(pid,signal.SIGTERM);stopped.append(pid)
backup=w/'solvation1342_pre_chunked1442';backup.mkdir(exist_ok=True)
for target,source in [('solvation1342_empirical_output.json','solvation1342_chunked1442_output.json'),('solvation1342_empirical_execution.log','solvation1342_chunked1442_execution.log'),('solvation1342_original_empirical_current.json','solvation1342_chunked1442_original_empirical_current.json')]:
 dest=w/target
 if dest.exists():shutil.copyfile(dest,backup/target)
 temp=dest.with_suffix('.chunked-adopt');shutil.copyfile(w/source,temp);temp.replace(dest)
a.update(execution_backend='compiled-native-existing-proved-chunked-hash',compiled_build_receipt='work/solvation1342_chunked_build1442.json',compiled_executable_sha256=b['executable_sha256'],runtime_equivalence=eq,runtime_equivalence_audit_sha256=H(w/'chunked_hash1442_audit.log'))
p=w/'solvation1342_empirical_report.json';temp=p.with_suffix('.chunked-adopt');temp.write_text(json.dumps(a,indent=2)+'\n');temp.replace(p)
(w/'solvation1342_chunked_adoption1442.json').write_text(json.dumps({'status':'PASS','at':datetime.datetime.now(datetime.timezone.utc).isoformat(),'stopped_superseded_pids':stopped,'equivalence':eq,'report_sha256':H(p)},indent=2)+'\n');print('ADOPTED complete empirical comparison with existing zero-axiom universal hash equivalence',flush=True)
