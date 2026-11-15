from pathlib import Path
import sys,os,json,re,subprocess,hashlib,concurrent.futures
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator import values as v
s=(r/'SFT/Physics/LeptonDecimal.lean').read_text();bases=json.loads(re.search(r'def decimalBases : List Nat := (\[[^\n]+\])',s)[1]);assert {b+i for b in bases for i in range(10)}=={i for i in range(0x110000) if chr(i).isdecimal()}
tokens=['',' ','+1','-0','1-2','.', '.e2','0','00','1.','1.25e-2','0.1','0.2','.123','12e+3','1e-3','1E2','  1.23E-4  ','1e1_0','1e+','1e-','1e','1e_2','1e2_','1e1__2','1e+ 2','1e 2','1e2e3','1.2.3','1_2','a','1eAΣ','²','¹.₂','1e²','1\n2','1e1\n2']
for b in bases:
 for i in [0,1,9]:tokens.extend([chr(b+i),chr(b+i)+'.'+chr(b+5)+'e-2','1e'+chr(b+i)])
for i in range(0x110000):
 if chr(i).isdigit() and not chr(i).isdecimal():tokens.append(chr(i))
expected=[]
for t in tokens:
 try:expected.append({'ok':v.exact_text(v.parse_exact_number(t))})
 except v.CalculatorHalt as e:expected.append({'error':str(e)})
 except ValueError:expected.append({'error':'ValueError'})
header='''import SFT.Mathematics.CalculatorNumerals
open SFT.Mathematics SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String FoldScalar.Scalar → Value | .ok v => .object [("ok",.text (CalculatorValues.exactText v))] | .error e => .object [("error",.text e)]
'''
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def batch(i):
 p=w/f'constants-recovery/CalculatorNumerals1010_{i}.lean';p.write_text(header+'#eval IO.println (render (.array ['+','.join('result (CalculatorNumerals.parseExactNumber '+json.dumps(t,ensure_ascii=False)+')' for t in tokens[i:i+180])+']))\n');x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/f'calculator1010_numerals_batch{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];return json.loads(x.stdout)
with concurrent.futures.ThreadPoolExecutor(max_workers=6) as pool:actual=[a for rows in pool.map(batch,range(0,len(tokens),180)) for a in rows]
assert actual==expected,[(t,a,e) for t,a,e in zip(tokens,actual,expected) if a!=e][:10]
s=(r/'SFT/Mathematics/CalculatorNumerals.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1010_numerals_audit.lean';p.write_text('import SFT.Mathematics.CalculatorNumerals\n'+''.join('#print axioms SFT.Mathematics.CalculatorNumerals.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1010_numerals_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1010_numerals_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tokens),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),all_unicode13_decimal_characters_checked=True,scope='Exact admitted values and CalculatorHalt messages; host int failures retain ValueError type rather than Python diagnostic prose.'),indent=2));print('PASS',len(tokens),'original parser cases;',len(names),'emptyaxioms')
