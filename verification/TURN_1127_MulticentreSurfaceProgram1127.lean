import SFT.Chemistry.MulticentreSurface
import Lean
open SFT.Host SFT.Chemistry
abbrev J := Canonical.Value
def strings (xs : List String) : J := .array (xs.map Canonical.Value.text)
def result (p : MulticentreSurface.Parser) : J := .object [
 ("in_cell",.boolean p.inCell),("in_row",.boolean p.inRow),("cell",strings p.cell),("row",strings p.row),
 ("rows",.array (p.rows.map strings)),("all_parts",strings p.allParts),("text",.text (MulticentreSurface.text p))]
def event (x : Lean.Json) : Except String MulticentreSurface.Event := do
 let a ← x.getArr?
 let k ← a[0]!.getStr?
 let v ← a[1]!.getStr?
 if k=="start" then return .startTag v []
 if k=="end" then return .endTag v
 return .data v
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/multicentresurface1127_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw >>= Lean.Json.getArr?)
 let results ← input.toList.mapM fun x => do
  let events ← IO.ofExcept (do (← x.getArr?).toList.mapM event)
  return result (MulticentreSurface.parseEvents events)
 IO.println (Canonical.render (.array results))
