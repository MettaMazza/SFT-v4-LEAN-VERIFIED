import SFT.Physics.LeptonSupport
namespace SFT.Physics.LeptonInvariants
open SFT.Foundation.ExactOperations LeptonTake LeptonSupport BoundaryGrowth GeneratorOperations FoldFirstReturn
set_option maxRecDepth 20000

def whole (n : Nat) (positive : 0 < n) : PositiveFraction := normalizePositive n 1 positive (by decide)
def unitPart (n : Nat) (positive : 0 < n) : PositiveFraction := normalizePositive 1 n (by decide) positive

def reciprocal (value : PositiveFraction) : PositiveFraction :=
 normalizePositive value.denominator value.numerator (Nat.pos_of_ne_zero value.denominatorNonzero) value.positive

theorem denominatorPositive (n : Nat) (source : leadingDenominator = .ok n) : 0 < n := by
 have same : n = 485 := Except.ok.inj (source.symm.trans denominator485)
 cases same
 decide

def sharpened : CountInput → Except String PositiveFraction
 | .boolean _ => .error "ValueError: channel must be in the complete neighbouring generator census"
 | .integer (.negSucc _) => .error "ValueError: channel must be in the complete neighbouring generator census"
 | .integer (.ofNat 0) => .error "ValueError: channel must be in the complete neighbouring generator census"
 | .integer (.ofNat 1) => .error "ValueError: channel must be in the complete neighbouring generator census"
 | .integer (.ofNat (n+2)) =>
   if n ≤ 2 then
     match h : leadingDenominator with
     | .error e => .error e
     | .ok denominator => do
       let held ← positiveTake (asFraction (whole denominator (denominatorPositive denominator h)))
         (asFraction (unitPart (n+2) (Nat.zero_lt_succ _)))
       .ok (reciprocal held)
   else .error "ValueError: channel must be in the complete neighbouring generator census"

def generatedCounts : Except String (Nat × Nat) := do
 let colour ← generatorPeriod
 let fibres ← positivePredecessor (.integer (.ofNat colour))
 .ok (colour,fibres)

theorem countsThreeTwo : generatedCounts = .ok (3,2) := by
 unfold generatedCounts
 rw [generatorPeriodThree]
 rfl

theorem pairSupportPositive (counts : Nat × Nat) (source : generatedCounts = .ok counts) : 0 < counts.2*counts.1 := by
 have same : counts = (3,2) := Except.ok.inj (source.symm.trans countsThreeTwo)
 cases same
 decide

def chargedInvariants : Except String (PositiveFraction × PositiveFraction × PositiveFraction × PositiveFraction) :=
 match hc : generatedCounts with
 | .error e => .error e
 | .ok counts => match hd : leadingDenominator with
   | .error e => .error e
   | .ok denominator => do
     let sharpen ← sharpened (.integer (.ofNat counts.1))
     .ok (whole 1 (by decide),unitPart (counts.2*counts.1) (pairSupportPositive counts hc),
       unitPart denominator (denominatorPositive denominator hd),sharpen)

def pair (value : PositiveFraction) : Nat × Nat := (value.numerator,value.denominator)
def sharpenedPair (channel : CountInput) : Except String (Nat × Nat) := (sharpened channel).map pair

def invariantPairs : Except String ((Nat × Nat) × (Nat × Nat) × (Nat × Nat) × (Nat × Nat)) :=
 chargedInvariants.map fun (sum,pairs,leading,sharpen) => (pair sum,pair pairs,pair leading,pair sharpen)

theorem binaryChannel : sharpenedPair (.integer 2) = .ok (2,969) := rfl

theorem colourChannel : sharpenedPair (.integer 3) = .ok (3,1454) := rfl

theorem successorChannel : sharpenedPair (.integer 4) = .ok (4,1939) := rfl

theorem exactInvariants : invariantPairs = .ok ((1,1),(1,6),(1,485),(3,1454)) := rfl

def channelCensus : List Nat := [2,3,4]

theorem uniqueCarrierChannel (channel : Nat) :
 channel ∈ channelCensus → (channel = 3 ↔ .ok channel = generatorPeriod) := by
 intro _
 rw [generatorPeriodThree]
 exact ⟨fun h => congrArg Except.ok h,fun h => Except.ok.inj h⟩

end SFT.Physics.LeptonInvariants
