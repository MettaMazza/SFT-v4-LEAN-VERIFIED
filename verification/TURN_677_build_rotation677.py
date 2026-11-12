from pathlib import Path
import os,subprocess,sys
base=Path.cwd();env=os.environ.copy();env['LEAN_PATH']=str(base/'work/constants-recovery/.lake/build/lib/lean')+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'
for m in sys.argv[1:]:
 r=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288',f'work/constants-recovery/SFT/Materials/{m}.lean','-o',f'work/constants-recovery/.lake/build/lib/lean/SFT/Materials/{m}.olean'],capture_output=True,text=True,env=env);Path(f'work/rotation677_{m}_build.log').write_text(r.stdout+r.stderr);print(m,r.returncode,r.stdout,r.stderr);r.check_returncode()
