from pathlib import Path
import subprocess,os
toolchain=Path('/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0')
flags=['-I',str(toolchain/'include'),'-fstack-clash-protection','-ffp-contract=off','-fdata-sections','-ffunction-sections','-fvisibility=hidden','--sysroot',str(toolchain),'-nostdinc','-isystem',str(toolchain/'include/clang')]
libs=['-L',str(toolchain/'lib'),'-L',str(toolchain/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(toolchain/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip','-Wno-unused-command-line-argument']
ns={};s=Path('work/run_collective543.py').read_text();exec(s[:s.index('for stem,key,component in entries:')],ns)
r=ns['r'];ir=ns['ir'];env=ns['env'];common=ns['common'];mods=['TurbulenceGrammar','TurbulenceEvidence','TurbulenceExperiment','TurbulenceValidation'];objs=[ir/(m+'.c.o.export') for m in common+['SFT/Physics/'+m for m in mods] if (ir/(m+'.c.o.export')).exists()]
# Include only existing objects; no comparison is duplicated.
name='TurbulenceValidationProgram541';subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-c',name+'.c',name+'.lean'],cwd=r,env=env,check=True)
cmd=[str(toolchain/'bin/clang'),*flags,str(r/(name+'.c')),*map(str,objs),str(Path('work/field533_initializer_bridge.o').resolve()),str(Path('work/LeastCommonReturn533.o').resolve()),*[str(p.resolve()) for p in Path('work/selfsimilar498_dependencies').glob('*.o')],*[str(p.resolve()) for p in Path('work/limit_native543').glob('*.o')],str(Path('work/FiniteRefinementTrace541.o').resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a',*libs,'-Wl,-stack_size,0x10000000','-o',str(r.parent/name)];subprocess.run(cmd,env=env,check=True)
print('Native validation executable linked; existing full-program process retained')
