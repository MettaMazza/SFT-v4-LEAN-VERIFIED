from pathlib import Path
from types import SimpleNamespace
import sys,json,copy,subprocess,os,re,hashlib
w=Path('work');r=w/'turn1064_recovery';runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.chemistry import conjugated_support_validation_v1 as src
from sft.engine.canonical import canonical_value
from sft.claim_evidence.fold_language import FoldTable,FoldPair,FoldWord
from sft.engine.exact import HeldLabel
captured={};identity=src.sha256_identity
def capture(value):
 if isinstance(value,dict)and all(k in value for k in ['analysis','comparisons','controls']):captured.update(value)
 return identity(value)
src.sha256_identity=capture
empirical=canonical_value(src.ConjugatedSupportValidator(runtime).validate(SimpleNamespace(seal_hash='native-conjugated1079')));assert empirical['passed']
(w/'conjugated1079_original_empirical.json').write_text(json.dumps(empirical,indent=2)+'\n');(w/'conjugated1079_original_payload.json').write_text(json.dumps(canonical_value(captured),indent=2)+'\n')
execution=src.CapabilityClosedFoldInterpreter().execute(src.fold_program_from_mapping(src.prediction_program_document(runtime)),{'registered-premise':HeldLabel('sealed-derivation','native-conjugated1079')});output=execution.output;predicted=src._prediction_map(output);rows=src._source_rows(runtime)
q=lambda x:json.dumps(str(x),ensure_ascii=False)
def held(x):return '⟨'+q(x.family)+','+q(x.label)+',by rfl,by rfl⟩'
def value(x):
 if isinstance(x,HeldLabel):return '.label '+held(x)
 if isinstance(x,FoldWord):return '.word ['+','.join(value(v)for v in x.cells)+']'
 if isinstance(x,FoldTable):return '.table ['+','.join('('+value(p.left)+','+value(p.right)+')'for p in x.entries)+']'
 raise TypeError(type(x))
def rawTable(entries):
 result=object.__new__(FoldTable);object.__setattr__(result,'entries',entries);return result
mapcases=[('original',output),('omitted',FoldTable(output.entries[:-1])),('duplicate',rawTable((output.entries[0],)+output.entries[:-1])),('wrong-family',FoldTable((FoldPair(HeldLabel('wrong',output.entries[0].left.label),output.entries[0].right),)+output.entries[1:])),('short-word',FoldTable((FoldPair(output.entries[0].left,FoldWord(output.entries[0].right.cells[:-1])),)+output.entries[1:]))]
mapExpected=[];mapExpr=[]
for name,out in mapcases:
 try:res=src._prediction_map(out);expected={'ok':[[key,canonical_value(word)]for key,word in res.items()]}
 except ValueError as e:expected={'error':str(e)}
 mapExpected.append([name,expected]);mapExpr.append('('+q(name)+',predictionMap ('+value(out)+'))')
comparisons=[]
for row in rows:
 identityLean='⟨'+','.join(q(row[k])for k in src.IDENTITY_KEYS)+'⟩';word=predicted[row['target_id']];released=HeldLabel('external-complete-source-record-hash',row['target_payload_hash']);comparisons.append('compare '+identityLean+' '+q(row['target_payload_hash'])+' ['+','.join(value(c)for c in word.cells)+'] ('+value(released)+')')
harness='''import SFT.Chemistry.ConjugatedSupportComparison
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.ConjugatedSupportComparison
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000
abbrev J := Canonical.Value
def mapResult : Except String Predictions → J
 | .error e => .object [("error",.text e)]
 | .ok rows => .object [("ok",.array (rows.map (fun (key,word) => .array [.text key,canonical (.word word)])))]
def compareResult : Except String Comparison → J
 | .error e => .object [("error",.text e)]
 | .ok row => comparisonValue row
'''+ 'def maps : List (String × Except String Predictions) := ['+','.join(mapExpr)+']\ndef comparisons : List (Except String Comparison) := ['+','.join(comparisons)+''']
def main : IO Unit := IO.println (Canonical.render (.object [
 ("maps",.array (maps.map (fun (name,out) => .array [.text name,mapResult out]))),
 ("comparisons",.array (comparisons.map compareResult))]))
'''
p=w/'ConjugatedComparisonProgram1079.lean';p.write_text(harness)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)]
with (w/'conjugated1079_comparison_output.json').open('w')as out,(w/'conjugated1079_comparison_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert run.returncode==0,run.returncode
actual=json.loads((w/'conjugated1079_comparison_output.json').read_text());assert actual['maps']==mapExpected;assert actual['comparisons']==canonical_value(captured['comparisons'])
log=(w/'conjugated1079_comparison_build2.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",log);assert len(names)==8 and 'depends on axioms:'not in log
report=dict(status='PASS',prediction_map_cases=5,comparison_rows=10,all_fields_match=True,expected_comparisons='Captured directly from original ConjugatedSupportValidator.validate payload',axioms=[],declarations=names,source_sha256=hashlib.sha256((r/'SFT/Chemistry/ConjugatedSupportComparison.lean').read_bytes()).hexdigest())
(w/'conjugated1079_comparison_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS five source prediction-map cases and all ten original validator comparison records;8 declarations zero axioms')
