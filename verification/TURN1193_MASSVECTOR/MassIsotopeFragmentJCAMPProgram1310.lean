import SFT.Chemistry.MassIsotopeFragmentAnalysis
import Lean
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/massvector1310_jcamp_cases.json"
 let input ← IO.ofExcept (Lean.Json.parse raw >>= Lean.Json.getArr?)
 let result ← input.toList.mapM fun row => do
  let name ← IO.ofExcept (row.getObjValAs? String "name")
  let text ← IO.ofExcept (row.getObjValAs? String "text")
  return SFT.Host.Canonical.Value.object [("name",.text name),("passed",.boolean (SFT.Chemistry.MassIsotopeFragmentAnalysis.jcampComplete text "MASS SPECTRUM"))]
 IO.println (SFT.Host.Canonical.render (.array result))
