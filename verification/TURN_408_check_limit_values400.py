from pathlib import Path
from fractions import Fraction
import subprocess,os,json,ast,hashlib
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';source=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/mathematics/lineage_laws.py']).decode();tree=ast.parse(source);spec=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='LIMIT_CONTINUUM');kw={x.arg:x.value for x in spec.keywords};witnesses=[eval(compile(ast.Expression(w.args[2]),'<pinned-v3-witness>','eval'),{'Fraction':Fraction}) for w in kw['witnesses'].elts];assert witnesses==[True]*4
expected=[]
def emit(tag,k,x):expected.append(f'{tag}\t{k}\t{x.numerator}\t{x.denominator}')
for k in range(1,15):emit('rung',k,Fraction(1,2**k))
for k in range(1,11):
 h=Fraction(1,2**k);emit('quadratic',k,((1+h)**2-2+(1-h)**2)/h**2)
for k in range(1,10):
 h=Fraction(1,2**k);emit('cubic',k,((1+2*h)**3-2*(1+h)**3+1)/h**2);emit('error',k,6*h);emit('next-error-doubled',k,2*Fraction(6,2**(k+1)))
for k in range(1,6):emit('term',k,Fraction(1,2**k))
emit('ledger',5,sum(Fraction(1,2**k) for k in range(1,6))+Fraction(1,32));expected.append('witnesses\ttrue\ttrue\ttrue\ttrue')
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));actual=subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','2048','--run',str(r/'LimitValues400.lean')],env=env,text=True);Path('work/limit_values400_output.tsv').write_text(actual);assert actual.splitlines()==expected
report=dict(status='PASS',source_commit=pin,source_sha256=hashlib.sha256(source.encode()).hexdigest(),fresh_lean_execution=True,matched_rational_rows=len(expected)-1,original_witness_expressions_executed=4,scope='Original14rungs,10quadratic spacings,9cubic values/errors/doubled-next-errors,all5ledger terms and complete ledger; all4pinned witness AST expressions independently evaluated.')
Path('work/limit_values400_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
