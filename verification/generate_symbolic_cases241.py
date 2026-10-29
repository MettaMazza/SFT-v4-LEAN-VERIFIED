from pathlib import Path
from fractions import Fraction
import json,subprocess,hashlib
r=Path(__file__).resolve().parents[1];pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
raw=subprocess.check_output(['git','-C',json.loads((r/'reference/SOURCE.json').read_text())['local_source'],'show',pin+':sft/computation/operations.py'])
values=[Fraction(-1),Fraction(0),Fraction(1,3),Fraction(1,2),Fraction(1),Fraction(2)]
leaves=[('value',v) for v in values]+[('value',None),('name','x'),('name','y'),('name','missing'),('outside',)]
expressions=leaves+[('join',a,b) for a in leaves for b in leaves]+[('join',('join',a,('value',Fraction(1))),('name','x')) for a in leaves]
envs=[[]]+[[('x',v)] for v in values]+[[('x',a),('y',b)] for a in values for b in values]+[[('x',v),('x',Fraction(1))] for v in values]
def evaluate(e,env):
 bindings=dict(env)
 if len(bindings)!=len(env):raise ValueError('binding identity occurs twice')
 if e[0]=='value':
  if not isinstance(e[1],Fraction) or e[1]<=0:raise ValueError('only exact positive parts are semantic values')
  return e[1]
 if e[0]=='name':
  if e[1] not in bindings:raise ValueError('unbound name')
  return bindings[e[1]]
 if e[0]=='join':return evaluate(e[1],env)+evaluate(e[2],env)
 raise ValueError('expression constructor is outside the generated syntax')
def outcome(e,env):
 try:
  v=evaluate(e,env);return {'value':f'{v.numerator}/{v.denominator}'}
 except ValueError as error:return {'error':str(error)}
def number(v):
 if v==0:return '.zero'
 sign='positive' if v>0 else 'negative';v=abs(v)
 return f'(.{sign} (normalizePositive {v.numerator} {v.denominator} (by decide) (by decide)))'
lean='''import Lean
import SFT.Computation.SymbolicEvaluation
open Lean SFT.Computation.NumericalError SFT.Computation.SymbolicEvaluation SFT.Foundation.ExactOperations
 def numberText : Number → String
 | .zero => "0/1"
 | .positive p => toString p.numerator ++ "/" ++ toString p.denominator
 | .negative p => "-" ++ toString p.numerator ++ "/" ++ toString p.denominator
 def encode : Except String Number → Json
 | .error reason => Json.mkObj [("error",toJson reason)]
 | .ok value => Json.mkObj [("value",toJson (numberText value))]
'''
lean+=' def samples : List Number := ['+','.join(map(number,values))+']\n'
lean+=' def leaves : List SFT.Computation.SymbolicEvaluation.Expr := samples.map (fun value => .value (some value)) ++ [.value none,.name "x",.name "y",.name "missing",.outside "outside"]\n'
lean+=' def expressions : List SFT.Computation.SymbolicEvaluation.Expr := leaves ++ leaves.flatMap (fun a => leaves.map (fun b => .join a b)) ++ leaves.map (fun a => .join (.join a (.value (some (.positive (normalizePositive 1 1 (by decide) (by decide)))))) (.name "x"))\n'
lean+=' def environments : List SFT.Computation.SymbolicEvaluation.Environment := [[]] ++ samples.map (fun v => [("x",v)]) ++ samples.flatMap (fun a => samples.map (fun b => [("x",a),("y",b)])) ++ samples.map (fun v => [("x",v),("x",.positive (normalizePositive 1 1 (by decide) (by decide)))])\n'
lean+=' def main : IO Unit := do\n  for env in environments do\n    for expression in expressions do\n      IO.println (encode (evaluate env expression)).compress\n'
(r/'verification/TURN_241_SymbolicCases.lean').write_text(lean)
expected=[outcome(e,env) for env in envs for e in expressions]
(r/'verification/TURN_241_SYMBOLIC_CASES_EXPECTED.json').write_text(json.dumps(expected)+'\n')
(r/'verification/TURN_241_SYMBOLIC_CASES_META.json').write_text(json.dumps({'source_commit':pin,'source_sha256':hashlib.sha256(raw).hexdigest(),'cases':len(expected)}));print(len(expected))
