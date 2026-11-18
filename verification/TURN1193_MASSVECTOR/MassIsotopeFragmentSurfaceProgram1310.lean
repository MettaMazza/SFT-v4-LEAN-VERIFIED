import SFT.Chemistry.MassIsotopeFragmentAnalysis
import Lean
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/massvector1310_surface_cases.json"
 let cases ← IO.ofExcept (Lean.Json.parse raw >>= Lean.Json.getArr?)
 let results ← cases.toList.mapM fun item => do
  let name ← IO.ofExcept (item.getObjValAs? String "name")
  let rows ← IO.ofExcept (item.getObjVal? "files" >>= Lean.Json.getArr?)
  let files ← rows.toList.mapM fun row => do
   let path ← IO.ofExcept (row.getObjValAs? String "path")
   let bytes ← IO.ofExcept (row.getObjVal? "bytes" >>= Lean.Json.getArr?)
   let values ← bytes.toList.mapM fun n => IO.ofExcept n.getNat?
   return SFT.Materials.MaterialSource.Snapshot.mk path ⟨(values.map Nat.toUInt8).toArray⟩
  let result : SFT.Host.Canonical.Value := match SFT.Chemistry.MassIsotopeFragmentAnalysis.independentSurface files with
   | .error _ => .object [("status",.text "utf8-error")]
   | .ok (count,passed) => .object [("status",.text "ok"),("count",.integer (.ofNat count)),("passed",.boolean passed)]
  return SFT.Host.Canonical.Value.object [("name",.text name),("result",result)]
 IO.println (SFT.Host.Canonical.render (.array results))
