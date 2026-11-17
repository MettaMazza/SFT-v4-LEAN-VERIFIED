from pathlib import Path
import sys,json,hashlib,subprocess,os,platform
w=Path('work');r=w/'turn1064_recovery';runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.materials import successor_evidence as src
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
expected=json.loads((w/'edgecount1097_original_empirical.json').read_text());assert expected['passed']
data=json.loads((w/'edgecount1097_source_input.json').read_text());before=snapshot_protected_tree(runtime);data.update(before=canonical_value(before),after=canonical_value(before),derivation_seal='native-edgecount1097',host=platform.system(),implementation=platform.python_implementation());inp=w/'edgecount1097_empirical_input.json';inp.write_text(json.dumps(data))
s=Path('work/ResonanceValidationProgram1089.lean').read_text();s=s[:s.index('def main')].replace('import SFT.Chemistry.ResonanceEquivalentValidation','import SFT.Materials.BoundaryEdgeCountValidation').replace('open SFT.Chemistry SFT.Physics','open SFT.Materials SFT.Physics')
s+='''def main (args : List String) : IO Unit := do
 let input ← IO.FS.readFile (args.headD "")
 let parsed ← IO.ofExcept (Lean.Json.parse input)
 let path ← IO.ofExcept (text parsed "seal_path")
 let sealText ← IO.FS.readFile path
 let sealJson ← IO.ofExcept (Lean.Json.parse sealText)
 let payload ← IO.ofExcept (convert (sealText.utf8ByteSize+1) sealJson)
 let entries ← IO.ofExcept (items parsed "files")
 let files ← entries.mapM (fun entry => do
  let path ← IO.ofExcept (text entry "path")
  let localPath ← IO.ofExcept (text entry "local")
  let bytes ← IO.FS.readBinFile localPath
  pure ({path:=path,bytes:=bytes} : MaterialSource.Snapshot))
 let output ← IO.ofExcept (do
  let before ← field parsed "before" >>= protectedSnapshot
  let after ← field parsed "after" >>= protectedSnapshot
  BoundaryEdgeCountValidation.validate payload files (← text parsed "derivation_seal")
   (← text parsed "host") (← text parsed "implementation") before after)
 IO.println (SFT.Host.Canonical.render output)
''';p=w/'BoundaryEdgeValidationProgram1097.lean';p.write_text(s)
modules=['BoundaryEdgeCount','BoundaryEdgeCountSource','BoundaryEdgeCountExperiment','BoundaryEdgeCountValidation'];digests={n:hashlib.sha256((r/'SFT/Materials'/(n+'.lean')).read_bytes()).hexdigest()for n in modules};inputs={x['path']:hashlib.sha256(Path(x['local']).read_bytes()).hexdigest()for x in data['files']}
(w/'edgecount1097_empirical_start.json').write_text(json.dumps(dict(source_sha256=digests,input_file_sha256=inputs,expected_sha256=hashlib.sha256((w/'edgecount1097_original_empirical.json').read_bytes()).hexdigest()),indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'edgecount1097_empirical_output_raw.json').open('w')as out,(w/'edgecount1097_empirical_execution.log').open('w')as err:subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p),str(inp)],env=env,stdout=out,stderr=err,check=True)
assert snapshot_protected_tree(runtime)==before
for n,h in digests.items():assert hashlib.sha256((r/'SFT/Materials'/(n+'.lean')).read_bytes()).hexdigest()==h
for x in data['files']:assert hashlib.sha256(Path(x['local']).read_bytes()).hexdigest()==inputs[x['path']]
actual=json.loads((w/'edgecount1097_empirical_output_raw.json').read_text());assert actual==expected,[k for k in expected if expected[k]!=actual.get(k)]
(w/'edgecount1097_empirical_output.json').write_text(json.dumps(actual,indent=2)+'\n');(w/'edgecount1097_empirical_report.json').write_text(json.dumps(dict(status='PASS',fields=len(actual),messages=len(actual['measurements']),all_fields_and_hashes_match=True,source_sha256=digests,input_file_sha256=inputs,protected_tree_unchanged=True),indent=2)+'\n');print('PASS complete native empirical return',len(actual),'fields',len(actual['measurements']),'messages and all hashes',flush=True)
