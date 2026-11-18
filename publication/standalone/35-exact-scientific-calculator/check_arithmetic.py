from pathlib import Path
from fractions import Fraction as F
import sys,json,hashlib
root=Path(__file__).resolve().parents[1];dest=root
sys.dont_write_bytecode=True
if hasattr(sys,'set_int_max_str_digits'):sys.set_int_max_str_digits(0)
sys.path.insert(0,str(root/'v3'))
from sft.mathematics.calculator.values import forward,scalar_to_fraction_for_projection as frac,CertifiedInterval
from sft.mathematics.calculator.operations import nth_root,exp_enclosure,ln_enclosure
from sft.mathematics.calculator.operations_v2 import _atan_unit_enclosure_v2,circle_constant_enclosure
from sft.mathematics.calculator_browser.app import CalculatorWebApplication
roots=0
for target in [F(1,8),F(2),F(3),F(7,3),F(81,16)]:
 for degree in [2,3,4,5]:
  for depth in [0,1,8,24,80]:
   v=nth_root(forward(target),degree,depth)
   if isinstance(v,CertifiedInterval):
    a,b=frac(v.lower),frac(v.upper);assert a**degree<=target<=b**degree;assert b-a<=max(F(1),target)/2**depth
   else:assert frac(v)**degree==target
   roots+=1
parities=0
for x in [F(1,5),F(1,239),F(1,2),F(1)]:
 for n in range(1,33):
  p=sum(((-1)**j*x**(2*j+1)/F(2*j+1) for j in range(n)),F(0));q=x**(2*n+1)/F(2*n+1)
  v=_atan_unit_enclosure_v2(x,n);a,b=frac(v.lower),frac(v.upper)
  assert (a,b)==((p-q,p) if n%2 else (p,p+q));parities+=1
# The exact rational tangent composition that fixes the circle angle.
t=F(1,5)
t2=2*t/(1-t*t);t4=2*t2/(1-t2*t2);assert (t4-F(1,239))/(1+t4*F(1,239))==1
v=circle_constant_enclosure();assert F(314159265358979323846,10**20)<frac(v.lower)<frac(v.upper)<F(314159265358979323847,10**20)
series=0
for x in [F(1,4),F(1),F(2),F(3)]:
 v=exp_enclosure(forward(x),12);a,b=frac(v.lower),frac(v.upper)
 total=F(1);term=F(1)
 for k in range(1,300):term*=x/F(k);total+=term
 assert a<=total<=b and b-a<=F(1,10**12);series+=1
for x in [F(1,4),F(1,2),F(2),F(3)]:
 v=ln_enclosure(forward(x),12);a,b=frac(v.lower),frac(v.upper);z=(x-1)/(x+1)
 partial=2*sum((z**(2*j+1)/F(2*j+1) for j in range(300)),F(0));assert a<=partial<=b and b-a<=F(2,10**12);series+=1
app=CalculatorWebApplication(places=12,share=False)
for expression,expected in [('0.1+0.2','3/10'),('2^3^2','512'),('3-3','0')]:
 v=app.apply({'action':'evaluate','expression':expression})['view'];assert v['result']==expected and not v['error']
before=app.apply({'action':'state'})['view'];v=app.apply({'action':'evaluate','expression':'1-2'})['view'];assert v['result']=='HALT' and v['error'] and v['history']==before['history']
v=app.apply({'action':'evaluate','expression':'ans'})['view'];assert v['result']=='0'
browser=json.loads((root/'browser_execution_check.json').read_text());assert browser['status']=='PASS' and not browser['console_errors']
result={'status':'PASS','root_enclosure_cases':roots,'arctangent_parity_cases':parities,'exact_circle_tangent_identity':True,'series_rational_crosschecks':series,'application_exact_precedence_cancellation_and_transaction':True,'retained_actual_browser_cases':len(browser['rows']),'new_lean_builds':0}
dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
