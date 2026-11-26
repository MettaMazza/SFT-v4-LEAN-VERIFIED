from pathlib import Path
import sys,json,dataclasses,importlib.util
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));p=w/'pinned_metalcarbon1480/sft/chemistry/organometallic_metal_carbon_bond_law_v1.py';spec=importlib.util.spec_from_file_location('metalcarbon_original1480',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
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
for n in range(1,7):
 add(f'result ((direct "M1" "C1" ⟨{n},by decide⟩).map incidenceJSON)',lambda n=n:m.direct_incidence('M1','C1',m.PositiveCount(n)))
 add(f'result ((do forceRows "entity" [← direct "M1" "C1" ⟨{n},by decide⟩]).map topologyJSON)',lambda n=n:m.forced_organometallic_bond('entity',(m.direct_incidence('M1','C1',m.PositiveCount(n)),)))
 add(f'result ((do appendDirect (← forceRows "entity" [← direct "M1" "C1" ⟨{n},by decide⟩]) (← direct "M1" "C2" ⟨{n},by decide⟩)).map topologyJSON)',lambda n=n:m.append_direct_incidence(m.forced_organometallic_bond('entity',(m.direct_incidence('M1','C1',m.PositiveCount(n)),)),m.direct_incidence('M1','C2',m.PositiveCount(n))))
for identity in ['empty-One','custom-absence']:
 add(f'result ((forced "" (.empty {q(identity)})).map bondJSON)',lambda identity=identity:m.forced_organometallic_bond('',m.EmptyOne(identity)))
add('result ((forced "entity" (.rows [])).map bondJSON)',lambda:m.forced_organometallic_bond('entity',()))
def lab(f,n):return m.HeldLabel(f,n)
def ll(x):return '⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
def lls(xs):return '['+','.join(map(ll,xs))+']'
c=lab('organometallic-centre-occurrence','M1');a=lab('carbon-occurrence','C1');e=lab('held-bond-electron','e')
for cc,aa,es in [(lab('other','M1'),a,[e]),(c,lab('other','C1'),[e]),(c,a,[]),(c,a,[lab('other','e')]),(c,a,[e,e])]:
 add(f'result ((incidence {ll(cc)} {ll(aa)} {lls(es)}).map incidenceJSON)',lambda cc=cc,aa=aa,es=es:m.DirectMetalCarbonIncidence(cc,aa,tuple(es)))
row=m.direct_incidence('M1','C1',m.PositiveCount(2));row2=m.direct_incidence('M1','C2',m.PositiveCount(2));other=m.direct_incidence('M1','C1',m.PositiveCount(3))
for entity,rows,n,cl in [(lab('wrong','entity'),[row],1,lab('chemical-class','organometallic')),(lab('chemical-entity','entity'),[],1,lab('chemical-class','organometallic')),(lab('chemical-entity','entity'),[row,row2],1,lab('chemical-class','organometallic')),(lab('chemical-entity','entity'),[row,other],2,lab('chemical-class','organometallic')),(lab('chemical-entity','entity'),[row],1,lab('other','organometallic')),(lab('chemical-entity','entity'),[row],1,lab('chemical-class','other'))]:
 incs='['+','.join('(← direct '+q(z.centre.label)+' '+q(z.carbon_occurrence.label)+' ⟨'+str(len(z.electron_support))+',by decide⟩)'for z in rows)+']'
 add(f'result ((do topology {ll(entity)} {incs} ⟨{n},by decide⟩ {ll(cl)}).map topologyJSON)',lambda entity=entity,rows=rows,n=n,cl=cl:m.ExactOrganometallicBondTopology(entity,tuple(rows),m.PositiveCount(n),cl))
add('result ((do appendDirect (← first) (← direct "M1" "C1" ⟨3,by decide⟩)).map topologyJSON)',lambda:m.append_direct_incidence(m.forced_organometallic_bond('one',(row,)),other))
(w/'metalcarbon1480_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
head='''import SFT.Chemistry.OrganometallicBond
import SFT.Host.Canonical
open SFT.Chemistry.OrganometallicBond SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def incidenceJSON (i : Incidence) : J := .object [("centre",labelJSON i.centre),("carbon_occurrence",labelJSON i.carbon),("electron_support",.array (i.electrons.map labelJSON))]
def topologyJSON (t : Topology) : J := .object [("entity",labelJSON t.entity),("incidences",.array (t.incidences.map incidenceJSON)),("direct_incidence_count",.integer (.ofNat t.directCount.value)),("classification",labelJSON t.classification)]
def bondJSON : BondSupport → J
 | .empty identity => .object [("empty",.text identity)]
 | .positive t => topologyJSON t
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
''';(w/'OrganometallicBondCoreProgram1480.lean').write_text(head+',\n'.join(calls)+']))\n');print(len(expected),'complete original cases')
