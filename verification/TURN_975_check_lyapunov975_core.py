from pathlib import Path
import sys,json,subprocess,os,itertools,re,hashlib
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import lyapunov_ks_correspondence_terminal_law_v1 as src
vals=[False,True,-2,-1,0,1,2,3,4,5];depths=[False,True,-1,0,1,2,3,4]
def arg(x):return '(.boolean '+str(x).lower()+')' if isinstance(x,bool) else '(.integer ('+str(x)+'))'
def enc(x):return list(map(enc,x)) if isinstance(x,(list,tuple)) else x
s='''import SFT.Physics.LyapunovKSCorrespondence
import SFT.Host.Canonical
open SFT.Physics LyapunovKSCorrespondence SFT.Host.Canonical
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def result (f : α → Value) : Except String α → Value | .ok v => f v | .error e => .object [("error",.text e)]
def nat (n : Nat) : Value := .integer (.ofNat n)
def support (xs : List (List Nat)) : Value := .array (xs.map (fun x => .array (x.map nat)))
#eval IO.println (render (.array [
''';expected=[];fields=[];counts={}
for name,lean,render,args in [('positive_whole','positiveWhole','Value.integer',itertools.product(vals,[-2,-1,0,1,2,3])),('complete_word_support','completeWordSupport','support',itertools.product(vals,depths)),('exact_support_count','exactSupportCount','nat',itertools.product(vals,depths)),('separation_carrier','separationCarrier','Value.integer',itertools.product(vals,vals))]:
 count=0
 for a,b in args:
  try:out=getattr(src,name)(a,minimum=b) if name=='positive_whole' else getattr(src,name)(a,b)
  except ValueError as ex:out={'error':str(ex)}
  expected.append(enc(out));fields.append('result '+render+' ('+lean+' '+arg(a)+' '+('('+str(b)+')' if name=='positive_whole' else arg(b))+')');count+=1
 counts[name]=count
p=w/'constants-recovery/LyapunovCore975.lean';p.write_text(s+',\n'.join(fields)+']))\n');env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};binary='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);assert json.loads(out)==expected
m=c/'SFT/Physics/LyapunovKSCorrespondence.lean';ds=['SFT.Physics.LyapunovKSCorrespondence.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',m.read_text(),re.M)];p=w/'constants-recovery/LyapunovCoreAudit975.lean';p.write_text('import SFT.Physics.LyapunovKSCorrespondence\n'+'\n'.join('#print axioms '+d for d in ds));audit=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);(w/'lyapunov975_core_audit.log').write_text(audit);assert all("'"+d+"' does not depend on any axioms" in audit for d in ds)
(w/'lyapunov975_core_report.json').write_text(json.dumps(dict(status='PASS',cases=counts,total_cases=len(expected),declarations=ds,axioms=[],sha256=hashlib.sha256(m.read_bytes()).hexdigest()),indent=2));print('PASS',len(expected),'source cases;',len(ds),'empty declarations')
