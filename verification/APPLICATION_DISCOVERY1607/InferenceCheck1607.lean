import SFT.Applications.Discovery.InferenceSector
open Lean
open SFT.Applications.Discovery
open SFT.Applications.Discovery.InferenceSweep
open SFT.Host.Text

def require (name : String) (ok : Bool) : IO Unit := do
 if ok then (← IO.getStdout).putStrLn ("PASS "++name) else throw (IO.userError ("FAIL "++name))
def row (sector : Nat) (sig : Int := 5) (global : Option Int := none) : Json :=
 Json.mkObj ([ ("sector",toJson sector),("family",.str "a/b*c"),("name",.str "X/Y*Z"),("calculated",toJson (2 : Nat)),("measured",toJson (2 : Nat)),("deviation_pct",toJson (0 : Nat)),("significance",toJson sig)]++match global with | none => [] | some value => [("global_significance",toJson value)])
def runPath (name : String) : String := "work/inference1607/"++name++"/report.md"
def main : IO Unit := do
 let dir : System.FilePath := "work/inference1607"
 if ← dir.pathExists then IO.FS.removeDirAll dir
 IO.FS.createDirAll dir
 let d ← lift (datum (row 3))
 require "source family/name key replacement differs intentionally" (SFT.Host.Text.equal (cacheKey d) "sweep_3_a_b_c_X_Y*Z")
 let p := prompt d
 require "prompt keeps original decimal precision" (SFT.Host.Text.contains p "Calculated Ratio: 2.000000" && SFT.Host.Text.contains p "Deviation: 0.0000%" && SFT.Host.Text.contains p "Significance Score: 5.00")
 require "system prompt includes exact master text" (SFT.Host.Text.contains (systemPrompt "MASTER-FIXTURE") "MASTER-FIXTURE\n")
 let selected := selectTargets [row 1 100 (some 1),row 2 2,row 3 50 (some 2)]
 require "global significance takes precedence and ties remain stable" (decide ((selected.map (fun j => (j.getObjValD "sector").getNat?.toOption.getD 0))=[2,3,1]))
 require "selection preserves original fifty limit" (decide ((selectTargets ((List.range 61).map (fun i => row i))).length=50))
 let seen ← IO.mkRef (0 : Nat)
 let responder : Transport := fun body => do
  seen.modify (·+1)
  require "request disables streaming and preserves context16384" (body.getObjValD "stream" == .bool false && (body.getObjValD "options").getObjValD "num_ctx" == toJson (16384 : Nat))
  return Json.mkObj [("done",.bool true),("response",.str "native response")]
 let count ← generate "fixture-model" (runPath "success") "MASTER" "fixture-time" [row 3] responder
 require "success count is selected rows" (decide (count=1))
 let content ← IO.FS.readFile (runPath "success")
 require "report contains source heading stats and analysis" (SFT.Host.Text.contains content "## Discovery: Sector m = 3 (X/Y*Z)" && SFT.Host.Text.contains content "native response" && SFT.Host.Text.contains content "Generated at: fixture-time")
 let cached ← readCache "work/inference1607/success/usde_inference_sweep_cache.json"
 require "successful response persists exact cache key" (cached.getObjValD (cacheKey d) == .str "native response")
 let _ ← generate "fixture-model" (runPath "success") "MASTER" "fixture-time" [row 3] responder
 require "cached response suppresses another request" (decide ((← seen.get)=1))
 let failed ← IO.mkRef (0 : Nat)
 let _ ← generate "fixture-model" (runPath "failure") "" "fixture-time" [row 3,row 4] (fun _ => do failed.modify (·+1);throw (IO.userError "fixture error"))
 require "sweep makes one attempt per failed row and still writes final report" (decide ((← failed.get)=2) && !(SFT.Host.Text.contains (← IO.FS.readFile (runPath "failure")) "## Discovery:"))
 let _ ← generate "fixture-model" (runPath "incomplete") "" "fixture-time" [row 3] (fun _ => pure (Json.mkObj [("done",.bool false),("response",.str "discard")]))
 require "incomplete response does not produce analysis" (!(SFT.Host.Text.contains (← IO.FS.readFile (runPath "incomplete")) "discard"))
 let _ ← generate "fixture-model" (runPath "blank") "" "fixture-time" [row 3] (fun _ => pure (Json.mkObj [("done",.bool true),("response",.str "   ")]))
 require "source whitespace analysis is displayed but not cached" (SFT.Host.Text.contains (← IO.FS.readFile (runPath "blank")) "## Discovery:" && !(← (System.FilePath.mk "work/inference1607/blank/usde_inference_sweep_cache.json").pathExists))
 IO.FS.createDirAll "work/inference1607/corrupt"
 IO.FS.writeFile "work/inference1607/corrupt/usde_inference_sweep_cache.json" "not json"
 let _ ← generate "fixture-model" (runPath "corrupt") "" "fixture-time" [row 3] responder
 require "malformed cache is replaced after successful request" ((← readCache "work/inference1607/corrupt/usde_inference_sweep_cache.json").getObjValD (cacheKey d) == .str "native response")
 let mut rejected := false
 try
  let _ ← generate "fixture-model" (runPath "missing") "" "fixture-time" [Json.mkObj [("sector",toJson (3:Nat))]] responder
 catch _ => rejected := true
 require "selected malformed row raises before requesting" rejected

 for (value,expected) in [(0.1,"0.1"),(1.0/3.0,"0.3333333333333333"),(2.675,"2.675"),(1e16,"1e+16"),(1e-5,"1e-05"),(1e-4,"0.0001"),(Float.ofBits 1,"5e-324"),(Float.ofBits 9218868437227405311,"1.7976931348623157e+308"),(Float.ofBits 4503599627370496,"2.2250738585072014e-308"),(Float.ofBits 4607182418800017409,"1.0000000000000002"),(Float.ofBits 9223372036854775808,"-0.0"),(123.0,"123.0")] do
  require ("shortest original Float representation "++expected) (SFT.Host.Text.equal (FloatText.repr value) expected)

 require "JSON string rendering preserves Python ASCII escapes" (SFT.Host.Text.equal (InferenceSector.quote "α😀") "\"\\u03b1\\ud83d\\ude00\"")
 let groups ← lift (InferenceSector.targetGroups {} 2 false)
 require "ordinary report retains unfiltered source group" (decide (groups.length=1))
 require "limit-to-matches defaults to excluding unmatched groups" ((← lift (InferenceSector.targetGroups {} 2 true)).isEmpty)
 let target ← match groups with | [] => throw (IO.userError "missing fixture") | x::_ => pure x
 require "ordinary cache key uses sorted numerator-denominator pairs" (SFT.Host.Text.equal (InferenceSector.cacheKey target) "sector_2_coords_1-1")
 let raw := InferenceSector.rawData [fraction 1 2] 3 [1,2,4] (USDECore.runAutoProof [fraction 1 2] 3) []
 require "raw prompt includes twelve original invariant keys" (SFT.Host.Text.contains raw "\"T1_confines\": \"PASS\"" && SFT.Host.Text.contains raw "\"T5_pair_law\": \"FAIL\"" && SFT.Host.Text.contains raw "\"T12_cp_closure\": \"PASS\"")
 IO.FS.writeFile "work/inference1607/raw-data.json" raw
 let calls ← IO.mkRef (0 : Nat)
 let sleeps ← IO.mkRef (0 : Nat)
 let retry : Transport := fun body => do
  calls.modify (·+1)
  if (← calls.get)=1 then throw (IO.userError "first attempt fixture")
  require "ordinary request carries raw data and original master context" (SFT.Host.Text.contains ((body.getObjValD "prompt").getStr?.toOption.getD "") "coordinate_count" && SFT.Host.Text.contains ((body.getObjValD "system").getStr?.toOption.getD "") "MASTER-SECTOR")
  return Json.mkObj [("done",.bool true),("response",.str "native sector analysis")]
 let count ← InferenceSector.generate {} 2 "fixture" (runPath "sector") "MASTER-SECTOR" "fixture-time" false retry (sleeps.modify (·+1))
 require "ordinary successful retry sleeps exactly once" (decide (count=1 ∧ (← calls.get)=2 ∧ (← sleeps.get)=1))
 let text ← IO.FS.readFile (runPath "sector")
 require "ordinary report preserves original heading and full eigenvalue representation" (SFT.Host.Text.contains text "## Sector m = 2 Analysis" && SFT.Host.Text.contains text (InferenceSector.eigenvaluesText target.eigenvalues) && SFT.Host.Text.contains text "native sector analysis")
 let _ ← InferenceSector.generate {} 2 "fixture" (runPath "sector") "" "fixture-time" false retry (sleeps.modify (·+1))
 require "ordinary cached response suppresses request and backoff" (decide ((← calls.get)=2 ∧ (← sleeps.get)=1))
 let failures ← IO.mkRef (0 : Nat)
 let backoffs ← IO.mkRef (0 : Nat)
 let mut sectorRejected := false
 try
  let _ ← InferenceSector.generate {} 2 "fixture" (runPath "sectorfail") "" "fixture-time" false (fun _ => do failures.modify (·+1);pure (Json.mkObj [("done",.bool false)])) (backoffs.modify (·+1))
 catch _ => sectorRejected := true
 require "ordinary incomplete generation makes three attempts and two backoffs" (sectorRejected && decide ((← failures.get)=3 ∧ (← backoffs.get)=2))
 require "ordinary failed generation does not write a final report" (!(← (System.FilePath.mk (runPath "sectorfail")).pathExists))
 let whites ← IO.mkRef (0 : Nat)
 let _ ← InferenceSector.generate {} 2 "fixture" (runPath "sectorwhite") "" "fixture-time" false (fun _ => do whites.modify (·+1);pure (Json.mkObj [("done",.bool true),("response",.str "   ")])) (pure ())
 require "ordinary whitespace retains original three-attempt truthiness behavior" (decide ((← whites.get)=3) && SFT.Host.Text.contains (← IO.FS.readFile (runPath "sectorwhite")) "## Sector m = 2 Analysis")
 require "ordinary whitespace is never persisted as successful cache" (!(← (System.FilePath.mk "work/inference1607/sectorwhite/usde_inference_cache.json").pathExists))
 IO.FS.createDirAll "work/inference1607/sectorempty"
 IO.FS.writeFile "work/inference1607/sectorempty/usde_inference_cache.json" (Json.mkObj [(InferenceSector.cacheKey target,.str "")]).compress
 let emptyCalls ← IO.mkRef (0 : Nat)
 let mut emptyRejected := false
 try
  let _ ← InferenceSector.generate {} 2 "fixture" (runPath "sectorempty") "" "fixture-time" false (fun _ => do emptyCalls.modify (·+1);pure Json.null) (pure ())
 catch _ => emptyRejected := true
 require "empty cached analysis raises without retry as in source" (emptyRejected && decide ((← emptyCalls.get)=0))

 IO.FS.writeFile "work/inference1607/sweep-prompt.txt" (InferenceSweep.prompt d)
 IO.FS.writeFile "work/inference1607/sweep-system.txt" (InferenceSweep.systemPrompt "MASTER-FIXTURE")
 IO.FS.writeFile "work/inference1607/sector-prompt.txt" (InferenceSector.prompt 3 raw)
 IO.FS.writeFile "work/inference1607/sector-system.txt" (InferenceSector.systemPrompt "MASTER-FIXTURE")
 IO.FS.createDirAll "work/inference1607/cachewrite/usde_inference_sweep_cache.json"
 let writeCalls ← IO.mkRef (0 : Nat)
 let _ ← InferenceSweep.generate "fixture" (runPath "cachewrite") "" "fixture-time" [row 3,row 3] (fun _ => do writeCalls.modify (·+1);return Json.mkObj [("done",.bool true),("response",.str "retained despite write error")])
 require "sweep retains analysis and in-memory cache after cache-write error" (decide ((← writeCalls.get)=1) && SFT.Host.Text.contains (← IO.FS.readFile (runPath "cachewrite")) "retained despite write error")
 IO.FS.createDirAll "work/inference1607/sectorwrite/usde_inference_cache.json"
 let sectorWriteCalls ← IO.mkRef (0 : Nat)
 let _ ← InferenceSector.generate {} 2 "fixture" (runPath "sectorwrite") "" "fixture-time" false (fun _ => do sectorWriteCalls.modify (·+1);return Json.mkObj [("done",.bool true),("response",.str "retained sector write failure")]) (pure ())
 require "ordinary cache-write failure retains analysis across all three attempts" (decide ((← sectorWriteCalls.get)=3) && SFT.Host.Text.contains (← IO.FS.readFile (runPath "sectorwrite")) "retained sector write failure")
