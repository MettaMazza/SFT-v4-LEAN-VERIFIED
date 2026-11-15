import SFT.Physics.StaticFoldClock
import SFT.Physics.StrongFieldHorizon
import SFT.Physics.GravitySourceProofs
namespace SFT.Physics.StaticExteriorClock
open LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def positiveRemainder : FoldFirstReturn.Input → FoldFirstReturn.Input → Except String (Option Rat)
 | .nonFraction,.nonFraction => .error "exact positive taken part required"
 | .nonFraction,.fraction _ => .error "exact positive taken part required"
 | .fraction _,.nonFraction => .error "exact positive taken part required"
 | .fraction whole,.fraction taken => do
  if !zero.blt taken || whole.blt taken then throw "exact positive taken part required"
  if taken==whole then pure none else
   let remainder := subtract whole taken
   if !zero.blt remainder then throw "remainder must be positive or empty"
   pure (some remainder)
def generatedHorizonRadius : FoldFirstReturn.Input → Except String Rat
 | .nonFraction => .error "mass must retain a positive doubled radius no greater than the One"
 | .fraction mass => do
  let binary ← AlphaCovers.binaryCount
  let half ← LeptonRatios.divide (normalize 1 1 (by decide)) (VacuumLedgerProofs.wholeRatio binary)
  if !zero.blt mass || half.blt mass then throw "mass must retain a positive doubled radius no greater than the One"
  pure (multiply (VacuumLedgerProofs.wholeRatio binary) mass)
structure State where
 mass : Rat
 horizon : Rat
 radius : Rat
 wellShare : Rat
 coefficient : Option Rat
 field : Rat
 flux : Rat
def exteriorState (massInput radiusInput : FoldFirstReturn.Input) : Except String State := do
 let horizon ← generatedHorizonRadius massInput
 let mass ← match massInput with
  | .fraction value => .ok value
  | .nonFraction => .error "mass must retain a positive doubled radius no greater than the One"
 let radius ← match radiusInput with
  | .fraction value => if value.blt horizon then .error "static exterior chart requires radius at or outside its generated boundary" else .ok value
  | .nonFraction => .error "static exterior chart requires radius at or outside its generated boundary"
 let well ← LeptonRatios.divide horizon radius
 let coefficient ← positiveRemainder (.fraction (normalize 1 1 (by decide))) (.fraction well)
 let field ← LeptonRatios.divide horizon (multiply radius radius)
 let flux := multiply (multiply field radius) radius
 if !(flux==horizon) || !(multiply well radius==horizon) then throw "exterior source ledger failed"
 match coefficient with
 | none => pure ⟨mass,horizon,radius,well,none,field,flux⟩
 | some value =>
  if !(add value well==normalize 1 1 (by decide)) then throw "positive complement failed"
  pure ⟨mass,horizon,radius,well,some value,field,flux⟩
structure ClockPair where
 mass : Rat
 near : State
 far : State
 nearRate : Rat
 farRate : Rat
 farOverNearRate : Rat
 farClockFaster : Bool
def exactClockPair : Except String ClockPair := do
 let mass := normalize 1 4 (by decide)
 let near ← exteriorState (.fraction mass) (.fraction (normalize 8 7 (by decide)))
 let far ← exteriorState (.fraction mass) (.fraction (normalize 25 18 (by decide)))
 let nearRate := normalize 3 4 (by decide)
 let farRate := normalize 4 5 (by decide)
 let validNear := match near.coefficient with | none => false | some q => q==multiply nearRate nearRate
 let validFar := match far.coefficient with | none => false | some q => q==multiply farRate farRate
 if !validNear || !validFar then throw "exact rational clock carriers changed"
 pure ⟨mass,near,far,nearRate,farRate,← LeptonRatios.divide farRate nearRate,nearRate.blt farRate⟩
theorem originalGeneratedBoundary : generatedHorizonRadius (.fraction (normalize 1 4 (by decide)))=.ok (normalize 1 2 (by decide)) := rfl
theorem originalEmptyBoundary :
 (do let s ← exteriorState (.fraction (normalize 1 4 (by decide))) (.fraction (normalize 1 2 (by decide))); pure s.coefficient)=.ok none := rfl
theorem originalClockRatio : (do let c ← exactClockPair; pure c.farOverNearRate)=.ok (normalize 16 15 (by decide)) := rfl
end SFT.Physics.StaticExteriorClock
