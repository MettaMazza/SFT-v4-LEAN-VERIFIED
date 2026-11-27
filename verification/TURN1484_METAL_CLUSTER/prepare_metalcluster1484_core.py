from pathlib import Path
import sys,json,dataclasses,importlib.util
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));p=w/'pinned_metalcluster1484/sft/chemistry/metal_cluster_bonding_law_v1.py';spec=importlib.util.spec_from_file_location('metalcluster_original1484',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def enc(x):
 if isinstance(x,m.HeldLabel):return dict(family=x.family,label=x.label)
 if isinstance(x,m.PositiveCount):return x.value
 if isinstance(x,m.EmptyOne):return dict(empty=x.identity)
 if dataclasses.is_dataclass(x):return {f.name:enc(getattr(x,f.name))for f in dataclasses.fields(x)}
 if isinstance(x,(list,tuple)):return [enc(y)for y in x]
 return x
q=lambda x:json.dumps(x,ensure_ascii=False);expected=[];calls=[]
def add(expr,fn):
 calls.append(expr)
 try:expected.append(dict(ok=enc(fn())))
 except Exception as e:expected.append(dict(error=str(e)))
def ll(x):return '⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
def ls(xs):return '['+','.join(ll(x)for x in xs)+']'
def cnt(x):return '(.emptyOne '+q(x.identity)+')'if isinstance(x,m.EmptyOne)else '(.count ⟨'+str(x.value)+',by decide⟩)'
def rel(r):return '⟨'+ll(r.left)+','+ll(r.right)+','+ll(r.mode)+','+ls(r.bridge_support)+'⟩'
def rels(rs):return '['+','.join(rel(r)for r in rs)+']'
modes=['direct-metal-bond','bridging-ligand-path','held-grouping-relation']
for mode in modes+['unknown']:
 for n in [m.EMPTY_ONE,m.EmptyOne('other'),m.PositiveCount(1),m.PositiveCount(3)]:
  add('result ((relation "L" "R" '+q(mode)+' '+cnt(n)+').map relationJSON)',lambda mode=mode,n=n:m.relation('L','R',mode,n))
for mode in modes:
 for k in range(2,8):
  cs=tuple('M'+str(i)for i in range(k));rs=tuple(m.relation(cs[i],cs[i+1],mode,m.PositiveCount(2)if mode==modes[1]else m.EMPTY_ONE)for i in range(k-1))[::-1]
  ce='['+','.join(map(q,cs))+']'
  expr='forced "entity" '+ce+' '+rels(rs)
  add('result (('+expr+').map clusterJSON)',lambda cs=cs,rs=rs:m.forced_cluster('entity',cs,rs))
  add('result ((do appendCentre (← '+expr+') "fresh" '+q(cs[-1])+' '+q(mode)+').map clusterJSON)',lambda cs=cs,rs=rs,mode=mode:m.append_centre(m.forced_cluster('entity',cs,rs),'fresh',cs[-1],mode))
r=m.relation('M1','M2',modes[0]);reverse=m.relation('M2','M1',modes[0]);outside=m.relation('O1','O2',modes[0]);outsideTouch=m.relation('M2','O1',modes[0]);br=m.relation('M1','M2',modes[1],m.PositiveCount(1))
for cs,rs in [((),()),(('M1',),()),(('M1','M1'),(r,)),(('M1','M2'),()),(('M1','M2','M3'),(r,)),(('M1','M2'),(r,reverse)),(('M1','M2'),(r,br)),(('M1','M2'),(r,outside)),(('M1','M2'),(r,outsideTouch)),(('M1','M2','M3'),(r,outsideTouch)),(('M2','M1'),(r,)),(('M1',''),(r,))]:
  add('result ((forced "entity" ['+','.join(map(q,cs))+'] '+rels(rs)+').map clusterJSON)',lambda cs=cs,rs=rs:m.forced_cluster('entity',cs,rs))
base=m.forced_cluster('d',('M1','M2'),(r,))
for label,anchor,mode in [('M1','M2',modes[0]),('M3','other',modes[0]),('M3','M2','other'),('M3','M2',modes[2])]:
 add('result ((do appendCentre (← direct) '+q(label)+' '+q(anchor)+' '+q(mode)+').map clusterJSON)',lambda label=label,anchor=anchor,mode=mode:m.append_centre(base,label,anchor,mode))
for left,right,mode,bridges in [(r.left,r.left,r.mode,()),(m.HeldLabel('other','M1'),r.right,r.mode,()),(r.left,r.right,m.HeldLabel('other',r.mode.label),()),(r.left,r.right,br.mode,()),(r.left,r.right,br.mode,(m.HeldLabel('other','bridge'),)),(r.left,r.right,r.mode,br.bridge_support),(r.left,r.right,br.mode,br.bridge_support*2)]:
 add('result ((makeRelation '+ll(left)+' '+ll(right)+' '+ll(mode)+' '+ls(bridges)+').map relationJSON)',lambda left=left,right=right,mode=mode,bridges=bridges:m.MetalCentreRelation(left,right,mode,bridges))
for n,d,b in [(1,m.PositiveCount(1),m.EMPTY_ONE),(2,m.EMPTY_ONE,m.EMPTY_ONE),(2,m.PositiveCount(1),m.EmptyOne('other')),(2,m.PositiveCount(1),m.PositiveCount(1))]:
 add('result ((cluster '+ll(base.entity)+' '+ls(base.centres)+' '+rels(base.relations)+' ⟨'+str(n)+',by decide⟩ '+cnt(d)+' '+cnt(b)+').map clusterJSON)',lambda n=n,d=d,b=b:m.ExactMetalCluster(base.entity,base.centres,base.relations,m.PositiveCount(n),d,b))
(w/'metalcluster1484_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
head='''import SFT.Chemistry.MetalCluster
import SFT.Host.Canonical
open SFT.Chemistry.MetalCluster SFT.Physics.CapabilityValues
set_option maxHeartbeats 20000000
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def labelsJSON (xs : List HeldLabel) : J := .array (xs.map labelJSON)
def countJSON : SFT.Chemistry.ElectronCountSpin.CountOrEmpty → J
 | .emptyOne identity => .object [("empty",.text identity)]
 | .count n => .integer (.ofNat n.value)
def relationJSON (r : Relation) : J := .object [("left",labelJSON r.left),("right",labelJSON r.right),("mode",labelJSON r.mode),("bridge_support",labelsJSON r.bridges)]
def clusterJSON (c : Cluster) : J := .object [("entity",labelJSON c.entity),("centres",labelsJSON c.centres),("relations",.array (c.relations.map relationJSON)),("centre_count",.integer (.ofNat c.centreCount.value)),("direct_bond_count",countJSON c.directCount),("bridge_path_count",countJSON c.bridgeCount)]
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
''';(w/'MetalClusterCoreProgram1484.lean').write_text(head+',\n'.join(calls)+']))\n');print(len(expected),'full original cases')
s=(w/'check_insertion1483_core.py').read_text().replace('insertion1483','metalcluster1484').replace('InsertionElimination','MetalCluster').replace('1483','1484').replace('PASS65','PASS'+str(len(expected)));(w/'check_metalcluster1484_core.py').write_text(s)
