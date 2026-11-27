from pathlib import Path
import sys,json,platform
w=Path('work');stage=w/'pinned_addition1499';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()));from sft.chemistry import addition_reaction_batch_v3 as b,addition_reaction_validation_v3 as v
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
paths={'identityDocument':b.IDENTITY_PATH,'preseal':b.PRESEAL_PATH,'inventory':b.INVENTORY_PATH,'selection':b.SELECTION_PATH,'selectionSeal':b.SELECTION_SEAL_PATH,'comparison':b.COMPARISON_PATH,'historyV5':v.V5_SELECTION,'historyV6':v.V6_COMPARISON,'historyV8':v.V8_COMPARISON}
x={k:json.loads((stage/p).read_text())for k,p in paths.items()};x['queryV7']=(stage/v.V7_QUERY).read_text()
x['prior_identity_paths']=[f'experiments/external_sources/chemistry/org_009_target_identities_v{version}.json'for version in range(1,5)]
x['paths']={k:p for k,p in paths.items()};x['paths']['analyzer']=v.V9_ANALYZER
x['source_files']=[r['path']for r in json.load(open(w/'addition1501_source_pin.json'))['files']]
x.update(before=canonical_value(snapshot_protected_tree(stage)),after=canonical_value(snapshot_protected_tree(stage)),derivation_seal='native-addition1501',host=platform.system(),implementation=platform.python_implementation())
(w/'addition1502_empirical_input.json').write_text(json.dumps(x,indent=2)+'\n')
analysis,checks=v.exact_analysis(stage);(w/'addition1502_analysis_expected.json').write_text(json.dumps({'analysis':analysis,'checks':checks},indent=2)+'\n')
s=(w/'ElectrophilicValidationStreaming1499.lean').read_text();s=s[:s.index('def sourceHash')].replace('ElectrophilicValidation','AdditionValidation')
s+='''def stage : String := "work/pinned_addition1499/"
def sourceReceipt (path : String) : IO AdditionAnalysis.FileReceipt := do
 let full : System.FilePath := stage++path
 if !(← full.pathExists) then return ⟨path,false,0,""⟩
 let bytes ← IO.FS.readBinFile full
 return ⟨path,true,bytes.size,SFT.Host.Text.append "sha256:" (SFT.Host.SHA256Streaming.digest bytes)⟩
def receiptHash (files : List AdditionAnalysis.FileReceipt) (path : String) : Except String String :=
 match files.find? (fun r => SFT.Host.Text.equal r.path path) with
 | none => .error ("missing source receipt: "++path)
 | some r => .ok r.hash
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/addition1502_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let doc := fun name => IO.ofExcept (field input name >>= convert (raw.utf8ByteSize+1))
 let paths ← IO.ofExcept (field input "paths")
 let filePaths ← IO.ofExcept ((← IO.ofExcept (items input "source_files")).mapM Lean.Json.getStr?)
 let files ← filePaths.mapM sourceReceipt
 let hash := fun name => do
  let path ← IO.ofExcept (text paths name)
  IO.ofExcept (receiptHash files path)
 let priorPaths ← IO.ofExcept ((← IO.ofExcept (items input "prior_identity_paths")).mapM Lean.Json.getStr?)
 let priorPresent ← priorPaths.mapM fun path => (System.FilePath.mk (stage++path)).pathExists
 let data : AdditionAnalysis.Input := ⟨← doc "identityDocument",← doc "preseal",← doc "inventory",← doc "selection",
  ← doc "selectionSeal",← doc "comparison",← doc "historyV5",← doc "historyV6",← doc "historyV8",
  ← IO.ofExcept (text input "queryV7"),priorPresent,files,
  ← hash "selection",← hash "inventory",← hash "selectionSeal",← hash "preseal",← hash "analyzer",← hash "comparison"⟩
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let analysis : CJ := match AdditionAnalysis.analysis data with
  | .error e => .object [("error",.text e)]
  | .ok (a,checks) => .object [("analysis",a),("checks",.object (checks.map fun (k,v) => (k,.boolean v)))]
 let empirical : CJ := match AdditionValidation.validate data derivationSeal host implementation before after with
  | .error e => .object [("error",.text e)]
  | .ok r => r.value
 IO.println (SFT.Host.Canonical.render (.object [("analysis_result",analysis),("empirical_result",empirical)]))
'''
(w/'AdditionValidation1502.lean').write_text(s)
print('Prepared original analysis expectation,104source byte inputs and fresh native runtime')
