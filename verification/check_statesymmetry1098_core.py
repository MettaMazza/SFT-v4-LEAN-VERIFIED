from pathlib import Path
import sys,json,os,subprocess,hashlib
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry.state_symmetry_law_v1 import symmetry_signature_from_source,build_equivalence_class,StateSymmetrySignature,FiniteStateEquivalenceClass
from sft.claim_evidence.fold_language import EmptyOne,EMPTY_ONE
from sft.engine.exact import PositiveCount,HeldLabel,InadmissibleExactValue
from sft.engine.canonical import canonical_value
q=lambda s:json.dumps(s,ensure_ascii=False)
cases=[('H2',m,symbol,'absence','absence','absence','absence')for m in range(1,13)for symbol in ['Σ','Π','Δ','Φ']]+[('NO',2,'Π','absence','absence','absence','r'),('H2',1,'Σ','g','plus-fibre','absence','absence'),('x',1,'invalid','absence','absence','absence','absence'),('',1,'Σ','absence','absence','absence','absence'),('x',1,'Σ','','absence','absence','absence')]
expected=[]
for molecule,m,symbol,inv,refl,comp,kind in cases:
 try:expected.append({'ok':canonical_value(build_equivalence_class(symmetry_signature_from_source(molecule,PositiveCount(m),symbol,inv,refl,comp,kind)))})
 except InadmissibleExactValue as e:expected.append({'error':str(e)})
code='''import SFT.Chemistry.StateSymmetry
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.StateSymmetry
def labelValue (x : HeldLabel) : Canonical.Value := .object [("family",.text x.family),("label",.text x.label)]
def countValue (x : PositiveCount) : Canonical.Value := .object [("value",.integer (.ofNat x.value))]
def rankValue : AxisRank → Canonical.Value
 | .emptyOne s => .object [("identity",.text s)]
 | .count c => countValue c
def optionalValue : OptionalLabel → Canonical.Value
 | .emptyOne s => .object [("identity",.text s)]
 | .held h => labelValue h
def signatureValue (s : Signature) : Canonical.Value := .object [
 ("molecular_carrier",labelValue s.molecularCarrier),("positive_spin_multiplicity",countValue s.multiplicity),
 ("axis_rank",rankValue s.axisRank),("positive_axis_orientation_count",countValue s.orientationCount),
 ("inversion_label",optionalValue s.inversion),("reflection_label",optionalValue s.reflection),
 ("axis_component",optionalValue s.axisComponent),("component_kind",optionalValue s.componentKind)]
def classValue (c : EquivalenceClass) : Canonical.Value := .object [
 ("signature",signatureValue c.signature),("component_occurrences",.array (c.occurrences.map labelValue))]
def resultValue : Except String EquivalenceClass → Canonical.Value
 | .error e => .object [("error",.text e)]
 | .ok c => .object [("ok",classValue c)]
def results : List Canonical.Value := [
'''
code+=',\n'.join('resultValue (fromSource '+q(mol)+' ⟨'+str(m)+',by decide⟩ '+' '.join(q(v)for v in [symbol,inv,refl,comp,kind])+' >>= buildClass)'for mol,m,symbol,inv,refl,comp,kind in cases)
code+='''\n]
def main : IO Unit := IO.println (Canonical.render (.array results))
'''
p=w/'StateSymmetryProgram1098.lean';p.write_text(code)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'statesymmetry1098_core_output.json').open('w')as out,(w/'statesymmetry1098_core_execution.log').open('w')as err:subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,stdout=out,stderr=err,check=True)
assert json.loads((w/'statesymmetry1098_core_output.json').read_text())==expected
(w/'statesymmetry1098_core_report.json').write_text(json.dumps(dict(status='PASS',source_constructor_cases=len(cases),component_classes=sum('ok'in x for x in expected),source_sha256=hashlib.sha256((r/'SFT/Chemistry/StateSymmetry.lean').read_bytes()).hexdigest(),scope='Source-symbol construction, signature fields and generated ordered component classes; direct constructor/equivalence adverse controls remain separate.'),indent=2)+'\n');print('PASS',len(cases),'source constructor/class cases')
