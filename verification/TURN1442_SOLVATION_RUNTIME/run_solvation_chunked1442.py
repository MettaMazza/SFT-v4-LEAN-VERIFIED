from pathlib import Path
import os,subprocess,json,hashlib
w=Path('work');r=w/'turn1064_recovery';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0'
env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']))
with (w/'chunked_hash1442_audit.log').open('w') as f:subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192',str(w/'ChunkedHashAudit1442.lean')],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
s=(w/'chunked_hash1442_audit.log').read_text();assert s.count('does not depend on any axioms')==2 and 'depends on axioms' not in s
p=w/'chunked_solvation1442_source_correspondence.json';a=json.loads(p.read_text());assert hashlib.sha256((r/'SFT/Host/SHA256Chunks.lean').read_bytes()).hexdigest()==a['equivalence_source_sha256'];assert hashlib.sha256((r/'SFT/Host/Canonical.lean').read_bytes()).hexdigest()==a['unchanged_original_canonical'];a['status']='EQUIVALENCE_AUDIT_PASS';p.write_text(json.dumps(a,indent=2)+'\n');print('PASS existing universal digest equivalence and implementation have empty axiom dependencies',flush=True)
for name in ['prepare_solvation1342_chunked1442.py','check_solvation1342_chunked1442.py']:
 if (w/'solvation1342_empirical_report.json').exists() and json.loads((w/'solvation1342_empirical_report.json').read_text()).get('status')=='PASS':print('Original entry comparison completed; retaining isolated preparation');break
 print('RUN '+name,flush=True);subprocess.run(['python3','-u','work/'+name],check=True)

