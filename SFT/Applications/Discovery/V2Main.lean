import SFT.Applications.Discovery.Reports
open SFT.Host.Text
open SFT.Applications.Discovery.Source
open SFT.Applications.Discovery.Reports
open SFT.Applications.Discovery.Display

def main (args : List String) : IO Unit := do
 let root := args.headD "reference/applications/discovery-SFT-v2"
 let flags := args.drop 1
 let has := fun flag => flags.any (fun x => equal x flag)
 let corpus ← load root
 let hash ← selfHash root
 reportMain hash corpus (has "--full")
 if has "--closed" || has "--provenance" || has "--groups" || has "--unaccounted" || has "--prove" then
  let analysis := analyze corpus
  each [("--closed",reportClosed),("--provenance",reportProvenance),("--groups",reportGroups),("--unaccounted",reportUnaccounted),("--prove",reportProve)] fun (flag,report) => do
   if has flag then
    line (append "discovery self-hash: " (String.ofList ((chars hash).take 16)))
    report analysis
