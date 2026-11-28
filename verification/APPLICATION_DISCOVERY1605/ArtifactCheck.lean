import SFT.Applications.Discovery.MaxArtifacts
open SFT.Applications.Discovery
open SFT.Applications.Discovery.MaxArtifacts
open SFT.Applications.Discovery.Reports
open SFT.Host.Text

def main (args : List String) : IO Unit := do
 let root := args.headD "work/turn1064_recovery/reference/applications/discovery-SFT-v2"
 let output := (args.drop 1).headD "work/discovery_artifacts1605"
 let corpus ← Source.load root
 let a := analyze corpus
 IO.FS.createDirAll (System.FilePath.mk output)
 each [("unclaimed_census.md",censusMarkdown a),("sector_scan.md",sectorMarkdown),("cross_identities.md",crossMarkdown),("auto_extend_report.md",extendedMarkdown a),("orbit_census.csv",orbitCSV 60),("running_curves.csv",runningCSV 20)] fun (name,content) => do
  IO.FS.writeBinFile (System.FilePath.mk (join [output,"/",name])) content.toUTF8
