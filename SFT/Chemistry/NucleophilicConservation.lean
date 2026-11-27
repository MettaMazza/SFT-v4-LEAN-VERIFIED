import SFT.Chemistry.NucleophilicPath
namespace SFT.Chemistry.NucleophilicConservation
open NucleophilicCarrier SFT.Physics.CapabilityValues

theorem transitionConservation (n : PositiveCount) (entry exit : State) (action : HeldLabel)
 (out : Transition) (accepted : transition n entry exit action=.ok out) :
 DihedralTorsion.equalLabels entry.atoms exit.atoms=true ∧
 sameSet (electrons entry) (electrons exit)=true ∧ out=Transition.mk n entry exit action := by
 change (if !SFT.Host.Text.equal action.family "substitution-action" || !(["cleave-displaced-support","form-entering-support","exchange-support-in-one-transition"].any (SFT.Host.Text.equal action.label)) then Except.error "transition action is outside the generated substitution alphabet"
  else if !DihedralTorsion.equalLabels entry.atoms exit.atoms then Except.error "every atom occurrence must survive a substitution transition"
  else if !sameSet (electrons entry) (electrons exit) then Except.error "every held electron occurrence must survive a substitution transition"
  else Except.ok (Transition.mk n entry exit action))=Except.ok out at accepted
 split at accepted
 · cases accepted
 · split at accepted
   · cases accepted
   · rename_i atomsOK
     split at accepted
     · cases accepted
     · rename_i electronsOK
       have a : DihedralTorsion.equalLabels entry.atoms exit.atoms=true := by
        cases h : DihedralTorsion.equalLabels entry.atoms exit.atoms with
        | true => rfl
        | false => exact False.elim (atomsOK (by rw [h]; rfl))
       have e : sameSet (electrons entry) (electrons exit)=true := by
        cases h : sameSet (electrons entry) (electrons exit) with
        | true => rfl
        | false => exact False.elim (electronsOK (by rw [h]; rfl))
       cases accepted
       exact ⟨a,e,rfl⟩

theorem pairOccurrenceDistinct (first second : HeldLabel) (out : Pair)
 (accepted : pair first second=.ok out) : DihedralTorsion.equalLabel first second=false := by
 change (if !SFT.Host.Text.equal first.family "held-electron-occurrence" || !SFT.Host.Text.equal second.family "held-electron-occurrence" || DihedralTorsion.equalLabel first second then Except.error "a joining pair requires two distinct held electron occurrences" else Except.ok (Pair.mk first second))=Except.ok out at accepted
 cases h : DihedralTorsion.equalLabel first second with
 | false => rfl
 | true =>
  rw [h] at accepted
  cases a : (!SFT.Host.Text.equal first.family "held-electron-occurrence" || !SFT.Host.Text.equal second.family "held-electron-occurrence") <;> rw [a] at accepted <;> cases accepted
end SFT.Chemistry.NucleophilicConservation
