from pathlib import Path
import sys,os,json,re,subprocess,hashlib,random,concurrent.futures
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator.machine import Calculator
from sft.mathematics.calculator.values import CalculatorHalt
rng=random.Random(1010);tokens=['',' ','0.1+0.2','1e','1e+','1e-2','1..2','.1e2',' . ','abc_123','π','1 + @','1\t+\n2','١٢.٣e-٢','²','root(2,3)','--2^3!','1e1_0','empty_one','cos(1)']
alphabet=list('0123456789.eE+-*/^!%(),_abcXYZ @\t\n')+['١','٩','π','²','\u2003']
tokens += [''.join(rng.choice(alphabet) for _ in range(rng.randrange(1,30))) for _ in range(900)]
expected=[]
for t in tokens:
 try:expected.append({'ok':[[x.kind,x.text] for x in Calculator()._lex(t)]})
 except CalculatorHalt as e:expected.append({'error':str(e)})
header='''import SFT.Mathematics.CalculatorLexer
open SFT.Mathematics SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String (List CalculatorLexer.Token) → Value | .ok xs => .object [("ok",.array (xs.map (fun x => .array [.text x.kind,.text x.text])))] | .error e => .object [("error",.text e)]
'''
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def batch(i):
 p=w/f'constants-recovery/CalculatorLexer1010_{i}.lean';p.write_text(header+'#eval IO.println (render (.array ['+','.join('result (CalculatorLexer.lex '+json.dumps(t,ensure_ascii=False)+')' for t in tokens[i:i+180])+']))\n');x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/f'calculator1010_lexer_batch{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];return json.loads(x.stdout)
with concurrent.futures.ThreadPoolExecutor(max_workers=6) as pool:actual=[a for rows in pool.map(batch,range(0,len(tokens),180)) for a in rows]
assert actual==expected,[(t,a,e) for t,a,e in zip(tokens,actual,expected) if a!=e][:10]
s=(r/'SFT/Mathematics/CalculatorLexer.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1010_lexer_audit.lean';p.write_text('import SFT.Mathematics.CalculatorLexer\n'+''.join('#print axioms SFT.Mathematics.CalculatorLexer.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1010_lexer_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1010_lexer_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tokens),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Complete original _lex token kinds/text/order and boundary errors including Unicode decimal digits,whitespace,optional exponents,ASCII names and operators.'),indent=2));print('PASS',len(tokens),'original lexer cases;',len(names),'emptyaxioms')
