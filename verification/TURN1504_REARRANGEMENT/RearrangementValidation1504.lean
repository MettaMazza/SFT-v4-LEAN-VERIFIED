import SFT.Host.SHA256Streaming
import SFT.Chemistry.RearrangementValidation
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


def stage : String := "work/pinned_rearrangement1504/"
def sourceReceipt (path : String) : IO RearrangementAnalysis.FileReceipt := do
 let full : System.FilePath := stage++path
 if !(← full.pathExists) then return ⟨path,false,0,""⟩
 let bytes ← IO.FS.readBinFile full
 return ⟨path,true,bytes.size,SFT.Host.Text.append "sha256:" (SFT.Host.SHA256Streaming.digest bytes)⟩
def receiptHash (files : List RearrangementAnalysis.FileReceipt) (path : String) : Except String String :=
 match files.find? (fun r => SFT.Host.Text.equal r.path path) with
 | none => .error ("missing source receipt: "++path)
 | some r => .ok r.hash
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/rearrangement1504_empirical_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let doc := fun name => IO.ofExcept (field input name >>= convert (raw.utf8ByteSize+1))
 let paths ← IO.ofExcept (field input "paths")
 let filePaths ← IO.ofExcept ((← IO.ofExcept (items input "source_files")).mapM Lean.Json.getStr?)
 let files ← filePaths.mapM sourceReceipt
 let hash := fun name => do
  let path ← IO.ofExcept (text paths name)
  IO.ofExcept (receiptHash files path)
 let rawPages ← IO.ofExcept ((← IO.ofExcept (items input "rawPages")).mapM Lean.Json.getStr?)
 let data : RearrangementAnalysis.Input := ⟨← doc "analysisDocument",← doc "inventory",← doc "identityDocument",← doc "preseal",← doc "firstAnalysis",← doc "molecularDefinition",← doc "stageDefinition",← IO.ofExcept (text input "aliasText"),rawPages,files,← hash "analysisDocument",← hash "inventory"⟩
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let derivationSeal ← IO.ofExcept (text input "derivation_seal")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let analysis : CJ := match RearrangementAnalysis.analysis data with
  | .error e => .object [("error",.text e)]
  | .ok (a,checks) => .object [("analysis",a),("checks",.object (checks.map fun (k,v) => (k,.boolean v)))]
 let empirical : CJ := match RearrangementValidation.validate data derivationSeal host implementation before after with
  | .error e => .object [("error",.text e)]
  | .ok r => r.value
 IO.println (SFT.Host.Canonical.render (.object [("analysis_result",analysis),("empirical_result",empirical)]))
