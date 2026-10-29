from pathlib import Path
from fractions import Fraction
import json,subprocess,shutil
r=Path(__file__).resolve().parents[1]
lake=shutil.which('lake') or str(Path.home()/'.elan/bin/lake')
subprocess.run([lake,'build','SFT.Physics.ElectroweakMixing'],cwd=r,check=True,stdout=subprocess.DEVNULL)
actual=json.loads(subprocess.check_output([lake,'env','lean','--run','verification/TURN_279_MixingCases.lean'],cwd=r,text=True))
expected=[]
for image in sorted({Fraction(n,d) for n in range(-2,11) for d in range(1,9)}):
 for depth in list(range(-2,7))+[True,False]:
  if image<=0 or image>1 or depth<1:
   expected.append({'error':'ValueError: preimage enumeration requires an exact Fold part and positive depth'})
  elif isinstance(depth,bool):
   expected.append({'error':'ValueError: positive power requires positive exact counts'})
  else:
   parts=[Fraction(i,2**depth) for i in range(1,2**depth+1)]
   output=[p for p in parts if (2*p if 2*p<=1 else 2*p-1)==image]
   expected.append({'values':[[p.numerator,p.denominator] for p in output]})
assert actual==expected
print(json.dumps({'status':'PASS','cases':len(expected),'fresh_lean_execution':True}))
