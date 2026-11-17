from pathlib import Path
import sys,json,subprocess,os
from dataclasses import replace
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry.state_symmetry_law_v1 import StateSymmetrySignature,FiniteStateEquivalenceClass,equivalent
from sft.claim_evidence.fold_language import EMPTY_ONE,EmptyOne
from sft.engine.exact import PositiveCount,HeldLabel,InadmissibleExactValue
from sft.engine.canonical import canonical_value
q=lambda s:json.dumps(s,ensure_ascii=False)
base=dict(molecular_carrier=HeldLabel('molecular-carrier','NO'),positive_spin_multiplicity=PositiveCount(2),axis_rank=PositiveCount(1),positive_axis_orientation_count=PositiveCount(2),inversion_label=EMPTY_ONE,reflection_label=EMPTY_ONE,axis_component=EMPTY_ONE,component_kind=EMPTY_ONE)
raws=[base,dict(base,axis_rank=EMPTY_ONE,positive_axis_orientation_count=PositiveCount(1)),dict(base,axis_rank=EMPTY_ONE),dict(base,positive_axis_orientation_count=PositiveCount(1)),dict(base,axis_rank=PositiveCount(7)),dict(base,axis_rank=EmptyOne('other'),positive_axis_orientation_count=PositiveCount(3)),dict(base,molecular_carrier=HeldLabel('wrong','NO'))]
for field,family in [('inversion_label','inversion-symmetry'),('reflection_label','reflection-symmetry'),('axis_component','axis-component'),('component_kind','component-kind')]:
 raws += [dict(base,**{field:HeldLabel('wrong','x')}),dict(base,**{field:HeldLabel(family,'x')}),dict(base,**{field:EmptyOne('other')})]

def expr(raw):
 carrier=raw['molecular_carrier'];lines=['let carrier ← heldLabel '+q(carrier.family)+' '+q(carrier.label)]
 for native,source in [('iv','inversion_label'),('rf','reflection_label'),('ac','axis_component'),('ck','component_kind')]:
  v=raw[source]
  if isinstance(v,EmptyOne):lines+=['let '+native+' : OptionalLabel := .emptyOne '+q(v.identity)]
  else:lines+=['let '+native+'Label ← heldLabel '+q(v.family)+' '+q(v.label),'let '+native+' : OptionalLabel := .held '+native+'Label']
 ax=raw['axis_rank'];axis='.emptyOne '+q(ax.identity) if isinstance(ax,EmptyOne) else '.count ⟨'+str(ax.value)+',by decide⟩'
 lines+=['validate ⟨carrier,⟨'+str(raw['positive_spin_multiplicity'].value)+',by decide⟩,'+axis+',⟨'+str(raw['positive_axis_orientation_count'].value)+',by decide⟩,iv,rf,ac,ck⟩']
 return '(do '+'; '.join(lines)+')'
expected=[];valid=[]
for raw in raws:
 try:
  s=StateSymmetrySignature(**raw);expected.append({'ok':canonical_value(s)});valid.append((raw,s))
 except InadmissibleExactValue as e:expected.append({'error':str(e)})
header=(w/'StateSymmetryProgram1098.lean').read_text().split('def results')[0]
code=header+'''def signatureResult : Except String Signature → Canonical.Value
 | .error e => .object [("error",.text e)]
 | .ok s => .object [("ok",signatureValue s)]
def signatures : List Canonical.Value := ['''+','.join('signatureResult '+expr(raw)for raw in raws)+']\n'
baseSignature=StateSymmetrySignature(**base);equivalence=[];equivexpr=[]
for raw,s in valid:
 equivalence.append(equivalent(baseSignature,s));equivexpr.append('(do let a ← '+expr(base)+'; let b ← '+expr(raw)+'; pure (equivalent a b))')
code+='def equalityResults : List (Except String Bool) := ['+','.join(equivexpr)+']\n'
occurrences=[[],[HeldLabel('state-component','a')]*4,[HeldLabel('wrong',str(i))for i in range(4)],[HeldLabel('state-component',str(i))for i in [4,3,2,1]]]
classes=[];ce=[]
for occ in occurrences:
 try:classes.append({'ok':canonical_value(FiniteStateEquivalenceClass(baseSignature,tuple(occ)))})
 except InadmissibleExactValue as e:classes.append({'error':str(e)})
 lines=['let s ← '+expr(base),'let occurrences ← (['+','.join('heldLabel '+q(x.family)+' '+q(x.label)for x in occ)+'] : List (Except String HeldLabel)).mapM (fun x => x)','validateClass ⟨s,occurrences⟩'];ce.append('resultValue (do '+'; '.join(lines)+')')
code+='def classes : List Canonical.Value := ['+','.join(ce)+']\n'
code+='''def main : IO Unit := do
 let equalities ← equalityResults.mapM (fun x => IO.ofExcept x)
 IO.println (Canonical.render (.object [("signatures",.array signatures),("equivalence",.array (equalities.map Canonical.Value.boolean)),("classes",.array classes)]))
'''
p=w/'StateSymmetryControls1098.lean';p.write_text(code)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'statesymmetry1098_controls_output.json').open('w')as out,(w/'statesymmetry1098_controls_execution.log').open('w')as err:subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,stdout=out,stderr=err,check=True)
assert json.loads((w/'statesymmetry1098_controls_output.json').read_text())==dict(signatures=expected,equivalence=equivalence,classes=classes)
(w/'statesymmetry1098_controls_report.json').write_text(json.dumps(dict(status='PASS',signature_cases=len(raws),equivalence_cases=len(equivalence),class_cases=len(classes),preserves_nondefault_empty_identity=True),indent=2)+'\n');print('PASS',len(raws),'signature constructors,',len(equivalence),'equivalences,',len(classes),'class controls')
