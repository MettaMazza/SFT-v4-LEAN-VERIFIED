import SFT.Applications.Discovery.USDESweep
import SFT.Applications.Discovery.MaxCensus
open SFT.Applications.Discovery
open SFT.Applications.Discovery.USDECore
open SFT.Applications.Discovery.USDEEigenvalues
open SFT.Applications.Discovery.Display
open SFT.Applications.Discovery.Reports
open SFT.Host.Text

def require (name : String) (ok : Bool) : IO Unit :=
 bif ok then line (append "PASS " name) else throw (IO.userError (append "FAIL " name))
def familyCount (m : Int) : Nat := match solveEigenvaluesOpenEnded m with | .error _ => 0 | .ok xs => xs.length

def main (args : List String) : IO Unit := do
 require "core zero casts to One" (equal (USDECore.castOut (fraction 0 1)) (fraction 1 1))
 require "core negative half casts to half" (equal (USDECore.castOut (fraction (-1) 2)) (fraction 1 2))
 require "USDE seed30 contains One and 270 coordinates" (let xs := USDECore.closedSet; decide (xs.length = 270) && Explorer.contains xs (fraction 1 1))
 require "negative multiplier retains cyclic casting" (let xs := USDECore.closedSet 4 [-2]; xs.all (fun x => decide (0 < x.numerator ∧ x.numerator ≤ x.denominator)))
 require "order special branches" (decide (getOrderOf2 0 = 0 ∧ getOrderOf2 1 = 1 ∧ getOrderOf2 3 = 2 ∧ getOrderOf2 7 = 3 ∧ getOrderOf2 (-1) = -1))
 require "order general branch five" (decide (getOrderOf2 5 = 4))
 require "sector4 primitive orbit group" (let xs := resolveSectorGroupsAnalytically 4; decide (xs.length = 1) && decide ((xs.headD []).length = 2))
 require "sector8 splits primitive residues into two groups" (let xs := resolveSectorGroupsAnalytically 8; decide (xs.length = 2) && xs.all (fun g => decide (g.length = 3)))
 require "large even-denominator source branch" (let xs := resolveSectorGroupsAnalytically 100001; decide (xs.length = 1) && decide ((xs.headD []).length = 1) && Explorer.contains (xs.headD []) (fraction 1 100000))
 require "large odd-denominator source branch" (let xs := resolveSectorGroupsAnalytically 131072; decide (xs.length = 1) && decide ((xs.headD []).length = 17) && (xs.headD []).all (fun x => equal x (fraction 1 131071)))
 require "invalid sector all-negative result" (let p := runAnalyticalProof 1; !p.proves && !p.confines && !p.cpClosure && decide (p.pairs = 0))
 require "denominator2 exceptional closure" (runAnalyticalProof 3).closed
 require "other even denominator rejection" (!(runAnalyticalProof 5).closed)
 require "odd denominator divisible by3 composite rejection" (!(runAnalyticalProof 10).closed)
 require "odd denominator equal3 remains closed" (runAnalyticalProof 4).closed
 require "explicit group antipodal pairs" (let p := runAutoProof [fraction 1 3,fraction 2 3] 4; p.proves && p.pairLaw && decide (p.pairs = 1) && !p.cpClosure)
 require "all source sectors2through120 assembled" ((List.range 119).all (fun i => (resolveSectorGroupsAnalytically (Int.ofNat (i+2))).all (fun g => !(g.isEmpty))))
 require "sector2 open-family count600" (decide (familyCount 2 = 600))
 require "sector3 open-family count1125" (decide (familyCount 3 = 1125))
 require "sector15 complete1875family grid" (decide (familyCount 15 = 1875))
 require "zero-sector division error retained" (match solveEigenvalues 0 with | .error _ => true | .ok _ => false)
 require "open-family denominator error retained" (match solveEigenvaluesOpenEnded (-1) with | .error _ => true | .ok _ => false)
 let values := match solveEigenvalues 3 with | .error _ => [] | .ok xs => xs
 require "sector3 squared roots positive and ordered" (match values with | [a,b,c] => a > 0 && b > a && c > b | _ => false)
 line (append "USDE_SECTOR3_EIGENVALUES " (intercalate "," (values.map Float.toString)))

 let db := USDEMatching.harvestPhysicalDatabase
 require "source fallback has seven targets and seven sigmas" (decide (db.targets.length = 7 ∧ db.sigmas.length = 7))
 let particles : List USDEMatching.Particle := [⟨"e-",some 2.0,some 0.2,none⟩,⟨"mu-",some 4.0,none,some 0.4⟩,⟨"unlisted",some 10.0,none,none⟩]
 let harvested := USDEMatching.harvestPhysicalDatabase particles
 require "particle selection and pair ratio" (decide (harvested.targets.length = 8) && harvested.targets.any (fun t => t.value == 2.0 && SFT.Host.Text.equal t.description "Mass Ratio mu-/e-"))
 require "mass error propagation uses upper then lower" (let expected := Float.pow (Float.pow (0.2/2.0) 2 + Float.pow (0.4/4.0) 2) (1.0/2.0); harvested.sigmas.any (fun p => p.1 == 2.0 && p.2 == expected))
 let db2 : USDEMatching.Database := {targets := [⟨2.0,"two"⟩,⟨4.0,"four"⟩],sigmas := [(2.0,0.001)]}
 let result := USDEMatching.crossReferenceOpenEnded db2 5.0 3 [1.0,2.0,4.0] "fixture"
 require "three ratios compare against every target" (match result with | .error _ => false | .ok r => decide (r.comparisons = 6 ∧ r.alignments.length = 3))
 require "optional sigma and exact-match significance" (match result with | .error _ => false | .ok r => r.alignments.all (fun a => a.significance == 5.0 && a.deviationPct == 0.0 && if a.measured == 2.0 then a.withinExperimentalError.getD false else a.withinExperimentalError.isNone))
 require "within2percent can remain outside sigma tolerance" (match USDEMatching.crossReferenceOpenEnded db2 5.0 3 [1.0,2.02,4.0804] "fixture" with | .error _ => false | .ok r => decide (r.alignments.length = 2) && r.alignments.all (fun a => !(a.withinExperimentalError.getD true)))
 require "empty roots perform no comparisons" (match USDEMatching.crossReferenceOpenEnded db2 5.0 3 [] "fixture" with | .error _ => false | .ok r => decide (r.comparisons = 0) && r.alignments.isEmpty)
 require "zero root preserves division failure" (match USDEMatching.crossReferenceOpenEnded db2 5.0 3 [0.0,1.0,2.0] "fixture" with | .error _ => true | .ok _ => false)
 require "overwritten database key keeps insertion position" (let d := USDEMatching.setTarget db2 2.0 "updated"; decide (d.targets.length = 2) && (d.targets.head?.map (fun t => SFT.Host.Text.equal t.description "updated")).getD false)
 require "USDE binary orbit uses its own casting rule" (let xs := USDECore.binaryOrbitSet (fraction (-1) 2); decide (xs.length = 1) && Explorer.contains xs (fraction (-1) 2))

 let corpus ← Source.load (args.headD "reference/applications/discovery-SFT-v2")
 let analysis := Reports.analyze corpus
 let rows := MaxCensus.censusRows analysis.unclaimed
 require "unclaimed census preserves every member" (decide ((rows.foldl (fun n row => n+row.members.length) 0) = analysis.unclaimed.length))
 require "each denominator group retains exact denominator" (rows.all (fun row => row.members.all (fun x => decide (x.denominator=row.denominator))))
 require "census sector samples use first five members" (rows.all (fun row => row.sectors.all (fun sector => (row.members.take 5).any (fun x => decide (Explorer.foldCount x = some sector)))))
 require "census source factorization24" (decide (MaxCensus.sourceFactors 24 = [2,2,2,3]))
 require "census source ignores final unlisted prime" (MaxCensus.sourceFactors 31).isEmpty
 require "census prime and claimed flags" (MaxCensus.sectorIsPrime 31 && !(MaxCensus.sectorIsPrime 24) && MaxCensus.sectorIsClaimed 24 && !(MaxCensus.sectorIsClaimed 31))
 line (join ["MAX_CENSUS denominatorGroups=",n rows.length," sectorGroups=",n (MaxCensus.sectorSummary rows).length," members=",n analysis.unclaimed.length])

 let sweep := USDESweep.discoverySweep USDEMatching.fundamentalDatabase 4 5.0 true
 require "analytical sweep visits every original family" (match sweep with | .error _ => false | .ok r => decide (r.coordinatesScanned = 3 ∧ r.candidateGroups = 3 ∧ r.comparisonsPerformed = 63000))
 require "sweep preserves unique sector-family-name keys" (match sweep with | .error _ => false | .ok r => let xs := r.alignments.map (fun a => a.alignment); decide ((USDESweep.uniqueAlignments xs).length = xs.length))
 line (match sweep with | .error e => e | .ok r => join ["USDE_SWEEP comparisons=",n r.comparisonsPerformed," alignments=",n r.alignments.length])
 require "order loop retains five-million cap" (decide (getOrderOf2 2 = 5000000))
