from pathlib import Path
import json,subprocess,os,sys
from fractions import Fraction as F
w=Path('work');r=(w/'constants-recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import cyclic_advance,free_particle_phase,potential_phase_evolution
cases=[('cyclic',[F(1,3),F(1,4)]),('cyclic',[F(1,3),F(8,3)]),('cyclic',[F(1),F(1)]),('cyclic',[F(1,2),F(1,2)]),('cyclic',[F(0),F(1,2)]),('cyclic',[F(2),F(1,2)]),('cyclic',[None,F(1,2)]),('free',[F(1,3),F(1,4)]),('free',[F(1),F(1,2)]),('free',[F(1,2),F(2,3)]),('potential',[F(1,3),F(1,8),F(1,4)]),('potential',[F(3,4),F(7,3),F(8,7)])]
def encode(x):
 if isinstance(x,F):return {'numerator':x.numerator,'denominator':x.denominator}
 if isinstance(x,dict):return {k:encode(v) for k,v in x.items()}
 return x
expected=[];lines=['import SFT.Physics.FreePhase','open SFT.Physics SFT.Host.Canonical FreePhase','def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]','def outcome (x : Except String Value) : Value := match x with | .ok v => .object [("ok",v)] | .error e => .object [("error",.text e)]','def main : IO Unit := do']
for kind,args in cases:
 try:expected.append({'ok':encode({'cyclic':cyclic_advance,'free':free_particle_phase,'potential':potential_phase_evolution}[kind](*args))})
 except ValueError as e:expected.append({'error':str(e)})
 inputs=['.nonFraction' if x is None else f'(.fraction ⟨{x.numerator},{x.denominator},by decide,by decide⟩)' for x in args]
 call={'cyclic':'cyclicAdvance','free':'freeParticlePhase','potential':'potentialPhaseEvolution'}[kind]+' '+' '.join(inputs)
 convert={'cyclic':'fraction','free':'fun x => Value.object [("momentum",fraction x.momentum),("dispersion",fraction x.dispersion),("phase_after",fraction x.phaseAfter)]','potential':'fun x => Value.object [("kinetic",fraction x.1),("potential",fraction x.2.1),("total",fraction x.2.2.1),("phase_after",fraction x.2.2.2)]'}[kind]
 lines.append(f' IO.println (render (outcome (({call}).map ({convert}))))')
p=r/'FreePhaseCompare883.lean';p.write_text('\n'.join(lines)+'\n');o=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(p)],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True);actual=[json.loads(x) for x in o.splitlines()];assert actual==expected,(actual,expected);(w/'freephase883_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/relativistic_field_laws_v1.py',scope='Exact original cyclic advance,free phase and potential operations;12 source cases including wrap,whole-One,guards and full records. Entry grammars and general closure remain unregistered.',actual=actual,expected=expected),indent=2));print('PASS12 original source operation cases')
