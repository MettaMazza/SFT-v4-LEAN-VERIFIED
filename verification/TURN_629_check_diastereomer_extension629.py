from pathlib import Path
import json,subprocess,os,itertools
setup=Path('work/check_diastereomer_configurations627.py').read_text().split("H=ns['HeldLabel']")[0]
exec(setup)
src=raw('sft/chemistry/coordination_isomerism_law_v1.py');tree=ast.parse(src)
exec(compile(ast.Module(body=[n for n in tree.body if getattr(n,'name',None) in {'extend_coordination_form','forced_coordination_isomer_relation','ExactCoordinationIsomerRecord'}],type_ignores=[]),'pinned-successor','exec'),ns)
H,P,E,F=[ns[x] for x in ['HeldLabel','PositiveCount','EmptyOne','FiniteCoordinationForm']]
word=(H('fold-orientation-fibre','fibre-one'),E(),E());attachment=H('coordination-attachment-mode','held');labels=[H('coordination-composition-label',x) for x in ['E','F']]
left=F(tuple(labels),(attachment,attachment),(word,word),((P(1),P(2)),));right=F(tuple(reversed(labels)),(attachment,attachment),(word,word),((P(2),P(1)),))
terms=[];expected=[]
for fresh,target,links,element in itertools.product(['0','m','zz'],['0','m','zz'],[['a'],['z'],['a','z']],['E','G']):
 ll=tuple(P(1 if x=='a' else 2) for x in links);rr=tuple(P(2 if x=='a' else 1) for x in links)
 le=ns['extend_coordination_form'](left,H('coordination-composition-label',element),attachment,word,ll)
 re=ns['extend_coordination_form'](right,H('coordination-composition-label',element),attachment,word,rr)
 expected.append('true' if ns['_canonical'](le,False)==ns['_canonical'](re,False) else 'false')
 terms.append('('+q(fresh)+','+q(target)+','+q(element)+',['+','.join(map(q,links))+'])')
source='''import SFT.Chemistry.Diastereomer
open SFT.Chemistry SFT.Chemistry.Chirality SFT.Chemistry.Diastereomer
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def left : OrientedMolecule := ⟨⟨["a","z"],["E","F"],[("a","z")],[]⟩,[("a",baseOrientation),("z",baseOrientation)]⟩
def right : OrientedMolecule := ⟨⟨["p","b"],["F","E"],[("b","p")],[]⟩,[("p",baseOrientation),("b",baseOrientation)]⟩
def m : ConstitutionMap := sourceConstitutionMap left right ["b","p"]
 (by decide) (by decide) (by decide) (by decide) (by decide)
 (List.Perm.swap "p" "b" [])
 (by intro edge h; cases h with
     | head => exact ⟨.head _,.tail _ (.head _)⟩
     | tail _ h => cases h)
 (by decide)
def cases : List (String × String × String × List String) := ['''+','.join(terms)+''']
def main : IO Unit := cases.forM fun (fresh,target,element,links) =>
 IO.println (MolecularIsomer.structurallyEquivalent
  (extendedLeftCarrier m fresh element baseOrientation links).carrier
  (extendedRightCarrier m target element baseOrientation links).carrier)
'''
p=Path('work/DiastereomerExtensionCases629.lean');p.write_text(source)
env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()))
o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/diastereomer_extension629.log').write_text(o.stdout+o.stderr);assert o.returncode==0,(o.stdout+o.stderr)[-2500:];assert o.stdout.splitlines()==expected
report=dict(status='PASS',cases=len(expected),source_commit=pin,source_operations=['extend_coordination_form','_canonical(include_orientation=False)'],lean_operation='MolecularIsomer.structurallyEquivalent on extendedLeftCarrier/extendedRightCarrier',scope='Independently named reversed two-atom correspondence; all nonempty anchor subsets; lexical positions below/between/above old names; repeated or fresh elemental label.',source_width_guard='forced_coordination_isomer_relation rejects unequal positive widths before composition comparison')
Path('work/diastereomer_extension629_report.json').write_text(json.dumps(report,indent=2));print('PASS',len(expected),'fresh source extension comparisons')
