from pathlib import Path
import ast,json,subprocess,os,re,hashlib
source=Path('work/check_calculator1015_gui.py').read_text();exec(source[:source.index('expected=[]')])
actions=['change','insert','trace','copy','clear','clear_history','restore','restore_none','restore_bad']
cases=[(name,mode) for name in actions for mode in ['RAD','DEG','GRAD','invalid']];expected=[]
for name,mode in cases:
 a=app();a.expression.set('1+1=');a.evaluate();a.expression.set('12');a.entry.cursor=1;a.entry.selection=(0,1);a.mode.set(mode);error=''
 try:
  if name=='change':a._change_mode()
  elif name=='insert':a._insert('π+3')
  elif name=='trace':a._set_trace('retained\ntrace')
  elif name=='copy':a.copy_result()
  elif name=='clear':a.clear()
  elif name=='clear_history':a.clear_history()
  else:
   a.history_list.selected=() if name=='restore_none' else ((5,) if name=='restore_bad' else (0,));a.restore_history()
 except (ValueError,IndexError) as e:error=str(e)
 expected.append(dict(error=error,state=snapshot(a)))
tree=ast.parse(source);header=ast.literal_eval(next(n.value for n in tree.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='header' for t in n.targets)))
header+='''def runCallback (name mode : String) : Except String Canonical.Value := do
 let start : State := {session := {places := 3},expression := "1+1="}
 let evaluated ← CalculatorGUI.evaluate start
 let s := {evaluated with expression := "12",cursor := 1,selection := some (0,1),mode := mode}
 let result : Except String State :=
  if name == "change" then changeMode s
  else if name == "insert" then .ok (insert s "π+3")
  else if name == "trace" then .ok (setTrace s "retained\\ntrace")
  else if name == "copy" then .ok (copyResult s)
  else if name == "clear" then .ok (clear s)
  else if name == "clear_history" then .ok (clearHistory s)
  else restoreHistory {s with historySelection := if name == "restore_none" then none else if name == "restore_bad" then some 5 else some 0}
 match result with
 | .ok next => pure (.object [("error",.text ""),("state",snapshot next)])
 | .error e => pure (.object [("error",.text e),("state",snapshot s)])
#eval do
'''+''.join(' IO.println (Canonical.render (get (runCallback '+json.dumps(name)+' '+json.dumps(mode)+')))\n' for name,mode in cases)
p=w/'constants-recovery/CalculatorCallbacks1016.lean';p.write_text(header);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1016_callbacks_output.log').write_text(x.stdout+x.stderr);assert x.returncode==0,(x.returncode,x.stdout[-1000:]);actual=[json.loads(line) for line in x.stdout.splitlines()];assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
report=dict(status='PASS',cases=len(expected),module='SFT/Mathematics/CalculatorGUI.lean',source_sha256=hashlib.sha256((r/'SFT/Mathematics/CalculatorGUI.lean').read_bytes()).hexdigest(),scope='Originalchange-mode/insert/set-trace/copy/clear/clear-history/history-restorationcallbackswithvalidandinvalidsuppliedhostselectionandmodes. Reuses unchanged TURN1015controllerzeroaxiomaudit.');(w/'calculator1016_callbacks_report.json').write_text(json.dumps(report,indent=2));print('PASS',len(expected),'fulloriginalcallbackstates')
