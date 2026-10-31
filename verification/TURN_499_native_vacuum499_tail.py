from pathlib import Path
import subprocess,os,json,time,re
root=Path.cwd();r=(root/'work/constants-recovery');out=root/'work/native_vacuum498';out.mkdir(exist_ok=True);env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_PATH=str(r/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/bin/lean';leanc='/Users/dolltrading/.elan/bin/leanc'
modules=json.load(open('work/vacuum498_native_config.json'))['modules']
for i,m in enumerate(modules):
 if i < modules.index("VacuumDensityCensus224"): continue
 t=time.monotonic()
 with (out/(m+'.log')).open('w') as f:
  subprocess.run([lean,'-j','1','-M','4096','-c',str(out/(m+'.c')),'SFT/Physics/'+m+'.lean'],cwd=r,env=env,stdout=f,stderr=f,check=True)
  subprocess.run([leanc,'-O3','-c',str(out/(m+'.c')),'-o',str(out/(m+'.o'))],stdout=f,stderr=f,check=True)
 print('COMPILED',i+1,len(modules),m,round(time.monotonic()-t,2),flush=True)
with (out/'main.log').open('w') as f:subprocess.run([lean,'-j','1','-M','2048','-c',str(out/'VacuumDensityProgram.c'),'VacuumDensityProgram.lean'],cwd=r,env=env,stdout=f,stderr=f,check=True)
s=Path('work/link_hubble487_stack.py').read_text();a=s.index("+[str(r/'CosmicRatios.o')]");b=s.index('\ntoolchain=',a);s=s[:a]+"+[str(Path('work/native_vacuum498').resolve()/(m+'.o')) for m in "+repr(modules)+"]"+s[b:];s=s.replace('work/native486/HubbleProgram','work/native_vacuum498/VacuumDensityProgram');Path('work/link_vacuum498.py').write_text(s)
with (out/'link.log').open('w') as f:subprocess.run(['python3','work/link_vacuum498.py'],stdout=f,stderr=f,check=True)
s=Path('work/check_vacuum_density465.py').read_text();a=s.index('out=subprocess.check_output');b=s.index(';actual=json.loads(out)',a);s=s[:a]+"out=subprocess.check_output([str(Path('work/native_vacuum498/VacuumDensityProgram').resolve()),source],text=True)"+s[b:];s=s.replace('vacuum_density_program_output.json','planck_native_vacuum498_output.json').replace('vacuum_density_program_report.json','planck_native_vacuum498_report.json');Path('work/check_planck_native_vacuum498.py').write_text(s);subprocess.run(['python3','work/check_planck_native_vacuum498.py'],check=True)
