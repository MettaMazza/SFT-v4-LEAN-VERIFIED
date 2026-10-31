from pathlib import Path
import subprocess,os,hashlib,json
r=Path('work/constants-recovery').resolve();root=Path('work/native482/source').resolve();p=root/'SFT/Host/Canonical.lean';p.parent.mkdir(parents=True,exist_ok=True)
original=(r/'SFT/Host/Canonical.lean').read_text();s=original.replace('import SFT.Host.SHA256','import SFT.Host.SHA256Window',1).replace('SHA256.digest (render v).toUTF8','SHA256Window.digest (render v).toUTF8')
proof='''\ntheorem identityOriginal (v : Value) : identity v = "sha256:" +++ SHA256.digest (render v).toUTF8 := by
  unfold identity
  rw [SHA256Window.digestPreserved]
#print axioms identityOriginal
''';assert s.count('end SFT.Host.Canonical')==1;s=s.replace('end SFT.Host.Canonical',proof+'end SFT.Host.Canonical');p.write_text(s)
out=Path('work/native482').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
with Path('work/native_canonical482.log').open('w') as f:
 subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','1024','-c',str(out/'Canonical.c'),'SFT/Host/Canonical.lean'],cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
assert "'SFT.Host.Canonical.identityOriginal' does not depend on any axioms" in Path('work/native_canonical482.log').read_text()
subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c',str(out/'Canonical.c'),'-o',str(out/'Canonical.o')],check=True)
Path('work/native_canonical482_identity.json').write_text(json.dumps(dict(original_source_sha256=hashlib.sha256(original.encode()).hexdigest(),alternative_source_sha256=hashlib.sha256(s.encode()).hexdigest(),only_computational_change='identity invokes universally equal SHA256Window.digest; original canonical data type, ordering, rendering and remaining code unchanged.',equivalence='SFT.Host.Canonical.identityOriginal',axiom_dependencies=[],scope='Isolated executable link; canonical project source and all scientific sources unchanged.'),indent=2)+'\n')
s=Path('work/link_dark_system482.py').read_text();s=s.replace("objects=[str(old/(m.replace('.','_')+'.o')) for m in mods]","objects=[str(out/'Canonical.o') if m=='SFT.Host.Canonical' else str(old/(m.replace('.','_')+'.o')) for m in mods]+[str(r/'.lake/build/ir/SFT/Host/SHA256Window.c.o.export')]")
s=s.replace("out/'DarkBaryonProgram'","out/'DarkBaryonProgramWindow'").replace("work/native482/DarkBaryonProgram'","work/native482/DarkBaryonProgramWindow'").replace('dark_baryon_native482','dark_baryon_window482').replace('check_dark_native482.py','check_dark_window482.py')
Path('work/link_dark_window482.py').write_text(s)
