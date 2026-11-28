import SFT.Applications.Discovery.MaxCore
open SFT.Applications.Discovery
open SFT.Applications.Discovery.MaxCore
open SFT.Applications.Discovery.Display
open SFT.Applications.Discovery.Reports
open SFT.Host.Text

def require (name : String) (ok : Bool) : IO Unit :=
 bif ok then line (append "PASS " name) else throw (IO.userError (append "FAIL " name))
def main : IO Unit := do
 let deep := deepAxis1
 require "default deep sweep covers 490050 expressions" (decide (deep.total = 490050))
 require "default deep sweep completes every source case" (decide (deep.tally.unresolved = 0))
 line (join ["DEEP returnsOne=",n deep.tally.returnsOne," fixed=",n deep.tally.fixed," cycle=",n deep.tally.cycle," longestCycle=",n deep.longestCycle])
 let census := MaxCore.orbitCensus
 require "default census retains 7140 unreduced input positions" (decide (census.length = 7140))
 require "default census resolves" (census.all (fun row => match row.result.kind with | .unresolved => false | .returnsOne => true | .fixed => true | .cycle => true))
 require "source ladder sum 247/210" (equal ladderShortfall (fraction 247 210))
 require "source ladder span 210" (equal ladderSpan (fraction 210 1))
 require "all 15 prime sectors scanned" (decide (sectorScan.length = 15))
 require "universal mode is half-One" (decide (universalModes.length = 1) && Explorer.contains universalModes (fraction 1 2))
 require "45 odd-prime identity pairs" (decide (crossIdentities.length = 45))
 require "57 original running levels ordered" (decide (runningCurves.length = 57) && runningCurves.all (fun r => r.ordered))
 require "all 15 on-shell ties" (decide (onShell.length = 15) && onShell.all (fun r => r.tied))
 require "negative running depth preserves empty source range" (runningCurves (-1)).isEmpty
 let quarter := trace (fraction 1 4) 2
 require "quarter reachesOne after two steps" (decide (quarter.transient = 2) && match quarter.kind with | .returnsOne => true | .fixed => false | .cycle => false | .unresolved => false)
 let seventh := trace (fraction 1 7) 2
 require "seventh period3 transient0" (decide (seventh.period = 3 && seventh.transient = 0))
 line (join ["CENSUS maxPeriod=",n (census.foldl (fun a r => max a r.result.period) 0)," maxTransient=",n (census.foldl (fun a r => max a r.result.transient) 0)])
