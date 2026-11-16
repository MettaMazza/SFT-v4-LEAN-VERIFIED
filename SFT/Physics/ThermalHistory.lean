import SFT.Physics.VelocityComposition
namespace SFT.Physics.ThermalHistory
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Original thermal_history_recombination_terminal_law_v1.py operations.
def requirePositive (value : Rat) (name : String) : Except String Rat :=
 if zero.blt value then .ok value
 else .error (SFT.Host.Text.append name " must be an exact positive Fold carrier")
def transportedTemperature (temperature growth : Rat) : Except String Rat := do
 let t ← requirePositive temperature "temperature"
 let g ← requirePositive growth "scale growth"
 LeptonRatios.divide t g
def temperatureScaleInvariant (temperature growth : Rat) : Except String Bool := do
 let later ← transportedTemperature temperature growth
 pure (VelocityComposition.ratEqual (multiply later growth) temperature)
def insertDescending (value : Rat) : List Rat → List Rat
 | [] => [value]
 | x::xs => if x.blt value then value::x::xs else x::insertDescending value xs
def sortDescending : List Rat → List Rat
 | [] => []
 | x::xs => insertDescending x (sortDescending xs)
def distinct : List Rat → Bool
 | [] => true
 | x::xs => !(xs.any (VelocityComposition.ratEqual x)) && distinct xs
def orderedThresholds (thresholds : List Rat) : Except String (List Rat) := do
 if thresholds.isEmpty then throw "at least one generated threshold is required"
 let exact ← thresholds.mapM (fun x => requirePositive x "threshold")
 if !distinct exact then throw "epoch thresholds must retain distinct exact records"
 pure (sortDescending exact)
-- The original orbit terminates on the first repeated residue; the eight-step
-- bound is a host termination bound covering the seven possible residues.
def orbitLoop : Nat → Nat → List Nat → List Nat
 | 0,_,orbit => orbit
 | fuel+1,residue,orbit =>
   if orbit.contains residue then orbit
   else orbitLoop fuel ((2*residue)%7) (orbit++[residue])
def liveDepthSevenOrbit : List Nat := orbitLoop 8 1 []
structure CaptureLedger where
 orbit : List Nat
 freezeoutNeutronShare : Rat
 freezeoutProtonShare : Rat
 freezeoutRatio : Rat
 captureNeutronShare : Rat
 captureProtonShare : Rat
 captureRatio : Rat
 heliumShare : Rat
 hydrogenShare : Rat
def freezeoutCaptureLedger : Except String CaptureLedger := do
 let orbit := liveDepthSevenOrbit
 let least := orbit.foldl min 7
 let neutron := normalize (Int.ofNat least) 7 (by decide)
 let proton := normalize 6 7 (by decide)
 let cover := 2^3
 let captureN := normalize 1 cover (by decide)
 let captureP := normalize 7 cover (by decide)
 pure ⟨orbit,neutron,proton,← LeptonRatios.divide neutron proton,
   captureN,captureP,← LeptonRatios.divide captureN captureP,
   multiply (wholeRatio 2) captureN,normalize 6 cover (by decide)⟩
structure Visibility where
 radius : Nat
 weights : List Nat
 normalized : List Rat
 midpointIndex : Nat
 uniqueMidpoint : Bool
 complete : Bool
def visibilityAt : List Rat → Nat → Rat
 | [],_ => zero
 | x::_,0 => x
 | _::xs,n+1 => visibilityAt xs n
def visibilityLedger (radius : Nat) (isBool : Bool := false) : Except String Visibility := do
 if isBool || radius == 0 then throw "visibility radius must be a positive generated count"
 let rising := (List.range (radius+1)).map (fun n => n+1)
 let weights := rising ++ ((List.range radius).map (fun n => n+1)).reverse
 let total := weights.foldl (·+·) 0
 let normalized ← weights.mapM (fun n => LeptonRatios.divide (wholeRatio n) (wholeRatio total))
 let middle := visibilityAt normalized radius
 let maximum := normalized.foldl (fun a b => if a.blt b then b else a) zero
 let unique := VelocityComposition.ratEqual middle maximum &&
   (normalized.filter (VelocityComposition.ratEqual middle)).length == 1
 pure ⟨radius,weights,normalized,radius,unique,
   VelocityComposition.ratEqual (normalized.foldl add zero) (wholeRatio 1)⟩
structure AcousticMode where
 mode : Nat
 phaseSupport : Rat
 loading : String
def acousticModeLedger (count : Nat) (isBool : Bool := false) : Except String (List AcousticMode) := do
 if isBool || count == 0 then throw "mode count must be a positive generated count"
 (List.range count).mapM fun n => do
   let mode := n+1
   pure ⟨mode,← LeptonRatios.divide (wholeRatio mode) (wholeRatio (count+1)),
     if mode%2 == 1 then "compression" else "rarefaction"⟩
def horizonSegments : List Rat → List Rat → Except String (List Rat)
 | [],_ => .ok []
 | _,[] => .ok []
 | d::ds,s::ss => do
   let duration ← requirePositive d "duration"
   let speed ← requirePositive s "speed"
   pure (multiply duration speed :: (← horizonSegments ds ss))
def finiteSoundHorizon (durations speeds : List Rat) : Except String Rat := do
 if durations.isEmpty || durations.length != speeds.length then
   throw "sound-horizon segments must be nonempty and paired"
 let segments ← horizonSegments durations speeds
 match segments with
 | [] => throw "sound-horizon segments must be nonempty and paired"
 | first::rest => pure (rest.foldl add first)
theorem originalOrbit : liveDepthSevenOrbit = [1,2,4] := by decide +kernel
theorem originalCaptureShares : freezeoutCaptureLedger.toOption.map (fun r =>
 [r.freezeoutNeutronShare.num,r.freezeoutNeutronShare.den,
 r.freezeoutRatio.num,r.freezeoutRatio.den,r.captureRatio.num,r.captureRatio.den,
 r.heliumShare.num,r.heliumShare.den,r.hydrogenShare.num,r.hydrogenShare.den]) =
 some [1,7,1,6,1,7,1,4,3,4] := by decide +kernel
end SFT.Physics.ThermalHistory
