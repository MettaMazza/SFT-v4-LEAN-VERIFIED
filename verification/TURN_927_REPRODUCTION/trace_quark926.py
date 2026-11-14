from pathlib import Path
import sys,json
from fractions import Fraction
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics import matter_flavour_validation_v1 as s
out={}
for name,v in s.quark_cubic_invariants().items():
 b=s.isolate_cubic_roots(v[1],v[2]);n=0
 while any(u-l>Fraction(1,10**12) for l,u in b):b=tuple(s.bisect_bracket(row,v[1],v[2]) for row in b);n+=1
 out[name]={'steps':n,'pair_sum':[v[1].numerator,v[1].denominator],'product':[v[2].numerator,v[2].denominator],'result':[[[x.numerator,x.denominator] for x in row] for row in b]}
Path('work/quark926_refinement_trace.json').write_text(json.dumps(out,indent=2));print(json.dumps(out))
