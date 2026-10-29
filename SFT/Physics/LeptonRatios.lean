import SFT.Physics.LeptonIsolation
namespace SFT.Physics.LeptonRatios
open LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000

def divide (a b : Rat) : Except String Rat :=
 match b.num with
 | .ofNat 0 => .error "ZeroDivisionError: Fraction division by zero"
 | .ofNat (n+1) => .ok (normalize (a.num*Int.ofNat b.den) (a.den*(n+1))
     (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.zero_lt_succ _)))
 | .negSucc n => .ok (normalize (-(a.num*Int.ofNat b.den)) (a.den*(n+1))
     (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.zero_lt_succ _)))

def squaredRatio (numerator denominator : Rat × Rat) : Except String (Rat × Rat) :=
 if !zero.blt numerator.1 || !zero.blt denominator.1 then
   .error "ValueError: mass-ratio brackets must be strictly positive"
 else do
   let lower ← divide numerator.1 denominator.2
   let upper ← divide numerator.2 denominator.1
   .ok (multiply lower lower,multiply upper upper)

def atIndex {α : Type} : List α → Nat → Except String α
 | [],_ => .error "IndexError: tuple index out of range"
 | head :: _,0 => .ok head
 | _ :: tail,n+1 => atIndex tail n

def pythonIndex {α : Type} (values : List α) : Int → Except String α
 | .ofNat n => atIndex values n
 | .negSucc n => if n+1 ≤ values.length then atIndex values (values.length-(n+1))
   else .error "IndexError: tuple index out of range"

def prediction (numerator denominator : Int) (brackets : List (Rat × Rat)) : Except String (Rat × Rat) := do
 let n ← pythonIndex brackets numerator
 let d ← pythonIndex brackets denominator
 squaredRatio n d

def disjoint (predicted source : Rat × Rat) : Bool :=
 predicted.2.blt source.1 || source.2.blt predicted.1

def contained (predicted source : Rat × Rat) : Bool :=
 !predicted.1.blt source.1 && !source.2.blt predicted.2

def finished (predicted source : Rat × Rat) : Bool := disjoint predicted source || contained predicted source

def overlap (first second : Rat × Rat) : Bool := !second.2.blt first.1 && !first.2.blt second.1

def refine (pairSum product : Rat) (brackets : List (Rat × Rat)) : List (Rat × Rat) :=
 brackets.map fun bracket => bisectRoot bracket pairSum product

theorem refinementRetainsAll (pairSum product : Rat) (brackets : List (Rat × Rat)) :
 (refine pairSum product brackets).length = brackets.length := by
 induction brackets with
 | nil => rfl
 | cons b bs ih => exact congrArg Nat.succ ih

inductive RefinementRun (numerator denominator : Int) (source : Rat × Rat) (pairSum product : Rat) :
 List (Rat × Rat) → Rat × Rat → Prop where
 | stop (brackets : List (Rat × Rat)) (predicted : Rat × Rat)
   (computed : prediction numerator denominator brackets = .ok predicted)
   (accepted : finished predicted source = true) :
   RefinementRun numerator denominator source pairSum product brackets predicted
 | next (brackets : List (Rat × Rat)) (predicted result : Rat × Rat)
   (computed : prediction numerator denominator brackets = .ok predicted)
   (rejected : finished predicted source = false)
   (later : RefinementRun numerator denominator source pairSum product (refine pairSum product brackets) result) :
   RefinementRun numerator denominator source pairSum product brackets result

def refineWithin (numerator denominator : Int) (source : Rat × Rat) (pairSum product : Rat) :
 Nat → List (Rat × Rat) → Except String (Option (Rat × Rat))
 | 0,_ => .ok none
 | fuel+1,brackets => match prediction numerator denominator brackets with
   | .error e => .error e
   | .ok predicted => if finished predicted source then .ok (some predicted)
     else refineWithin numerator denominator source pairSum product fuel (refine pairSum product brackets)

theorem refinementSound (numerator denominator : Int) (source : Rat × Rat) (pairSum product : Rat)
 (fuel : Nat) (brackets : List (Rat × Rat)) (result : Rat × Rat)
 (found : refineWithin numerator denominator source pairSum product fuel brackets = .ok (some result)) :
 RefinementRun numerator denominator source pairSum product brackets result := by
 induction fuel generalizing brackets result with
 | zero => cases found
 | succ fuel ih =>
   unfold refineWithin at found
   cases hc : prediction numerator denominator brackets with
   | error e => rw [hc] at found; cases found
   | ok predicted =>
     rw [hc] at found
     dsimp only at found
     cases hs : finished predicted source with
     | false =>
       rw [hs] at found
       exact .next brackets predicted result hc hs (ih _ result found)
     | true =>
       rw [hs] at found
       have same : predicted = result := Option.some.inj (Except.ok.inj found)
       cases same
       exact .stop brackets result hc hs

end SFT.Physics.LeptonRatios
