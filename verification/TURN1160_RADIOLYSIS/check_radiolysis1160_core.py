from pathlib import Path
import sys,json,subprocess,os,hashlib,itertools
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1160/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import radiolysis_network_law_v1 as m
from sft.engine.exact import HeldLabel,PositiveCount
q=lambda x:json.dumps(x,ensure_ascii=False)
base=['radiolysis-medium','water','chemical-species','water','chemical-species','hydroxyl','reaction-channel','ionization',3,10]
cases=[base.copy()]
for i in [0,2,4,6]:
 d=base.copy();d[i]='wrong-family';cases.append(d)
d=base.copy();d[5]='water';cases.append(d)
for n,e in itertools.product(range(1,6),range(1,5)):
 d=base.copy();d[-2:]=[n,e];cases.append(d)
def original(d):return m.RadiolysisChannel(*[HeldLabel(d[i],d[i+1])for i in range(0,8,2)],PositiveCount(d[8]),PositiveCount(d[9]))
def label(h):return h.family+':'+h.label
def lean(d):return 'construct '+' '.join('(← heldLabel '+q(d[i])+' '+q(d[i+1])+')'for i in range(0,8,2))+' (← count '+str(d[8])+') (← count '+str(d[9])+')'
def ratio(f):return str(f.numerator)+'/'+str(f.denominator)
def display(row):return '|'.join([label(row.medium),label(row.reactant),label(row.product),label(row.channel),str(row.product_events.value),str(row.deposited_resource.value),ratio(row.yield_ratio)])
expected=[];lines=['import SFT.Chemistry.RadiolysisNetwork','open SFT.Chemistry.RadiolysisNetwork SFT.Physics.CapabilityValues','set_option maxRecDepth 10000','def lab (h : HeldLabel) := h.family++":"++h.label','def rat (r : Nat × Nat) := toString r.1++"/"++toString r.2','def showRow : Except String Channel → String',' | .error e => "error:"++e',' | .ok row => String.intercalate "|" [lab row.medium,lab row.reactant,lab row.product,lab row.channel,toString row.productEvents.value,toString row.depositedResource.value,rat (yieldRatio row)]','def showNetwork : Except String Network → String',' | .error e => "error:"++e',' | .ok .emptyOne => "EmptyOne"',' | .ok (.rows rows) => String.intercalate ";" (rows.map fun r => String.intercalate "|" [lab r.1,lab r.2.1,lab r.2.2.1,rat r.2.2.2.1,rat r.2.2.2.2])','def main : IO Unit := do']
for d in cases:
 try:out=display(original(d))
 except Exception as e:out='error:'+str(e)
 expected.append(out);lines.append(' IO.println (showRow (do '+lean(d)+'))')
networks=[[]]
for n in range(1,9):
 rows=[]
 for i in range(n):
  d=base.copy();d[5]='product'+str(i);d[7]='channel'+str(i);d[8:]=[i+1,i+7];rows.append(d)
 networks.append(rows)
for kind in ['repeat','medium']:
 rs=[x.copy()for x in networks[3]]
 if kind=='repeat':rs[1][7]=rs[0][7]
 else:rs[1][1]='another-medium'
 networks.append(rs)
for rs in networks:
 try:
  result=m.radiolysis_network(tuple(original(d)for d in rs));out='EmptyOne'if result is m.EMPTY_ONE else ';'.join('|'.join([label(x[0]),label(x[1]),label(x[2]),ratio(x[3]),ratio(x[4])])for x in result)
 except Exception as e:out='error:'+str(e)
 expected.append(out);lines.append(' IO.println (showNetwork (do let rows ← (do pure ['+','.join('(← '+lean(d)+')'for d in rs)+']); network rows))')
p=w/'RadiolysisParity1160.lean';p.write_text('\n'.join(lines)+'\n');env=dict(os.environ,LEAN_PATH=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean')+':'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');a=subprocess.run([sys.executable,'work/run_lean_guarded.py',str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'),'-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'radiolysis1160_core_parity.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-2000:];assert a.stdout.splitlines()==expected,[(i,x,y)for i,(x,y)in enumerate(zip(a.stdout.splitlines(),expected))if x!=y][:3]
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();(w/'radiolysis1160_core_report.json').write_text(json.dumps(dict(status='PASS',constructors=len(cases),networks=len(networks),native_sha256=H(r/'SFT/Chemistry/RadiolysisNetwork.lean'),source_sha256=H(w/'pinned1160/sft/chemistry/radiolysis_network_law_v1.py')),indent=2)+'\n');print('PASS',len(cases),'complete constructor/yield cases and',len(networks),'complete network cases')
