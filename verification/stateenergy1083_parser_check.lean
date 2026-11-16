import Lean
import SFT.Chemistry.StateEnergySourceTables
open SFT.Chemistry.ElectronSpinHtml
open SFT.Chemistry.StateEnergySourceTables
def eventFromJson (j : Lean.Json) : Except String Event := do
 let xs ← j.getArr?
 let kind ← xs[0]!.getStr?
 let value ← xs[1]!.getStr?
 if kind == "data" then return .data value
 if kind == "end" then return .endTag value
 let attrs ← xs[2]!.getArr?
 let pairs ← attrs.toList.mapM fun a => do
  let pair ← a.getArr?
  let key ← pair[0]!.getStr?
  let value := match pair[1]! with | .null => none | _ => pair[1]!.getStr?.toOption
  return (key,value)
 return .startTag value pairs
def process (j : Lean.Json) : Except String String := do
 let kind ← j.getObjValAs? String "kind"
 if kind == "unescape" then
  return unescape (← j.getObjValAs? String "input")
 let events ← (← (← j.getObjVal? "events").getArr?).toList.mapM eventFromJson
 let p := SFT.Chemistry.StateEnergySourceTables.parseEvents events
 return SFT.Host.Canonical.render (.object [("depth",.integer (.ofNat p.depth)),("in_row",.boolean p.rowFlag),("in_cell",.boolean p.cellFlag),("note",.integer (.ofNat p.note)),("cell",.array (p.cell.map .text)),("row",.array (p.row.map .text)),("rows",.array (p.rows.map fun row => .array (row.map .text)))])
def main : IO Unit := do
 let stdin ← IO.getStdin
 let stdout ← IO.getStdout
 repeat
  let line ← stdin.getLine
  if line.isEmpty then break
  match Lean.Json.parse line >>= process with
  | .ok result => stdout.putStrLn (Lean.Json.str result).compress
  | .error e => throw (IO.userError e)
