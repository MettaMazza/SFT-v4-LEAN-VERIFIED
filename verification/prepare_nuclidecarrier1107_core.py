from pathlib import Path
import sys,json,importlib.util,itertools
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));p=w/'pinned1107/sft/chemistry/nuclide_chemical_carrier_law_v1.py';sp=importlib.util.spec_from_file_location('nuclide_carrier_original1107',p);m=importlib.util.module_from_spec(sp);sys.modules[sp.name]=m;sp.loader.exec_module(m)
from sft.engine.exact import HeldLabel,PositiveCount
cases=[];expected=[]
for bits in itertools.product([False,True],repeat=4):
 for nucleons,occ in itertools.product([1,90],[1,2]):
  families=[good if b else 'erased'for b,good in zip(bits,['element','nuclear-state','chemical-species','chemical-phase'])];cases.append([families,nucleons,occ])
  try:
   r=m.NuclideChemicalCarrier(HeldLabel(families[0],'strontium'),PositiveCount(nucleons),HeldLabel(families[1],'held'),HeldLabel(families[2],'solution-carrier'),HeldLabel(families[3],'aqueous'),PositiveCount(occ))
   result={'ok':[[r.element.family,r.element.label],r.nucleon_count.value,[r.nuclear_state.family,r.nuclear_state.label],[r.species.family,r.species.label],[r.phase.family,r.phase.label],r.occurrence.value]}
  except ValueError as e:result={'error':str(e)}
  expected.append(result)
(w/'nuclidecarrier1107_expected.json').write_text(json.dumps({'cases':expected,'witnesses':[x[2]for x in m.OPERATIONAL_WITNESSES]},indent=2)+'\n');q=lambda x:json.dumps(x,ensure_ascii=False)
s='''import SFT.Chemistry.NuclideChemicalCarrier
open SFT.Host SFT.Host.Canonical SFT.Physics.CapabilityValues SFT.Chemistry.NuclideChemicalCarrier
'''
s+='def cases : List (List String × Nat × Nat) := ['+','.join('(['+','.join(q(f)for f in fam)+'],'+str(n)+','+str(o)+')'for fam,n,o in cases)+']\n'
s+='''def label (x : HeldLabel) : SFT.Host.Canonical.Value := .array [.text x.family,.text x.label]
def encode (r : Carrier) : SFT.Host.Canonical.Value := .array [label r.element,.integer (.ofNat r.nucleonCount.value),label r.nuclearState,
 label r.species,label r.phase,.integer (.ofNat r.occurrence.value)]
def runCase (data : List String × Nat × Nat) : SFT.Host.Canonical.Value :=
 let result := do
  let f := data.1
  construct (← heldLabel (f[0]!) "strontium") (← count data.2.1) (← heldLabel (f[1]!) "held")
   (← heldLabel (f[2]!) "solution-carrier") (← heldLabel (f[3]!) "aqueous") (← count data.2.2)
 match result with
 | .ok r => .object [("ok",encode r)]
 | .error e => .object [("error",.text e)]
def main : IO Unit := IO.println (render (.object [("cases",.array (cases.map runCase)),
 ("witnesses",.array ([elementWitness,nuclideWitness,stateWitness,speciesWitness,phaseWitness,occurrenceWitness,distinctWitness,successorWitness].map SFT.Host.Canonical.Value.boolean))]))
'''
(w/'NuclideCarrierProgram1107.lean').write_text(s);print('Prepared64 original constructor cases and8 original operational witnesses.')
