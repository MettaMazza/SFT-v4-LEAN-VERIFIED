import SFT.Physics.AlphaPromotion
import SFT.Physics.BoundaryGrowth
namespace SFT.Physics.AlphaRatio
open SFT.Foundation.ExactOperations AlphaPromotion AlphaBlocks GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000

def whole (value : Nat) (positive : 0 < value) : PositiveFraction :=
 normalizePositive value 1 positive (by decide)

def one : PositiveFraction := whole 1 (by decide)

def add (a b : PositiveFraction) : PositiveFraction :=
 normalizePositive (a.numerator*b.denominator+b.numerator*a.denominator) (a.denominator*b.denominator)
   (Nat.add_pos_left (Nat.mul_pos a.positive (Nat.pos_of_ne_zero b.denominatorNonzero)) _)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.denominatorNonzero) (Nat.pos_of_ne_zero b.denominatorNonzero))

def reciprocal (a : PositiveFraction) : PositiveFraction :=
 normalizePositive a.denominator a.numerator (Nat.pos_of_ne_zero a.denominatorNonzero) a.positive

def divide (a b : PositiveFraction) : PositiveFraction := BoundaryGrowth.multiply a (reciprocal b)

theorem addValue (a b : PositiveFraction) :
 (a.numerator*b.denominator+b.numerator*a.denominator)*(add a b).denominator =
 (add a b).numerator*(a.denominator*b.denominator) :=
 normalizedValuePreserved _ _ (Nat.add_pos_left (Nat.mul_pos a.positive (Nat.pos_of_ne_zero b.denominatorNonzero)) _)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.denominatorNonzero) (Nat.pos_of_ne_zero b.denominatorNonzero))

theorem reciprocalValue (a : PositiveFraction) :
 a.denominator*(reciprocal a).denominator = (reciprocal a).numerator*a.numerator :=
 normalizedValuePreserved _ _ (Nat.pos_of_ne_zero a.denominatorNonzero) a.positive

theorem rungsPositive (rungs : List Nat) (source : promotionRungs = .ok rungs) :
 ∀ n, n ∈ rungs → 0 < n := by
 have same : rungs = [125,175,245,343] := Except.ok.inj (source.symm.trans forcedRungs)
 cases same
 intro n h
 cases h with
 | head => decide
 | tail _ h => cases h with
   | head => decide
   | tail _ h => cases h with
     | head => decide
     | tail _ h => cases h with
       | head => decide
       | tail _ h => cases h

def exactRungs : (rungs : List Nat) → (positive : ∀ n, n ∈ rungs → 0 < n) → List PositiveFraction
 | [],_ => []
 | n :: ns,positive => whole n (positive n (List.Mem.head _)) ::
   exactRungs ns (fun value member => positive value (List.Mem.tail _ member))

theorem exactRungsLength (rungs : List Nat) (positive : ∀ n, n ∈ rungs → 0 < n) :
 (exactRungs rungs positive).length = rungs.length := by
 induction rungs with
 | nil => rfl
 | cons n ns ih => exact congrArg Nat.succ (ih _)

theorem blockPositive (blocks : Blocks) (source : fineStructureBlocks = .ok blocks) :
 0 < blocks.tower ∧ 0 < blocks.boundary ∧ 0 < blocks.cover := by
 have same : blocks = ⟨2,3,5,7,128,9,250⟩ := Except.ok.inj (source.symm.trans forcedBlocks)
 cases same
 exact ⟨by decide,by decide,by decide⟩

def rungAt (rungs : List PositiveFraction) (index : Nat) : PositiveFraction :=
 match rungs with
 | [] => one
 | head :: tail => match index with
   | 0 => head
   | n+1 => rungAt tail n

def chainBack (rungs : List PositiveFraction) : Nat → PositiveFraction → PositiveFraction
 | 0,chain => chain
 | n+1,chain => chainBack rungs n (add (rungAt rungs (n+1)) (reciprocal chain))

inductive ChainSteps (rungs : List PositiveFraction) : Nat → PositiveFraction → PositiveFraction → Prop where
 | done (chain : PositiveFraction) : ChainSteps rungs 0 chain chain
 | step (n : Nat) (chain result : PositiveFraction)
   (tail : ChainSteps rungs n (add (rungAt rungs (n+1)) (reciprocal chain)) result) :
   ChainSteps rungs (n+1) chain result

theorem nativeChain (rungs : List PositiveFraction) (steps : Nat) (chain : PositiveFraction) :
 ChainSteps rungs steps chain (chainBack rungs steps chain) := by
 induction steps generalizing chain with
 | zero => exact .done _
 | succ n ih => exact .step _ _ _ (ih _)

def effectiveCover (order : CountInput) : Except String PositiveFraction :=
 match hr : promotionRungs with
 | .error e => .error e
 | .ok rungs =>
   match order with
   | .boolean _ => .error "ValueError: order must name a positive generated promotion rung"
   | .integer (.negSucc _) => .error "ValueError: order must name a positive generated promotion rung"
   | .integer (.ofNat 0) => .error "ValueError: order must name a positive generated promotion rung"
   | .integer (.ofNat (index+1)) =>
     if index+1 > rungs.length then .error "ValueError: order must name a positive generated promotion rung"
     else match hb : fineStructureBlocks with
       | .error e => .error e
       | .ok blocks =>
         let cover := whole blocks.cover (blockPositive blocks hb).2.2
         match index with
         | 0 => .ok cover
         | earlier+1 =>
           let exact := exactRungs rungs (rungsPositive rungs hr)
           let chain := chainBack exact earlier (rungAt exact (earlier+1))
           .ok (add cover (reciprocal chain))

def inverseFineStructure (order : Option CountInput := none) : Except String PositiveFraction := do
 let chosen ← match order with
   | some requested => .ok requested
   | none => do let rungs ← promotionRungs; .ok (.integer (.ofNat rungs.length))
 match hb : fineStructureBlocks with
 | .error e => .error e
 | .ok blocks =>
   let cover ← effectiveCover chosen
   let positive := blockPositive blocks hb
   let tower := whole blocks.tower positive.1
   let boundary := whole blocks.boundary positive.2.1
   .ok (add tower (divide (BoundaryGrowth.multiply boundary (add cover one)) cover))

def outputPair (result : Except String PositiveFraction) : Except String (Nat × Nat) :=
 result.map fun p => (p.numerator,p.denominator)

theorem leadingRatio : outputPair (inverseFineStructure (some (.integer 1))) = .ok (34259,250) := rfl

theorem terminalRatio : outputPair (inverseFineStructure none) = .ok (503846395469,3676744786) := rfl

theorem automaticTerminal : inverseFineStructure none = inverseFineStructure (some (.integer 4)) := rfl

theorem firstCover : outputPair (effectiveCover (.integer 1)) = .ok (250,1) := rfl

end SFT.Physics.AlphaRatio
