import SFT.Physics.NuclearBindingPeak
namespace SFT.Physics.NuclearBindingPeakAssembly
open NuclearBindingPeak NuclearBindingCensus
theorem acceptedStep (candidates : List (Nat × Nat)) (fuel n : Nat) (result : Separation)
 (h : separationStep candidates n = .ok (some result)) :
 separateWithin candidates (fuel+1) n = .ok (some result) := by
 unfold separateWithin
 rw [h]
 rfl
theorem continuedStep (candidates : List (Nat × Nat)) (fuel n : Nat) (result : Separation)
 (h : separationStep candidates n = .ok none)
 (next : separateWithin candidates fuel (n+n) = .ok (some result)) :
 separateWithin candidates (fuel+1) n = .ok (some result) := by
 unfold separateWithin
 rw [h]
 exact next
theorem peakFromEvaluations (censusFuel separationFuel : Nat) (candidates : List (Nat × Nat))
 (separation : Separation) (certificate : Certificate)
 (hc : finitePeakCandidatesWithin censusFuel = .ok (some candidates))
 (hs : separateWithin candidates separationFuel 1 = .ok (some separation))
 (ht : completeCertificate candidates separation = .ok certificate) :
 bindingPeakWithin censusFuel separationFuel = .ok (some certificate) := by
 unfold bindingPeakWithin
 rw [hc]
 dsimp only [Except.bind,Bind.bind]
 rw [hs]
 dsimp only [Except.bind,Bind.bind]
 rw [ht]
 rfl
theorem separationFromEvaluations (candidates : List (Nat × Nat)) (n : Nat)
 (first : Scored) (rest : List Scored) (winner : Scored) (rivals : List Scored) (upper : Rat)
 (hs : scoreCandidates n candidates = .ok (first::rest))
 (hb : bestLower first rest = winner)
 (hr : (first::rest).filter (fun row => !sameCoordinate row winner) = first::rivals)
 (hu : largestUpper first rivals = upper) :
 separationStep candidates n =
 (if upper.blt winner.lower then .ok (some ⟨winner,upper,n⟩) else .ok none) := by
 unfold separationStep
 rw [hs]
 dsimp only [Except.bind,Bind.bind]
 rw [hb,hr]
 dsimp only []
 rw [hu]
 rfl
theorem filterHead {α : Type} (f : α → Bool) (first : α) (rest : List α) (h : f first = true) :
 (first::rest).filter f = first::rest.filter f := by
 change (bif f first then first::rest.filter f else rest.filter f) = _
 rw [h]
 rfl
theorem bestOfFull (first winner : Scored) (rest : List Scored)
 (self : (if first.lower.blt first.lower then first else first) = first)
 (h : (first::rest).foldl (fun best row => if best.lower.blt row.lower then row else best) first = winner) :
 bestLower first rest = winner := by
 change rest.foldl _ (if first.lower.blt first.lower then first else first) = winner at h
 rw [self] at h
 exact h
theorem upperOfFull (first : Scored) (rest : List Scored) (upper : Rat)
 (self : (if first.upper.blt first.upper then first.upper else first.upper) = first.upper)
 (h : (first::rest).foldl (fun best row => if best.blt row.upper then row.upper else best) first.upper = upper) :
 largestUpper first rest = upper := by
 change rest.foldl _ (if first.upper.blt first.upper then first.upper else first.upper) = upper at h
 rw [self] at h
 exact h
end SFT.Physics.NuclearBindingPeakAssembly
