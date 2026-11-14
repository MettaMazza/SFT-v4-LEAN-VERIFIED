from pathlib import Path
import subprocess,json,os,hashlib,itertools
ns={};exec(Path('work/unbounded_spec867.py').read_text(),ns);src=ns['ns'];r=Path('work/constants-recovery').resolve();p=subprocess.Popen(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'UnboundedScience867.lean')],stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')));digest=hashlib.sha256();count=0

def result(f,*args):
 try:return dict(ok=f(*args))
 except ValueError as e:return dict(error=str(e))
def compare(expected):
 global count
 line=p.stdout.readline();assert line,p.stderr.read();a=json.loads(line);expected=json.loads(json.dumps(expected));assert a==expected,(count,a,expected);digest.update(line.encode());count+=1
for d in range(1,15):compare(result(src['forced_width'],tuple('fault-'+str(i+1) for i in range(d))))
masks=0
for label in ['held','returned']:
 for d in [1,2,3]:
  for n in range(d+1):
   for mask in itertools.combinations(range(2*d+1),n):
    word=tuple(('returned' if label=='held' else 'held') if i in mask else label for i in range(2*d+1));compare(dict(label=label,depth=d,mask=mask,changed=word,decoded=result(src['decode'],word)));masks+=1
short=0
for d in range(1,15):
 for width in range(1,2*d+1):
  word=tuple('returned' if i<(width+1)//2 else 'held' for i in range(width));compare(dict(depth=d,width=width,changed=word,decoded=result(src['decode'],word)));short+=1
for source in itertools.product(('held','returned'),repeat=7):
 changed=[tuple(('returned' if label=='held' else 'held') if i<14 else label for i in range(29)) for label in source];recovered=tuple(src['decode'](w) for w in changed);compare(dict(source=source,changed=changed,recovered=dict(ok=recovered)))
for word in [(),('external',),('held','returned'),('held',),('returned',)]:compare(result(src['decode'],word))
for fault in [(),('f','f'),('f',)]:compare(result(src['forced_width'],fault))
assert p.stdout.read()=='';assert p.wait()==0,p.stderr.read();v=dict(status='PASS',source_commit=ns['pin'],width_orders=14,complete_small_masks=masks,predecessor_counterexamples=short,complete_depth_seven_roundtrips=128,guard_cases=8,actual_output_sha256=digest.hexdigest());Path('work/unbounded867_science_report.json').write_text(json.dumps(v,indent=2));print(json.dumps(v))
