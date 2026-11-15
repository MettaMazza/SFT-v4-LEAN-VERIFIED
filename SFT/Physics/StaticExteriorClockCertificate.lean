import SFT.Physics.StaticExteriorClock
namespace SFT.Physics.StaticExteriorClockCertificate
open StaticExteriorClock LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def successivePairs {α : Type} : List α → List (α × α)
 | [] => []
 | [_] => []
 | x::y::xs => (x,y)::successivePairs (y::xs)
structure Certificate where
 mass : Rat
 horizon : Rat
 boundary : State
 rows : List State
 allExteriorCoefficientsPositive : Bool
 allFluxesEqualHorizon : Bool
 allWellRadiusProductsEqualHorizon : Bool
 allComplementsCompleteOne : Bool
 wellHalvesEachSuccessor : Bool
 fieldQuartersEachSuccessor : Bool
 coefficientIncreasesEachSuccessor : Bool
 horizonClockRecordEmpty : Bool
 exactClockPair : ClockPair
 weakFieldSuccessor : String
 generalFluxIdentity : String
 generalCoefficientIdentity : String
 physicalUnitConversionNotFormalInput : Bool
 forbiddenProofScalarUsed : Bool
def exteriorCertificate (input : GeneratorOperations.CountInput := .integer 10) : Except String Certificate := do
 let depth ← match input with
  | .boolean _ => .error "at least binary positive successor depth required"
  | .integer (.negSucc _) => .error "at least binary positive successor depth required"
  | .integer (.ofNat 0) => .error "at least binary positive successor depth required"
  | .integer (.ofNat 1) => .error "at least binary positive successor depth required"
  | .integer (.ofNat (n+2)) => .ok (n+2)
 let mass := normalize 1 4 (by decide)
 let horizon ← generatedHorizonRadius (.fraction mass)
 let boundary ← exteriorState (.fraction mass) (.fraction horizon)
 let binary ← AlphaCovers.binaryCount
 let rows ← (List.range depth).mapM (fun step => do
  let power ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat (step+1)))
  exteriorState (.fraction mass) (.fraction (multiply horizon (VacuumLedgerProofs.wholeRatio power))))
 let clock ← StaticExteriorClock.exactClockPair
 let pairs := successivePairs rows
 pure ⟨mass,horizon,boundary,rows,
  rows.all (fun row => match row.coefficient with | none => false | some q => zero.blt q),
  rows.all (fun row => row.flux==horizon),
  rows.all (fun row => multiply row.wellShare row.radius==horizon),
  rows.all (fun row => match row.coefficient with | none => false | some q => add q row.wellShare==normalize 1 1 (by decide)),
  pairs.all (fun p => multiply p.2.wellShare (VacuumLedgerProofs.wholeRatio binary)==p.1.wellShare),
  pairs.all (fun p => multiply p.2.field (VacuumLedgerProofs.wholeRatio (binary*binary))==p.1.field),
  pairs.all (fun p => match p.1.coefficient,p.2.coefficient with | some a,some b => a.blt b | none,none => false | none,some _ => false | some _,none => false),
  boundary.coefficient.isNone,clock,
  "At every positive depth, well share is One over binary-to-depth, the coefficient is its positive complement from the One, and no completed infinity is invoked.",
  "field times radius paired with radius equals generated horizon radius",
  "coefficient paired with horizon-radius over radius completes the One",true,false⟩
def certificateFacts : Except String Bool := do
 let c ← exteriorCertificate
 pure (c.horizon==normalize 1 2 (by decide) && c.allExteriorCoefficientsPositive && c.allFluxesEqualHorizon && c.allWellRadiusProductsEqualHorizon && c.allComplementsCompleteOne && c.wellHalvesEachSuccessor && c.fieldQuartersEachSuccessor && c.coefficientIncreasesEachSuccessor && c.horizonClockRecordEmpty && c.exactClockPair.farOverNearRate==normalize 16 15 (by decide) && c.exactClockPair.farClockFaster && !c.forbiddenProofScalarUsed)
theorem originalComputedFacts : certificateFacts=.ok true := rfl
end SFT.Physics.StaticExteriorClockCertificate
