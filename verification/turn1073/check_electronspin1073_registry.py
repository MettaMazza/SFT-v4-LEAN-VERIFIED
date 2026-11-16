import json,sys,os,subprocess,re,hashlib
from pathlib import Path
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry import electron_count_spin_validation_v1 as src
from sft.engine.canonical import canonical_value
q=lambda s:json.dumps(s,ensure_ascii=False)
def value(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,list):return '.array ['+','.join(value(v)for v in x)+']'
 return '.object []'
def fields(row):
 pops=['⟨'+q(str(p['element_symbol']))+','+str(int(p['atomic_number']))+','+str(int(p['occurrence_count']))+'⟩'for p in row['nuclear_composition']]
 charge='none'if 'charge_count' not in row else 'some ('+value(row['charge_count'])+')'
 return '⟨'+','.join([q(str(row['row_id'])),q(str(row['molecular_formula'])),q(str(row['charge_action'])),charge,'['+','.join(pops)+']'])+'⟩'
rows=list(src._load_inputs(root));actualrows='['+','.join(fields(row)for row in rows)+']'
expected=[];expressions=[]
for action in ['empty-One','adjoin-electron','remove-electron','bad','']:
 for n in [None,False,True,0,-1,1,3,'2',[]]:
  row=dict(rows[0],charge_action=action,charge_count=n)
  try:result=canonical_value(src._transfer_from_row(row))
  except (ValueError,AssertionError)as e:result={'error':str(e)}
  expected.append(result);expressions.append('transferResult (transferFromRow '+fields(row)+')')
prefix='''import SFT.Chemistry.ElectronSpinRegistry
open SFT.Chemistry.ElectronSpinRegistry SFT.Chemistry.ElectronSpinPrediction
abbrev TestJson := SFT.Host.Canonical.Value
def transferResult : Except String SFT.Chemistry.ElectronCountSpin.HeldChargeTransfer → TestJson
 | .error e => .object [("error",.text e)]
 | .ok row => .object [("action",.object [("family",.text row.action.family),("label",.text row.action.label)]),("count",match row.count with | .count n => .object [("value",.integer (.ofNat n.value))] | .emptyOne s => .object [("identity",.text s)])]
def inputResult : Except String (List InputFields) → TestJson
 | .error e => .object [("error",.text e)]
 | .ok rows => .array (rows.map fun r => .text r.rowId)
set_option maxRecDepth 100000
def sourceRows : List InputFields := '''+actualrows+'''
def fullProgram : Except String TestJson := do
 let admitted ← loadInputs SFT.Chemistry.ElectronSpinExperiment.inputRegistryHash (some (.text "sft-v3-electron-spin-inputs/1")) sourceRows
 let inputs ← admitted.mapM countInput
 let predictions ← predictionRows inputs
 return SFT.Chemistry.ElectronSpinExperiment.registration (programDocument predictions)
'''
cases=['loadInputs "changed" none sourceRows','loadInputs SFT.Chemistry.ElectronSpinExperiment.inputRegistryHash none sourceRows','loadInputs SFT.Chemistry.ElectronSpinExperiment.inputRegistryHash (some (.text "sft-v3-electron-spin-inputs/1")) (sourceRows.drop 1)','loadInputs SFT.Chemistry.ElectronSpinExperiment.inputRegistryHash (some (.text "sft-v3-electron-spin-inputs/1")) (sourceRows.map fun (r : InputFields) => {r with rowId := "duplicate"})']
test=w/'electronspin1073_registry_check.lean';test.write_text(prefix+'#eval match fullProgram with\n | .error e => IO.println e\n | .ok registration => IO.println (SFT.Host.Canonical.render (.array [registration,.array ['+','.join(expressions)+'],.array ['+','.join('inputResult ('+c+')'for c in cases)+']]))\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
r=subprocess.run(cmd+[str(test)],env=env,capture_output=True,text=True);(w/'electronspin1073_registry_check.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout[-1500:]
actual=json.loads(r.stdout);assert actual==[canonical_value(src.experiment_registration_record(root)),expected,[{'error':e}for e in ['ELEC-002 prediction input registry changed','ELEC-002 prediction input registry is incomplete','ELEC-002 prediction input registry is incomplete','ELEC-002 prediction rows are duplicated']]]
allnames=[];digests={}
for module in ['ElectronSpinExperiment','ElectronSpinRegistry']:
 file=w/'turn1064_recovery/SFT/Chemistry'/(module+'.lean');names=['SFT.Chemistry.'+module+'.'+n for n in re.findall(r'^def (\w+)',file.read_text(),re.M)]
 audit=w/(module+'1073_audit.lean');a=subprocess.run(cmd+[str(audit)],env=env,capture_output=True,text=True);(w/(module+'1073_audit.log')).write_text(a.stdout+a.stderr);assert a.returncode==0 and a.stdout.count('does not depend on any axioms')==len(names),a.stdout
 allnames+=names;digests[module]=hashlib.sha256(file.read_bytes()).hexdigest()
(w/'electronspin1073_registry_report.json').write_text(json.dumps(dict(status='PASS',registry_rows=22,transfer_cases=len(expected),registry_controls=4,all_registration_fields_match=True,axioms=[],declarations=allnames,source_sha256=digests),indent=2)+'\n')
print('PASS source registration,22 input rows,45 transfer cases,four registry controls;',len(allnames),'zero-axiom declarations')
