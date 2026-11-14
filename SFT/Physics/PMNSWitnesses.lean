import SFT.Physics.PMNSSupport
namespace SFT.Physics.PMNSWitnesses
open PMNSSupport
structure Witness where
 name : String
 statement : String
 passed : Bool

def tripleCheck : Bool :=
 match squaredSupport with
 | .error _ => false
 | .ok s => decide (s.atmospheric.num=1) && s.atmospheric.den==2 && decide (s.solar.num=1) && s.solar.den==3 && decide (s.reactor.num=1) && s.reactor.den==48

def nonemptyCheck : Bool :=
 match squaredSupport with
 | .error _ => false
 | .ok s => decide (0<s.reactor.num) && decide (s.reactor.num<Int.ofNat s.reactor.den)

def towerCheck : Bool :=
 match (do
  let b ← AlphaCovers.binaryCount
  let c ← FoldFirstReturn.generatorPeriod
  AlphaCovers.positivePower (.integer (.ofNat b)) (.integer (.ofNat c))) with
 | .error _ => false
 | .ok n => n==8

theorem triplePass : tripleCheck=true := by unfold tripleCheck;rw [sourceAssembly];rfl
theorem nonemptyPass : nonemptyCheck=true := by unfold nonemptyCheck;rw [sourceAssembly];rfl
theorem towerPass : towerCheck=true := by
 unfold towerCheck
 rw [AlphaCovers.binaryCountTwo,FoldFirstReturn.generatorPeriodThree]
 rfl

def witnesses : List Witness := [⟨"triple","The three exact support parts reconstruct without target access.",tripleCheck⟩,⟨"nonempty-reactor","The reactor carrier is a strict positive part of the One.",nonemptyCheck⟩,⟨"tower","Complete binary support at generator depth is eight.",towerCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (tripleCheck && (nonemptyCheck && (towerCheck && true)))=true
 rw [triplePass,nonemptyPass,towerPass];rfl
end SFT.Physics.PMNSWitnesses
