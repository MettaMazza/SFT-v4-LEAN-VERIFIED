import SFT.Applications.Discovery.USDESweep
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Display
open SFT.Applications.Discovery.Reports
open SFT.Applications.Discovery.USDESweep
open SFT.Host.Text

def main (args : List String) : IO Unit := do
 let analytical := args.any (fun x => equal x "analytical")
 line (append "MODE " (if analytical then "analytical" else "enumerated"))
 match discoverySweep USDEMatching.fundamentalDatabase 120 5.0 analytical with
 | .error e => throw (IO.userError e)
 | .ok result =>
  line (join ["RESULT coordinates=",n result.coordinatesScanned," groups=",n result.candidateGroups," comparisons=",n result.comparisonsPerformed," alignments=",n result.alignments.length," nullExpected=",Float.toString result.nullExpectedAlignments])
  each result.alignments fun a =>
   line (intercalate "\t" [number a.alignment.sector,a.alignment.family,a.alignment.name,Float.toString a.alignment.calculated,Float.toString a.alignment.deviationPct,Float.toString a.expectedChanceMatches,if a.beyondChance then "true" else "false"])
