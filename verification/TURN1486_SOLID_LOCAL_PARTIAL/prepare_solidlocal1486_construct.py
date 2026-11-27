from pathlib import Path
import sys,json,dataclasses,itertools
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned_solidlocal1485/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.solid_state_local_coordination_law_v1 import *
from sft.engine.exact import HeldLabel,PositiveCount
from sft.claim_evidence.fold_language import EmptyOne,EMPTY_ONE
H=lambda family,label:HeldLabel(family,label)
q=lambda x:json.dumps(x,ensure_ascii=False)
def hl(x):return '⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
def ls(xs,enc):return '['+','.join(map(enc,xs))+']'
def n(v):return '⟨'+str(v)+',by decide⟩'
def formula(fs):return ls(fs,lambda f:'⟨'+hl(f.species)+','+n(f.primitive_count.value)+'⟩')
def constituent(x):return '.emptyOne '+q(x.identity) if isinstance(x,EmptyOne) else '.support '+ls(x,hl)
def encode(x):
 if isinstance(x,PositiveCount):return x.value
 if isinstance(x,EmptyOne):return {'emptyOne':x.identity}
 if dataclasses.is_dataclass(x):return {f.name:encode(getattr(x,f.name))for f in dataclasses.fields(x)}
 if isinstance(x,(list,tuple)):return [encode(z)for z in x]
 return x
base=dict(motif=H('local-solid-motif','AB'),occurrences=(H('species-occurrence','A#1'),H('species-occurrence','A#2'),H('species-occurrence','B#1'),H('species-occurrence','B#2')),repeat_axes=(H('generated-repeat-axis','axis-1'),H('generated-repeat-axis','axis-2')),constituent_support=EMPTY_ONE,chemistry_scope=H('ownership','composition-and-local-bonding'),bulk_handoff=H('ownership-handoff','materials-bulk-response'))
base['formula']=primitive_formula(base['occurrences']);base['local_bonds']=((base['occurrences'][0],base['occurrences'][2]),(base['occurrences'][1],base['occurrences'][3]))
fixtures=[]
for a,b,rank in itertools.product(range(1,4),range(1,4),range(1,5)):
 d=base.copy();d['occurrences']=tuple(H('species-occurrence',f'{s}#{i+1}')for s,k in [('A',a),('B',b)]for i in range(k));d['formula']=primitive_formula(d['occurrences']);d['local_bonds']=((d['occurrences'][0],d['occurrences'][a]),);d['repeat_axes']=tuple(H('generated-repeat-axis',f'axis-{i+1}')for i in range(rank));fixtures.append((d,None))
for key,values in [
 ('motif',[H('wrong','AB')]),('occurrences',[(),base['occurrences']+base['occurrences'][:1],(H('wrong','A#1'),)]),
 ('formula',[(),(FormulaEntry(H('chemical-species','A'),PositiveCount(2)),FormulaEntry(H('chemical-species','B'),PositiveCount(2)))]),
 ('repeat_axes',[(),(base['repeat_axes'][0],)*2,(H('wrong','axis-1'),)]),
 ('local_bonds',[(),base['local_bonds']+base['local_bonds'][:1],((base['occurrences'][0],base['occurrences'][0]),),((base['occurrences'][0],H('species-occurrence','Z#1')),),base['local_bonds']+((base['occurrences'][2],base['occurrences'][0]),)]),
 ('constituent_support',[(),EmptyOne('other-empty'),(H('second-constituent-occurrence','guest-1'),),(H('wrong','guest-1'),)]),
 ('chemistry_scope',[H('ownership','other')]),('bulk_handoff',[H('ownership-handoff','other')])]:
 for value in values:d=base.copy();d[key]=value;fixtures.append((d,None))
for species in ['A','B','C','α','A#1']:
 for anchor in [base['occurrences'][0],H('species-occurrence','Z#1')]:fixtures.append((base,(species,anchor)))
expected=[];expr=[]
for d,append in fixtures:
 try:
  out=ExactSolidStateLocalChemistry(**d)
  if append:out=append_occurrence(out,*append)
  expected.append({'ok':encode(out)})
 except Exception as e:expected.append({'error':str(e)})
 body='solid '+hl(d['motif'])+' '+ls(d['occurrences'],hl)+' '+ls(d['local_bonds'],lambda e:'('+hl(e[0])+','+hl(e[1])+')')+' '+formula(d['formula'])+' '+ls(d['repeat_axes'],hl)+' ('+constituent(d['constituent_support'])+') '+hl(d['chemistry_scope'])+' '+hl(d['bulk_handoff'])
 if append:body='do let s ← '+body+'; appendOccurrence s '+q(append[0])+' '+hl(append[1])
 expr.append('encode ('+body+')')
source='''import SFT.Chemistry.SolidLocal
import Lean
open SFT.Chemistry.SolidLocal SFT.Physics.CapabilityValues SFT.Host
abbrev J := Canonical.Value
def label (x : HeldLabel) : J := .object [("family",.text x.family),("label",.text x.label)]
def encode (x : Except String Solid) : J := match x with
 | .error e => .object [("error",.text e)]
 | .ok s => .object [("ok",.object [
 ("motif",label s.motif),("occurrences",.array (s.occurrences.map label)),
 ("local_bonds",.array (s.localBonds.map fun e => .array [label e.1,label e.2])),
 ("formula",.array (s.formula.map fun f => .object [("species",label f.species),("primitive_count",.integer (.ofNat f.primitiveCount.value))])),
 ("repeat_axes",.array (s.repeatAxes.map label)),
 ("constituent_support",match s.constituent with | .emptyOne identity => .object [("emptyOne",.text identity)] | .support xs => .array (xs.map label)),
 ("chemistry_scope",label s.chemistryScope),("bulk_handoff",label s.bulkHandoff)])]
def main : IO Unit := IO.println (Canonical.render (.array ['''+','.join(expr)+''']))
'''
(w/'SolidLocalConstructProgram1486.lean').write_text(source)
(w/'solidlocal1486_construct_expected.json').write_text(json.dumps(expected,ensure_ascii=False)+'\n')
s=(w/'check_solidlocal1486_formula.py').read_text().replace('solidlocal1486_formula','solidlocal1486_construct').replace('SolidLocalFormulaProgram1486','SolidLocalConstructProgram1486');(w/'check_solidlocal1486_construct.py').write_text(s)
print('Prepared',len(fixtures),'complete constructor/successor comparisons')
