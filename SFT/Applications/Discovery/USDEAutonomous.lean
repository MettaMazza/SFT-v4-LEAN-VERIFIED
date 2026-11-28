import SFT.Applications.Discovery.USDEPhysics
namespace SFT.Applications.Discovery.USDEAutonomous
open SFT.Applications.Discovery
open SFT.Applications.Discovery.USDEPhysics
open SFT.Applications.Discovery.USDECore
open SFT.Applications.Discovery.USDEEigenvalues
open SFT.Applications.Discovery.USDESweep

structure DiscoveredAlignment where
 alignment : PhysicsAlignment
 provesT1T4 : Bool
structure RuntimeState where
 verifiedSectors : List (Int × List Fraction) := []
 discoveredAlignments : List DiscoveredAlignment := []
structure SectorVisit where
 sector : Int
 groupSize : Nat
 proof : AnalyticalProof
 eigenvalues : List Float
 physics : PhysicsResult
structure AutonomousResult where
 state : RuntimeState
 coordinatesScanned : Nat
 candidateGroups : Nat
 sectorsProven : Nat
 sectorsScanned : Nat
 visits : List SectorVisit
 skippedMixedDenominators : List (List Int)

def registerSector (state : RuntimeState) (sector : Int) (group : List Fraction) : RuntimeState :=
 if state.verifiedSectors.any (fun pair => decide (pair.1=sector)) then
  {state with verifiedSectors := state.verifiedSectors.map (fun pair => if pair.1=sector then (sector,group) else pair)}
 else {state with verifiedSectors := state.verifiedSectors++[(sector,group)]}

def autonomousLoop (particles : ParticleQueries) (initial : RuntimeState := {}) (limit : Nat := 120) (analytical : Bool := false) : Except String AutonomousResult := do
 let scan := candidateGroups limit analytical
 let initialResult : AutonomousResult := {state := initial,coordinatesScanned := scan.coordinatesScanned,candidateGroups := scan.groups.length,sectorsProven := 0,sectorsScanned := scan.groups.length,visits := [],skippedMixedDenominators := []}
 scan.groups.foldlM (fun result group => do
  match group with
  | [] => return result
  | first::_ =>
   let denominators := group.foldl (fun out x => if out.any (fun d => decide (d=x.denominator)) then out else x.denominator::out) []
   if denominators.length ≠ 1 then
    return {result with skippedMixedDenominators := result.skippedMixedDenominators++[Reports.sortInts denominators]}
   let sector := first.denominator+1
   let proof := runAutoProof group sector
   let state := registerSector result.state sector group
   let eigenvalues ← solveEigenvalues sector
   let physics := crossReferencePhysics particles sector eigenvalues
   let state := {state with discoveredAlignments := state.discoveredAlignments++physics.alignments.map (fun alignment => {alignment,provesT1T4 := proof.proves})}
   return {result with state,sectorsProven := result.sectorsProven+(if proof.proves then 1 else 0),visits := result.visits++[{sector,groupSize := group.length,proof,eigenvalues,physics}]}) initialResult
end SFT.Applications.Discovery.USDEAutonomous
