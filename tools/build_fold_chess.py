from pathlib import Path
import os,subprocess,concurrent.futures,time,shutil
root=Path(__file__).resolve().parents[1];build=root/'.lake/build/applications/fold_chess';build.mkdir(exist_ok=True);tool=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin';env=dict(os.environ,LEAN_PATH=str(root))
modules=['SFT/Host/Text']+['SFT/Applications/FoldChess/'+n for n in ['Board','Moves','Attacks','LegalMoves','ReachMap','Evaluation','Ordering','Endgame','Quiescence','Search','Driver','Protocol','Demonstrations','Main']]
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
subprocess.run([str(tool/'leanc'),'-O3','-o',str(build/'fold_chess_lean')]+objects,check=True)
print('BUILT',build/'fold_chess_lean',flush=True)
