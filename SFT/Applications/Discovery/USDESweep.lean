import SFT.Applications.Discovery.USDEMatching
import Std.Data.HashSet
namespace SFT.Applications.Discovery.USDESweep
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Reports
open SFT.Applications.Discovery.USDEMatching
open SFT.Applications.Discovery.USDEEigenvalues
open SFT.Host.Text

structure GroupScan where
 groups : List (List Fraction)
 coordinatesScanned : Nat

def candidateGroups (limit : Nat) (analytical : Bool) : GroupScan :=
 if analytical then
  let groups := (List.range (limit-1)).flatMap (fun i => USDECore.resolveSectorGroupsAnalytically (Int.ofNat (i+2)))
  let sorted := sortGroups (groups.map (fun members => ({key := [],members} : OrbitGroup)))
  {groups := sorted.map OrbitGroup.members,coordinatesScanned := groups.length}
 else
  let closed := USDECore.closedSet limit
  let groups := closed.foldl (fun groups x => insertGroup x (USDECore.binaryOrbitSet x) groups) []
  {groups := (sortGroups groups).map OrbitGroup.members,coordinatesScanned := closed.length}

def sameKey (a b : Alignment) : Bool := decide (a.sector=b.sector) && SFT.Host.Text.equal a.family b.family && SFT.Host.Text.equal a.name b.name

def uniqueAlignments (xs : List Alignment) : List Alignment :=
 let (_,out) := xs.foldl (fun (seen,out) x =>
  let key := (x.sector,x.family,x.name)
  if seen.contains key then (seen,out) else (seen.insert key,x::out)) (({},[]) : Std.HashSet (Int × String × String) × List Alignment)
 out.reverse

structure AnnotatedAlignment where
 alignment : Alignment
 expectedChanceMatches : Float
 globalSignificance : Float
 beyondChance : Bool
structure SweepResult where
 coordinatesScanned : Nat
 candidateGroups : Nat
 comparisonsPerformed : Nat
 nullExpectedAlignments : Float
 alignments : List AnnotatedAlignment

structure Accumulation where
 comparisons : Nat := 0
 chunks : List (List Alignment) := []

def sweepGroup (db : Database) (toleranceSigmas : Float) (state : Accumulation) (group : List Fraction) : Except String Accumulation := do
 match group with
 | [] => return state
 | first::_ =>
  if !(group.all (fun x => decide (x.denominator=first.denominator))) then return state
  let sector := first.denominator+1
  let families ← solveEigenvaluesOpenEnded sector
  families.foldlM (fun state family => do
   let result ← crossReferenceOpenEnded db toleranceSigmas sector family.eigenvalues family.description
   return {comparisons := state.comparisons+result.comparisons,chunks := result.alignments::state.chunks}) state

def discoverySweep (db : Database) (limit : Nat := 120) (toleranceSigmas : Float := 5.0) (analytical : Bool := false) : Except String SweepResult := do
 let scan := candidateGroups limit analytical
 let accumulated ← scan.groups.foldlM (sweepGroup db toleranceSigmas) {}
 let sorted := accumulated.chunks.reverse.flatten.mergeSort (fun a b => decide (a.significance ≥ b.significance))
 let unique := uniqueAlignments sorted
 match db.targets with
 | [] => .error "max() arg is an empty sequence"
 | first::rest =>
  let maximum := rest.foldl (fun value target => if target.value > value then target.value else value) first.value
  let minimum := rest.foldl (fun value target => if target.value < value then target.value else value) first.value
  if minimum == 0.0 then .error "float division by zero" else
  if maximum/minimum <= 0.0 then .error "math domain error" else
  let logRange := Float.log10 (maximum/minimum)*2.302585092994046
  let logRange := if logRange > 1e-9 then logRange else 1e-9
  let comparisons := Float.ofNat accumulated.comparisons
  let nullExpectedAlignments := comparisons*2.0*(2.0/100.0)/logRange
  let dbSize := Float.ofNat db.targets.length
  let alignments := unique.map (fun alignment =>
   let dev := alignment.deviationPct/100.0
   let expectedChanceMatches := (comparisons/dbSize)*2.0*dev/logRange
   let globalSignificance := -Float.log10 (if expectedChanceMatches > 1e-12 then expectedChanceMatches else 1e-12)
   {alignment,expectedChanceMatches,globalSignificance,beyondChance := decide (expectedChanceMatches < 1.0)})
  .ok {coordinatesScanned := scan.coordinatesScanned,candidateGroups := scan.groups.length,comparisonsPerformed := accumulated.comparisons,nullExpectedAlignments,alignments}
end SFT.Applications.Discovery.USDESweep
