from pathlib import Path
import os,subprocess,shutil,sys
root=Path(__file__).resolve().parents[1];b=root/'.lake/build/applications/discovery';s=b/'source';s.mkdir(parents=True,exist_ok=True)
t=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin';env=dict(os.environ,LEAN_PATH=str(s));objects=[]
for m in ['SFT/Host/Text','SFT/Host/SHA256']+['SFT/Applications/Discovery/'+n for n in ['Core','Explorer','Carry','Source','Display','Reports','Extended','V2Main']]:
 dst=s/(m+'.lean');dst.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(root/(m+'.lean'),dst);c=b/(m.replace('/','_')+'.c');o=c.with_suffix('.o')
 subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192','-o',str(dst.with_suffix('.olean')),'-c',str(c),str(dst)],env=env,check=True)
 subprocess.run([str(t/'leanc'),'-O3','-c',str(c),'-o',str(o)],check=True);objects.append(str(o))
subprocess.run([str(t/'leanc'),'-O3','-o',str(b/'discovery_v2_lean')]+objects,check=True)
print('BUILT',b/'discovery_v2_lean')

if '--validate' in sys.argv:
 evidence=root/'verification/APPLICATION_DISCOVERY1603'
 originals=root/'reference/applications/discovery-SFT-v2'
 for fixture,output in [('SourceCheck','source_rows.tsv'),('ReportsCheck','reports_checks.log'),('ExtendedCheck','extended_checks.log')]:
  dst=s/(fixture+'.lean');shutil.copyfile(evidence/(fixture+'.lean'),dst);c=b/(fixture+'.c');o=c.with_suffix('.o');exe=b/fixture
  subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192','-c',str(c),str(dst)],env=env,check=True)
  subprocess.run([str(t/'leanc'),'-O3','-c',str(c),'-o',str(o)],check=True)
  subprocess.run([str(t/'leanc'),'-O3','-o',str(exe)]+objects[:-1]+[str(o)],check=True)
  with (b/output).open('w')as f:subprocess.run([str(exe),str(originals)],stdout=f,check=True)
 subprocess.run([sys.executable,str(root/'tools/check_discovery_registry_source.py'),str(originals),str(b)],check=True)
 with (b/'axioms.log').open('w')as f:subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192',str(evidence/'Audit.lean')],env=env,stdout=f,check=True)
 assert 'depends on axioms:'not in (b/'axioms.log').read_text()
 print('PASS discovery V2 native validation and original-source inspection')
