import SFT.Chemistry.ComplexSpinState
namespace SFT.Chemistry.ComplexSpinStateDerivation
open SFT.Physics.CapabilityValues ComplexSpinState
def selectedLow : Except String Signature := do low (← sixCensus)
def selectedHigh : Except String Signature := do high (← sixCensus)
def censusWitness : Bool := match sixCensus with
 | .error _ => false
 | .ok rows => rows.length==10 && distinctSignatures rows
def isEmpty : ExactCount → Bool
 | .empty _ => true | .positive _ => false
def lowWitness : Bool := match selectedLow with
 | .error _ => false
 | .ok s => number s.lowerPairs==3 && isEmpty (crossings s) && (spinWidth s).value==1
def highWitness : Bool := match selectedHigh with
 | .error _ => false
 | .ok s => number s.lowerPairs==1 && number s.lowerSingles==2 && number s.upperSingles==2 && (spinWidth s).value==5
def orderWitness : Bool := orderLabels==["high-precedes-low","crossover-coincidence","low-precedes-high"]
def capacityWitness : Bool := match capacity ⟨2,by decide⟩ ⟨3,by decide⟩ with
 | .error _ => true | .ok _ => false
def occupancyWitness : Bool := match signature ⟨6,by decide⟩ (exactCount 3) (exactCount 1) (.empty "empty-One") (.empty "empty-One") with
 | .error _ => true | .ok _ => false
theorem censusPassed : censusWitness=true := by decide
theorem lowPassed : lowWitness=true := by decide
theorem highPassed : highWitness=true := by decide
theorem orderPassed : orderWitness=true := by decide
theorem capacityPassed : capacityWitness=true := by decide
theorem occupancyPassed : occupancyWitness=true := by decide
theorem exactCountNumber (n : Nat) : number (exactCount n)=n := by
 unfold exactCount
 split
 · rfl
 · rename_i h
   have hn : n=0 := Nat.eq_zero_of_not_pos h
   subst n
   rfl
theorem positiveCost (s : Signature) (r : PositiveCount) :
 number (pathCost s (.positive r))=number (pairClosures s)+r.value*number (crossings s) := exactCountNumber _
theorem dilutedCost (s : Signature) (identity : String) :
 number (pathCost s (.empty identity))=number (pairClosures s) := exactCountNumber _
theorem successorCost (s : Signature) (r : PositiveCount) :
 number (pathCost s (.positive ⟨r.value+1,Nat.zero_lt_succ _⟩))=
 number (pathCost s (.positive r))+number (crossings s) := by
 rw [positiveCost,positiveCost,Nat.succ_mul,Nat.add_assoc]
def lowSix : Signature := ⟨⟨6,by decide⟩,exactCount 3,exactCount 0,exactCount 0,exactCount 0⟩
def highSix : Signature := ⟨⟨6,by decide⟩,exactCount 1,exactCount 2,exactCount 0,exactCount 2⟩
theorem lowSelected : selectedLow=.ok lowSix := by rfl
theorem highSelected : selectedHigh=.ok highSix := by rfl
theorem lowCost (r : PositiveCount) : number (pathCost lowSix (.positive r))=3 := by
 rw [positiveCost]; change 3+r.value*0=3; rw [Nat.mul_zero,Nat.add_zero]
theorem highCost (r : PositiveCount) : number (pathCost highSix (.positive r))=1+r.value*2 := positiveCost _ _
theorem uniqueCoincidence (r : PositiveCount) :
 number (pathCost highSix (.positive r))=number (pathCost lowSix (.positive r)) ↔ r.value=1 := by
 constructor
 · intro h
   have hc := (highCost r).symm.trans (h.trans (lowCost r))
   rcases r with ⟨n,hpos⟩
   cases n with
   | zero => exact False.elim (Nat.not_lt_zero _ hpos)
   | succ n =>
     cases n with
     | zero => rfl
     | succ k =>
       have bigger : 1<k+2 := Nat.lt_of_lt_of_le (by decide : 1<2) (Nat.le_add_left 2 k)
       have costBigger : 3<1+(k+2)*2 := Nat.add_lt_add_left (Nat.mul_lt_mul_of_pos_right bigger (by decide : 0<2)) 1
       exact False.elim (Nat.ne_of_gt costBigger hc)
 · intro h
   exact (highCost r).trans ((congrArg (fun n => 1+n*2) h).trans (lowCost r).symm)
theorem laterLowPrecedes (r : PositiveCount) (later : 1<r.value) :
 number (pathCost lowSix (.positive r))<number (pathCost highSix (.positive r)) := by
 rw [lowCost,highCost]
 exact Nat.add_lt_add_left (Nat.mul_lt_mul_of_pos_right later (by decide : 0<2)) 1
theorem dilutedHighPrecedes (identity : String) :
 number (pathCost highSix (.empty identity))<number (pathCost lowSix (.empty identity)) := by
 rw [dilutedCost,dilutedCost]; decide
end SFT.Chemistry.ComplexSpinStateDerivation
