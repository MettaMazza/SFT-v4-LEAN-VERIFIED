import SFT.Biology.LifeOrganizationSource
import Lean
open SFT.Host SFT.Host.Canonical SFT.Biology
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev J := Lean.Json
def field (j : J) (k : String) := j.getObjVal? k
def text (j : J) (k : String) := j.getObjValAs? String k
def items (j : J) (k : String) : Except String (List J) := do return (← (← field j k).getArr?).toList
def bytesValue (j : J) : Except String ByteArray := do
 let ns ← (← j.getArr?).toList.mapM fun n => n.getNat?
 return ⟨(ns.map UInt8.ofNat).toArray⟩
def main (args : List String) : IO Unit := do
 let raw ← IO.FS.readFile "work/lifeorganization1106_source_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let mode := args.headD "controls"
 if mode=="controls" then
  let cases ← IO.ofExcept ((← IO.ofExcept (items input "decode_cases")).mapM bytesValue)
  let texts ← IO.ofExcept ((← IO.ofExcept (items input "corpus_cases")).mapM Lean.Json.getStr?)
  IO.println (render (.object [("decode",.array (cases.map fun b => .text (LifeOrganizationSource.decodeReplace b))),
   ("corpus",.array (texts.map fun s => .text (LifeOrganizationSource.corpus s.toUTF8)))]))
 else
  let entries ← IO.ofExcept (items input "files")
  let files ← entries.mapM fun entry => do
   let path ← IO.ofExcept (text entry "path")
   let localPath ← IO.ofExcept (text entry "local")
   let bytes ← IO.FS.readBinFile localPath
   return SFT.Materials.MaterialSource.Snapshot.mk path bytes
  let sources ← IO.ofExcept (LifeOrganizationSource.sources.mapM fun source => do
   let bytes ← LifeOrganizationSource.readSnapshot files source.path
   return Value.array [.text source.sourceId,.text (SHA256Window.digest (LifeOrganizationSource.corpus bytes).toUTF8)])
  let target := match LifeOrganizationSource.sourceDerivedTarget files with
   | .error e => Value.object [("error",.text e)]
   | .ok (label,hash) => Value.object [("ok",.array [.text label,.text hash])]
  IO.println (render (.object [("sources",.array sources),("target",target)]))
