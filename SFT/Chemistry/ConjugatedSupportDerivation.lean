import SFT.Chemistry.ConjugatedSupport
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ConjugatedSupport
open SFT.Host SFT.Physics.CapabilityValues

-- The choice executed by append_opposed_fibre, over the source's two labels.
theorem opposedChoiceUnique (last next : String)
 (admittedLast : last = "fold-fibre-one" ∨ last = "fold-fibre-two")
 (admittedNext : next = "fold-fibre-one" ∨ next = "fold-fibre-two")
 (opposed : Text.equal last next = false) :
 next = (if Text.equal last "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one") := by
 cases admittedLast with
 | inl first =>
  cases first
  cases admittedNext with
  | inl same => cases same; cases opposed
  | inr other => cases other; rfl
 | inr second =>
  cases second
  cases admittedNext with
  | inl other => cases other; rfl
  | inr same => cases same; cases opposed

theorem appendedAtomCount (support : ExactConjugatedSupport) (fresh : HeldLabel) :
 (support.atoms ++ [fresh]).length = support.atoms.length+1 :=
 SFT.Foundation.CommonRefinement.appendLength _ _
theorem appendedFibreCount (support : ExactConjugatedSupport) (next : HeldLabel) :
 (support.supportFibres ++ [next]).length = support.supportFibres.length+1 :=
 SFT.Foundation.CommonRefinement.appendLength _ _

-- Exact operational source successor; the hypotheses are its own successful
-- constructors and admission checks, with no additional scientific condition.
theorem appendSourceEquation (support result : ExactConjugatedSupport)
 (name : String) (fresh last next : HeldLabel)
 (named : atom name = .ok fresh)
 (newOccurrence : support.atoms.any (ElectronCountSpin.sameLabel fresh) = false)
 (lastHeld : lastFibre support.supportFibres = .ok last)
 (opposed : fibre (if Text.equal last.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one") = .ok next)
 (admitted : validSupport ⟨support.carrier,support.atoms++[fresh],support.supportFibres++[next]⟩ = .ok result) :
 appendOpposedFibre support name = .ok result := by
 unfold appendOpposedFibre
 rw [named]
 change (if support.atoms.any (ElectronCountSpin.sameLabel fresh) then
  Except.error "successor atom occurrence must be fresh"
  else do
   let last ← lastFibre support.supportFibres
   let next ← fibre (if Text.equal last.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one")
   validSupport ⟨support.carrier,support.atoms++[fresh],support.supportFibres++[next]⟩) = .ok result
 rw [newOccurrence]
 change (do
   let last ← lastFibre support.supportFibres
   let next ← fibre (if Text.equal last.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one")
   validSupport ⟨support.carrier,support.atoms++[fresh],support.supportFibres++[next]⟩) = .ok result
 rw [lastHeld]
 change (do
   let next ← fibre (if Text.equal last.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one")
   validSupport ⟨support.carrier,support.atoms++[fresh],support.supportFibres++[next]⟩) = .ok result
 rw [opposed]
 exact admitted

#print axioms opposedChoiceUnique
#print axioms appendedAtomCount
#print axioms appendedFibreCount
#print axioms appendSourceEquation
end SFT.Chemistry.ConjugatedSupport
