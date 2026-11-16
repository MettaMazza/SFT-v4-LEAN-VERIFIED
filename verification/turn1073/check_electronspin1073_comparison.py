import json,sys,os,subprocess,re,hashlib
from pathlib import Path
from types import SimpleNamespace
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry import electron_count_spin_validation_v1 as src
from sft.engine.canonical import canonical_value
captured={};original_identity=src.sha256_identity
def capture(value):
 if isinstance(value,dict) and 'comparisons' in value and 'adverse_controls' in value:captured.update(value)
 return original_identity(value)
src.sha256_identity=capture
validation=src.ElectronCountSpinValidator(root).validate(SimpleNamespace(seal_hash='native-electronspin1073'))
(w/'electronspin1073_original_empirical.json').write_text(json.dumps(canonical_value(validation),indent=2)+'\n')
(w/'electronspin1073_original_payload.json').write_text(json.dumps(canonical_value(captured),indent=2)+'\n')
assert validation.passed
q=lambda s:json.dumps(s,ensure_ascii=False)
pc=lambda n:'⟨'+str(n)+',by decide⟩'
held=lambda f,s:'⟨'+q(f)+','+q(s)+',by rfl,by rfl⟩'
rows=list(src._load_inputs(root));targets=src._source_targets(root);pred=src.prediction_rows(root)
inputs=[];expressions=[];entries=[]
for row,t,p in zip(rows,targets,pred):
 populations=['⟨'+held('element-symbol',str(v['element_symbol']))+','+pc(int(v['atomic_number']))+','+pc(int(v['occurrence_count']))+'⟩'for v in row['nuclear_composition']]
 transferCount='structuralEmpty'if row['charge_action']=='empty-One'else '.count '+pc(row['charge_count'])
 inp='⟨'+q(row['row_id'])+',['+','.join(populations)+'],⟨'+held('electron-transfer',row['charge_action'])+','+transferCount+'⟩⟩';inputs.append(inp)
 pair='('+pc(p['electron_count'])+','+held('spin-width-parity',p['required_spin_width_parity'])+')'
 target='.word [.label '+held('measured-ground-state-term',t['state_term'])+',.count '+pc(t['multiplicity'])+']'
 expressions.append('comparisonResult (compare '+inp+' '+q(row['molecular_formula'])+' '+q(t['state_term'])+' '+pair+' ('+target+'))')
 entries.append('(.label '+held('molecular-row',row['row_id'])+',.word [.count '+pc(p['electron_count'])+',.label '+held('spin-width-parity',p['required_spin_width_parity'])+'])')
first=src.ELECTRON_COUNT_SPIN_SPEC.target_rows[0];data=(root/first.snapshot_path).read_bytes();tamper='sha256:'+hashlib.sha256(data+b'deliberate-tamper').hexdigest()
prefix='''import SFT.Chemistry.ElectronSpinComparison
open SFT.Chemistry.ElectronSpinComparison SFT.Chemistry.ElectronCountSpin
abbrev TestJson := SFT.Host.Canonical.Value
def comparisonResult : Except String Comparison → TestJson
 | .error e => .object [("error",.text e)]
 | .ok row => comparisonValue row
def controlsResult : Except String (List (String × Bool)) → TestJson
 | .error e => .object [("error",.text e)]
 | .ok rows => .object (rows.map fun (k,b) => (k,.boolean b))
def predictionsResult : Except String (List (String × (SFT.Physics.CapabilityValues.PositiveCount × SFT.Physics.CapabilityValues.HeldLabel))) → TestJson
 | .error e => .object [("error",.text e)]
 | .ok rows => .array (rows.map fun (k,n,p) => .array [.text k,.integer (.ofNat n.value),.text p.label])
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
test=w/'electronspin1073_comparison_check.lean';test.write_text(prefix+'#eval IO.println (SFT.Host.Canonical.render (.array [.array ['+','.join(expressions)+'],controlsResult (adverseControls '+inputs[0]+' 22 22 '+q(first.snapshot_hash)+' '+q(tamper)+' '+q(first.snapshot_hash)+'),predictionsResult (predictions (.table ['+','.join(entries)+']))]))\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
r=subprocess.run(cmd+[str(test)],env=env,capture_output=True,text=True);(w/'electronspin1073_comparison_check.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout[-1500:]
actual=json.loads(r.stdout);assert actual==[canonical_value(captured['comparisons']),captured['adverse_controls'],[[p['row_id'],p['electron_count'],p['required_spin_width_parity']]for p in pred]]
module=w/'turn1064_recovery/SFT/Chemistry/ElectronSpinComparison.lean';names=['SFT.Chemistry.ElectronSpinComparison.'+n for n in re.findall(r'^def (\w+)',module.read_text(),re.M)]
audit=w/'electronspin1073_comparison_audit.lean';audit.write_text('import SFT.Chemistry.ElectronSpinComparison\n'+''.join('#print axioms '+n+'\n'for n in names))
a=subprocess.run(cmd+[str(audit)],env=env,capture_output=True,text=True);(w/'electronspin1073_comparison_audit.log').write_text(a.stdout+a.stderr);assert a.returncode==0 and a.stdout.count('does not depend on any axioms')==len(names),a.stdout
(w/'electronspin1073_comparison_report.json').write_text(json.dumps(dict(status='PASS',comparisons=22,controls=5,prediction_rows=22,axioms=[],declarations=names,source_sha256=hashlib.sha256(module.read_bytes()).hexdigest()),indent=2)+'\n')
print('PASS22 source comparisons, five original adverse controls and full prediction-table decoding;',len(names),'zero-axiom declarations')
