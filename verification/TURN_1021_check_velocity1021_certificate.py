exec(open('work/check_velocity1021.py').read().split('expected=[]')[0])
header='''import SFT.Physics.VelocityComposition
import SFT.Host.Canonical
open SFT.Physics.VelocityComposition SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def row (c : BilinearCandidate) : Value := .object [("candidate_id",.text c.candidateId),("numerator_cross",.boolean c.numeratorCross),("denominator_cross",.boolean c.denominatorCross),("identity_forced_terms",.array (c.identityForcedTerms.map Value.text)),("limit_absorbing",.boolean c.limitAbsorbing)]
def certificate (c : Certificate) : Value := .object [("candidate_count",.integer (.ofNat c.candidateCount)),("survivor",.text c.survivor),("closure",.boolean c.closure),("associativity",.boolean c.associativity),("pair_equivalence",.boolean c.pairEquivalence),("strict_sublimit",.boolean c.strictSublimit),("limiting_speed_absorbing",.boolean c.limitingSpeedAbsorbing),("typed_rest_identity",.boolean c.typedRestIdentity),("low_speed_difference_exact",.boolean c.lowSpeedDifferenceExact)]
#eval IO.println (render (.array [ .array (bilinearCandidates.map row), match theoremCertificate with | .ok c => certificate c | .error e => .text e]))
'''
p=w/'constants-recovery/VelocityCertificate1021.lean';p.write_text(header);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'velocity1021_certificate.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout;actual=json.loads(x.stdout);expected=[canonical_value(src.bilinear_candidates()),canonical_value(src.theorem_certificate())];assert actual==expected,(actual,expected);(w/'velocity1021_certificate_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,lean_sha256=hashlib.sha256((r/'SFT/Physics/VelocityComposition.lean').read_bytes()).hexdigest(),original_sha256=hashlib.sha256(pinned).hexdigest()),indent=2));print('PASS entire four-row bilinear census and all nine certificate fields')
