from pathlib import Path
import sys,json,dataclasses,importlib.util
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));p=w/'pinned_electronaccount1481/sft/chemistry/organometallic_electron_accounting_law_v1.py';spec=importlib.util.spec_from_file_location('electronaccount_original1481',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
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
def rows(xs):return '['+','.join('['+','.join(ll(x)for x in pair)+']'for pair in xs)+']'
def support(xs):return '(.empty '+q(xs.identity)+')' if isinstance(xs,m.EmptyOne)else '(.rows '+rows(xs)+')'
for stem in ['bond','nonbonded','α']:
 for n in range(1,11):
  add(f'result ((completePairs {q(stem)} ⟨{n},by decide⟩).map pairsJSON)',lambda stem=stem,n=n:m.complete_pairs(stem,m.PositiveCount(n)))
for n in range(10):
 for k in range(10-n):
  nb=m.complete_pairs('nonbonded',m.PositiveCount(n))if n else m.EMPTY_ONE
  bd=m.complete_pairs('bond',m.PositiveCount(k))if k else m.EMPTY_ONE
  add(f'result ((forced "entity" {support(nb)} {support(bd)}).map resultJSON)',lambda nb=nb,bd=bd:m.forced_electron_account('entity',nb,bd))
  if n+k:
   a=m.forced_electron_account('entity',nb,bd)
   for dest in ['nonbonded','bond','wrong']:
    add(f'result ((do appendPair (← forcePositive "entity" {support(nb)} {support(bd)}) {q(dest)}).map accountJSON)',lambda a=a,dest=dest:m.append_pair(a,dest))
for nb,bd in [(m.EMPTY_ONE,m.EmptyOne('other')), ((),()), (m.EMPTY_ONE,()), ((),m.EMPTY_ONE),(m.complete_pairs('same',m.PositiveCount(1)),m.complete_pairs('same',m.PositiveCount(1))),(m.EMPTY_ONE,m.complete_pairs('bond',m.PositiveCount(10)))]:
 add(f'result ((forced "" {support(nb)} {support(bd)}).map resultJSON)',lambda nb=nb,bd=bd:m.forced_electron_account('',nb,bd))
pair=m.complete_pairs('bond',m.PositiveCount(1))[0];e=m.HeldLabel('organometallic-entity','entity');r=m.HeldLabel('capacity-relation','capacity-incomplete');mag=m.HeldLabel('magnetic-class','diamagnetic')
cases=[(e,((pair[0],),),2,18,r,mag),(e,((pair[0],pair[0]),),2,18,r,mag),(e,((m.HeldLabel('other','x'),m.HeldLabel('other','x')),),2,18,r,mag),(e,(pair,pair),4,18,r,mag),(e,(pair,),3,18,r,mag),(e,(pair,),2,17,r,mag),(e,(pair,),2,18,m.HeldLabel('capacity-relation','capacity-complete'),mag),(e,(pair,),2,18,r,m.HeldLabel('magnetic-class','other')),(m.HeldLabel('other','entity'),(pair,),2,18,r,mag),(e,(),2,18,r,mag),(e,((m.HeldLabel('other','x'),m.HeldLabel('different','x')),),2,18,r,mag)]
for e,ps,n,c,r,mag in cases:
 add(f'result ((account {ll(e)} (.empty "empty-One") (.rows {rows(ps)}) ⟨{n},by decide⟩ ⟨{c},by decide⟩ {ll(r)} {ll(mag)}).map accountJSON)',lambda e=e,ps=ps,n=n,c=c,r=r,mag=mag:m.ExactOrganometallicElectronAccount(e,m.EMPTY_ONE,ps,m.PositiveCount(n),m.PositiveCount(c),r,mag))
(w/'electronaccount1481_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
head='''import SFT.Chemistry.OrganometallicElectronAccount
import SFT.Host.Canonical
open SFT.Chemistry.OrganometallicElectronAccount SFT.Physics.CapabilityValues
set_option maxHeartbeats 20000000
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def pairsJSON (xs : List (List HeldLabel)) : J := .array (xs.map fun pair => .array (pair.map labelJSON))
def supportJSON : PairSupport → J
 | .empty identity => .object [("empty",.text identity)]
 | .rows xs => pairsJSON xs
def accountJSON (a : Account) : J := .object [("entity",labelJSON a.entity),("nonbonded_pairs",supportJSON a.nonbonded),("bond_pairs",supportJSON a.bond),("complete_electron_count",.integer (.ofNat a.electronCount.value)),("capacity",.integer (.ofNat a.capacity.value)),("capacity_relation",labelJSON a.relation),("magnetic_class",labelJSON a.magneticClass)]
def resultJSON : Result → J
 | .empty identity => .object [("empty",.text identity)]
 | .positive a => accountJSON a
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''
(w/'OrganometallicElectronAccountCoreProgram1481.lean').write_text(head+',\n'.join(calls)+']))\n');print(len(expected),'complete original cases')
s=(w/'check_metalcarbon1480_core.py').read_text().replace('metalcarbon1480','electronaccount1481').replace('OrganometallicBond','OrganometallicElectronAccount').replace('1480','1481').replace('PASS33','PASS'+str(len(expected)))
(w/'check_electronaccount1481_core.py').write_text(s)
