import SFT.Physics.CosmoCompleteBudget
import Lean
open SFT.Physics
def ratioJson (q : Rat) : Lean.Json := .arr #[Lean.toJson q.num,Lean.toJson q.den]
def main : IO Unit := do
 match CosmoCompleteBudget.cosmicBudgetStructure with
 | .error e => throw (IO.userError e)
 | .ok b => IO.println ((Lean.Json.mkObj [
  ("depth",Lean.toJson b.depth),
  ("support",Lean.toJson b.support),
  ("pinned",Lean.toJson b.pinned),
  ("free",Lean.toJson b.free),
  ("matter",ratioJson b.matter),
  ("vacuum",ratioJson b.vacuum),
  ("baryon_within_matter",ratioJson b.baryonWithinMatter),
  ("dark_within_matter",ratioJson b.darkWithinMatter),
  ("baryon",ratioJson b.baryon),
  ("cold_dark",ratioJson b.coldDark)]).compress)
