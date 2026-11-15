from pathlib import Path
import sys,os,json,re,subprocess,runpy
from unittest.mock import patch
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));m=runpy.run_path(str(w/'calculator1025_original_edges.py'));from sft.mathematics.calculator_complete.gui import SFTCalculatorApp,GUIDE_TEXT
FakeWidget=m['FakeWidget'];oldinsert=FakeWidget.insert
# Record text-widget content without changing the original GUI operations.
def insert(self,index,value):
 if index=='1.0':self.content=value
 oldinsert(self,index,value)
FakeWidget.insert=insert
root=m['FakeRoot']();tk=m['fake_tk_module'](root)
with patch.dict(sys.modules,{'tkinter':tk}):app=SFTCalculatorApp(root,places=3)
actions=[('expression','1+1'),('evaluate',''),('press','+'),('press','3'),('press','='),('toggle',''),('toggle',''),('learn',''),('learn',''),('mode','DEG'),('catalog','sum'),('restore','0'),('restore','none'),('copy',''),('clear',''),('expression','1/0'),('evaluate',''),('press','CE'),('expression','sqrt(2)'),('evaluate',''),('press','MS'),('press','MR'),('copy','')]
actions += [('press',x)for x in ['C','7','+','8','=','M+','MC','±','⌫','π','CE']]
def snapshot():return dict(expression=app.expression.get(),result=app.result.get(),status=app.status.get(),mode=app.mode.get(),memory=app.memory_indicator.get(),proof=getattr(app.proof_text,'content',''),history=app.history_list.items,visible=app.details_visible,tab=app.details.selected_tab,geometry=root.geometries[-1],button=app.details_button.options['text'],clipboard=root.clipboard,cursor=app.entry.options.get('cursor')=='end',focus=app.entry.options.get('focused',False))
expected=[json.loads(json.dumps(snapshot()))]
for kind,arg in actions:
 if kind=='expression':app.expression.set(arg)
 elif kind=='mode':app.mode.set(arg);app.change_mode()
 elif kind=='press':app.press(arg)
 elif kind=='evaluate':app.evaluate()
 elif kind=='toggle':app.toggle_details()
 elif kind=='learn':app.show_learn()
 elif kind=='catalog':app.insert_catalog(arg)
 elif kind=='restore':app.history_list.selection=()if arg=='none'else(int(arg),);app.restore_history()
 elif kind=='copy':app.copy_result()
 elif kind=='clear':app.clear_history()
 expected.append(json.loads(json.dumps(snapshot())))
head='''import SFT.Mathematics.CalculatorCompleteGUI
open SFT.Mathematics SFT.Host CalculatorCompleteGUI
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def snapshot (s : State) : Canonical.Value := .object [
 ("expression",.text s.expression),("result",.text s.result),("status",.text s.status),("mode",.text s.mode),("memory",.text s.memoryIndicator),("proof",.text s.proofText),("history",.array (s.history.map Canonical.Value.text)),("visible",.boolean s.detailsVisible),("tab",match s.selectedTab with | none => .null | some n => .integer (.ofNat n)),("geometry",.text s.geometry),("button",.text s.detailsButton),("clipboard",.text s.clipboard),("cursor",.boolean s.cursorAtEnd),("focus",.boolean s.entryFocused)]
def scenario : Except String (List Canonical.Value) := do
 let s := create 3
 let out := [snapshot s]
'''
for kind,arg in actions:
 q=json.dumps(arg,ensure_ascii=False)
 code={'expression':'let s := {s with expression := '+q+'}','mode':'let s ← changeMode {s with mode := '+q+'}','press':'let s ← press s '+q,'evaluate':'let s ← evaluate s','toggle':'let s := toggleDetails s','learn':'let s := showLearn s','catalog':'let s ← insertCatalog s '+q,'restore':'let s ← restoreHistory s '+('[]'if arg=='none'else '['+arg+']'),'copy':'let s := copyResult s','clear':'let s ← clearHistory s'}[kind]
 head+=' '+code+'\n let out := out ++ [snapshot s]\n'
head+=' pure out\n#eval match scenario with | .error e => IO.println e | .ok xs => IO.println (Canonical.render (.array xs))\n#eval IO.println (Canonical.render (.text guideText))\n'
p=w/'calculator1025_gui_check.lean';p.write_text(head);lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1025_gui_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];rows=[json.loads(x)for x in x.stdout.splitlines()];assert rows[0]==expected,[(i,a,b)for i,(a,b)in enumerate(zip(rows[0],expected))if a!=b][:1];assert rows[1]==GUIDE_TEXT
s=(r/'SFT/Mathematics/CalculatorCompleteGUI.lean').read_text();names=re.findall(r'^(?:def|theorem) (\w+)',s,re.M);p=w/'calculator1025_gui_audit.lean';p.write_text('import SFT.Mathematics.CalculatorCompleteGUI\n'+''.join('#print axioms SFT.Mathematics.CalculatorCompleteGUI.'+n+'\n'for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1025_gui_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1025_gui_report.json').write_text(json.dumps(dict(status='PASS',complete_GUI_states=len(expected),guide_text=True,declarations=names,axioms=[]),indent=2));print('PASS',len(expected),'complete GUI states andguide;',len(names),'emptyaxiom definitions')
