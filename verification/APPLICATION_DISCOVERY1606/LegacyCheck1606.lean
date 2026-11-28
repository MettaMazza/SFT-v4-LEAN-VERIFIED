import SFT.Applications.Discovery.USDEAutonomous
import SFT.Applications.Discovery.AcademicReport
open SFT.Applications.Discovery
open SFT.Applications.Discovery.USDEPhysics
open SFT.Applications.Discovery.USDEAutonomous
open SFT.Applications.Discovery.Display
open SFT.Applications.Discovery.Reports
open SFT.Host.Text

def require (name : String) (ok : Bool) : IO Unit :=
 bif ok then line (append "PASS " name) else throw (IO.userError (append "FAIL " name))
def sampleQueries : ParticleQueries :=
 {available := true,values := [("e-",1),("mu-",2),("tau-",4),("u",1),("c",2),("t",4),("d",1),("s",2),("b",4),("W+",1),("Z0",2)].map (fun (name,value) => (name,.ok (some value)))}
def replaceValue (source : ParticleQueries) (name : String) (value : Except String (Option Float)) : ParticleQueries :=
 {source with values := source.values.map (fun (k,v) => if SFT.Host.Text.equal k name then (k,value) else (k,v))}

def main : IO Unit := do
 let full := crossReferencePhysics sampleQueries 3 [1,2,4]
 require "all three mass families retain both ordered ratios" (decide (full.alignments.length = 6) && full.warning.isNone)
 require "source output order starts with lepton ratios" ((full.alignments.head?.map (fun a => SFT.Host.Text.equal a.name "Lepton Mass Ratio mu/e")).getD false)
 require "missing particle library exits before queries" ((crossReferencePhysics {} 3 [1,2,4]).alignments.isEmpty && (crossReferencePhysics {} 3 [1,2,4]).warning.isNone)
 require "empty eigenvalues exit before queries" ((crossReferencePhysics {available := true} 3 []).warning.isNone)
 let missing := crossReferencePhysics (replaceValue sampleQueries "Z0" (.error "fixture missing Z0")) 3 [1,2,4]
 require "all eleven masses queried before comparisons" (missing.alignments.isEmpty && missing.warning.isSome)
 let partialResult := crossReferencePhysics (replaceValue sampleQueries "u" (.ok (some 0))) 3 [1,2,4]
 require "early division failure preserves prior lepton matches" (decide (partialResult.alignments.length = 2) && partialResult.warning.isSome)
 let missingMass := crossReferencePhysics (replaceValue sampleQueries "Z0" (.ok none)) 2 [1,2,4]
 require "gauge division occurs even at sector2" (decide (missingMass.alignments.length = 6) && missingMass.warning.isSome)
 let weak := crossReferencePhysics sampleQueries 5 [1,2,4]
 require "sector division retains distinct ten-percent tolerance" (weak.alignments.any (fun a => SFT.Host.Text.equal a.name "Weak Mixing Angle from Sector Division"))
 let before := {verifiedSectors := [(3,[fraction 1 2])] : RuntimeState}
 let registered := registerSector before 3 [fraction 1 3]
 require "sector registration overwrites without duplicating" (decide (registered.verifiedSectors.length = 1) && Explorer.contains ((registered.verifiedSectors.headD (0,[])).2) (fraction 1 3))
 let small ← match autonomousLoop {} {} 4 true with | .error e => throw (IO.userError e) | .ok value => pure value
 require "small analytical autonomous scan covers all three groups" (decide (small.candidateGroups = 3 ∧ small.sectorsScanned = 3 ∧ small.visits.length = 3 ∧ small.state.verifiedSectors.length = 3))
 require "unavailable particle source preserves empty alignments" small.state.discoveredAlignments.isEmpty
 let enumerated ← match autonomousLoop {} {} 120 false with | .error e => throw (IO.userError e) | .ok value => pure value
 let analytical ← match autonomousLoop {} {} 120 true with | .error e => throw (IO.userError e) | .ok value => pure value
 require "both original full configurations cover1594groups" (decide (enumerated.candidateGroups = 1594 ∧ analytical.candidateGroups = 1594))
 require "both full configurations register119sectors" (decide (enumerated.state.verifiedSectors.length = 119 ∧ analytical.state.verifiedSectors.length = 119))
 require "proof-failing sectors remain registered" (enumerated.visits.any (fun v => !v.proof.proves) && enumerated.visits.all (fun v => enumerated.state.verifiedSectors.any (fun p => decide (p.1=v.sector))))
 require "proven count is original per-group counter" (decide (enumerated.sectorsProven = (enumerated.visits.filter (fun v => v.proof.proves)).length))
 let preserved : RuntimeState := {discoveredAlignments := [⟨{name := "retained",sector := 3,calculated := 1,measured := 1,deviationPct := 0},true⟩]}
 let resumed ← match autonomousLoop {} preserved 4 true with | .error e => throw (IO.userError e) | .ok value => pure value
 require "repeat scans preserve prior discovered alignments" (decide (resumed.state.discoveredAlignments.length = 1))
 line (join ["AUTONOMOUS groups=",n enumerated.candidateGroups," proven=",n enumerated.sectorsProven," registered=",n enumerated.state.verifiedSectors.length," enumeratedCoordinates=",n enumerated.coordinatesScanned," analyticalCoordinates=",n analytical.coordinatesScanned])

 require "fixed decimal formatting rounds exact half to even" (SFT.Host.Text.equal (FloatText.fixed 0.125 2) "0.12" && SFT.Host.Text.equal (FloatText.fixed 0.375 2) "0.38")
 require "fixed decimal formatting preserves binary64 rounding" (SFT.Host.Text.equal (FloatText.fixed 2.675 2) "2.67")
 require "fixed decimal formatting preserves negative zero" (SFT.Host.Text.equal (FloatText.fixed (Float.ofBits 9223372036854775808) 6) "-0.000000")
 require "fixed decimal formatting supplies original eight digits" (SFT.Host.Text.equal (FloatText.fixed (1.0/3.0) 8) "0.33333333")

 let report ← match AcademicReport.reportText {} 4 "fixture-time" with | .error e => throw (IO.userError e) | .ok value => pure value
 require "academic report preserves original group count" (decide (report.2 = 3))
 require "academic report includes original invariant prose" (SFT.Host.Text.contains report.1 "Chiral Preimage Splitting" && SFT.Host.Text.contains report.1 "CP Symmetry Preservation")
 require "academic report includes source equations and precision" (SFT.Host.Text.contains report.1 "e_2 = 1/(2m)" && SFT.Host.Text.contains report.1 "Generated at: fixture-time")
 IO.FS.writeBinFile (System.FilePath.mk "work/academic_report1606.txt") report.1.toUTF8
