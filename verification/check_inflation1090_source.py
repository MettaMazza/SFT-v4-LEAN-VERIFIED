from pathlib import Path
from types import SimpleNamespace
import json,sys,subprocess,os,ast,hashlib
w=Path('work');r=w/'turn1064_recovery';runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.materials import successor_evidence as src
spec=next(x for x in src.SPECS if x.claim_id=='SFT-MAT-CRYST-QUASICRYSTAL-INFLATION-002')
payload=json.loads((runtime/src.PRE_SOURCE_SEAL_PATH).read_text());paths=list(payload['source_files'])+[src.SOURCE_BY_ID[spec.source_ids[0]].path]
inputpath=w/'inflation1090_source_input.json';inputpath.write_text(json.dumps(dict(seal_path=str(runtime/src.PRE_SOURCE_SEAL_PATH),files=[dict(path=p,local=str(runtime/p))for p in paths])))
head=Path('work/ResonanceValidationProgram1089.lean').read_text();head=head[:head.index('def protectedSnapshot')].replace('import SFT.Chemistry.ResonanceEquivalentValidation','import SFT.Materials.QuasicrystalInflationSource').replace('open SFT.Chemistry SFT.Physics','open SFT.Materials QuasicrystalInflationSource')
head+='''def result : Except String SFT.Host.Canonical.Value → SFT.Host.Canonical.Value
 | .ok value => .object [("ok",value)]
 | .error e => .object [("error",.text e)]
def main (args : List String) : IO Unit := do
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
 let sealResult := result (do let hash ← validatePreSourceSeal payload files; pure (.text hash))
 let observed := result (do let rows ← receipts files; pure (.array rows))
 let tampered := files.map (fun file => {file with bytes := file.bytes.push 32})
 let badSeal := result (do let hash ← validatePreSourceSeal payload tampered; pure (.text hash))
 let badSource := result (do let rows ← receipts tampered; pure (.array rows))
 IO.println (SFT.Host.Canonical.render (.object [("seal",sealResult),("receipts",observed),("changed_source",badSeal),("changed_snapshot",badSource)]))
''';harness=w/'InflationSourceProgram1090.lean';harness.write_text(head)
method=next(n for n in ast.walk(ast.parse((runtime/'sft/materials/successor_evidence.py').read_text()))if isinstance(n,ast.FunctionDef)and n.name=='validate'and any(isinstance(x,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='receipts'for t in x.targets)for x in n.body))
assignment=next(n for n in method.body if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='receipts'for t in n.targets));loop=next(n for n in method.body if isinstance(n,ast.For));scope=dict(vars(src),self=SimpleNamespace(root=runtime,spec=spec));exec(compile(ast.Module(body=[assignment,loop],type_ignores=[]),'<original-receipt-loop>','exec'),scope)
expected=dict(seal={'ok':src.validate_pre_source_seal(runtime)},receipts={'ok':[list(row)for row in scope['receipts']]},changed_source={'error':'sealed successor source changed'},changed_snapshot={'error':'successor external source mismatch'})
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'inflation1090_source_output.json').open('w')as out,(w/'inflation1090_source_execution.log').open('w')as err:subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(harness),str(inputpath)],env=env,stdout=out,stderr=err,check=True)
assert json.loads((w/'inflation1090_source_output.json').read_text())==expected
log=(w/'inflation1090_source_build2.log').read_text();assert log.count('does not depend on any axioms')==7 and'depends on axioms:'not in log
(w/'inflation1090_source_report.json').write_text(json.dumps(dict(status='PASS',preseal_source_files=3,receipt_rows=2,changed_source_and_snapshot_rejected=True,all_original_fields_match=True,axioms=[],declarations=7,source_sha256=hashlib.sha256((r/'SFT/Materials/QuasicrystalInflationSource.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS original seal, all3 source hashes, both original receipts and changed-source controls;7 empty-axiom declarations')
