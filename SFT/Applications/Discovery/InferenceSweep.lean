import Lean.Data.Json
import SFT.Applications.Discovery.AcademicReport
namespace SFT.Applications.Discovery.InferenceSweep
open Lean
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Display
open SFT.Applications.Discovery.Reports
open SFT.Host.Text

-- Prompt strings are original program data, not instructions to the translator.
def systemPrompt (masterText : String) : String := join ["You are an expert theoretical physicist specializing in the Smithian Fold Theory of Everything (SFTOE). Your task is to analyze candidate coordinate sectors and polynomial families generated in our sweep and write a deep, publication-grade academic analysis explaining the physical and algebraic significance of the findings.\n\nCRITICAL WARNING ON PARADIGM BIAS AND MATHEMATICAL CORRECTNESS:\n1. NO CONTINUUM PHYSICS: Do NOT reference standard QFT, gauge fields, continuous groups, or smooth spacetime metrics.\n2. DO NOT HALLUCINATE MATHEMATICS: The fold map is chaotic and non-associative. Verify all coordinate arithmetic.\n3. STRICT SFTOE ALGEBRA: Focus purely on coordinate confinement, binary state-space trees, and the balance points of the sector-associated polynomial roots.\n\n",masterText,"\n"]

def payload (model prompt system : String) : Json := Json.mkObj [
 ("model",.str model),("prompt",.str prompt),("system",.str system),
 ("stream",.bool false),("options",Json.mkObj [("num_ctx",toJson (16384 : Nat))])]

abbrev Transport := Json → IO Json
-- Only the translated Lean program uses this adapter; native validation injects responses.
def request (body : Json) : IO Json := do
 let result ← IO.Process.output {cmd := "/usr/bin/curl",args := #["--silent","--show-error","--fail-with-body","--max-time","180","--header","Content-Type: application/json","--data-binary","@-","http://localhost:11434/api/generate"]} (some body.compress)
 if result.exitCode != 0 then throw (IO.userError result.stderr)
 match Json.parse result.stdout with
 | .error e => throw (IO.userError e)
 | .ok result => return result

def readMaster (masterPath : System.FilePath) : IO String := do
 if ← masterPath.pathExists then IO.FS.readFile masterPath else pure ""
def timestamp : IO String := do
 let result ← IO.Process.output {cmd := "/bin/date",args := #["+%Y-%m-%d %H:%M:%S"]}
 return String.ofList ((chars result.stdout).filter (fun c => decide (c.toNat≠10 ∧ c.toNat≠13)))
def reportDirectory (path : System.FilePath) : System.FilePath :=
 match path.parent with
 | none => "usde_reports"
 | some parent => if SFT.Host.Text.equal parent.toString "" then "usde_reports" else parent

def readCache (path : System.FilePath) : IO Json := do
 try
  if ← path.pathExists then
   match Json.parse (← IO.FS.readFile path) with
   | .ok value => return value
   | .error _ => return Json.mkObj []
  else return Json.mkObj []
 catch _ => return Json.mkObj []
def cacheSet (cache : Json) (key : String) (value : Json) : Except String Json := do
 let object ← cache.getObj?
 return Json.mkObj ((object.toList.filter (fun p => !(SFT.Host.Text.equal p.1 key)))++[(key,value)])
def strField (data : Json) (key : String) : Except String String := do
 let value ← data.getObjVal? key
 value.getStr?
def floatValue : Json → Except String Float
 | .num n => .ok n.toFloat
 | _ => .error "expected number"
def floatField (data : Json) (key : String) : Except String Float := do
 floatValue (← data.getObjVal? key)
def rankValue (data : Json) : Float :=
 match data.getObjVal? "global_significance" with
 | .ok v => (floatValue v).toOption.getD 0.0
 | .error _ => (floatField data "significance").toOption.getD 0.0
def deviationValue (data : Json) : Float := (floatField data "deviation_pct").toOption.getD 1.0
-- Stable ordering is the source tuple (-global_or_local_significance, deviation).
def selectTargets (rows : List Json) : List Json :=
 (rows.mergeSort (fun a b => if rankValue a == rankValue b then decide (deviationValue a ≤ deviationValue b) else decide (rankValue a ≥ rankValue b))).take 50

def keyPart (s : String) (replaceStar : Bool) : String :=
 String.ofList ((chars s).map (fun c => if c=='/' || (replaceStar && c=='*') then '_' else c))
structure Datum where
 sector : Int
 family : String
 name : String
 calculated : Float
 measured : Float
 deviation : Float
 significance : Float

def datum (row : Json) : Except String Datum := do
 let sector ← (← row.getObjVal? "sector").getInt?
 let family ← strField row "family"
 let name ← strField row "name"
 let calculated ← floatField row "calculated"
 let measured ← floatField row "measured"
 let deviation ← floatField row "deviation_pct"
 let significance ← floatField row "significance"
 return {sector,family,name,calculated,measured,deviation,significance}
def cacheKey (d : Datum) : String := join ["sweep_",number d.sector,"_",keyPart d.family true,"_",keyPart d.name false]
def prompt (d : Datum) : String := join [
 "Analyze the following generative discovery datum:\n- Sector m: ",number d.sector,
 "\n- Polynomial Family: ",d.family,"\n- Matched Physical Relation: ",d.name,
 "\n- Calculated Ratio: ",FloatText.fixed d.calculated 6,"\n- Measured Ratio: ",FloatText.fixed d.measured 6,
 "\n- Deviation: ",FloatText.fixed d.deviation 4,"%\n- Significance Score: ",FloatText.fixed d.significance 2,"\n\n",
 "Please write a comprehensive, non-heuristic academic report segment. Structure your response with:\n",
 "1. **Algebraic Structure Analysis**: Explain how this specific polynomial family represents the topological balance points of the sector.\n",
 "2. **Physical Observable Alignment**: Explain the physical implication of the match (e.g. why this mass ratio emerges from the sector coordinates).\n",
 "Keep the tone strictly scientific, professional, and dense with physical insight."]
def reportSection (d : Datum) (analysis : String) : List String := [
 join ["## Discovery: Sector m = ",number d.sector," (",d.name,")"],"### Summary Stats",
 join ["- **Family**: `",d.family,"`"],
 join ["- **Calculated**: `",FloatText.fixed d.calculated 6,"` | **Measured**: `",FloatText.fixed d.measured 6,"`"],
 join ["- **Deviation**: `",FloatText.fixed d.deviation 4,"%` | **Significance**: `",FloatText.fixed d.significance 2,"`"],
 "","### LLM Analysis",analysis,"\n---\n"]
def nonempty (s : String) : Bool := !(chars s).isEmpty
def nonblank (s : String) : Bool := (chars s).any (fun c => !c.isWhitespace)
def lift {α : Type} (value : Except String α) : IO α :=
 match value with | .error e => throw (IO.userError e) | .ok value => pure value

-- The injected transport/clock permit native-only validation of network failure branches.
def generate (model outputPath masterText time : String) (alignments : List Json)
 (transport : Transport := request) : IO Nat := do
 let directory := reportDirectory outputPath
 IO.FS.createDirAll directory
 let cachePath := directory / "usde_inference_sweep_cache.json"
 let cache ← IO.mkRef (← readCache cachePath)
 let targets := selectTargets alignments
 let mut lines := ["# Smithian Fold Theory — Generative Discovery Sweep Atlas",append "Generated at: " time,join ["Ollama Model: `",model,"`"],"","## Executive Summary","This document contains physical and mathematical explanations of generalized coordinate sector polynomial eigenvalues and physical ratio alignments.","","---",""]
 line (join ["Generating LLM reports for ",n targets.length," sweep discoveries using model '",model,"'..."])
 for row in targets do
  let d ← lift (datum row)
  let key := cacheKey d
  let analysis ← IO.mkRef ""
  match (← cache.get).getObjVal? key with
  | .ok value =>
   match value with
   | .null => pure ()
   | _ => analysis.set (← lift value.getStr?)
  | .error _ =>
   try
    let response ← transport (payload model (prompt d) (systemPrompt masterText))
    if response.getObjValD "done" == Json.bool true then
     let value := response.getObjValD "response"
     match value with
     | .null => pure ()
     | _ => analysis.set (← lift value.getStr?)
     if nonblank (← analysis.get) then
      cache.set (← lift (cacheSet (← cache.get) key (.str (← analysis.get))))
      IO.FS.writeFile cachePath (← cache.get).pretty
   catch e => line (join ["  Failed to generate analysis for Sector m=",number d.sector," (",d.name,"): ",e.toString])
  if nonempty (← analysis.get) then
   lines := lines++reportSection d (← analysis.get)
   try IO.FS.writeFile outputPath (intercalate "\n" lines) catch _ => pure ()
 IO.FS.writeFile outputPath (intercalate "\n" lines)
 line (append "Sweep Inference Report saved to: " outputPath)
 return targets.length

def generateInferenceReportSweep (model outputPath : String) (alignments : List Json)
 (masterPath : System.FilePath) : IO Nat := do
 let master ← readMaster masterPath
 let time ← timestamp
 generate model outputPath master time alignments
end SFT.Applications.Discovery.InferenceSweep
