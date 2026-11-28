from pathlib import Path
import os,subprocess,concurrent.futures,time,shutil,sys
root=Path(__file__).resolve().parents[1];build=root/'.lake/build/applications/fold_go';build.mkdir(parents=True,exist_ok=True);tool=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin';env=dict(os.environ,LEAN_PATH=str(root))
modules=['SFT/Host/Text']+['SFT/Applications/FoldChess/'+n for n in ['Board','Moves','Attacks','LegalMoves','ReachMap','Evaluation','Ordering','Endgame','Quiescence','Search','Driver']]+['SFT/Applications/FoldGo/'+n for n in ['Board','Hashing','Evaluation','IndexSet','Selection','SearchState','Search','Driver','Protocol','Tournament','Run','Main']]
source_root=root;root=build/'source';root.mkdir(exist_ok=True)
for m in modules:
 dest=root/(m+'.lean');dest.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(source_root/(m+'.lean'),dest)
env=dict(os.environ,LEAN_PATH=str(root))
def compile_module(m):
 name=m.replace('/','_');c=build/(name+'.c');o=build/(name+'.o');log=build/(name+'.log')
 with log.open('w')as f:
  subprocess.run([str(tool/'lean'),'-R',str(root),'-j1','-M8192','-c',str(c),'-o',str(root/(m+'.olean')),str(root/(m+'.lean'))],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
  subprocess.run([str(tool/'leanc'),'-O3','-c',str(c),'-o',str(o)],stdout=f,stderr=subprocess.STDOUT,check=True)
 print('compiled',m,flush=True);return str(o)
with concurrent.futures.ThreadPoolExecutor(max_workers=1)as pool:objects=list(pool.map(compile_module,modules))
subprocess.run([str(tool/'leanc'),'-O3','-o',str(build/'fold_go_lean')]+objects,check=True)
print('BUILT',build/'fold_go_lean',flush=True)

if "--validate" in sys.argv:
 validation=root/'Validation.lean'
 shutil.copyfile(source_root/'applications/fold_go/Validation.lean',validation)
 c=build/'Validation.c';o=build/'Validation.o'
 subprocess.run([str(tool/'lean'),'-R',str(root),'-j1','-M8192','-c',str(c),str(validation)],env=env,check=True)
 subprocess.run([str(tool/'leanc'),'-O3','-c',str(c),'-o',str(o)],check=True)
 check=build/'fold_go_validation'
 subprocess.run([str(tool/'leanc'),'-O3','-o',str(check)]+objects[:-1]+[str(o)],check=True)
 subprocess.run([str(check)],check=True)
