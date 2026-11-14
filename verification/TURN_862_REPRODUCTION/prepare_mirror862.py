from pathlib import Path
s=Path('work/bounded_spec859.py').read_text().replace('bounded859','mirror862').replace('BOUNDED_N_BODY','RIEMANN_MIRROR');Path('work/mirror_spec862.py').write_text(s)
s=Path('work/prepare_bounded_grammar859.py').read_text().replace('BOUNDED_N_BODY','RIEMANN_MIRROR').replace('BoundedNBody','RiemannMirror').replace('BoundedFoldTransient','RiemannMirror');Path('work/prepare_mirror_grammar862.py').write_text(s)
s=Path('work/prepare_bounded_evidence859.py').read_text().replace('bounded_spec859','mirror_spec862').replace('BoundedNBody','RiemannMirror').replace('BoundedFoldTransient','RiemannMirror').replace('state_domain :=','domain :=')
a=s.index('def witness0');b=s.index('theorem witness0Passed',a)
s=s[:a]+'''def exactPartner (p q : SFT.Foundation.ExactPartCarrier.Part) : Bool :=
 match SFT.Foundation.HalfOneDerivation.complement p with
 | .error _ => false
 | .ok r => r.numerator == q.numerator && r.denominator == q.denominator
def witness0 : Bool := exactPartner SFT.Foundation.HalfOneDerivation.halfOne SFT.Foundation.HalfOneDerivation.halfOne
def witness1 : Bool := exactPartner RiemannMirror.quarter RiemannMirror.threeQuarters && exactPartner RiemannMirror.third RiemannMirror.twoThirds
def witness2 : Bool := exactPartner RiemannMirror.quarter RiemannMirror.threeQuarters && exactPartner RiemannMirror.threeQuarters RiemannMirror.quarter
'''+s[b:];Path('work/prepare_mirror_evidence862.py').write_text(s)
