import SFT.Physics.LeptonComparison
open SFT.Physics LeptonSource LeptonComparison SFT.Host.Canonical
set_option maxRecDepth 20000

def fractionText (x : Rat) : String := if x.den == 1 then s!"{x.num}" else s!"{x.num}/{x.den}"
def pairValue (p : Rat × Rat) : Value := .array [.text (fractionText p.1),.text (fractionText p.2)]
def rowValue (r : Row) : Value := .object [
 ("predicted_interval",pairValue r.predicted),("source_interval",pairValue r.source),
 ("source_central",.text (fractionText r.central)),("overlap",.boolean r.overlaps)]
def recordValue (r : Record) : Value := .object [
 ("muon_electron",rowValue r.muonElectron),("muon_tau",rowValue r.muonTau),("all_rows_passed",.boolean r.allRowsPassed)]
def main (args : List String) : IO Unit := do
 let text ← IO.FS.readFile (args.headD "")
 let rawRows := lines (SFT.Host.Text.chars text)
 if rawRows != snapshotRows ++ [[]] then throw (IO.userError "full snapshot row sequence differs")
 match comparisonWithin text 27 15 with
 | .error e => throw (IO.userError e)
 | .ok none => throw (IO.userError "incomplete comparison")
 | .ok (some r) => IO.println (render (recordValue r))
