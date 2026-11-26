from pathlib import Path
import sys,json,dataclasses,importlib.util
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));p=w/'pinned_colour1478/sft/chemistry/inorganic_colour_transition_law_v1.py';spec=importlib.util.spec_from_file_location('colour_original1478',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def enc(x):
 if isinstance(x,m.HeldLabel):return dict(family=x.family,label=x.label)
 if isinstance(x,m.PositiveCount):return x.value
 if dataclasses.is_dataclass(x):
  d={f.name:enc(getattr(x,f.name))for f in dataclasses.fields(x)}
  if isinstance(x,m.ExactSelectiveAbsorption):d.update(absorbed_count=enc(x.absorbed_count),retained_colour_count=enc(x.retained_colour_count))
  return d
 if isinstance(x,(list,tuple)):return [enc(y)for y in x]
 return x
q=lambda x:json.dumps(x,ensure_ascii=False);expected=[];calls=[]
def add(expr,fn):
 calls.append(expr)
 try:expected.append(dict(ok=enc(fn())))
 except Exception as e:expected.append(dict(error=str(e)))
add('result (classes.map (fun xs => .array (xs.map labelJSON)))',m.generate_complete_carrier_transition_classes)
for sc in ['ligand','metal']:
 for tc in ['ligand','metal']:
  for a in range(1,4):
   for b in range(1,4):
    add(f'result ((build "complex" {q(sc)} {q(tc)} "lower" "upper" ⟨{a},by decide⟩ ⟨{b},by decide⟩).map transitionJSON)',lambda sc=sc,tc=tc,a=a,b=b:m.build_exact_transition('complex',sc,tc,'lower','upper',m.PositiveCount(a),m.PositiveCount(b)))
for sc,tc,lo,hi in [('other','metal','a','b'),('ligand','other','a','b'),('metal','metal','same','same'),('ligand','metal','','b')]:
 add(f'result ((build "complex" {q(sc)} {q(tc)} {q(lo)} {q(hi)} ⟨1,by decide⟩ ⟨3,by decide⟩).map transitionJSON)',lambda sc=sc,tc=tc,lo=lo,hi=hi:m.build_exact_transition('complex',sc,tc,lo,hi,m.PositiveCount(1),m.PositiveCount(3)))
t=m.build_exact_transition('complex','ligand','metal','lower','upper',m.PositiveCount(1),m.PositiveCount(3));labels=[m.HeldLabel('observation-distinction',f'd-{i}')for i in range(1,5)]
for inc,absr in [([0,1],[0]),([0,1],[1]),([0,1,2],[1]),([0,1,2],[0,2]),([0,1,2],[]),([0,1,2],[0,1,2]),([0,0,1],[0]),([0,1,2],[0,0]),([0,1,2],[3]),([],[0])]:
 leanlabels=lambda ids:'['+','.join('⟨"observation-distinction",'+q(labels[i].label)+',by decide,by decide⟩'for i in ids)+']'
 add(f'result ((do let t ← witnessTransition; selective t {leanlabels(inc)} {leanlabels(absr)}).map absorptionJSON)',lambda inc=inc,absr=absr:m.forced_selective_absorption(t,tuple(labels[i]for i in inc),tuple(labels[i]for i in absr)))
(w/'colour1478_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
head='''import SFT.Chemistry.InorganicColour
import SFT.Host.Canonical
open SFT.Chemistry.InorganicColour SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def stateJSON (s : State) : J := .object [("complex_identity",labelJSON s.complexIdentity),("carrier_kind",labelJSON s.carrierKind),("state_identity",labelJSON s.stateIdentity),("order_position",.integer (.ofNat s.orderPosition.value))]
def transitionJSON (t : Transition) : J := .object [("source",stateJSON t.source),("target",stateJSON t.target),("positive_order_gap",.integer (.ofNat t.positiveOrderGap.value)),("transfer_class",labelJSON t.transferClass)]
def absorptionJSON (a : Absorption) : J := .object [("transition",transitionJSON a.transition),("incident_distinctions",.array (a.incident.map labelJSON)),("absorbed_distinctions",.array (a.absorbed.map labelJSON)),("retained_colour_distinctions",.array (a.retained.map labelJSON)),("absorbed_count",.integer (.ofNat (absorbedCount a).value)),("retained_colour_count",.integer (.ofNat (retainedCount a).value))]
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
''';(w/'InorganicColourCoreProgram1478.lean').write_text(head+',\n'.join(calls)+']))\n');print(len(expected),'complete original cases')
