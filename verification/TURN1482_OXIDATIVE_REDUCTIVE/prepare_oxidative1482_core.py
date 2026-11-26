from pathlib import Path
import sys,json,dataclasses,importlib.util
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));p=w/'pinned_oxidative1482/sft/chemistry/oxidative_addition_reductive_elimination_law_v1.py';spec=importlib.util.spec_from_file_location('oxidative_original1482',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def enc(x):
 if isinstance(x,m.HeldLabel):return dict(family=x.family,label=x.label)
 if isinstance(x,m.PositiveCount):return x.value
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
def ps(xs):return '['+','.join('('+ll(a)+','+ll(b)+')'for a,b in xs)+']'
for metals in [(),('M',),('M1','M2'),('M','M'),('M1','M2','M3'),('α',),('',),('M',''),('M','M','M','M')]:
 for x,y in [('X','Y'),('X','X'),('','Y'),('α','β')]:
  expr='oxidative ['+','.join(q(z)for z in metals)+'] '+q(x)+' '+q(y)
  add('result (('+expr+').map oxidativeJSON)',lambda metals=metals,x=x,y=y:m.oxidative_addition(metals,x,y))
  add('result ((do reductive (← '+expr+')).map reductiveJSON)',lambda metals=metals,x=x,y=y:m.reductive_elimination(m.oxidative_addition(metals,x,y)))
t=m.oxidative_addition(('M',),'X','Y');ms=t.metal_occurrences;cs=t.transferred_carriers;prod=t.product_incidences;d=t.held_direction
cases=[(ms,cs,cs,prod,(2,),d),((),cs,cs,prod,(2,),d),((m.HeldLabel('other','M'),),cs,cs,prod,(2,),d),(ms,(cs[0],cs[0]),cs,prod,(2,),d),(ms,(m.HeldLabel('other','X'),cs[1]),cs,prod,(2,),d),(ms,cs,cs[::-1],prod,(2,),d),(ms,cs,cs,prod[::-1],(2,),d),(ms,cs,cs,((m.HeldLabel('metal-occurrence','other'),cs[0]),prod[1]),(2,),d),(ms,cs,cs,prod,(1,1),d),(ms,cs,cs,prod,(2,),m.HeldLabel('other',d.label)),(ms,cs+(cs[0],),cs+(cs[0],),prod+(prod[0],),(2,),d),((ms[0],ms[0]),cs,cs,prod,(1,1),d)]
for metals,carriers,source,products,dist,direction in cases:
 ds='['+','.join('⟨'+str(n)+',by decide⟩'for n in dist)+']'
 add(f'result ((oxidativeTrace {ls(metals)} {ls(carriers)} {ls(source)} {ps(products)} {ds} {ll(direction)}).map oxidativeJSON)',lambda metals=metals,carriers=carriers,source=source,products=products,dist=dist,direction=direction:m.ExactOxidativeAdditionTrace(metals,carriers,source,products,tuple(m.PositiveCount(n)for n in dist),direction))
rd=m.HeldLabel('electron-transfer-orientation','two-incidences-to-metal-support')
for restored,removed,direction in [(cs,prod,rd),(cs[::-1],prod,rd),(cs,prod[::-1],rd),(cs,prod,m.HeldLabel('other',rd.label)),(cs,prod,m.HeldLabel(rd.family,'other'))]:
 add(f'result ((do reductiveTrace (← one) {ls(restored)} {ps(removed)} {ll(direction)}).map reductiveJSON)',lambda restored=restored,removed=removed,direction=direction:m.ExactReductiveEliminationTrace(t,restored,removed,direction))
(w/'oxidative1482_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
head='''import SFT.Chemistry.OxidativeReductive
import SFT.Host.Canonical
open SFT.Chemistry.OxidativeReductive SFT.Physics.CapabilityValues
set_option maxHeartbeats 20000000
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def labelsJSON (xs : List HeldLabel) : J := .array (xs.map labelJSON)
def productsJSON (xs : List (HeldLabel × HeldLabel)) : J := .array (xs.map fun (a,b) => .array [labelJSON a,labelJSON b])
def oxidativeJSON (t : OxidativeTrace) : J := .object [("metal_occurrences",labelsJSON t.metals),("transferred_carriers",labelsJSON t.carriers),("source_bond",labelsJSON t.sourceBond),("product_incidences",productsJSON t.products),("transfer_distribution",.array (t.distribution.map fun n => .integer (.ofNat n.value))),("held_direction",labelJSON t.direction)]
def reductiveJSON (t : ReductiveTrace) : J := .object [("oxidative_trace",oxidativeJSON t.oxidative),("restored_bond",labelsJSON t.restoredBond),("removed_product_incidences",productsJSON t.removedProducts),("held_direction",labelJSON t.direction)]
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''
(w/'OxidativeReductiveCoreProgram1482.lean').write_text(head+',\n'.join(calls)+']))\n');print(len(expected),'complete original cases')
s=(w/'check_electronaccount1481_core.py').read_text().replace('electronaccount1481','oxidative1482').replace('OrganometallicElectronAccount','OxidativeReductive').replace('1481','1482').replace('PASS264','PASS'+str(len(expected)));(w/'check_oxidative1482_core.py').write_text(s)
