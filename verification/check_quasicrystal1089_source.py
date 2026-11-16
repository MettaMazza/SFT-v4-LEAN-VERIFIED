from pathlib import Path
import json,sys,subprocess,os,hashlib
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.materials.successor_structural_counts import substitution_populations,rational_inflation_fixed_point_certificate
from sft.engine.exact import PositiveCount
from sft.engine.canonical import canonical_value
p=w/'QuasicrystalInflationProgram1089.lean';p.write_text('''import SFT.Materials.QuasicrystalInflationCertificate
open SFT.Host SFT.Materials.QuasicrystalInflation
set_option maxHeartbeats 20000000
def histories : List (List PopulationPair) := ['''+','.join('substitutionPopulations ⟨'+str(n)+',by decide⟩'for n in range(1,33))+''']
def main : IO Unit := IO.println (Canonical.render (.object [
 ("certificate",fixedPointCertificate),("witness",.boolean substitutionWitness),
 ("histories",.array (histories.map (fun rows => .array (rows.map (fun row => .array [.integer (.ofNat row.first.val),.integer (.ofNat row.second.val)])))))]))
''')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'quasicrystal1089_source_output.json').open('w')as out,(w/'quasicrystal1089_source_execution.log').open('w')as err:subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,stdout=out,stderr=err,check=True)
expected=dict(certificate=canonical_value(rational_inflation_fixed_point_certificate()),witness=True,histories=[[[x.first.value,x.second.value]for x in substitution_populations(PositiveCount(n))]for n in range(1,33)])
assert json.loads((w/'quasicrystal1089_source_output.json').read_text())==expected
s=(w/'quasicrystal1089_certificate_build.log').read_text();assert s.count('does not depend on any axioms')==4 and'depends on axioms:'not in s
(w/'quasicrystal1089_source_report.json').write_text(json.dumps(dict(status='PASS',positive_depth_cases=32,certificate_fields=6,source_witness=True,axioms=[],new_declarations=4,lean_sha256=hashlib.sha256((r/'SFT/Materials/QuasicrystalInflationCertificate.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS32 original population histories, all six certificate fields and original witness;four empty-axiom declarations')
