from pathlib import Path
import subprocess,types,sys,json,hashlib
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';path='sft/mathematics/calculator/values.py';source=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+path],text=True)
m=types.ModuleType('pinned_scalar485');sys.modules[m.__name__]=m;exec(compile(source,path,'exec'),m.__dict__)
def parse(s):
 if s=='empty-One':return m.EMPTY_ONE
 o,f=s.split(':');return m.FoldScalar(o,m.Fraction(f))
def record(x):
 if isinstance(x,m.EmptyOne):return 'empty-One'
 return x.orientation+':'+str(x.magnitude.numerator)+'/'+str(x.magnitude.denominator)
out=subprocess.check_output([str(Path('work/FoldScalarProgram485').resolve())],text=True)
counts={}
for line in out.splitlines():
 fields=line.split('\t');kind=fields[0];args=[parse(x) for x in fields[1:-1]]
 if kind=='reverse':expected=m.reverse(*args)
 elif kind=='add':expected=m.add_scalar(*args)
 elif kind=='subtract':expected=m.subtract_scalar(*args)
 elif kind=='multiply':expected=m.multiply_scalar(*args)
 elif kind=='rate':expected=m.divide_scalar(m.subtract_scalar(args[0],args[1]),args[2])
 else:raise AssertionError(kind)
 assert fields[-1]==record(expected),(line,record(expected));counts[kind]=counts.get(kind,0)+1
Path('work/scalar485_output.tsv').write_text(out)
report=dict(status='PASS',source_commit=pin,source_path=path,source_sha256=hashlib.sha256(source.encode()).hexdigest(),checks=counts,total=sum(counts.values()),scope='Fresh native outputs against unchanged pinned source reverse/add_scalar/subtract_scalar/multiply_scalar/divide_scalar on structural Empty One, both orientations and all numerator/denominator pairs1..5; rates over five positive durations. Universal operation identities are separately kernel proved; finite replay does not substitute for them.')
Path('work/scalar485_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
