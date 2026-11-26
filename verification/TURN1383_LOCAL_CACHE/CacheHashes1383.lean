import Lake
open Lean Lake
structure Item where
 path : String
 text : Bool
 deriving FromJson
def main (args : List String) : IO Unit := do
 let raw ← IO.FS.readFile (args.headD "")
 let items : Array Item ← IO.ofExcept ((Json.parse raw) >>= fromJson?)
 for item in items do
  let value ← computeFileHash item.path item.text
  IO.println (Json.compress (toJson (item.path,toString value)))
