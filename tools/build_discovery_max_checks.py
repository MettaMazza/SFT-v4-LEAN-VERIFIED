from pathlib import Path
import shutil,subprocess,os
r=Path(__file__).resolve().parents[1];b=r/'.lake/build/applications/discovery';s=b/'source';t=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin';env=dict(os.environ,LEAN_PATH=str(s));name='MaxCheck'
if not (b/'SFT_Applications_Discovery_Reports.o').exists(): subprocess.run([os.sys.executable,str(r/'tools/build_discovery_v2.py')],check=True)
m='SFT/Applications/Discovery/MaxCore';dst=s/(m+'.lean');shutil.copyfile(r/(m+'.lean'),dst)
subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192','-o',str(dst.with_suffix('.olean')),'-c',str(b/'SFT_Applications_Discovery_MaxCore.c'),str(dst)],env=env,check=True)
subprocess.run([str(t/'leanc'),'-O3','-c',str(b/'SFT_Applications_Discovery_MaxCore.c'),'-o',str(b/'SFT_Applications_Discovery_MaxCore.o')],check=True)
shutil.copyfile(r/'verification/APPLICATION_DISCOVERY1604'/ (name+'.lean'),s/(name+'.lean'))
subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192','-c',str(b/(name+'.c')),str(s/(name+'.lean'))],env=env,check=True)
subprocess.run([str(t/'leanc'),'-O3','-c',str(b/(name+'.c')),'-o',str(b/(name+'.o'))],check=True)
objects=[str(b/(x.replace('/','_')+'.o'))for x in ['SFT/Host/Text','SFT/Host/SHA256']+['SFT/Applications/Discovery/'+n for n in ['Core','Explorer','Carry','Source','Display','Reports','MaxCore']]]
subprocess.run([str(t/'leanc'),'-O3','-o',str(b/'max_check')]+objects+[str(b/(name+'.o'))],check=True)
with (b/'max_checks.log').open('w')as f:subprocess.run([str(b/'max_check')],stdout=f,check=True)

with (b/"max_axioms.log").open("w")as f:subprocess.run([str(t/"lean"),"-j1","-M8192",str(r/"verification/APPLICATION_DISCOVERY1604/Audit.lean")],env=env,stdout=f,check=True)
assert "depends on axioms:"not in (b/"max_axioms.log").read_text()
print("PASS native discovery max computational checks and zero-axiom audit")
