from pathlib import Path
import re,subprocess,json,hashlib
out=Path('work/stackdecode500');out.mkdir(exist_ok=True);records=[]
for source,symbol,name in [('/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/ir/SFT/Host/Text.c','lp_sft__v4_SFT_Host_Text_decode','TextPackaged'),('work/native381/SFT_Host_Text.c','l_SFT_Host_Text_decode','TextBare')]:
 data=Path(source).read_text();pattern=r'LEAN_EXPORT lean_object\* '+symbol+r'\(([^;]+?)\)\{';m=re.search(pattern,data);assert m
 args=re.findall(r'lean_object\* (\w+)',m.group(1));assert len(args)==2
 a=m.end()-1;depth=1;b=a+1
 while depth:
  if data[b]=='{':depth+=1
  if data[b]=='}':depth-=1
  b+=1
 patched=data[:a]+'{ return l_SFT_Host_StackDecode_decode('+','.join(args)+'); }'+data[b:]
 patched=patched.replace('#include <lean/lean.h>','#include <lean/lean.h>\nlean_object* l_SFT_Host_StackDecode_decode(lean_object*,lean_object*);',1)
 p=out/(name+'.c');p.write_text(patched)
 subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c',str(p),'-o',str(out/(name+'.o'))],check=True)
 records.append(dict(original=source,sha256=hashlib.sha256(data.encode()).hexdigest(),patched=str(p),patched_sha256=hashlib.sha256(patched.encode()).hexdigest(),symbol=symbol,implementation='SFT.Host.StackDecode.decode',equivalence='SFT.Host.StackDecode.decodePreserves'))
subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c','work/StackDecode500.c','-o',str(out/'StackDecode.o')],check=True)
Path('work/stackdecode500_native_report.json').write_text(json.dumps(records,indent=2)+'\n')
s=Path('work/link_running500.py').read_text();mark='toolchain=Path('
pos=s.index(mark);s=s[:pos]+'''objects=[str(Path('work/stackdecode500/TextBare.o').resolve()) if Path(p).name=='SFT_Host_Text.o' else p for p in objects]
objects += [str(Path(p).resolve()) for p in ['work/stackdecode500/TextPackaged.o','work/stackdecode500/StackDecode.o']]
'''+s[pos:];Path('work/link_running500_stackdecode.py').write_text(s)
