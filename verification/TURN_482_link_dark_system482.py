from pathlib import Path
import ast,subprocess
r=Path('work/constants-recovery').resolve();old=Path('work/native381').resolve();out=Path('work/native482').resolve();out.mkdir(exist_ok=True)
tree=ast.parse(Path('work/native_dependencies381.py').read_text());mods=next(ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and any(getattr(t,'id',None)=='mods' for t in n.targets))
objects=[str(old/(m.replace('.','_')+'.o')) for m in mods]+[str(r/(m+'.o')) for m in ['CosmicRatios','DarkBaryonGrammar','DarkBaryonWitnesses','DarkBaryonControls','DarkBaryonEvidence']]
toolchain=Path('/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0')
flags=['-I',str(toolchain/'include'),'-fstack-clash-protection','-ffp-contract=off','-fdata-sections','-ffunction-sections','-fvisibility=hidden','--sysroot',str(toolchain),'-nostdinc','-isystem',str(toolchain/'include/clang')]
libs=['-L',str(toolchain/'lib'),'-L',str(toolchain/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(toolchain/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip','-Wno-unused-command-line-argument']
subprocess.run([str(toolchain/'bin/clang'),*flags,str(r/'DarkBaryonProgram.c'),*objects,'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a',*libs,'-Wl,-stack_size,0x4000000','-o',str(out/'DarkBaryonProgram')],check=True)
print(subprocess.check_output(['/usr/bin/otool','-l',str(out/'DarkBaryonProgram')],text=True).split('cmd LC_MAIN')[1].split('Load command')[0])
s=Path('work/check_dark_baryon_program455.py').read_text();a=s.index('out=subprocess.check_output');b=s.index(';actual=json.loads(out)',a)
s=s[:a]+"out=subprocess.check_output([str(Path('work/native482/DarkBaryonProgram').resolve()),source],cwd=Path.cwd(),text=True)"+s[b:]
s=s.replace('dark_baryon_program_output.json','dark_baryon_native482_output.json').replace('dark_baryon_program_report.json','dark_baryon_native482_report.json');Path('work/check_dark_native482.py').write_text(s)
