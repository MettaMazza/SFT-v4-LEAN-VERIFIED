import SFT.Applications.Discovery.USDENull
open SFT.Applications.Discovery
open SFT.Applications.Discovery.PythonRandom
open SFT.Applications.Discovery.Display
open SFT.Applications.Discovery.Reports
open SFT.Host.Text

def require (name : String) (ok : Bool) : IO Unit :=
 bif ok then line (append "PASS " name) else throw (IO.userError (append "FAIL " name))
def main (args : List String) : IO Unit := do
 let initial := seed (61731+24903*2^32+614*2^64+42143*2^96)
 let (_,samples) := (List.range 2000).foldl (fun (g,xs) _ => let (x,g) := next53 g; (g,x::xs)) (initial,([] : List Nat))
 let expected : List Nat := [0x0eab3258d2231f,0x1b89db315277a5,0x1db622a5518016,0x0b7f9af0d575bf,0x029e4c4db82240,0x04961892f5d673,0x02b291598e4589,0x11388382c15694,0x02dad977c9e1fe,0x191d96d4d334c6]
 require "CPython published 2000-draw exact53bit reference" (decide ((samples.take 10).reverse = expected))
 require "positive and negative integer seed have identical state" (decide ((seed (-20260612)).state.toList = (seed 20260612).state.toList))
 require "zero seed uses one zero word" (decide ((seed 0).state.toList = (initByArray #[0]).state.toList))
 let database := USDEMatching.fundamentalDatabase
 let synthetic ← USDENull.syntheticDatabase database
 let synthetic2 ← USDENull.syntheticDatabase database
 let db ← match synthetic with | .error e => throw (IO.userError e) | .ok value => pure value
 let db2 ← match synthetic2 with | .error e => throw (IO.userError e) | .ok value => pure value
 require "null database retains target count and clears sigmas" (decide (db.targets.length = 7) && db.sigmas.isEmpty)
 require "integer-seeded null database reproducible" ((db.targets.zip db2.targets).all (fun (a,b) => a.value == b.value && SFT.Host.Text.equal a.description b.description))
 require "real database remains intact" (decide (database.targets.length = 7 ∧ database.sigmas.length = 7))
 let limit := if args.any (fun x => equal x "full") then 120 else 4
 let result ← USDENull.runNullBaseline database 20260612 limit 5.0 true
 let summary ← match result with | .error e => throw (IO.userError e) | .ok value => pure value
 require "null and physical sweeps use identical comparison count" (decide (summary.comparisonsPerformed = (if limit=120 then 62623575 else 63000)))
 line (join ["NULL seed=",number summary.seed," dbSize=",n summary.dbSize," comparisons=",n summary.comparisonsPerformed," alignments=",n summary.nullAlignments," analyticExpected=",Float.toString summary.analyticNullExpected])
