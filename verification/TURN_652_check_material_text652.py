from pathlib import Path
import json,re,html,subprocess,os
w=Path('work');r=(w/'constants-recovery').resolve();root=Path('/Volumes/One Touch/ernos-labs-sft-platform')
cases=['','<>','<a>HELLO</a>','a<b\nc>d','a<unterminated','a<<b>c',' &amp; &AMP &notit; &unknown; ','&#0; &#13; &#128; &#xD800; &#x110000; &#x10FFFF;','&#; &#x; &#X41; &#65x','A\u00a0 B\u2003C\n','&CounterClockwiseContourIntegral; &NotEqualTilde;','&'+'a'*40+';','<script>if (a < b) x</script>','&lt;tag&gt;']
cases += ['&'+k for k in html.entities.html5]
cases += ['&#'+str(n)+';' for n in list(html._invalid_charrefs)+list(html._invalid_codepoints)+[1,9,10,13,32,65,55296,57343,57344,1114111,1114112]]
# The exact target snapshot and whole archived authority corpus after original ignore decoding.
cases.append((root/'experiments/external_sources/materials/snapshots/nist-reference-materials.html').read_text(encoding='utf8',errors='ignore'))
d=w/'material_text652_inputs';d.mkdir(exist_ok=True)
for i,s in enumerate(cases):(d/str(i)).write_text(s)
expected=[' '.join(html.unescape(re.sub(r'<[^>]+>',' ',s)).casefold().split()) for s in cases]
(w/'material_text652_expected.json').write_text(json.dumps(expected))
runner='''import SFT.Materials.SourceText
import SFT.Host.Canonical
open SFT.Host.Canonical
def main (args : List String) : IO Unit := do
 for p in args do
  let text ← IO.FS.readFile p
  IO.println (render (.text (SFT.Materials.SourceText.corpus text)))
'''
(r/'MaterialText652.lean').write_text(runner)
env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-c','MaterialText652.c','MaterialText652.lean'],cwd=r,env=env,check=True)
# Use the existing native runner toolchain and library closure; no proof recompile.
ns={};src=(w/'run_material651.py').read_text();exec(src[:src.index("modules=")],ns)
ir=ns['ir'];toolchain=ns['toolchain']
objects=[]
for m in ['SFT/Chemistry/SourceText','SFT/Materials/SourceText']:
 out=w/(m.split('/')[-2]+'SourceText652.o');subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(ir/(m+'.c')),'-o',str(out)],check=True);objects.append(str(out.resolve()))
subprocess.run([str(toolchain/'bin/clang'),*ns['flags'],str(r/'MaterialText652.c'),*objects,'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a',*ns['libs'],'-Wl,-stack_size,0x10000000','-o',str((w/'MaterialText652').resolve())],check=True)
o=subprocess.check_output([str((w/'MaterialText652').resolve()),*[str((d/str(i)).resolve()) for i in range(len(cases))]],text=True)
actual=[json.loads(x) for x in o.splitlines()];(w/'material_text652_actual.json').write_text(json.dumps(actual));assert len(actual)==len(expected)
for i,(a,b) in enumerate(zip(actual,expected)):assert a==b,(i,cases[i][:100],a[:300],b[:300])
report={'status':'PASS','cases':len(cases),'full_named_html_entities':len(html.entities.html5),'actual_entry_snapshot':'nist-reference-materials.html','source_operation':'external_bindings.source_corpus: regex tags, HTML unescape, Unicode casefold, whitespace split/join'};(w/'material_text652_report.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))
