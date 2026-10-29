from pathlib import Path
from fractions import Fraction
from itertools import product
import json,subprocess,hashlib
r=Path(__file__).resolve().parents[1];pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
raw=subprocess.check_output(['git','-C',json.loads((r/'reference/SOURCE.json').read_text())['local_source'],'show',pin+':sft/computation/operations.py'])
values=[Fraction(-1),Fraction(0),Fraction(1,3),Fraction(1,2),Fraction(1),Fraction(2)]
support=[list(x) for n in range(3) for x in product(values,repeat=n)]
def number(v):
 if v==0:return '.zero'
 sign='positive' if v>0 else 'negative';v=abs(v)
 return f'(.{sign} (normalizePositive {v.numerator} {v.denominator} (by decide) (by decide)))'
def array(v):return '['+','.join(map(number,v))+']'
def expected(a,b):
 if len(a)!=len(b) or not a:return {'error':'comparison requires equal nonempty generated supports'}
 out=[]
 for i,(x,y) in enumerate(zip(a,b),1):
  if x<=0 or y<=0:return {'error':'scientific proof values must be exact positive parts'}
  value=Fraction(1) if x==y else abs(x-y)
  out.append([f'cell-{i}',f'{value.numerator}/{value.denominator}','equal' if x==y else 'held-below' if y<x else 'held-above'])
 return {'rows':out}
header='''import Lean
import SFT.Computation.NumericalLedger
open SFT.Computation.NumericalError SFT.Foundation.ExactOperations
open Lean
set_option maxRecDepth 100000
set_option maxHeartbeats 0
 def encode : Except String (List Row) → Json
 | .error reason => Json.mkObj [("error",toJson reason)]
 | .ok rows => Json.mkObj [("rows",toJson (rows.map (fun r => [r.1,toString r.2.1.numerator ++ "/" ++ toString r.2.1.denominator,r.2.2])))]
 def main : IO Unit := do
'''
checks=[(a,b) for a in support for b in support]
body=header[:header.index(' def main')]+' def samples : List Number := '+array(values)+'\n'
body+=' def supports : List (List Number) := [[]] ++ samples.map (fun x => [x]) ++ samples.flatMap (fun x => samples.map (fun y => [x,y]))\n'
body+=' def main : IO Unit := do\n  for a in supports do\n    for b in supports do\n      IO.println (encode (exactErrorLedger a b)).compress\n'
(r/'verification/TURN_238_NumericalCases.lean').write_text(body)
(r/'verification/TURN_238_NUMERICAL_CASES_EXPECTED.json').write_text(json.dumps([expected(a,b) for a,b in checks]))
(r/'verification/TURN_238_NUMERICAL_CASES_META.json').write_text(json.dumps({'source_commit':pin,'source_sha256':hashlib.sha256(raw).hexdigest(),'cases':len(checks)}));print(len(checks))
