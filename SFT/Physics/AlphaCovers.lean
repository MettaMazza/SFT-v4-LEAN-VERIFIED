import SFT.Physics.BoundaryRankEvidence
namespace SFT.Physics.AlphaCovers
open GeneratorOperations FoldFirstReturn

def binaryCount : Except String Nat := do
 let generator ← generatorPeriod
 positivePredecessor (.integer (.ofNat generator))

theorem binaryCountTwo : binaryCount = .ok 2 := by
 unfold binaryCount
 rw [generatorPeriodThree]
 rfl

def powerFrom (base : Nat) : Nat → Nat → Nat
 | 0,value => value
 | n+1,value => powerFrom base n (value*base)

theorem powerFromValue (base steps initial : Nat) : powerFrom base steps initial = initial*base^steps := by
 induction steps generalizing initial with
 | zero => exact (Nat.mul_one initial).symm
 | succ steps ih =>
   change powerFrom base steps (initial*base) = initial*(base^steps*base)
   exact (ih (initial*base)).trans ((SFT.Foundation.FractionReduction.mulAssoc initial base (base^steps)).trans
     (congrArg (fun x => initial*x) (Nat.mul_comm base (base^steps))))

def positivePower : CountInput → CountInput → Except String Nat
 | .boolean _,_ => .error "ValueError: positive power requires positive exact counts"
 | _,.boolean _ => .error "ValueError: positive power requires positive exact counts"
 | .integer (.negSucc _),_ => .error "ValueError: positive power requires positive exact counts"
 | _,.integer (.negSucc _) => .error "ValueError: positive power requires positive exact counts"
 | .integer (.ofNat 0),_ => .error "ValueError: positive power requires positive exact counts"
 | _,.integer (.ofNat 0) => .error "ValueError: positive power requires positive exact counts"
 | .integer (.ofNat (base+1)),.integer (.ofNat (steps+1)) => .ok (powerFrom (base+1) steps (base+1))

theorem positivePowerValue (base steps : Nat) :
 positivePower (.integer (.ofNat (base+1))) (.integer (.ofNat (steps+1))) = .ok ((base+1)^(steps+1)) := by
 change Except.ok (powerFrom (base+1) steps (base+1)) = _
 rw [powerFromValue,Nat.pow_succ,Nat.mul_comm (base+1)]

inductive CoverRun (carrier : Nat) : Nat → Nat → Nat → Prop where
 | stop (depth support : Nat) (covered : carrier ≤ support) : CoverRun carrier depth support depth
 | step (depth support result : Nat) (notCovered : support < carrier)
   (tail : CoverRun carrier (depth+1) (support*2) result) : CoverRun carrier depth support result

theorem successorBudget (carrier support fuel : Nat) (positive : 0 < support)
 (bound : carrier ≤ support+(fuel+1)) : carrier ≤ support*2+fuel := by
 have grows : support+1 ≤ support*2 := by
   have h := Nat.add_le_add_left positive support
   rw [Nat.mul_succ,Nat.mul_one]
   exact h
 have h := Nat.add_le_add_right grows fuel
 rw [Nat.add_assoc, Nat.add_comm 1 fuel, ← Nat.add_assoc] at h
 exact Nat.le_trans bound h

def coverBounded (carrier : Nat) : (fuel depth support : Nat) →
 (positive : 0 < support) → (bound : carrier ≤ support+fuel) →
 {result : Nat // CoverRun carrier depth support result}
 | 0,depth,support,_,bound => ⟨depth,.stop depth support (by rw [Nat.add_zero] at bound; exact bound)⟩
 | fuel+1,depth,support,positive,bound =>
   if smaller : support < carrier then
    let next := coverBounded carrier fuel (depth+1) (support*2)
      (Nat.mul_pos positive (by decide)) (successorBudget carrier support fuel positive bound)
    ⟨next.val,.step depth support next.val smaller next.property⟩
   else ⟨depth,.stop depth support (Nat.le_of_not_gt smaller)⟩

def coverDepth (carrier : Nat) : Nat :=
 (coverBounded carrier carrier 1 2 (by decide) (Nat.le_add_left carrier 2)).val

theorem coverDepthRun (carrier : Nat) : CoverRun carrier 1 2 (coverDepth carrier) :=
 (coverBounded carrier carrier 1 2 (by decide) (Nat.le_add_left carrier 2)).property

theorem runLower (carrier depth support result : Nat) (run : CoverRun carrier depth support result) : depth ≤ result := by
 induction run with
 | stop => exact Nat.le_refl _
 | step depth support result smaller tail ih => exact Nat.le_trans (Nat.le_succ _) ih

theorem runCovered (carrier depth support result : Nat) (run : CoverRun carrier depth support result)
 (power : support = 2^depth) : carrier ≤ 2^result := by
 induction run with
 | stop depth support covered => exact power ▸ covered
 | step depth support result smaller tail ih =>
   apply ih
   rw [power,Nat.pow_succ]

theorem runMinimal (carrier depth support result : Nat) (run : CoverRun carrier depth support result)
 (power : support = 2^depth) (earlier : ∀ k, 0 < k → k < depth → 2^k < carrier) :
 ∀ k, 0 < k → k < result → 2^k < carrier := by
 induction run with
 | stop => exact earlier
 | step depth support result smaller tail ih =>
   apply ih
   · rw [power,Nat.pow_succ]
   · intro k positive below
     have bound := Nat.le_of_lt_succ below
     cases Nat.lt_or_eq_of_le bound with
     | inl less => exact earlier k positive less
     | inr same => exact same ▸ (power ▸ smaller)

theorem leastPositiveCover (carrier : Nat) :
 0 < coverDepth carrier ∧ carrier ≤ 2^(coverDepth carrier) ∧
 ∀ k, 0 < k → k < coverDepth carrier → 2^k < carrier := by
 have run := coverDepthRun carrier
 refine ⟨runLower carrier 1 2 _ run,runCovered carrier 1 2 _ run rfl,?_⟩
 apply runMinimal carrier 1 2 _ run rfl
 intro k positive below
 exact False.elim (Nat.not_lt_of_ge positive below)

def minimalBinaryCover : CountInput → Except String Nat
 | .boolean _ => .error "ValueError: covering requires a positive exact carrier"
 | .integer (.negSucc _) => .error "ValueError: covering requires a positive exact carrier"
 | .integer (.ofNat 0) => .error "ValueError: covering requires a positive exact carrier"
 | .integer (.ofNat (n+1)) => do
   let _binary ← binaryCount
   .ok (coverDepth (n+1))

theorem nativeLeastCover (carrier : Nat) :
 minimalBinaryCover (.integer (.ofNat (carrier+1))) = .ok (coverDepth (carrier+1)) := by
 unfold minimalBinaryCover
 rw [binaryCountTwo]
 rfl

theorem downCover : coverDepth 27 = 5 := rfl

theorem upCover : coverDepth 81 = 7 := rfl
theorem supportPower (depth : Nat) : GeneratorThreeDerivation.supportCount depth = 2^depth := by
 induction depth with
 | zero => rfl
 | succ depth ih =>
   change GeneratorThreeDerivation.supportCount depth + GeneratorThreeDerivation.supportCount depth = _
   rw [ih,Nat.pow_succ,Nat.mul_succ,Nat.mul_one]

theorem completeBinarySupport (depth : Nat) :
 (SFT.Foundation.FoldAssembly.supportAfterExtensions depth).length = 2^depth :=
 (GeneratorThreeDerivation.completeSupportCount depth).trans (supportPower depth)

theorem leastCompleteSupport (carrier : Nat) :
 carrier ≤ (SFT.Foundation.FoldAssembly.supportAfterExtensions (coverDepth carrier)).length ∧
 ∀ k, 0 < k → k < coverDepth carrier →
   (SFT.Foundation.FoldAssembly.supportAfterExtensions k).length < carrier := by
 have h := leastPositiveCover carrier
 constructor
 · rw [completeBinarySupport]; exact h.2.1
 · intro k positive before
   rw [completeBinarySupport]
   exact h.2.2 k positive before
end SFT.Physics.AlphaCovers
