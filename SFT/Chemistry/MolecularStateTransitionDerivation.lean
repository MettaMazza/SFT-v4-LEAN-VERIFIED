import SFT.Chemistry.MolecularStateTransition
namespace SFT.Chemistry.MolecularStateTransitionDerivation
open SFT.Chemistry.MolecularStateTransition SFT.Physics.CapabilityValues SFT.Host
open SFT.Chemistry.MulticentreSupport (sameLabel)

theorem acceptedTerminalMeaning (carrier initial : HeldLabel) (terminal : Terminal)
 (orientation record : HeldLabel) (t : Transition)
 (accepted : construct carrier initial terminal orientation record = .ok t) :
 (t.terminal = .emptyOne ∧ sameLabel t.orientation absent = true) ∨
 (∃ endpoint, t.terminal = .state endpoint ∧ Text.equal endpoint.family "molecular-state" = true ∧
   sameLabel endpoint t.initialState = false ∧
   (sameLabel t.orientation forward || sameLabel t.orientation reverse ||
    sameLabel t.orientation bidirectional || sameLabel t.orientation coupled) = true) := by
 unfold construct at accepted
 cases firstGuard : (!Text.equal carrier.family "molecular-carrier" || !Text.equal initial.family "molecular-state") with
 | true => rw [firstGuard] at accepted; cases accepted
 | false =>
  rw [firstGuard] at accepted
  cases recordGuard : (!Text.equal record.family "transition-record") with
  | true => rw [recordGuard] at accepted; cases accepted
  | false =>
   rw [recordGuard] at accepted
   cases absence : sameLabel orientation absent with
   | true =>
    rw [absence] at accepted
    cases terminal with
    | state endpoint => cases accepted
    | otherEmptyOne identity => cases accepted
    | emptyOne =>
     cases accepted
     exact Or.inl ⟨rfl,absence⟩
   | false =>
    rw [absence] at accepted
    cases direction : (sameLabel orientation forward || sameLabel orientation reverse ||
       sameLabel orientation bidirectional || sameLabel orientation coupled) with
    | false => rw [direction] at accepted; cases accepted
    | true =>
     rw [direction] at accepted
     cases terminal with
     | emptyOne => cases accepted
     | otherEmptyOne identity => cases accepted
     | state endpoint =>
      change (if !Text.equal endpoint.family "molecular-state" then
        Except.error "observed transformation requires a retained terminal state"
        else if sameLabel endpoint initial then Except.error "a transformation must retain a state distinction"
        else Except.ok (⟨carrier,initial,.state endpoint,orientation,record⟩ : Transition)) = .ok t at accepted
      cases family : Text.equal endpoint.family "molecular-state" with
      | false => rw [family] at accepted; cases accepted
      | true =>
       rw [family] at accepted
       cases distinction : sameLabel endpoint initial with
       | true => rw [distinction] at accepted; cases accepted
       | false =>
        rw [distinction] at accepted
        cases accepted
        exact Or.inr ⟨endpoint,rfl,family,distinction,direction⟩

theorem observedHasDistinctTerminal (carrier initial : HeldLabel) (terminal : Terminal)
 (orientation record : HeldLabel) (t : Transition)
 (accepted : construct carrier initial terminal orientation record = .ok t)
 (observed : isObserved t = true) :
 ∃ endpoint, t.terminal = .state endpoint ∧ Text.equal endpoint.family "molecular-state" = true ∧
   sameLabel endpoint t.initialState = false ∧
   (sameLabel t.orientation forward || sameLabel t.orientation reverse ||
    sameLabel t.orientation bidirectional || sameLabel t.orientation coupled) = true := by
 cases acceptedTerminalMeaning carrier initial terminal orientation record t accepted with
 | inl closed =>
  unfold isObserved at observed
  rw [closed.2] at observed
  cases observed
 | inr retained => exact retained

theorem absentTerminalIsStructural (carrier initial : HeldLabel) (terminal : Terminal)
 (orientation record : HeldLabel) (t : Transition)
 (accepted : construct carrier initial terminal orientation record = .ok t)
 (absence : sameLabel t.orientation absent = true) : t.terminal = .emptyOne := by
 unfold construct at accepted
 cases firstGuard : (!Text.equal carrier.family "molecular-carrier" || !Text.equal initial.family "molecular-state") with
 | true => rw [firstGuard] at accepted; cases accepted
 | false =>
  rw [firstGuard] at accepted
  cases recordGuard : (!Text.equal record.family "transition-record") with
  | true => rw [recordGuard] at accepted; cases accepted
  | false =>
   rw [recordGuard] at accepted
   cases a : sameLabel orientation absent with
   | true =>
    rw [a] at accepted
    cases terminal with
    | state endpoint => cases accepted
    | otherEmptyOne identity => cases accepted
    | emptyOne => cases accepted; rfl
   | false =>
    rw [a] at accepted
    cases direction : (sameLabel orientation forward || sameLabel orientation reverse ||
       sameLabel orientation bidirectional || sameLabel orientation coupled) with
    | false => rw [direction] at accepted; cases accepted
    | true =>
     rw [direction] at accepted
     cases terminal with
     | emptyOne => cases accepted
     | otherEmptyOne identity => cases accepted
     | state endpoint =>
      change (if !Text.equal endpoint.family "molecular-state" then
        Except.error "observed transformation requires a retained terminal state"
        else if sameLabel endpoint initial then Except.error "a transformation must retain a state distinction"
        else Except.ok (⟨carrier,initial,.state endpoint,orientation,record⟩ : Transition)) = .ok t at accepted
      cases family : Text.equal endpoint.family "molecular-state" with
      | false => rw [family] at accepted; cases accepted
      | true =>
       rw [family] at accepted
       cases distinction : sameLabel endpoint initial with
       | true => rw [distinction] at accepted; cases accepted
       | false =>
        rw [distinction] at accepted
        cases accepted
        change sameLabel orientation absent = true at absence
        rw [a] at absence
        cases absence

end SFT.Chemistry.MolecularStateTransitionDerivation
