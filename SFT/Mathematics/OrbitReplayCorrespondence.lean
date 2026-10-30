import SFT.Mathematics.OrbitNumberWitnessBase
namespace SFT.Mathematics.OrbitReplayCorrespondence
open OrbitNumberWitnesses OrbitOrderIdentity

inductive OrderRun (q : Nat) : Nat → Nat → Nat → Prop where
 | returned (residue count : Nat) (complete : (residue == 1) = true) :
   OrderRun q residue count count
 | advanced (residue count result : Nat) (incomplete : (residue == 1) = false)
   (tail : OrderRun q ((residue*2)%q) (count+1) result) : OrderRun q residue count result

theorem orderReplayCorrespondence (q fuel residue count result : Nat)
 (finished : orderReplay q fuel residue count = some result) : OrderRun q residue count result := by
 induction fuel generalizing residue count with
 | zero =>
   unfold orderReplay at finished
   cases h : residue == 1 with
   | false => rw [h] at finished; cases finished
   | true => rw [h] at finished; cases finished; exact .returned residue result h
 | succ fuel ih =>
   unfold orderReplay at finished
   cases h : residue == 1 with
   | false => rw [h] at finished; exact .advanced residue count result h (ih _ _ finished)
   | true => rw [h] at finished; cases finished; exact .returned residue result h

inductive OrbitRun (q : Nat) : Nat → List Nat → List Nat → Prop where
 | repeated (current : Nat) (seen : List Nat) (visited : seen.contains current = true) :
   OrbitRun q current seen seen
 | advanced (current : Nat) (seen result : List Nat) (fresh : seen.contains current = false)
   (tail : OrbitRun q (foldRank current q) (seen++[current]) result) : OrbitRun q current seen result

theorem orbitReplayCorrespondence (q fuel current : Nat) (seen result : List Nat)
 (finished : orbitReplay q fuel current seen = some result) : OrbitRun q current seen result := by
 induction fuel generalizing current seen with
 | zero =>
   unfold orbitReplay at finished
   cases h : seen.contains current with
   | false => rw [h] at finished; cases finished
   | true => rw [h] at finished; cases finished; exact .repeated current result h
 | succ fuel ih =>
   unfold orbitReplay at finished
   cases h : seen.contains current with
   | false => rw [h] at finished; exact .advanced current seen result h (ih _ _ finished)
   | true => rw [h] at finished; cases finished; exact .repeated current result h

end SFT.Mathematics.OrbitReplayCorrespondence
