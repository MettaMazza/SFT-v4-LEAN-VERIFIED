from pathlib import Path
import sys,json,itertools,hashlib
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1126/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import multicentre_support_law_v1 as v
cases=[];expected=[];q=lambda x:json.dumps(x,ensure_ascii=False)
def label(x):return [x.family,x.label]
def record(expr,fn):
 cases.append(expr)
 try:
  s=fn();expected.append({'ok':[label(s.molecular_carrier),label(s.topology),[label(c)for c in s.centres],[[label(e.left),label(e.right)]for e in s.edges],[label(c)for c in s.electron_support.cells],s.positive_centre_count.value,s.positive_edge_count.value,s.irreducible_to_one_localized_pair]})
 except (v.InadmissibleExactValue,IndexError)as e:expected.append({'error':str(e)})
for n in [3,4]:
 labels=tuple('c'+str(i)for i in range(n));pairs=list(itertools.combinations(range(n),2))
 for mask in range(1<<len(pairs)):
  selected=[p for i,p in enumerate(pairs)if mask&(1<<i)]
  for ps in [selected,list(reversed(selected))]:
   for tn,t in [('ribbon',v.RIBBON),('surface',v.SURFACE),('volume',v.VOLUME)]:
    expr='support "m" '+tn+' '+q(labels)+' ['+','.join('('+str(a)+','+str(b)+')'for a,b in ps)+']'
    record(expr,lambda:v._support('m',t,labels,tuple(ps)))
for labels in [(),('a',),('a','b'),('a','b','c'),('a','b','a'),('a','','c'),('a','b','c','d'),tuple('c'+str(i)for i in range(8))]:
 for native,fn in [('ribbonSupport',v.ribbon_support),('surfaceSupport',v.surface_cycle_support),('tetrahedralSupport',v.tetrahedral_volume_support)]:
  record(native+' "m" '+q(labels),lambda:fn('m',labels))
for ps in [[(0,1),(1,2),(2,0)],[(0,1),(1,0)],[(0,0)],[(0,3)],[(0,-1),(-1,1)],[(0,-4)]]:
 expr='support "m" ribbon ["a","b","c"] ['+','.join('('+str(a)+','+str(b)+')'for a,b in ps)+']';record(expr,lambda:v._support('m',v.RIBBON,('a','b','c'),tuple(ps)))
prefix='''import SFT.Chemistry.MulticentreSupport
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.MulticentreSupport
abbrev J := Canonical.Value
def labelValue (l : HeldLabel) : J := .array [.text l.family,.text l.label]
def output : Except String Support → J
 | .error e => .object [("error",.text e)]
 | .ok s => .object [("ok",.array [labelValue s.molecularCarrier,labelValue s.topology,
 .array (s.centres.map labelValue),.array (s.edges.map (fun e => .array [labelValue e.left,labelValue e.right])),
 .array (s.electronSupport.map labelValue),.integer (.ofNat s.centres.length),.integer (.ofNat s.edges.length),.boolean (irreducible s)])]
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
# Group the generated expressions to keep elaboration shallow; preserve exact case order.
chunks=[]
for i in range(0,len(cases),24):
 name='cases'+str(i);chunks.append(name);prefix+='def '+name+' : List (Except String Support) := ['+','.join(cases[i:i+24])+']\n'
prefix+='def main : IO Unit := do\n IO.println (Canonical.render (.object [("cases",.array (('+ '++'.join(chunks)+').map output)),("witnesses",.array ([bridgeWitness,cycleWitness,volumeWitness,localizedWitness,disconnectedWitness].map J.boolean))]))\n'
(w/'MulticentreProgram1126.lean').write_text(prefix);(w/'multicentre1126_expected.json').write_text(json.dumps(dict(cases=expected,witnesses=[x[2]for x in v.OPERATIONAL_WITNESSES])))
print('Prepared',len(cases),'exact original comparisons')
