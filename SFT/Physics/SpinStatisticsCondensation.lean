import SFT.Physics.ThermalEquilibriumResponse
namespace SFT.Physics.SpinStatisticsCondensation
open CollectiveRadiation LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Pinned spin_statistics_condensation_terminal_law_v1.py: exact source operations.
def positiveWhole (value : CountInput) (name : String) : Except String Nat :=
 positiveCount value (SFT.Host.Text.append name " must be a positive whole Fold count")
def walk (cap : Nat) : Nat → List Nat → Nat → List (List Nat)
 | 0, prior, remaining => if remaining ≤ cap then [prior++[remaining]] else []
 | .succ levels, prior, remaining =>
   (List.range (min cap remaining+1)).flatMap (fun occupied => walk cap levels (prior++[occupied]) (remaining-occupied))
def occupationVectors (particleCount levelCount : CountInput) (exchange : String) : Except String (List (List Nat)) := do
 let particles ← positiveWhole particleCount "particle count"
 let levels ← positiveWhole levelCount "level count"
 if exchange != "preserving" && exchange != "alternating" then throw "exchange class must be preserving or alternating"
 let cap := if exchange == "preserving" then particles else 1
 pure (walk cap (levels-1) [] particles)
structure Census where
 bosons : List (List Nat)
 fermions : List (List Nat)
 bosonCount : Nat
 fermionCount : Nat
 expectedBosons : Nat
 expectedFermions : Nat
 complete : Bool
def occupationCensus (particleCount levelCount : CountInput) : Except String Census := do
 let particles ← positiveWhole particleCount "particle count"
 let levels ← positiveWhole levelCount "level count"
 let bosons ← occupationVectors particleCount levelCount "preserving"
 let fermions ← occupationVectors particleCount levelCount "alternating"
 let eb := ThermalEquilibriumResponse.binomial (particles+levels-1) particles
 let ef := if particles≤levels then ThermalEquilibriumResponse.binomial levels particles else 0
 pure ⟨bosons,fermions,bosons.length,fermions.length,eb,ef,bosons.length==eb && fermions.length==ef⟩
def rawLevelWeights (levelCount : CountInput) : Except String (List Nat) := do
 let levels ← positiveWhole levelCount "level count"
 pure ((List.range levels).map (fun index => 2^(levels-index-1)))
def canonicalOccupationWeights (particleCount levelCount : CountInput) (exchange : String) (coldDepth : CountInput) : Except String (List (List Nat × Rat)) := do
 let depth ← positiveWhole coldDepth "cold depth"
 let vectors ← occupationVectors particleCount levelCount exchange
 if vectors.isEmpty then return []
 let raw ← rawLevelWeights levelCount
 let scores := vectors.map (fun row => (raw.zip row).foldl (fun score (weight,occupied) => score*weight^(depth*occupied)) 1)
 let total := scores.foldl Nat.add 0
 (vectors.zip scores).mapM (fun (row,score) => do
   let weight ← LeptonRatios.divide (wholeRatio score) (wholeRatio total)
   pure (row,weight))
structure SpinCensus where
 preserving : List String
 alternating : List String
 completeCount : Nat
 preservingShare : Rat
 alternatingShare : Rat
def exchangeSpinCensus : SpinCensus :=
 let preserving := ["lower-lower","mixed-preserving","upper-upper"]
 let alternating := ["mixed-alternating"]
 ⟨preserving,alternating,preserving.length+alternating.length,natRatio preserving.length 4 (by decide),natRatio alternating.length 4 (by decide)⟩
structure SpinReturn where
 alternatingOrbit : List String
 alternatingFirstReturn : Nat
 pairedOrbit : List String
 pairedFirstReturn : Nat
 composedClass : String
def spinReturnCertificate : SpinReturn := ⟨["lower","upper","lower"],2,["paired","paired"],1,"preserving"⟩
def groundWord (particles levels : Nat) : List Nat := particles::List.replicate (levels-1) 0
def lookupGround (ground : List Nat) : List (List Nat × Rat) → Rat
 | [] => zero
 | (word,weight)::rest => if word==ground then weight else lookupGround ground rest
def groundShare (particleCount levelCount : CountInput) (exchange : String) (coldDepth : CountInput) : Except String Rat := do
 let rows ← canonicalOccupationWeights particleCount levelCount exchange coldDepth
 let particles ← positiveWhole particleCount "particle count"
 let levels ← positiveWhole levelCount "level count"
 pure (lookupGround (groundWord particles levels) rows)
def totalThrow (row : List Nat) : Nat := wordEnergy ((List.range row.length).map (fun index => index+1)) row
def canonicalMeanThrow (particleCount levelCount : CountInput) (exchange : String) (coldDepth : CountInput) : Except String Rat := do
 let particles ← positiveWhole particleCount "particle count"
 let rows ← canonicalOccupationWeights particleCount levelCount exchange coldDepth
 if rows.isEmpty then throw "the declared exchange class has no occupation word"
 let terms ← rows.mapM (fun (row,weight) => do
   let energy ← LeptonRatios.divide (wholeRatio (totalThrow row)) (wholeRatio particles)
   pure (multiply weight energy))
 pure (terms.foldl add zero)
structure Condensation where
 particles : Nat
 levels : Nat
 factor : Nat
 lockShare : Rat
 criticalDepth : Nat
 criticalMean : Rat
 groundShare : Rat
 priorBelow : Bool
 rows : List (Nat × Rat × Rat)
 ground : List Nat
def firstCrossing (particles levels factor : Nat) (threshold : Rat) : List Nat → List (Nat × Rat × Rat) → Except String Condensation
 | [], _ => .error "finite Fold bound failed to produce the forced lock crossing"
 | depth::rest, prior => do
   let share ← groundShare (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat depth))
   let mean ← canonicalMeanThrow (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat depth))
   let rows := prior++[(depth,share,mean)]
   if !share.blt threshold then
     let below := match prior.getLast? with
       | none => true
       | some (_,previous,_) => previous.blt threshold
     return ⟨particles,levels,factor,threshold,depth,mean,share,below,rows,groundWord particles levels⟩
   firstCrossing particles levels factor threshold rest rows
def criticalCondensationCertificate (particleCount levelCount foldFactor : CountInput) : Except String Condensation := do
 let particles ← positiveWhole particleCount "particle count"
 let levels ← positiveWhole levelCount "level count"
 let factor ← positiveWhole foldFactor "fold factor"
 if levels<2 || factor<2 then throw "condensation requires at least two levels and a Fold factor of at least two"
 let forms ← occupationVectors particleCount levelCount "preserving"
 let threshold ← LeptonRatios.divide (wholeRatio (factor-1)) (wholeRatio factor)
 let sufficient := AlphaCovers.coverDepth (max 1 ((forms.length-1)*(factor-1)))
 firstCrossing particles levels factor threshold ((List.range (sufficient+1)).map (fun n => n+1)) []
structure GroundCertificate where
 least : Nat
 survivors : List (List Nat)
 unique : Bool
def minimalThrowGroundCertificate (particleCount levelCount : CountInput) : Except String GroundCertificate := do
 let particles ← positiveWhole particleCount "particle count"
 let levels ← positiveWhole levelCount "level count"
 let rows ← occupationVectors particleCount levelCount "preserving"
 let energies := rows.map (fun row => (row,totalThrow row))
 let least := match energies with
   | [] => 0
   | (_,first)::rest => rest.foldl (fun value (_,energy) => min value energy) first
 let survivors := (energies.filter (fun (_,value) => value==least)).map Prod.fst
 pure ⟨least,survivors,survivors==[groundWord particles levels]⟩
end SFT.Physics.SpinStatisticsCondensation
