from pathlib import Path
import sys,json,itertools,hashlib,os,subprocess,re
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry import resonance_equivalent_representation_law_v1 as s
b=(w/'v3-runtime500/sft/chemistry/resonance_equivalent_representation_law_v1.py').read_bytes();assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()=='0185c53c91ab6138d03acf38c7d75205c64fdfc0'
q=lambda x:json.dumps(x,ensure_ascii=False)
def norm(v):
 if isinstance(v,s.HeldLabel):return[v.family,v.label]
 if isinstance(v,s.PositiveCount):return v.value
 if isinstance(v,s.ExactMolecularEncoding):return[norm(v.encoding),norm(v.carrier),[norm(x)for x in v.atoms],[[norm(a),norm(b)]for a,b in v.adjacency],[norm(x)for x in v.fibres]]
 if isinstance(v,s.ExactEquivalentRepresentationPair):return[norm(v.carrier),norm(v.first),norm(v.second)]
 if isinstance(v,tuple):return[norm(x)for x in v]
 return v
expr=[];expected=[]
def add(name,e,fn):
 try:result={'ok':norm(fn())}
 except(ValueError,IndexError)as err:result={'error':str(err)}
 expr.append('('+q(name)+','+e+')');expected.append([name,result])
def ls(xs):return '['+','.join(q(x)for x in xs)+']'
def call(name,carrier,atoms,edges,fibres):return 'encoding '+q(name)+' '+q(carrier)+' '+ls(atoms)+' ['+','.join('('+str(a)+','+str(b)+')'for a,b in edges)+'] '+ls(fibres)
for label in ['fold-fibre-one','fold-fibre-two','other','',' ']:add('fibre-'+label,'result labelValue (fibre '+q(label)+')',lambda label=label:s.fibre(label))
for n in range(7):
 atoms=tuple('a'+str(i)for i in range(n));edges=tuple((i,i+1)for i in range(1,n));fibs=tuple('fold-fibre-one'if i%2==0 else'fold-fibre-two'for i in range(len(edges)))
 variants=[edges,(),edges+edges[:1],((1,1),),((0,1),),((-1,1),),((1,n+1),),((1,3),)]
 for j,es in enumerate(variants):
  fs=fibs if j in [0,1,2]else('fold-fibre-one',)
  add(f'encoding-{n}-{j}','result encodingValue ('+call('first','carrier',atoms,es,fs)+')',lambda atoms=atoms,es=es,fs=fs:s.encoding('first','carrier',atoms,es,fs))
for name,carrier,atoms,fibs in [('', 'carrier',('a','b','c'),('fold-fibre-one','fold-fibre-two')),('first','',('a','b','c'),('fold-fibre-one','fold-fibre-two')),('first','carrier',('a','a','c'),('fold-fibre-one','fold-fibre-two')),('first','carrier',('a','','c'),('fold-fibre-one','fold-fibre-two')),('first','carrier',('a','b','c'),('other','fold-fibre-two'))]:
 es=((1,2),(2,3));add('encoding-guard-'+repr((name,carrier,atoms,fibs)),'result encodingValue ('+call(name,carrier,atoms,es,fibs)+')',lambda name=name,carrier=carrier,atoms=atoms,fibs=fibs:s.encoding(name,carrier,atoms,es,fibs))
atoms=('a','b','c');edges=((1,2),(2,3));labels=['fold-fibre-one','fold-fibre-two']
for left in itertools.product(labels,repeat=2):
 for right in itertools.product(labels,repeat=2):
  for rightname,rightcarrier,es in [('second','carrier',edges),('first','carrier',edges),('second','other',edges),('second','carrier',((1,3),(2,3)))]:
   l=call('first','carrier',atoms,edges,left);rr=call(rightname,rightcarrier,atoms,es,right)
   e='(do let first ← '+l+'; let second ← '+rr+'; equivalentPair "carrier" first second)'
   def make(left=left,right=right,rightname=rightname,rightcarrier=rightcarrier,es=es):return s.equivalent_pair('carrier',s.encoding('first','carrier',atoms,edges,left),s.encoding(rightname,rightcarrier,atoms,es,right))
   name='pair-'+repr((left,right,rightname,rightcarrier,es));add(name,'result pairValue '+e,make)
   try:pair=make()
   except ValueError:continue
   for fresh in ['d','a','']:
    add(name+'-append-'+fresh,'result pairValue (do let p ← '+e+'; appendSharedSuccessor p '+q(fresh)+')',lambda pair=pair,fresh=fresh:s.append_shared_successor(pair,fresh))
   add(name+'-count','result countValue (do let p ← '+e+'; representationCount p)',lambda pair=pair:pair.representation_count)
h='''import SFT.Chemistry.ResonanceEquivalent
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.ResonanceEquivalent
set_option maxHeartbeats 20000000
abbrev J := Canonical.Value
def labelValue (v : HeldLabel) : J := .array [.text v.family,.text v.label]
def countValue (v : PositiveCount) : J := .integer (.ofNat v.value)
def encodingValue (v : ExactMolecularEncoding) : J := .array [labelValue v.encoding,labelValue v.carrier,.array (v.atoms.map labelValue),.array (v.adjacency.map fun (a,b)=>.array [labelValue a,labelValue b]),.array (v.fibres.map labelValue)]
def pairValue (v : ExactEquivalentRepresentationPair) : J := .array [labelValue v.carrier,encodingValue v.first,encodingValue v.second]
def result {α : Type} (f : α → J) : Except String α → J
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",f v)]
''';h+='def rows : List (String × J) := [\n'+',\n'.join(expr)+'\n]\ndef main : IO Unit := IO.println (Canonical.render (.array (rows.map fun (name,value)=>.array [.text name,value])))\n';hp=w/'ResonanceProgram1087.lean';hp.write_text(h)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(hp)]
with(w/'resonance1087_output.json').open('w')as out,(w/'resonance1087_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert run.returncode==0
actual=json.loads((w/'resonance1087_output.json').read_text());assert actual==expected,[(a,b)for a,b in zip(actual,expected)if a!=b][:3]
log=(w/'resonance1087_build.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",log);assert len(names)==14 and 'depends on axioms:'not in log
report=dict(status='PASS',cases=len(expected),declarations=names,axioms=[],source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_git_blob='0185c53c91ab6138d03acf38c7d75205c64fdfc0',lean_source_sha256=hashlib.sha256((r/'SFT/Chemistry/ResonanceEquivalent.lean').read_bytes()).hexdigest());(w/'resonance1087_core_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS',len(expected),'original source operations;14 empty-axiom declarations')
