from pathlib import Path
import json,sys,dataclasses,itertools
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__.insert(0,str((w/'pinned_antiaromatic1492/sft/chemistry').resolve()))
from sft.chemistry import antiaromatic_nonaromatic_distinction_law_v1 as v
from sft.chemistry.aromatic_recurrence_stability_law_v1 import aromatic_recurrence,complete_ordered_pair_cells
from sft.engine.exact import HeldLabel,PositiveCount
from sft.claim_evidence.fold_language import EmptyOne,EMPTY_ONE
q=lambda x:json.dumps(x,ensure_ascii=False);ls=lambda xs:'['+','.join(xs)+']';num=lambda n:'⟨'+str(n)+',by decide⟩'
def enc(x):
 if isinstance(x,PositiveCount):return x.value
 if isinstance(x,EmptyOne):return {'emptyOne':x.identity}
 if dataclasses.is_dataclass(x):return {f.name:enc(getattr(x,f.name))for f in dataclasses.fields(x)}
 if isinstance(x,(list,tuple)):return list(map(enc,x))
 return x
lab=lambda x:'⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
cell=lambda x:'('+lab(x[0])+','+lab(x[1])+')';layer=lambda x:ls(map(cell,x))
def cycle(x):return '⟨'+','.join([lab(x.molecular_carrier),lab(x.topology),ls(map(lab,x.centres)),ls('⟨'+lab(e.left)+','+lab(e.right)+'⟩'for e in x.edges),ls(map(lab,x.electron_support.cells))])+'⟩'
def support(x):return '(.emptyOne '+q(x.identity)+')'if isinstance(x,EmptyOne)else '(.positive '+num(x.value)+')'
def args(d):return ' '.join([lab(d['molecular_carrier']),cycle(d['cycle']),lab(d['geometry_state']),lab(d['support_state']),lab(d['recurrence_class']),support(d['recurrence_support']),ls(map(layer,d['complete_pair_cell_layers']))])
def alt(a):return '⟨'+','.join([lab(a.molecular_carrier),cycle(a.cycle),lab(a.geometry_state),lab(a.support_state),lab(a.recurrence_class),support(a.recurrence_support),ls(map(layer,a.complete_pair_cell_layers))])+'⟩'
expected=[];expr=[]
def add(fn,code,kind='emit'):
 try:expected.append({'ok':enc(fn())})
 except Exception as e:expected.append({'error':str(e)})
 expr.append(kind+' ('+code+')')
for k in range(9):
 cs=tuple('C'+str(i)for i in range(k));add(lambda cs=cs:v.same_cycle_census('M',cs),'census "M" '+ls(map(q,cs)),'emitRows')
for name,cs in [('',('a','b','c')),('M',('a','a','b')),('M',('α','β','γ'))]:add(lambda name=name,cs=cs:v.same_cycle_census(name,cs),'census '+q(name)+' '+ls(map(q,cs)),'emitRows')
base=v.same_cycle_census('M',('a','b','c','d'));cy=base[0].cycle
for row in base:add(lambda row=row:v.append_complete_layer(row),'appendLayer '+alt(row))
for n in range(1,7):
 rec=aromatic_recurrence('M',('a','b','c','d'),PositiveCount(n));a=v.aromatic_alternative(rec);f=v.antiaromatic_alternative(cy,PositiveCount(n))
 add(lambda n=n:v.antiaromatic_alternative(cy,PositiveCount(n)),'antiaromaticAlternative '+cycle(cy)+' '+num(n))
 add(lambda a=a:v.append_complete_layer(a),'appendLayer '+alt(a));add(lambda f=f:v.append_complete_layer(f),'appendLayer '+alt(f))
for p,c in itertools.product([False,True],repeat=2):add(lambda p=p,c=c:v.nonaromatic_alternative(cy,break_plane=p,break_conjugation=c),'nonaromaticAlternative '+cycle(cy)+' '+str(p).lower()+' '+str(c).lower())
for row in base:
 d={f.name:getattr(row,f.name)for f in dataclasses.fields(row)};cases=[d]
 changes={'molecular_carrier':[HeldLabel('wrong','M'),HeldLabel('molecular-carrier','other')],'geometry_state':[v.COMPLETE_PLANE,v.BROKEN_PLANE,HeldLabel('wrong','x')],'support_state':[v.COMPLETE_CONJUGATION,v.BROKEN_CONJUGATION,HeldLabel('wrong','x')],'recurrence_class':[v.AROMATIC,v.ANTIAROMATIC,v.NONAROMATIC,HeldLabel('wrong','x')],'recurrence_support':[EMPTY_ONE,EmptyOne('other'),PositiveCount(1),PositiveCount(4),PositiveCount(6),PositiveCount(8)],'complete_pair_cell_layers':[(),(complete_ordered_pair_cells(),),(complete_ordered_pair_cells()[:3],),(complete_ordered_pair_cells(),)*2]}
 for key,vs in changes.items():
  for value in vs:cases.append(dict(d,**{key:value}))
 for data in cases:add(lambda data=data:v.ExactSameCycleAlternative(**data),'alternative '+args(data))
for rows in [(),base[:1],base[:2],base,base[::-1],base+(base[0],), (base[0],base[1],v.same_cycle_census('X',('a','b','c','d'))[2])]:add(lambda rows=rows:v.same_cycle_stability_order(rows),'censusOrder '+ls(map(alt,rows)),'emitOrder')
for x,y in [(1,1),(1,2),(2,1)]:add(lambda x=x,y=y:v.ExactSameCycleStabilityOrder(*base,PositiveCount(x),PositiveCount(y)),'stabilityOrder '+' '.join(map(alt,base))+' '+num(x)+' '+num(y),'emitOrder')
old=(w/'AromaticRecurrenceCasesProgram1491.lean').read_text();header=old[:old.index('def recurrenceJ')].replace('SFT.Chemistry.AromaticRecurrence','SFT.Chemistry.AntiaromaticDistinction')
header+='''def supportJ : RecurrenceSupport → J
 | .emptyOne s => .object [("emptyOne",.text s)] | .positive n => .integer (.ofNat n.value)
def altJ (a : Alternative) : J := .object [("molecular_carrier",labelJ a.carrier),("cycle",cycleJ a.cycle),("geometry_state",labelJ a.geometry),("support_state",labelJ a.supportState),("recurrence_class",labelJ a.recurrenceClass),("recurrence_support",supportJ a.recurrenceSupport),("complete_pair_cell_layers",.array (a.layers.map fun layer => .array (layer.map fun c => .array [labelJ c.1,labelJ c.2])))]
def emit : Except String Alternative → J
 | .error e => .object [("error",.text e)] | .ok a => .object [("ok",altJ a)]
def emitRows : Except String (List Alternative) → J
 | .error e => .object [("error",.text e)] | .ok a => .object [("ok",.array (a.map altJ))]
def emitOrder : Except String StabilityOrder → J
 | .error e => .object [("error",.text e)]
 | .ok s => .object [("ok",.object [("aromatic",altJ s.aromatic),("nonaromatic",altJ s.nonaromatic),("antiaromatic",altJ s.antiaromatic),("aromatic_to_nonaligned_transfer",.integer (.ofNat s.firstTransfer.value)),("nonaligned_to_frustrated_transfer",.integer (.ofNat s.secondTransfer.value))])]
set_option maxHeartbeats 20000000
set_option maxRecDepth 20000
'''
(w/'AntiaromaticCasesProgram1492.lean').write_text(header+'def main : IO Unit := IO.println (Canonical.render (.array ['+','.join(expr)+']))\n');(w/'antiaromatic1492_cases_expected.json').write_text(json.dumps(expected))
s=(w/'check_aromatic1491_cases.py').read_text().replace('aromatic1491','antiaromatic1492').replace('AromaticRecurrenceCasesProgram1491','AntiaromaticCasesProgram1492').replace("['AromaticRecurrence']","['AntiaromaticDistinction']");(w/'check_antiaromatic1492_cases.py').write_text(s);print('Prepared',len(expected),'original operation cases')
