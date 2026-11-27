import SFT.Host.SHA256Streaming
import SFT.Chemistry.AdditionValidation
import SFT.Physics.HostilePackage
import Lean
open SFT.Chemistry SFT.Physics
abbrev CJ := SFT.Host.Canonical.Value
def convert : Nat → Lean.Json → Except String CJ
 | 0,_ => .error "JSON nesting exceeds input byte count"
 | n+1,j => match j with
  | .null => .ok .null
  | .bool b => .ok (.boolean b)
  | .num _ => do return .integer (← j.getInt?)
  | .str s => .ok (.text s)
  | .arr xs => do return .array (← xs.toList.mapM (convert n))
  | .obj fs => do return .object (← fs.toList.mapM fun (k,v) => do return (k,← convert n v))
def field (j : Lean.Json) (name : String) := j.getObjVal? name
def text (j : Lean.Json) (name : String) := j.getObjValAs? String name
def items (j : Lean.Json) (name : String) : Except String (List Lean.Json) := do
 return (← (← field j name).getArr?).toList
def protectedSnapshot (j : Lean.Json) : Except String HostilePackage.Snapshot := do
 let pairs ← (← items j "file_hashes").mapM fun row => do
  let a ← row.getArr?
  return (← a[0]!.getStr?,← a[1]!.getStr?)
 return ⟨← text j "root_identity",pairs,← text j "snapshot_hash"⟩


def stage : String := "work/pinned_addition1499/"
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
