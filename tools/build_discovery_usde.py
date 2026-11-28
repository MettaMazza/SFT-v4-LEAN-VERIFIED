from pathlib import Path
import os,sys,subprocess,shutil,json
root=Path(__file__).resolve().parents[1]
b=root/'.lake/build/applications/discovery';s=b/'source';s.mkdir(parents=True,exist_ok=True)
t=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin';env=dict(os.environ,LEAN_PATH=str(s))
if not (b/'SFT_Applications_Discovery_Reports.o').exists():
 subprocess.run([sys.executable,str(root/'tools/build_discovery_v2.py')],check=True)
modules=['MaxCore','USDECore','USDEEigenvalues','USDEMatching','USDESweep','MaxCensus','MaxArtifacts']
for name in modules:
 m='SFT/Applications/Discovery/'+name;dst=s/(m+'.lean');shutil.copyfile(root/(m+'.lean'),dst);c=b/(m.replace('/','_')+'.c');o=c.with_suffix('.o')
 subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192','-o',str(dst.with_suffix('.olean')),'-c',str(c),str(dst)],env=env,check=True)
 subprocess.run([str(t/'leanc'),'-O3','-c',str(c),'-o',str(o)],check=True)
objects=[str(b/(m.replace('/','_')+'.o'))for m in ['SFT/Host/Text','SFT/Host/SHA256']+['SFT/Applications/Discovery/'+n for n in ['Core','Explorer','Carry','Source','Display','Reports','Extended']+modules]]
evidence=root/'verification/APPLICATION_DISCOVERY1605';original=root/'reference/applications/discovery-SFT-v2'
for name in ['NativeCheck','FullSweep','ArtifactCheck']:
 dst=s/(name+'.lean');shutil.copyfile(evidence/(name+'.lean'),dst);c=b/(name+'.c');o=c.with_suffix('.o');exe=b/('usde_'+name)
 subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192','-c',str(c),str(dst)],env=env,check=True)
 subprocess.run([str(t/'leanc'),'-O3','-c',str(c),'-o',str(o)],check=True)
 subprocess.run([str(t/'leanc'),'-O3','-o',str(exe)]+objects+[str(o)],check=True)
with (b/'usde_native_checks.log').open('w')as f:subprocess.run([str(b/'usde_NativeCheck'),str(original)],stdout=f,check=True)
artifacts=b/'max_artifacts_output';subprocess.run([str(b/'usde_ArtifactCheck'),str(original),str(artifacts)],check=True)
comparisons=[]
for p in sorted(artifacts.iterdir()):
 same=p.read_bytes()==(original/'pure/reports'/p.name).read_bytes();comparisons.append({'file':p.name,'byte_equal':same});assert same,p.name
(b/'max_artifact_comparison.json').write_text(json.dumps(comparisons,indent=2)+'\n')
with (b/'usde_axioms.log').open('w')as f:subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192',str(evidence/'Audit.lean')],env=env,stdout=f,check=True)
if '--full' in sys.argv:
 for mode in ['analytical','enumerated']:
  with (b/('usde_full_'+mode+'.tsv')).open('w')as f:subprocess.run([str(b/'usde_FullSweep')]+(['analytical']if mode=='analytical'else[]),stdout=f,check=True)
print('PASS native USDE checks and six original report byte comparisons; actual axiom report retained separately.')
