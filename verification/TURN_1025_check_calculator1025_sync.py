from pathlib import Path
import sys,os,json,subprocess,itertools
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');s=(w/'check_calculator1025_layout.py').read_text();exec(s[:s.index('cases=')]);from sft.mathematics.calculator_complete.controller import CalculatorView
cases=list(itertools.product([[],['old'],['new']],[[],['new']],[False,True],['','domain error']));expected=[];code='''import SFT.Mathematics.CalculatorCompleteLayout
open SFT.Mathematics SFT.Host CalculatorCompleteLayout
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
for before,after,memory,error in cases:
 h=Host([],False);app=object.__new__(gui.SFTCalculatorApp)
 for name in ['expression','result','mode','memory_indicator','status','proof_text','history_list']:setattr(app,name,Widget(h,name))
 def get(*args):h.record('history_list','get',args,{});return tuple(before)
 app.history_list.get=get
 view=CalculatorView('expr','answer','exact',error,memory,'DEG',tuple(after));app._sync(view);expected.append(h.calls)
 code+='#eval IO.println (Canonical.render (.array (syncCalls ⟨"expr","answer","exact",'+json.dumps(error)+','+str(memory).lower()+',"DEG",'+json.dumps(after)+'⟩ '+json.dumps(before)+')))\n'
p=w/'calculator1025_sync_check.lean';p.write_text(code);x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'calculator1025_sync_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1000:];actual=[json.loads(x)for x in x.stdout.splitlines()];assert actual==expected
(w/'calculator1025_sync_report.json').write_text(json.dumps(dict(status='PASS',exact_sync_traces=len(cases),text_state_order=True,conditional_history_replacement=True),indent=2));print('PASS',len(cases),'complete original GUI sync traces')
