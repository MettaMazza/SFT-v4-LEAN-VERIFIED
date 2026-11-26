from pathlib import Path
w=Path('work');s='''import SFT.Chemistry.CoordinationIsomerism
namespace SFT.Chemistry.CoordinationIsomerismDerivation
open SFT.Host SFT.Physics.CapabilityValues CoordinationIsomerism
-- Every accepted original constructor retains its four complete input words.
theorem constructedExact (composition attachment : List HeldLabel) (orientation : List (List Cell))
 (edges : List (PositiveCount × PositiveCount)) (out : Form)
 (accepted : construct composition attachment orientation edges = .ok out) :
 out = ⟨composition,attachment,orientation,edges⟩ := by
 unfold construct at accepted
 dsimp only at accepted
'''
guards=['composition.length<1 || attachment.length != composition.length || orientation.length != composition.length','!(composition.all fun h => Text.equal h.family "coordination-composition-label")','!(attachment.all fun h => Text.equal h.family "coordination-attachment-mode")','orientation.any (fun word => word.length != 3 || word.all emptyCell)','!(orientation.all fun word => word.all validCell)','edges.any (fun (a,b) => a.value>composition.length || b.value>composition.length || a.value==b.value)','!distinctPairs (edges.map fun (a,b) => normalizedPair a.value b.value)']
for i,g in enumerate(guards):
 pad=' '*(i+1);s+=pad+'cases guard'+str(i)+' : ('+g+') with\n'+pad+'| true => rw [guard'+str(i)+'] at accepted; cases accepted\n'+pad+'| false =>\n'+pad+' rw [guard'+str(i)+'] at accepted\n'
s+=' '*8+'exact (Except.ok.inj accepted).symm\n'
s+='''
theorem extensionRetains (form : Form) (composition attachment : HeldLabel)
 (word : List Cell) (prior : Extension) (out : Form)
 (accepted : extend form composition attachment word prior = .ok out) :
 out.composition=form.composition++[composition] ∧
 out.attachment=form.attachment++[attachment] ∧
 out.orientation=form.orientation++[word] ∧
 out.adjacency=form.adjacency++(match prior with
   | .empty => []
   | .endpoints values => values.map fun p => (p,(⟨form.composition.length+1,Nat.zero_lt_succ _⟩ : PositiveCount))) := by
 have finish (pairs : List (PositiveCount × PositiveCount))
  (built : construct (form.composition++[composition]) (form.attachment++[attachment])
   (form.orientation++[word]) (form.adjacency++pairs) = .ok out) :
  out.composition=form.composition++[composition] ∧
  out.attachment=form.attachment++[attachment] ∧
  out.orientation=form.orientation++[word] ∧ out.adjacency=form.adjacency++pairs := by
  rw [constructedExact _ _ _ _ _ built]
  exact ⟨rfl,rfl,rfl,rfl⟩
 unfold extend at accepted
 cases g0 : (!Text.equal composition.family "coordination-composition-label") with
 | true => rw [g0] at accepted; cases accepted
 | false =>
  rw [g0] at accepted
  cases g1 : (!Text.equal attachment.family "coordination-attachment-mode") with
  | true => rw [g1] at accepted; cases accepted
  | false =>
   rw [g1] at accepted
   cases g2 : (word.length != 3) with
   | true => rw [g2] at accepted; cases accepted
   | false =>
    rw [g2] at accepted
    cases prior with
    | empty => exact finish [] accepted
    | endpoints values =>
     dsimp only at accepted ⊢
     cases g3 : (values.any (fun p => p.value>form.composition.length)) with
     | true => rw [g3] at accepted; cases accepted
     | false =>
      rw [g3] at accepted
      cases g4 : ((values.foldl (fun seen p => if seen.any (fun q => q.value==p.value) then seen else seen++[p]) []).length != values.length) with
      | true => rw [g4] at accepted; cases accepted
      | false =>
       rw [g4] at accepted
       exact finish _ accepted
end SFT.Chemistry.CoordinationIsomerismDerivation
'''
(w/'turn1064_recovery/SFT/Chemistry/CoordinationIsomerismDerivation.lean').write_text(s)
