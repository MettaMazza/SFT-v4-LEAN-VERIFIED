from pathlib import Path
from itertools import product
import sys,json,re,subprocess,os,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import baryogenesis_dependency_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
expected=[];expr=[]
for t,c,h in product([False,True],repeat=3):expected.append(canonical_value(src.retained_baryon_residue(baryon_tally_changes=t,conjugate_paths_distinguished=c,reverse_completion_held=h)));expr.append('residue (retainedBaryonResidue '+' '.join(str(x).lower() for x in [t,c,h])+')')
expected+=[canonical_value(src.complete_condition_census()),src.unique_positive_process()];expr+=['Value.array (completeConditionCensus.map row)','Value.boolean uniquePositiveProcess']
s='''import SFT.Physics.BaryogenesisDependency
import SFT.Host.Canonical
open SFT.Physics.BaryogenesisDependency SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def residue : ResidueRecord → Value
 | .emptyOne => .array [.text "empty-One"]
 | .residue orientation support => .object [("orientation",.text orientation),("support",rational support)]
def row (r : ConditionRow) : Value := .object [("baryon_tally_changes",.boolean r.baryonTallyChanges),("conjugate_paths_distinguished",.boolean r.conjugatePathsDistinguished),("reverse_completion_held",.boolean r.reverseCompletionHeld),("residue",residue r.residue),("positive_residue",.boolean r.positiveResidue)]
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n';p=w/'constants-recovery/Baryogenesis997.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'baryogenesis997_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout;actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
code=(r/'SFT/Physics/BaryogenesisDependency.lean').read_text();names=['SFT.Physics.BaryogenesisDependency.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',code,re.M)];p=w/'baryogenesis997_core_audit.lean';p.write_text('import SFT.Physics.BaryogenesisDependency\n'+''.join('#print axioms '+n+'\n' for n in names));out=subprocess.check_output([lean,str(p)],env=env,text=True);(w/'baryogenesis997_core_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names),out
(w/'baryogenesis997_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS all8sourceprocesses andfull5fieldcensus/uniquecheck;',len(names),'emptydeclarations')
