from pathlib import Path
import sys,json,dataclasses,importlib.util,itertools
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));p=w/'pinned_insertion1483/sft/chemistry/insertion_elimination_pathway_law_v1.py';spec=importlib.util.spec_from_file_location('insertion_original1483',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def enc(x):
 if isinstance(x,m.HeldLabel):return dict(family=x.family,label=x.label)
 if dataclasses.is_dataclass(x):return {f.name:enc(getattr(x,f.name))for f in dataclasses.fields(x)}
 if isinstance(x,(tuple,list)):return [enc(y)for y in x]
 return x
q=lambda x:json.dumps(x,ensure_ascii=False);expected=[];calls=[]
def add(expr,fn):
 calls.append(expr)
 try:expected.append(dict(ok=enc(fn())))
 except Exception as e:expected.append(dict(error=str(e)))
def ll(x):return '⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
def ls(xs):return '['+','.join(ll(x)for x in xs)+']'
def es(xs):return '['+','.join('('+ll(a)+','+ll(b)+')'for a,b in xs)+']'
for args in list(itertools.permutations(['X','Y','Z']))+[('X','X','Y'),('X','Z','X'),('','Z','Y'),('α','β','γ')]:
 arg=' '.join(map(q,args))
 add(f'result ((insertion {arg}).map traceJSON)',lambda args=args:m.insertion(*args))
 add(f'result ((do extrusion (← insertion {arg})).map traceJSON)',lambda args=args:m.extrusion(m.insertion(*args)))
 add(f'result ((migratory {arg}).map traceJSON)',lambda args=args:m.migratory_insertion(*args))
 add(f'result ((do extrusion (← migratory {arg})).map traceJSON)',lambda args=args:m.extrusion(m.migratory_insertion(*args)))
for args in [('A','B','X','Y'),('A','A','X','Y'),('A','B','X','X'),('A','A','X','X'),('A','X','A','X'),('B','A','Y','X'),('','B','X','Y'),('α','β','γ','δ')]:
 add('result ((elimination '+' '.join(map(q,args))+').map traceJSON)',lambda args=args:m.elimination(*args))
t=m.insertion('X','Z','Y');cs=t.carriers;bef=t.before;aft=t.after;cl=t.pathway_class;comp=t.composition
variants=[{},dict(carriers=cs+(cs[0],)),dict(carriers=cs[:1]),dict(before=((cs[0],cs[0]),)),dict(before=bef+bef),dict(after=aft+aft),dict(removed=()),dict(added=()),dict(removed=bef+bef),dict(added=aft+aft),dict(carriers=cs[:2]),dict(pathway_class=m.HeldLabel('other','insertion')),dict(composition=())]
for delta in variants:
 d=dict(carriers=cs,before=bef,after=aft,removed=bef,added=aft,pathway_class=cl,composition=comp);d.update(delta)
 add('result ((trace '+ls(d['carriers'])+' '+' '.join(es(d[k])for k in ['before','after','removed','added'])+' '+ll(d['pathway_class'])+' '+ls(d['composition'])+').map traceJSON)',lambda d=d:m.ExactAdjacencyTransformationTrace(**d))
for a,b in [(m.HeldLabel('a','z'),m.HeldLabel('b','a')),(m.HeldLabel('same','a'),m.HeldLabel('same','z')),(m.HeldLabel('same','α'),m.HeldLabel('same','β')),(m.HeldLabel('same','a'),m.HeldLabel('same','a'))]:
 add('result (.ok (edgeJSON (edge '+ll(a)+' '+ll(b)+')))',lambda a=a,b=b:m._edge(a,b))
(w/'insertion1483_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
head='''import SFT.Chemistry.InsertionElimination
import SFT.Host.Canonical
open SFT.Chemistry.InsertionElimination SFT.Physics.CapabilityValues
set_option maxHeartbeats 20000000
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def labelsJSON (xs : List HeldLabel) : J := .array (xs.map labelJSON)
def edgeJSON (p : Edge) : J := .array [labelJSON p.1,labelJSON p.2]
def edgesJSON (xs : List Edge) : J := .array (xs.map edgeJSON)
def traceJSON (t : Trace) : J := .object [("carriers",labelsJSON t.carriers),("before",edgesJSON t.before),("after",edgesJSON t.after),("removed",edgesJSON t.removed),("added",edgesJSON t.added),("pathway_class",labelJSON t.pathwayClass),("composition",labelsJSON t.composition)]
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''
(w/'InsertionEliminationCoreProgram1483.lean').write_text(head+',\n'.join(calls)+']))\n');print(len(expected),'full original cases')
s=(w/'check_oxidative1482_core.py').read_text().replace('oxidative1482','insertion1483').replace('OxidativeReductive','InsertionElimination').replace('1482','1483').replace('PASS89','PASS'+str(len(expected)));(w/'check_insertion1483_core.py').write_text(s)
