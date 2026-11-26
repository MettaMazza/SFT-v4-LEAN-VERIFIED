import SFT.Chemistry.CoordinationIsomerism
namespace SFT.Chemistry.CoordinationIsomerismDerivation
open SFT.Host SFT.Physics.CapabilityValues CoordinationIsomerism
-- Every accepted original constructor retains its four complete input words.
theorem constructedExact (composition attachment : List HeldLabel) (orientation : List (List Cell))
 (edges : List (PositiveCount × PositiveCount)) (out : Form)
 (accepted : construct composition attachment orientation edges = .ok out) :
 out = ⟨composition,attachment,orientation,edges⟩ := by
 unfold construct at accepted
 dsimp only at accepted
 cases guard0 : (composition.length<1 || attachment.length != composition.length || orientation.length != composition.length) with
 | true => rw [guard0] at accepted; cases accepted
 | false =>
  rw [guard0] at accepted
  cases guard1 : (!(composition.all fun h => Text.equal h.family "coordination-composition-label")) with
  | true => rw [guard1] at accepted; cases accepted
  | false =>
   rw [guard1] at accepted
   cases guard2 : (!(attachment.all fun h => Text.equal h.family "coordination-attachment-mode")) with
   | true => rw [guard2] at accepted; cases accepted
   | false =>
    rw [guard2] at accepted
    cases guard3 : (orientation.any (fun word => word.length != 3 || word.all emptyCell)) with
    | true => rw [guard3] at accepted; cases accepted
    | false =>
     rw [guard3] at accepted
     cases guard4 : (!(orientation.all fun word => word.all validCell)) with
     | true => rw [guard4] at accepted; cases accepted
     | false =>
      rw [guard4] at accepted
      cases guard5 : (edges.any (fun (a,b) => a.value>composition.length || b.value>composition.length || a.value==b.value)) with
      | true => rw [guard5] at accepted; cases accepted
      | false =>
       rw [guard5] at accepted
       cases guard6 : (!distinctPairs (edges.map fun (a,b) => normalizedPair a.value b.value)) with
       | true => rw [guard6] at accepted; cases accepted
       | false =>
        rw [guard6] at accepted
        exact (Except.ok.inj accepted).symm

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
-- Original one-occurrence induction base.
theorem singleOccurrenceCensus (position : Nat) :
 MolecularGraphEnumeration.permutations [position] = [[position]] := rfl
-- Every occurrence position is selectable, retaining precisely all other positions.
theorem occurrenceSelection (before suffix : List Nat) (held : Nat) :
 (held,before++suffix) ∈ MolecularGraphEnumeration.selections (before++held::suffix) := by
 induction before with
 | nil => exact List.Mem.head _
 | cons first rest ih =>
  exact List.Mem.tail _ (SFT.Foundation.Count.TraceDerivation.memMap
   (fun pair : Nat × List Nat => (pair.1,first::pair.2)) (held,rest++suffix) _ ih)
-- Every selected image and every remaining mapping are retained in the next census.
theorem censusRetainsBranch (n held : Nat) (items rest suffix : List Nat)
 (selected : (held,rest) ∈ MolecularGraphEnumeration.selections items)
 (retained : suffix ∈ MolecularGraphEnumeration.permutationsAt n rest) :
 held::suffix ∈ MolecularGraphEnumeration.permutationsAt (n+1) items := by
 exact SFT.Foundation.CommonRefinement.memFlatMap _ _ (held,rest) _ selected
  (SFT.Foundation.Count.TraceDerivation.memMap (List.cons held) suffix _ retained)
theorem everyOccurrenceBranch (n held : Nat) (before suffix mapping : List Nat)
 (retained : mapping ∈ MolecularGraphEnumeration.permutationsAt n (before++suffix)) :
 held::mapping ∈ MolecularGraphEnumeration.permutationsAt (n+1) (before++held::suffix) :=
 censusRetainsBranch n held _ _ mapping (occurrenceSelection before suffix held) retained
end SFT.Chemistry.CoordinationIsomerismDerivation
