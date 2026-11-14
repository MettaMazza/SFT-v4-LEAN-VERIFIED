import SFT.Physics.VacuumSpectrum
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.StationarySpectrum
open SFT.Foundation.ExactOperations GeneratorOperations VacuumSpectrum LeptonIntervals

def same (a b : Rat) : Bool := !a.blt b && !b.blt a

def uniformFrom (spacing : Rat) (prior : PositiveFraction) : List PositiveFraction → Bool
 | [] => true
 | x::xs => same (subtract (BoundaryGrowth.asFraction x) (BoundaryGrowth.asFraction prior)) spacing && uniformFrom spacing x xs

def stationarySpectrum (depth : CountInput) : Except String (List PositiveFraction) := do
 let values ← oscillatorLevels depth
 match values with
 | [] => .error "stationary spectrum witness requires at least two levels"
 | first::rest => match rest with
  | [] => .error "stationary spectrum witness requires at least two levels"
  | second::_ =>
   let spacing := subtract (BoundaryGrowth.asFraction second) (BoundaryGrowth.asFraction first)
   if zero.blt spacing && uniformFrom spacing first rest then .ok values
   else .error "stationary spectrum is not uniformly separated"

theorem originalDepthTwo :
 (stationarySpectrum (.integer 2)).map pairs=.ok [(1,8),(3,8),(5,8),(7,8)] := rfl

theorem exactAdjacentGap (support i : Nat) (hs : 0<support) :
 ((level support (i+1) hs).numerator*(level support i hs).denominator)*(support*2)=
 ((level support i hs).numerator*(level support (i+1) hs).denominator)*(support*2)+
  2*((level support i hs).denominator*(level support (i+1) hs).denominator) := by
 let low := level support i hs
 let high := level support (i+1) hs
 have lower := levelExactValue support i hs
 have upper := levelExactValue support (i+1) hs
 have dist (a b c : Nat) : (a+b)*c=a*c+b*c := by
  rw [Nat.mul_comm (a+b) c,Nat.mul_add,Nat.mul_comm c a,Nat.mul_comm c b]
 have reorder (a b c : Nat) : a*b*c=a*c*b :=
  (SFT.Foundation.FractionReduction.mulAssoc a b c).trans
   ((congrArg (fun x => a*x) (Nat.mul_comm b c)).trans (SFT.Foundation.FractionReduction.mulAssoc a c b).symm)
 have increment : high.numerator*(support*2)=oddNumerator i*high.denominator+2*high.denominator := by
  exact upper.symm.trans ((congrArg (fun x => x*high.denominator) (uniformNumeratorSpacing i)).trans (dist _ _ _))
 calc
  (high.numerator*low.denominator)*(support*2)=(high.numerator*(support*2))*low.denominator := reorder _ _ _
  _=(oddNumerator i*high.denominator+2*high.denominator)*low.denominator := congrArg (fun x => x*low.denominator) increment
  _=(oddNumerator i*low.denominator)*high.denominator+2*(low.denominator*high.denominator) := by
   rw [dist,reorder (oddNumerator i) high.denominator low.denominator,
    reorder 2 high.denominator low.denominator,SFT.Foundation.FractionReduction.mulAssoc 2]
  _=(low.numerator*(support*2))*high.denominator+2*(low.denominator*high.denominator) :=
   congrArg (fun x => x*high.denominator+2*(low.denominator*high.denominator)) lower
  _=(low.numerator*high.denominator)*(support*2)+2*(low.denominator*high.denominator) :=
   congrArg (fun x => x+2*(low.denominator*high.denominator)) (reorder _ _ _)

end SFT.Physics.StationarySpectrum
