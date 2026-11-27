from pathlib import Path
import json,sys,dataclasses,itertools
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned_aromatic1491/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.aromatic_recurrence_stability_law_v1 import *
from sft.chemistry.multicentre_support_law_v1 import ribbon_support
from sft.claim_evidence.fold_language import EmptyOne
from sft.engine.exact import HeldLabel,PositiveCount
q=lambda x:json.dumps(x,ensure_ascii=False);ls=lambda xs:'['+','.join(xs)+']';num=lambda n:'⟨'+str(n)+',by decide⟩'
def enc(x):
 if isinstance(x,PositiveCount):return x.value
 if isinstance(x,EmptyOne):return {'emptyOne':x.identity}
 if dataclasses.is_dataclass(x):return {f.name:enc(getattr(x,f.name))for f in dataclasses.fields(x)}
 if isinstance(x,(list,tuple)):return list(map(enc,x))
 return x
lab=lambda x:'⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
cell=lambda x:'('+lab(x[0])+','+lab(x[1])+')'
layer=lambda x:ls(map(cell,x))
def cycle(x):return '⟨'+','.join([lab(x.molecular_carrier),lab(x.topology),ls(map(lab,x.centres)),ls('⟨'+lab(e.left)+','+lab(e.right)+'⟩'for e in x.edges),ls(map(lab,x.electron_support.cells))])+'⟩'
def rec(x):return '⟨'+','.join([lab(x.molecular_carrier),cycle(x.cycle),ls(map(lab,x.boundary_fibres)),ls(map(layer,x.pair_cell_layers))])+'⟩'
expected=[];expr=[]
def add(fn,code,stable=False):
 try:
  v=fn()
  out=({'value':enc(v),'precedes':v.closed_recurrence_precedes_opened_reference}if stable else {'value':enc(v),'layer_count':v.positive_layer_count.value,'support_count':v.positive_support_count.value,'first_return':enc(v.first_return_trace),'missing_boundary':enc(v.missing_pair_cell_boundary),'closure':v.complete_registered_perturbation_closure})
  expected.append({'ok':out})
 except Exception as e:expected.append({'error':str(e)})
 expr.append(('emitStability'if stable else'emit')+' ('+code+')')
for k,n in itertools.product(range(0,9),range(1,5)):
 centres=tuple('C'+str(i)for i in range(k));add(lambda centres=centres,n=n:aromatic_recurrence('M',centres,PositiveCount(n)),'aromaticRecurrence "M" '+ls(map(q,centres))+' '+num(n))
for label,centres in [('',('A','B','C')),('M',('A','B','A')),('M',('','B','C')),('M',('α','β','γ'))]:add(lambda label=label,centres=centres:aromatic_recurrence(label,centres,PositiveCount(1)),'aromaticRecurrence '+q(label)+' '+ls(map(q,centres))+' '+num(1))
b=aromatic_recurrence('M',('A','B','C'),PositiveCount(1));one,two=b.boundary_fibres;complete=complete_ordered_pair_cells()
d0={f.name:getattr(b,f.name)for f in dataclasses.fields(b)};cases=[d0]
for key,values in [('molecular_carrier',[HeldLabel('wrong','M'),HeldLabel('molecular-carrier','other')]),('boundary_fibres',[(),(one,),(one,one),(two,one),(one,two,one),(one,two,HeldLabel('wrong','x'))]),('pair_cell_layers',[(),(complete[:3],),(complete[::-1],),(complete,complete),(complete,complete[:2])]),('cycle',[ribbon_support('M',('A','B','C'))])]:
 for v in values:cases.append(dict(d0,**{key:v}))
for d in cases:
 add(lambda d=d:ExactAromaticRecurrence(**d),'recurrence '+lab(d['molecular_carrier'])+' '+cycle(d['cycle'])+' '+ls(map(lab,d['boundary_fibres']))+' '+ls(map(layer,d['pair_cell_layers'])))
for n in [1,2,4]:
 r=aromatic_recurrence('M',('A','B','C'),PositiveCount(n));add(lambda r=r:append_complete_pair_layer(r),'appendLayer '+rec(r));add(lambda r=r:aromatic_stability_order(r),'aromaticStability '+rec(r),True)
closed=HeldLabel('molecular-energy-state','closed');opened=HeldLabel('molecular-energy-state','opened')
for a,o,n in [(closed,opened,1),(closed,closed,1),(closed,opened,2),(HeldLabel('wrong','closed'),opened,1),(closed,HeldLabel('wrong','opened'),1)]:add(lambda a=a,o=o,n=n:ExactAromaticStabilityOrder(b,a,o,PositiveCount(n)),'stability '+rec(b)+' '+lab(a)+' '+lab(o)+' '+num(n),True)
header='''import SFT.Chemistry.AromaticRecurrence
import SFT.Host.Canonical
open SFT.Chemistry SFT.Chemistry.AromaticRecurrence SFT.Physics.CapabilityValues SFT.Host
abbrev J := Canonical.Value
def labelJ (x : HeldLabel) : J := .object [("family",.text x.family),("label",.text x.label)]
def labels (xs : List HeldLabel) : J := .array (xs.map labelJ)
def cycleJ (s : MulticentreSupport.Support) : J := .object [("molecular_carrier",labelJ s.molecularCarrier),("topology",labelJ s.topology),("centres",labels s.centres),("edges",.array (s.edges.map fun e => .object [("left",labelJ e.left),("right",labelJ e.right)])),("electron_support",.object [("cells",labels s.electronSupport)])]
def recurrenceJ (r : Recurrence) : J := .object [("molecular_carrier",labelJ r.carrier),("cycle",cycleJ r.cycle),("boundary_fibres",labels r.boundary),("pair_cell_layers",.array (r.layers.map fun layer => .array (layer.map fun c => .array [labelJ c.1,labelJ c.2])))]
def emit (input : Except String Recurrence) : J := match (do
 let r ← input
 let trace ← firstReturnTrace r
 pure (Canonical.Value.object [("value",recurrenceJ r),("layer_count",.integer (.ofNat r.layers.length)),("support_count",.integer (.ofNat (supportSize r))),("first_return",labels trace),("missing_boundary",.object [("emptyOne",.text "empty-One")]),("closure",.boolean (perturbationClosure r))])) with
 | .error e => .object [("error",.text e)] | .ok value => .object [("ok",value)]
def emitStability : Except String Stability → J
 | .error e => .object [("error",.text e)]
 | .ok s => .object [("ok",.object [("value",.object [("recurrence",recurrenceJ s.recurrence),("closed_state",labelJ s.closed),("opened_reference_state",labelJ s.opened),("opening_transfer",.integer (.ofNat s.transfer.value))]),("precedes",.boolean (closedPrecedes s))])]
set_option maxHeartbeats 20000000
set_option maxRecDepth 20000
'''
(w/'AromaticRecurrenceCasesProgram1491.lean').write_text(header+'def main : IO Unit := IO.println (Canonical.render (.array ['+','.join(expr)+']))\n');(w/'aromatic1491_cases_expected.json').write_text(json.dumps(expected,ensure_ascii=False))
s=(w/'check_inorgnetwork1490_cases.py').read_text().replace('inorgnetwork1490','aromatic1491').replace('InorganicNetworkCasesProgram1490','AromaticRecurrenceCasesProgram1491').replace("['InorganicNetwork','InorganicNetworkBoundary']","['AromaticRecurrence']");(w/'check_aromatic1491_cases.py').write_text(s);print('Prepared',len(expected),'original recurrence/stability/property/guard cases')
