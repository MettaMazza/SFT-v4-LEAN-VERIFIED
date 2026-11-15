from pathlib import Path
import json,os,sys,re,hashlib,subprocess
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_browser.law import SPEC
from sft.mathematics.generated_law import candidate_records,survivor_id,decision_reason
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
# Wait only for the original live build; do not start a duplicate.
import time
while 'Build completed successfully' not in (w/'calculator1026_grammar_build.log').read_text():
 if 'error: build failed' in (w/'calculator1026_grammar_build.log').read_text():raise RuntimeError('original grammar build failed')
 time.sleep(3)
mods=['CalculatorBrowserGrammarBase']+[f'CalculatorBrowserCensus{i}' for i in range(16)]+['CalculatorBrowserGrammar'];names=[];hashes={}
for m in mods:
 s=(r/f'SFT/Mathematics/{m}.lean').read_text();names+=['SFT.Mathematics.CalculatorBrowserGrammar.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)];hashes[m]=hashlib.sha256(s.encode()).hexdigest()
p=w/'calculator1026_grammar_check.lean';p.write_text('''import SFT.Mathematics.CalculatorBrowserGrammar
open SFT.Mathematics.CalculatorBrowserGrammar SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval IO.println (render (.array (candidates.map fun c => .array [.text (candidateId c),.text (exactForm c),.boolean (survives c),.text (decisionReason c)])))
''');x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1026_grammar_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1000:];actual=json.loads(x.stdout);records=candidate_records(SPEC);expected=[[a['candidate_id'],a['exact_form'],a['candidate_id']==survivor_id(SPEC),decision_reason(SPEC,a)]for a in records];assert actual==expected
p=w/'calculator1026_grammar_audit.lean';p.write_text('import SFT.Mathematics.CalculatorBrowserGrammar\n'+''.join('#print axioms '+n+'\n'for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1026_grammar_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout[-2000:]
report=dict(status='PASS',complete_ordered_candidates=len(actual),axioms=[],declarations=names,source_sha256=hashes);(w/'calculator1026_grammar_report.json').write_text(json.dumps(report,indent=2));print('PASS',len(actual),'ordered candidates and',len(names),'empty axiom declarations')
