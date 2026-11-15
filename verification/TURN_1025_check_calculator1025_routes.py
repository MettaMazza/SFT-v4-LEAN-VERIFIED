from pathlib import Path
import sys,os,json,subprocess,io,contextlib,ast
from unittest.mock import patch
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');source=Path('/Volumes/One Touch/ernos-labs-sft-platform');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_complete import __main__ as cli
from sft.mathematics.catalog import SPECS
from sft.mathematics.calculator_complete.explorer import RegisteredMathematicsExplorer
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';regs={}
def visit(id):
 if id in regs:return
 rel='claims/'+id+'/registration.json';path=source/rel
 if not path.exists():return
 b=subprocess.check_output(['git','-C',str(source),'show',pin+':'+rel]);assert b==path.read_bytes();regs[id]=json.loads(b).get('dependencies',[])
 for dep in regs[id]:visit(dep)
for spec in SPECS:visit(spec.claim_id)
census=json.loads((source/'census/claims.json').read_text())['claims'];selected=[x for x in census if x['claim_id'] in {s.claim_id for s in SPECS}]
def q(x):return json.dumps(x,ensure_ascii=False)
rows='['+','.join('⟨'+q(x['claim_id'])+','+('.text '+q(x['receipt_hash'])if x.get('receipt_hash')is not None else '.null')+','+str(bool(x.get('model_admitted',False))).lower()+'⟩'for x in selected)+']'
registrations='['+','.join('('+q(k)+',['+','.join(q(x)for x in v)+'])'for k,v in regs.items())+']'
head='''import SFT.Mathematics.CalculatorCompleteTerminal
import SFT.Mathematics.CalculatorCompleteCatalog
open SFT.Mathematics SFT.Host CalculatorCompleteTerminal
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''+f'def rows : List CalculatorCompleteEvidence.CensusRow := {rows}\ndef regs : List (String × List String) := {registrations}\n'+'''def run (a : Arguments) : Canonical.Value :=
 match mainAction a (CalculatorCompleteCatalog.explorer rows regs) (some rows) with
 | .finished x => .object [("stdout",.text x.stdout),("stderr",.text x.stderr),("exit",.integer (.ofNat (x.exitCode.getD 0))),("gui",.null)]
 | .gui p k => .object [("stdout",.text ""),("stderr",.text ""),("exit",.integer 0),("gui",.array [.integer p,.integer k])]
 | .interactive _ _ => .null
'''
cases=[(['--gui'], '{}'),(['--gui','1/0','--places','3','--limit','21'],'{gui:=true,expression:=some "1/0",places:=3,limit:=21}'),([], '{}'),(['--law','missing'],'{law:=some "missing"}'),(['--replay-law','missing'],'{replayLaw:=some "missing"}'),(['--law','', '--gui'],'{law:=some "",gui:=true}')]
for spec in SPECS:
 cases.append((['--law',spec.claim_id],'{law:=some '+q(spec.claim_id)+'}'))
 cases.append((['--replay-law',spec.claim_id],'{replayLaw:=some '+q(spec.claim_id)+'}'))
expected=[]
for argv,args in cases:
 out=io.StringIO();err=io.StringIO()
 with patch.object(sys,'argv',['sft-calculator']+argv),patch.object(cli,'RegisteredMathematicsExplorer',lambda:RegisteredMathematicsExplorer(source)),patch.object(cli,'launch_gui')as launch,contextlib.redirect_stdout(out),contextlib.redirect_stderr(err):exit=cli.main()
 expected.append(dict(stdout=out.getvalue(),stderr=err.getvalue(),exit=exit,gui=[launch.call_args.kwargs['places'],launch.call_args.kwargs['operation_limit']]if launch.called else None))
head+='#eval do\n for x in ['+','.join('run '+a for _,a in cases)+'] do IO.println (Canonical.render x)\n'
p=w/'calculator1025_routes_check.lean';p.write_text(head);x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M12288',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'calculator1025_routes_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1000:];actual=[json.loads(x)for x in x.stdout.splitlines()];assert actual==expected,[(i,a,e)for i,(a,e)in enumerate(zip(actual,expected))if a!=e][:1]
(w/'calculator1025_routes_report.json').write_text(json.dumps(dict(status='PASS',complete_main_routes=len(cases),original_registered_nodes=len(regs),pinned_registration_inputs=True,official_census_rows=len(selected)),indent=2));print('PASS',len(cases),'complete mainroutes;',len(regs),'pinnedregistrations')
