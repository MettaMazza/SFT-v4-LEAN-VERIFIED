import SFT.Chemistry.ElectrophilicPath
namespace SFT.Chemistry.ElectrophilicConservation
open ElectrophilicCarrier SFT.Physics.CapabilityValues
open NucleophilicCarrier (State sameSet electrons)

theorem transitionConservation (n : PositiveCount) (entry exit : State) (action : HeldLabel)
 (out : Transition) (accepted : transition n entry exit action=.ok out) :
 DihedralTorsion.equalLabels entry.atoms exit.atoms=true ∧
 sameSet (electrons entry) (electrons exit)=true ∧ out=Transition.mk n entry exit action := by
 change (if !SFT.Host.Text.equal action.family "acceptor-substitution-action" || !(["exchange-and-restore-in-one-transition","transfer-aromatic-pair-to-entering-support","relinquish-leaving-pair-to-restore-recurrence"].any (SFT.Host.Text.equal action.label)) then Except.error "transition action is outside the generated acceptor-exchange alphabet"
  else if !DihedralTorsion.equalLabels entry.atoms exit.atoms then Except.error "every atom occurrence must survive the transition"
  else if !sameSet (electrons entry) (electrons exit) then Except.error "every held electron occurrence must survive the transition"
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

end SFT.Chemistry.ElectrophilicConservation
