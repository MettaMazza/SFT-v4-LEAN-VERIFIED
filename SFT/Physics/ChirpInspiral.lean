import SFT.Physics.ChirpRingdownDerivation
namespace SFT.Physics.ChirpInspiral
open ChirpRingdown ChirpRingdownDerivation LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
private def falling : Nat → List Nat
 | 0=>[]
 | n+1=>n::falling n
private theorem appendNil (xs : List Nat) : xs++[]=xs := by
 induction xs with
 | nil=>rfl
 | cons x xs ih=>exact congrArg (List.cons x) ih
private theorem reverseAuxAppend {α : Type} (xs acc more : List α) : xs.reverseAux (acc++more)=xs.reverseAux acc++more := by
 induction xs generalizing acc with
 | nil=>rfl
 | cons x xs ih=>exact ih (x::acc)
private theorem reverseCons {α : Type} (x : α) (xs : List α) : (x::xs).reverse=xs.reverse++[x] := reverseAuxAppend xs [] [x]
private theorem rangeReverse (n : Nat) (acc : List Nat) : (List.range.loop n acc).reverse=acc.reverse++falling n := by
 induction n generalizing acc with
 | zero=>exact (appendNil _).symm
 | succ n ih=>
  change (List.range.loop n (n::acc)).reverse=_
  rw [ih,reverseCons,appendAssociative]
  rfl
def orbit (k : Nat) : Orbit :=
 let p:=2^k
 let hp : 0<p := Nat.pow_pos (by decide)
 ⟨wholeRatio p,wholeRatio (p*p*p),natRatio 1 (p*p*p) (Nat.mul_pos (Nat.mul_pos hp hp) hp),multiply (wholeRatio 4) (natRatio 1 (p*p*p) (Nat.mul_pos (Nat.mul_pos hp hp) hp)),natRatio 1 (2*p) (Nat.mul_pos (by decide) hp)⟩
def takeAt (k : Nat) : Rat := natRatio 1 (4*2^k) (Nat.mul_pos (by decide) (Nat.pow_pos (by decide)))
theorem originalOrbit (k : Nat) : orbitalRow (wholeRatio (2^k))=.ok (orbit k) := by
 rw [← natRatioWhole (2^k),originalOrbitalRow (2^k) 1 (Nat.pow_pos (by decide)) (by decide)]
 change (Except.ok (⟨natRatio (2^k) 1 (by decide),natRatio (2^k*2^k*2^k) 1 (by decide),_,_,_⟩ : Orbit) : Except String Orbit)=_
 rw [natRatioWhole,natRatioWhole]
 rfl
theorem originalBindingSuccessor (k : Nat) : (orbit (k+1)).bindingSupport=takeAt k := by
 change natRatio 1 (2*2^(k+1)) _=natRatio 1 (4*2^k) _
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.one_mul,Nat.pow_succ,Nat.mul_comm (2^k) 2,← SFT.Foundation.FractionReduction.mulAssoc]
def retainedRows : Nat → List InspiralRow
 | 0=>[⟨orbit 0,some (takeAt 0)⟩]
 | k+1=>⟨orbit (k+1),some (takeAt (k+1))⟩::retainedRows k
theorem originalRetainedTrace (k : Nat) :
 inspiralRows ((falling (k+1)).map (fun j=>wholeRatio (2^j))) (some (takeAt k))=.ok (retainedRows k) := by
 induction k with
 | zero=>rfl
 | succ k ih=>
  change (do
   let row ← orbitalRow (wholeRatio (2^(k+1)))
   let t ← positiveTake row.bindingSupport (takeAt (k+1))
   pure (InspiralRow.mk row (some t)::(← inspiralRows ((falling (k+1)).map (fun j=>wholeRatio (2^j))) (some row.bindingSupport))))=_
  rw [originalOrbit]
  dsimp only [Except.bind,Bind.bind]
  have take : positiveTake (orbit (k+1)).bindingSupport (takeAt (k+1))=.ok (takeAt (k+1)) :=
   originalBinaryBindingTake (2^(k+1)) (Nat.pow_pos (by decide))
  rw [take,originalBindingSuccessor,ih]
  rfl
theorem originalFullTrace (k : Nat) : inspiralTrace (.integer (.ofNat (k+1)))=
 .ok (⟨orbit (k+1),none⟩::retainedRows k) := by
 unfold inspiralTrace positiveWhole
 change inspiralRows (((List.range.loop (k+2) []).reverse).map (fun j=>wholeRatio (2^j))) none=_
 rw [rangeReverse]
 change (do
  let row ← orbitalRow (wholeRatio (2^(k+1)))
  pure (InspiralRow.mk row none::(← inspiralRows ((falling (k+1)).map (fun j=>wholeRatio (2^j))) (some row.bindingSupport))))=_
 rw [originalOrbit]
 dsimp only [Except.bind,Bind.bind]
 rw [originalBindingSuccessor,originalRetainedTrace]
 rfl
theorem originalRetainedLength (k : Nat) : (retainedRows k).length=k+1 := by
 induction k with
 | zero=>rfl
 | succ k ih=>change (retainedRows k).length+1=k+1+1;rw [ih]
theorem originalFullLength (k : Nat) : (inspiralTrace (.integer (.ofNat (k+1)))).map List.length=.ok (k+2) := by
 rw [originalFullTrace]
 change Except.ok ((retainedRows k).length+1)=_
 rw [originalRetainedLength]
theorem originalRetainedContact (k : Nat) : ∃ tail, (retainedRows k).reverse=⟨orbit 0,some (takeAt 0)⟩::tail := by
 induction k with
 | zero=>exact ⟨[],rfl⟩
 | succ k ih=>
  obtain ⟨tail,ht⟩:=ih
  refine ⟨tail++[⟨orbit (k+1),some (takeAt (k+1))⟩],?_⟩
  change (⟨orbit (k+1),some (takeAt (k+1))⟩::retainedRows k).reverse=_
  rw [reverseCons,ht]
  rfl
theorem originalTerminalContact (k : Nat) :
 (inspiralTrace (.integer (.ofNat (k+1)))).map (fun rows=>rows.reverse.head?.map (fun row=>row.orbit.separation))=.ok (some ChirpRingdown.one) := by
 rw [originalFullTrace]
 obtain ⟨tail,ht⟩:=originalRetainedContact k
 change Except.ok (((⟨orbit (k+1),none⟩::retainedRows k).reverse).head?.map (fun row=>row.orbit.separation))=_
 rw [reverseCons,ht]
 rfl
theorem originalAllRetainedTakesPositive (k : Nat) :
 (retainedRows k).all (fun row=>match row.radiatedTake with | none=>false | some q=>zero.blt q)=true := by
 induction k with
 | zero=>rfl
 | succ k ih=>
  change (zero.blt (takeAt (k+1)) && (retainedRows k).all (fun row=>match row.radiatedTake with | none=>false | some q=>zero.blt q))=true
  rw [ih]
  have positive : zero.blt (takeAt (k+1))=true := positiveNormalized 1 (4*2^(k+1)) (by decide) (Nat.mul_pos (by decide) (Nat.pow_pos (by decide)))
  rw [positive]
  rfl
#print axioms originalRetainedContact
#print axioms originalTerminalContact
#print axioms originalAllRetainedTakesPositive
#print axioms originalOrbit
#print axioms originalBindingSuccessor
#print axioms originalRetainedTrace
#print axioms originalFullTrace
#print axioms originalRetainedLength
#print axioms originalFullLength
end SFT.Physics.ChirpInspiral
