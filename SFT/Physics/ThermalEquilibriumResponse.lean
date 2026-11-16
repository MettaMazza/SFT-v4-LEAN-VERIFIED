import SFT.Physics.CollectiveRadiation
namespace SFT.Physics.ThermalEquilibriumResponse
open CollectiveRadiation LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exactTemperature (throws : List Rat) : Except String Rat := do
 if throws.isEmpty then throw "temperature requires a finite nonempty population"
 let exact ← throws.mapM (fun x => requirePositive x "throw")
 LeptonRatios.divide (exact.foldl add zero) (wholeRatio exact.length)
def totalThrowIdentity (throws : List Rat) : Except String Bool := do
 let temperature ← exactTemperature throws
 pure (VelocityComposition.ratEqual (throws.foldl add zero) (multiply (wholeRatio throws.length) temperature))
def factorial : Nat → Nat
 | 0 => 1
 | .succ n => (n+1)*factorial n
def binomial (population upper : Nat) : Nat := factorial population / (factorial upper*factorial (population-upper))
structure PairedCensus where
 population : Nat
 rows : List (Nat × Nat)
 survivors : List Nat
 share : Rat
def pairedEquilibriumCensus (pairCount : CountInput) : Except String PairedCensus := do
 let count ← positiveCount pairCount "pair count must be positive"
 let population := 2*count
 let rows := (List.range (population+1)).map (fun upper => (upper,binomial population upper))
 let maximum := rows.foldl (fun m r => max m r.2) 0
 let survivors := (rows.filter (fun r => r.2==maximum)).map Prod.fst
 let share ← LeptonRatios.divide (wholeRatio (occupationAt survivors 0)) (wholeRatio population)
 pure ⟨population,rows,survivors,share⟩
def dyadicCanonicalCounts (levelCount : CountInput) : Except String (List Nat) :=
 match levelCount with
 | .boolean _ => .error "at least two generated levels required"
 | .integer (.negSucc _) => .error "at least two generated levels required"
 | .integer (.ofNat 0) => .error "at least two generated levels required"
 | .integer (.ofNat 1) => .error "at least two generated levels required"
 | .integer (.ofNat (.succ (.succ n))) =>
   .ok ((List.range (n+2)).map (fun index => 2^(n+2-index-1)))
def dyadicCanonicalWeights (levelCount : CountInput) : Except String (List Rat) := do
 let counts ← dyadicCanonicalCounts levelCount
 let total := counts.foldl Nat.add 0
 counts.mapM (fun count => LeptonRatios.divide (wholeRatio count) (wholeRatio total))
def multinomialCount (counts : List Nat) : Nat :=
 counts.foldl (fun value count => value/factorial count) (factorial (counts.foldl Nat.add 0))
def countedThrow (counts : List Nat) : Nat := wordEnergy (List.range counts.length) counts
def walkForms (throw : Nat) : Nat → List Nat → Nat → List (List Nat)
 | 0, prior, remaining =>
   let candidate := prior++[remaining]
   if countedThrow candidate == throw then [candidate] else []
 | .succ levels, prior, remaining =>
   (List.range (remaining+1)).flatMap (fun count => walkForms throw levels (prior++[count]) (remaining-count))
def fixedCountThrowForms (levelCount : CountInput) : Except String (List (List Nat)) := do
 let target ← dyadicCanonicalCounts levelCount
 pure (walkForms (countedThrow target) (target.length-1) [] (target.foldl Nat.add 0))
structure MaximumCertificate where
 target : List Nat
 forms : Nat
 survivors : List (List Nat)
 unique : Bool
def canonicalMaximumCertificate (levelCount : CountInput) : Except String MaximumCertificate := do
 let target ← dyadicCanonicalCounts levelCount
 let forms ← fixedCountThrowForms levelCount
 let values := forms.map (fun form => (form,multinomialCount form))
 let maximum := values.foldl (fun m row => max m row.2) 0
 let survivors := (values.filter (fun row => row.2==maximum)).map Prod.fst
 pure ⟨target,forms.length,survivors,survivors==[target]⟩
structure FluctuationResponse where
 equilibrium : Rat
 fluctuation : Rat
 response : Rat
 complete : Bool
 equalDeparture : Bool
def fluctuationResponseLedger : FluctuationResponse :=
 let equilibrium := natRatio 1 2 (by decide)
 let fluctuation := natRatio 3 4 (by decide)
 let response := natRatio 1 4 (by decide)
 ⟨equilibrium,fluctuation,response,VelocityComposition.ratEqual (add fluctuation response) (wholeRatio 1),
 VelocityComposition.ratEqual (subtract fluctuation equilibrium) (subtract equilibrium response) &&
 VelocityComposition.ratEqual (subtract equilibrium response) (natRatio 1 4 (by decide))⟩
structure NoiseCycle where
 cycle : List Rat
 mean : Rat
 period : Nat
def deterministicNoiseCycle (repetitions : CountInput) : Except String NoiseCycle := do
 let count ← positiveCount repetitions "repetitions must be positive"
 let base := [natRatio 1 4 (by decide),natRatio 1 2 (by decide),natRatio 3 4 (by decide),natRatio 1 2 (by decide)]
 let cycle := (List.replicate count base).flatten
 let mean ← LeptonRatios.divide (cycle.foldl add zero) (wholeRatio cycle.length)
 pure ⟨cycle,mean,base.length⟩
end SFT.Physics.ThermalEquilibriumResponse
