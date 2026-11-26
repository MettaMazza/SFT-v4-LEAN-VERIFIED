from pathlib import Path
import sys,json,dataclasses,importlib.util
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));p=w/'pinned_inorgmag1479/sft/chemistry/inorganic_magnetic_state_law_v1.py';spec=importlib.util.spec_from_file_location('inorgmag_original1479',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def enc(x):
 if isinstance(x,m.HeldLabel):return dict(family=x.family,label=x.label)
 if isinstance(x,m.PositiveCount):return x.value
 if isinstance(x,m.EmptyOne):return dict(empty=x.identity)
 if dataclasses.is_dataclass(x):
  d={f.name:enc(getattr(x,f.name))for f in dataclasses.fields(x)}
  if isinstance(x,m.CompleteUnpairedSupport):d.update(unpaired_count=enc(x.unpaired_count),spin_width=enc(x.spin_width))
  return d
 if isinstance(x,(list,tuple)):return [enc(y)for y in x]
 return x
q=lambda x:json.dumps(x,ensure_ascii=False);expected=[];calls=[]
def add(expr,fn):
 calls.append(expr)
 try:expected.append(dict(ok=enc(fn())))
 except Exception as e:expected.append(dict(error=str(e)))
for n in range(9):
 v=m.EMPTY_ONE if n==0 else m.PositiveCount(n)
 add(f'result ((complete "complex" (exactCount {n})).map supportJSON)',lambda v=v:m.complete_unpaired_support('complex',v))
 add(f'result ((do forced (← complete "complex" (exactCount {n}))).map stateJSON)',lambda v=v:m.forced_inorganic_magnetic_state(m.complete_unpaired_support('complex',v)))
 add(f'result ((do appendSuccessor (← complete "complex" (exactCount {n}))).map supportJSON)',lambda v=v:m.append_unpaired_successor(m.complete_unpaired_support('complex',v)))
 add(f'result ((do forced (← appendSuccessor (← complete "complex" (exactCount {n})))).map stateJSON)',lambda v=v:m.forced_inorganic_magnetic_state(m.append_unpaired_successor(m.complete_unpaired_support('complex',v))))
def label(f,n):return m.HeldLabel(f,n)
def leanlabel(x):return '⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
def leanlabels(xs):return '['+','.join(map(leanlabel,xs))+']'
c=label('coordination-entity','complex');e=label('electron-occurrence','e');f=label('electron-spin','fibre-a')
for cid,es,fs in [(label('wrong','complex'),[],[]),(c,[e],[]),(c,[e,e],[f,f]),(c,[label('other','e')],[f]),(c,[e],[label('electron-spin','invalid')]),(c,[e],[label('other','fibre-a')])]:
 add(f'result ((support {leanlabel(cid)} {leanlabels(es)} {leanlabels(fs)}).map supportJSON)',lambda cid=cid,es=es,fs=fs:m.CompleteUnpairedSupport(cid,tuple(es),tuple(fs)))
# Preserve the original duplicate rejection on custom occurrence names at the successor index.
custom=[label('electron-occurrence','unpaired-2')]
add(f'result ((do appendSuccessor (← support {leanlabel(c)} {leanlabels(custom)} {leanlabels([f])})).map supportJSON)',lambda:m.append_unpaired_successor(m.CompleteUnpairedSupport(c,tuple(custom),(f,))))
for n,moment,width,rf,rl,cf,cl in [(0,1,1,'held-field-relation','repelled-from-field','inorganic-magnetic-class','diamagnetic'),(1,1,3,'held-field-relation','drawn-into-field','inorganic-magnetic-class','paramagnetic'),(1,1,2,'wrong','drawn-into-field','inorganic-magnetic-class','paramagnetic'),(1,1,2,'held-field-relation','drawn-into-field','wrong','paramagnetic'),(0,0,1,'held-field-relation','drawn-into-field','inorganic-magnetic-class','paramagnetic'),(1,1,2,'held-field-relation','repelled-from-field','inorganic-magnetic-class','diamagnetic')]:
 rel=label(rf,rl);clab=label(cf,cl)
 add(f'result ((do magneticState (← complete "complex" (exactCount {n})) (exactCount {moment}) ⟨{width},by decide⟩ {leanlabel(rel)} {leanlabel(clab)}).map stateJSON)',lambda n=n,moment=moment,width=width,rel=rel,clab=clab:m.ExactInorganicMagneticState(m.complete_unpaired_support('complex',m.EMPTY_ONE if n==0 else m.PositiveCount(n)),m.EMPTY_ONE if moment==0 else m.PositiveCount(moment),m.PositiveCount(width),rel,clab))
(w/'inorgmag1479_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
head='''import SFT.Chemistry.InorganicMagneticState
import SFT.Host.Canonical
open SFT.Chemistry.InorganicMagneticState SFT.Physics.CapabilityValues
open SFT.Chemistry.ComplexSpinState (ExactCount exactCount)
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def countJSON : ExactCount → J
 | .empty identity => .object [("empty",.text identity)]
 | .positive p => .integer (.ofNat p.value)
def supportJSON (s : Support) : J := .object [("complex_identity",labelJSON s.complexIdentity),("electron_occurrences",.array (s.occurrences.map labelJSON)),("spin_fibres",.array (s.fibres.map labelJSON)),("unpaired_count",countJSON (unpairedCount s)),("spin_width",.integer (.ofNat (spinWidth s).value))]
def stateJSON (s : MagneticState) : J := .object [("support",supportJSON s.support),("moment_support",countJSON s.momentSupport),("spin_width",.integer (.ofNat s.spinWidth.value)),("field_relation",labelJSON s.fieldRelation),("magnetic_class",labelJSON s.magneticClass)]
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
''';(w/'InorganicMagneticStateCoreProgram1479.lean').write_text(head+',\n'.join(calls)+']))\n');print(len(expected),'complete original cases')
