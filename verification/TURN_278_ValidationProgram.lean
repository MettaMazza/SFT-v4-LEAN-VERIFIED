import SFT.Physics.LeptonValidation
import Lean
open SFT.Physics LeptonPrediction LeptonExperiment LeptonCustody LeptonValidation SFT.Host.Canonical
set_option maxRecDepth 20000

def must {α : Type} : Except String α → IO α
 | .error e => throw (IO.userError e)
 | .ok x => pure x

def status {α : Type} : Except String α → Value
 | .error e => .text e
 | .ok _ => .text "ok"

-- IO-only port of the source pathlib/hashlib snapshot adapter. No V3 modules
-- are imported or executed; all protected files and all fields are retained.
def snapshot (root : System.FilePath) : IO Snapshot := do
 let output ← IO.Process.output {cmd := "/usr/bin/python3", args := #["-c", "from pathlib import Path\nimport hashlib,json,sys\nroot=Path(sys.argv[1]).resolve()\nrows=[]\nfor relative in (\"census\",\"receipts/engine/model_admitted\"):\n directory=root/relative\n if not directory.is_dir(): raise RuntimeError(\"HostilePackageHalt: protected authority directory is missing: \"+relative)\n for path in sorted(p for p in directory.rglob(\"*\") if p.is_file()):\n  rows.append((path.relative_to(root).as_posix(),\"sha256:\"+hashlib.sha256(path.read_bytes()).hexdigest()))\npayload={\"root_identity\":root.name,\"file_hashes\":rows}\npayload[\"snapshot_hash\"]=\"sha256:\"+hashlib.sha256(json.dumps(payload,sort_keys=True,separators=(\",\",\":\"),ensure_ascii=True).encode()).hexdigest()\nprint(json.dumps(payload,separators=(\",\",\":\")))\n",root.toString]}
 if output.exitCode != 0 then throw (IO.userError output.stderr)
 let parsed ← must (Lean.Json.parse output.stdout)
 let rootId ← must (parsed.getObjValAs? String "root_identity")
 let files ← must (parsed.getObjValAs? (List (String × String)) "file_hashes")
 let snapshotHash ← must (parsed.getObjValAs? String "snapshot_hash")
 pure ⟨rootId,files,snapshotHash⟩

def main (args : List String) : IO Unit := do
 let derivationSeal := args.headD ""
 let root : System.FilePath := (args.drop 1).headD ""
 let bytes ← IO.FS.readBinFile (root / sourcePath)
 let before ← snapshot root
 let execution ← must (execute derivationSeal)
 let _prediction ← must (nativeSeal derivationSeal)
 let after ← snapshot root
 let numeric ← must (LeptonComparison.comparisonWithin (String.fromUTF8! bytes) 27 15)
 let numeric ← match numeric with
   | none => throw (IO.userError "original numeric refinement did not finish")
   | some value => pure value
 let validation ← must (validate bytes derivationSeal "Darwin" "CPython" before after)
 let result ← must (requireAgreement numeric validation)
 let audit ← must (auditRegistered before after)
 let vault := registeredVault derivationSeal
 let predictionSeal ← must (nativeSeal derivationSeal)
 let (_,released) ← must (release vault predictionSeal)
 let comparison ← must (compareRows expectedLabel targets targetRows)
 let changed ← must (compareRows "changed-external-observation" targets targetRows)
 let trace := execution.trace.map traceValue
 IO.println (render (.object [
   ("validation",result.value),("audit",audit),("trace",.array trace),
   ("numeric_passed",.boolean numeric.allRowsPassed),
   ("comparison_rows",.array (comparison.map comparisonValue)),
   ("tampered_control",controlValue expectedLabel),
   ("snapshot_before_hash",.text before.snapshotHash),("snapshot_after_hash",.text after.snapshotHash),
   ("checks",.object [
     ("changed_tree",status (auditRegistered before {before with rootId := "changed"})),
     ("changed_source",status (validate (bytes.push 32) derivationSeal "Darwin" "CPython" before after)),
     ("wrong_prediction_family",status (observation (.label "external-observation" expectedLabel))),
     ("pair_prediction",status (observation (.pair (.label "a" "b") (.label "c" "d")))),
     ("missing_row",status (compareRows expectedLabel [] targetRows)),
     ("numeric_disagreement",status (requireAgreement numeric {validation with passed := false})),
     ("executable_key",.boolean (executablePresent ["schema","program_id","instructions","python"])),
     ("extra_field",.boolean (additionalFields ["schema","program_id","instructions","extra"])),
     ("missing_field",.boolean (additionalFields ["schema","program_id"])),
     ("changed_predictions_fail",.boolean (!(allPassed "changed-external-observation" changed))),
     ("registered_spec",status validateSpec),
     ("vault_empty_identity",status (checkVault {vault with nonce := ""})),
     ("vault_empty_targets",status (checkVault {vault with values := []})),
     ("vault_invalid_envelope",status (checkVault {vault with commitment := {vault.commitment with expectedEnvelopeHash := "bad"}})),
     ("release_invalid_identity",status (identityFromRelease {released with targetHash := "bad"}))])]))
