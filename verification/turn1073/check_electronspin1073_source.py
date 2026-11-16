import json,sys,os,subprocess,re,unicodedata,hashlib
from pathlib import Path
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry import electron_count_spin_validation_v1 as src
from sft.engine.canonical import canonical_value
q=lambda s:json.dumps(s,ensure_ascii=False)
pc=lambda n:'⟨'+str(n)+',by decide⟩'
held=lambda f,s:'⟨'+q(f)+','+q(s)+',by rfl,by rfl⟩'
formulas=['H2','CO','H2O','O2-','H2+','CH3CH2','C0','H01','H²','H₂','','+','2H','h2','H 2','H2++','H2+-','H2O\n']
formulas += ['H'+chr(n+2) for n in range(0x110000) if unicodedata.category(chr(n))=='Nd' and unicodedata.decimal(chr(n))==0]
expected=[];expressions=[]
for formula in formulas:
 try:
  composition,charge=src._formula_composition(formula);out=[[[k,v]for k,v in composition.items()],charge]
 except ValueError as e:out={'error':str(e)}
 expected.append(out);expressions.append('formulaValue (formulaComposition '+q(formula)+')')
inputs={r['row_id']:r for r in src._load_inputs(root)}
targets=json.loads((root/src.TARGET_REGISTRY_PATH).read_text())['rows'];targets={r['row_id']:r for r in targets}
resolved=src._source_targets(root)
for reference,want in zip(src.ELECTRON_COUNT_SPIN_SPEC.target_rows,resolved):
 row=inputs[reference.target_id];target=targets[reference.target_id]
 parser=src._IndependentNistStateParser();parser.feed((root/reference.snapshot_path).read_text())
 populations=['⟨'+held('element-symbol',str(p['element_symbol']))+','+pc(int(p['atomic_number']))+','+pc(int(p['occurrence_count']))+'⟩'for p in row['nuclear_composition']]
 count='structuralEmpty' if row['charge_action']=='empty-One' else '.count '+pc(row['charge_count'])
 inp='⟨'+q(row['row_id'])+',['+','.join(populations)+'],⟨'+held('electron-transfer',row['charge_action'])+','+count+'⟩⟩'
 targetexpr='⟨'+q(target['snapshot_hash'])+','+q(target['ground_state_term'])+','+str(target['measured_multiplicity'])+'⟩'
 rows='['+','.join('['+','.join(q(x)for x in r)+']'for r in parser.rows)+']'
 expressions.append('resolvedValue (resolveTarget '+inp+' '+q(row['molecular_formula'])+' '+q(reference.snapshot_hash)+' '+q(reference.snapshot_hash)+' '+targetexpr+' '+rows+')')
 expected.append(canonical_value(want))
prefix='''import SFT.Chemistry.ElectronSpinSource
open SFT.Chemistry.ElectronSpinSource SFT.Chemistry.ElectronCountSpin
abbrev J := SFT.Host.Canonical.Value
def formulaValue : Except String (List (String × Nat) × String) → J
 | .error e => .object [("error",.text e)]
 | .ok (rows,charge) => .array [.array (rows.map fun (k,n) => .array [.text k,.integer (.ofNat n)]),.text charge]
def resolvedValue : Except String Resolved → J
 | .error e => .object [("error",.text e)]
 | .ok row => .object [("row_id",.text row.rowId),("state_term",.text row.stateTerm),("multiplicity",.integer (.ofNat row.multiplicity.value)),("snapshot_hash",.text row.snapshotHash),("target_value",SFT.Physics.CapabilityValues.canonical row.targetValue)]
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
test=w/'electronspin1073_source_check.lean';test.write_text(prefix+'#eval IO.println (SFT.Host.Canonical.render (.array ['+','.join(expressions)+']))\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
r=subprocess.run(cmd+[str(test)],env=env,capture_output=True,text=True);(w/'electronspin1073_source_check.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout[-1500:]
actual=json.loads(r.stdout);assert actual==expected,[(i,str(a)[:100],str(b)[:100])for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:3]
module=w/'turn1064_recovery/SFT/Chemistry/ElectronSpinSource.lean';names=['SFT.Chemistry.ElectronSpinSource.'+n for n in re.findall(r'^def (\w+)',module.read_text(),re.M)]
audit=w/'electronspin1073_source_audit.lean';audit.write_text('import SFT.Chemistry.ElectronSpinSource\n'+''.join('#print axioms '+n+'\n'for n in names))
a=subprocess.run(cmd+[str(audit)],env=env,capture_output=True,text=True);(w/'electronspin1073_source_audit.log').write_text(a.stdout+a.stderr);assert a.returncode==0 and a.stdout.count('does not depend on any axioms')==len(names),a.stdout
(w/'electronspin1073_source_report.json').write_text(json.dumps(dict(status='PASS',formula_cases=len(formulas),resolved_targets=len(resolved),axioms=[],declarations=names,source_sha256=hashlib.sha256(module.read_bytes()).hexdigest()),indent=2)+'\n')
print('PASS',len(formulas),'formula cases,22 fully resolved source targets;',len(names),'zero-axiom declarations')
