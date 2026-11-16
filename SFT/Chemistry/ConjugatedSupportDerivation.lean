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


-- Exact index operation used by the source incidences property.
theorem labelAtPrefix (prior added : List HeldLabel) (index : Nat) (within : index < prior.length) :
 labelAt (prior++added) index = labelAt prior index := by
 induction prior generalizing index with
 | nil => exact (Nat.not_lt_zero index within).elim
 | cons first rest ih =>
  cases index with
  | zero => rfl
  | succ index =>
   change labelAt (rest++added) index = labelAt rest index
   exact ih index (Nat.lt_of_succ_lt_succ within)

theorem supportCountGuard (support result : ExactConjugatedSupport)
 (accepted : validSupport support = .ok result) :
 (support.supportFibres.length != support.atoms.length-1) = false := by
 unfold validSupport at accepted
 cases h0 : !Text.equal support.carrier.family "molecular-carrier" with
 | true => rw [h0] at accepted; cases accepted
 | false =>
  rw [h0] at accepted
  cases h1 : (support.atoms.length < 3 || !ElectronCountSpin.distinctLabels support.atoms) with
  | true => rw [h1] at accepted; cases accepted
  | false =>
   rw [h1] at accepted
   cases h2 : !(support.atoms.all (fun row => Text.equal row.family "conjugated-atom-occurrence")) with
   | true => rw [h2] at accepted; cases accepted
   | false =>
    rw [h2] at accepted
    cases h3 : (support.supportFibres.length != support.atoms.length-1) with
    | false => rfl
    | true => rw [h3] at accepted; cases accepted

theorem supportCountExact (support result : ExactConjugatedSupport)
 (accepted : validSupport support = .ok result) :
 support.supportFibres.length = support.atoms.length-1 := by
 have guard := supportCountGuard support result accepted
 cases h : (support.supportFibres.length == support.atoms.length-1) with
 | true => exact Nat.eq_of_beq_eq_true h
 | false =>
  change (!(support.supportFibres.length == support.atoms.length-1)) = false at guard
  rw [h] at guard
  cases guard

-- Every original range index keeps its exact left atom, fibre and right atom.
-- This is the body of the source's complete incidence enumeration.
theorem retainedSourceIncidence (support result : ExactConjugatedSupport)
 (fresh next : HeldLabel) (index : Nat)
 (accepted : validSupport support = .ok result)
 (within : index < support.supportFibres.length) :
 (do
  let left ← labelAt (support.atoms++[fresh]) index
  let held ← labelAt (support.supportFibres++[next]) index
  let right ← labelAt (support.atoms++[fresh]) (index+1)
  pure (left,held,right)) =
 (do
  let left ← labelAt support.atoms index
  let held ← labelAt support.supportFibres index
  let right ← labelAt support.atoms (index+1)
  pure (left,held,right) : Except String (HeldLabel × HeldLabel × HeldLabel)) := by
 have countEq := supportCountExact support result accepted
 have bound : index < support.atoms.length-1 := countEq ▸ within
 have nextBound : index+1 < support.atoms.length := by
  cases size : support.atoms.length with
  | zero => rw [size] at bound; exact (Nat.not_lt_zero index bound).elim
  | succ n => rw [size] at bound; exact Nat.succ_lt_succ bound
 have leftBound := Nat.lt_trans (Nat.lt_succ_self index) nextBound
 rw [labelAtPrefix _ _ _ leftBound,labelAtPrefix _ _ _ within,labelAtPrefix _ _ _ nextBound]

#print axioms labelAtPrefix
#print axioms supportCountGuard
#print axioms supportCountExact
#print axioms retainedSourceIncidence
end SFT.Chemistry.ConjugatedSupport
