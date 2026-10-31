from pathlib import Path
import ast,subprocess
r=Path('work/constants-recovery').resolve();old=Path('work/native381').resolve();out=Path('work/native482').resolve();out.mkdir(exist_ok=True)
tree=ast.parse(Path('work/native_dependencies381.py').read_text());mods=next(ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and any(getattr(t,'id',None)=='mods' for t in n.targets))
import json
ir=r/'.lake/build/ir'
common=json.load(open('work/running500_validation_objects.json'))
objects=[str(ir/(m+'.c.o.export')) for m in common if (ir/(m+'.c.o.export')).exists()]
objects += [str(p.resolve()) for p in Path('work/selfsimilar498_dependencies').glob('*.o')]
objects += [str(Path(p).resolve()) for p in ['work/field493_initializer_bridge.o','work/LeastCommonReturn490.o','work/PrimeSectorLadder498.o','work/native489/PlanckHierarchy.o','work/native491/EvolutionMeasuredSource.o','work/native491/LeptonDecimal.o']]

toolchain=Path('/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0')
flags=['-I',str(toolchain/'include'),'-fstack-clash-protection','-ffp-contract=off','-fdata-sections','-ffunction-sections','-fvisibility=hidden','--sysroot',str(toolchain),'-nostdinc','-isystem',str(toolchain/'include/clang')]
libs=['-L',str(toolchain/'lib'),'-L',str(toolchain/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(toolchain/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip','-Wno-unused-command-line-argument']
subprocess.run([str(toolchain/'bin/clang'),*flags,str(Path('work/constants-recovery/RunningValidationProgram500.c').resolve()),*objects,str(Path('work/native483/CanonicalPackaged.o').resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a',*libs,'-Wl,-stack_size,0x20000000','-o',str(Path('work/RunningValidationProgram500').resolve())],check=True)
print(subprocess.check_output(['/usr/bin/otool','-l',str(Path('work/RunningValidationProgram500').resolve())],text=True).split('cmd LC_MAIN')[1].split('Load command')[0])
