import SFT.Chemistry.AtomicNumberOrder
namespace SFT.Chemistry.IsotopeFamily
open ElementIdentity AtomicNumberOrder

structure Nuclide where
 atom : Atom
 complementaryNuclearRecord : List String
 nucleonCount : atom.massNumber = atomicNumber atom + complementaryNuclearRecord.length
 observation : SFT.Host.Canonical.Value

def sameElement (a b : Nuclide) : Prop := atomicNumber a.atom = atomicNumber b.atom
def isotopeDistinction (a b : Nuclide) : Prop := sameElement a b ∧ a.atom.massNumber ≠ b.atom.massNumber

theorem commonElement (a b : Nuclide) (related : isotopeDistinction a b) : ElementIdentity.sameElement a.atom b.atom := related.1

theorem distinctNuclides (a b : Nuclide) (related : isotopeDistinction a b) : a ≠ b :=
 fun equal => related.2 (congrArg (fun n : Nuclide => n.atom.massNumber) equal)

theorem complementaryDifference (a b : Nuclide) (related : isotopeDistinction a b) :
 a.complementaryNuclearRecord.length ≠ b.complementaryNuclearRecord.length := by
 intro same
 apply related.2
 exact a.nucleonCount.trans (((congrArg (fun k => k + a.complementaryNuclearRecord.length) related.1).trans (congrArg (Nat.add (atomicNumber b.atom)) same)).trans b.nucleonCount.symm)

theorem mixedElementRejected (a b : Nuclide) (different : atomicNumber a.atom ≠ atomicNumber b.atom) :
 ¬isotopeDistinction a b := fun related => different related.1

def rerecordObservation (a : Nuclide) (record : SFT.Host.Canonical.Value) : Nuclide := {a with observation := record}

theorem observationPreservesDistinction (a b : Nuclide) (left right : SFT.Host.Canonical.Value)
 (related : isotopeDistinction a b) : isotopeDistinction (rerecordObservation a left) (rerecordObservation b right) := related

def distinctMasses : List Nuclide → Prop
 | [] => True
 | a :: rest => (∀ b, b ∈ rest → a.atom.massNumber ≠ b.atom.massNumber) ∧ distinctMasses rest

def admitted (anchor : Nuclide) (members : List Nuclide) : Prop :=
 members ≠ [] ∧ (∀ a, a ∈ members → sameElement anchor a) ∧ distinctMasses members

theorem distinctAppend (members : List Nuclide) (new : Nuclide)
 (distinct : distinctMasses members)
 (fresh : ∀ a, a ∈ members → a.atom.massNumber ≠ new.atom.massNumber) :
 distinctMasses (members ++ [new]) := by
 induction members with
 | nil =>
   refine ⟨?_,True.intro⟩
   intro a impossible; cases impossible
 | cons first rest ih =>
   refine ⟨?_,ih distinct.2 (fun a held => fresh a (List.Mem.tail _ held))⟩
   intro a held
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases a rest [new] held with
   | inl old => exact distinct.1 a old
   | inr appended =>
     cases appended with
     | head => exact fresh first (List.Mem.head _)
     | tail _ impossible => cases impossible

theorem initialPair (a b : Nuclide) (related : isotopeDistinction a b) : admitted a [a,b] := by
 refine ⟨(fun h => nomatch h),?_,?_⟩
 · intro row held
   cases held with
   | head => rfl
   | tail _ tail =>
     cases tail with
     | head => exact related.1
     | tail _ impossible => cases impossible
 · refine ⟨?_,?_,True.intro⟩
   · intro row held
     cases held with
     | head => exact related.2
     | tail _ impossible => cases impossible
   · intro row impossible; cases impossible

theorem successorAdmitted (anchor : Nuclide) (members : List Nuclide) (new : Nuclide)
 (valid : admitted anchor members) (same : sameElement anchor new)
 (fresh : ∀ a, a ∈ members → a.atom.massNumber ≠ new.atom.massNumber) : admitted anchor (members ++ [new]) := by
 refine ⟨?_,?_,distinctAppend members new valid.2.2 fresh⟩
 · intro empty
   have held : new ∈ members ++ [new] := List.mem_append_right _ (List.Mem.head _)
   rw [empty] at held; cases held
 · intro a held
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases a members [new] held with
   | inl old => exact valid.2.1 a old
   | inr appended =>
     cases appended with
     | head => exact same
     | tail _ impossible => cases impossible

theorem priorNuclidesRetained (members : List Nuclide) (new old : Nuclide) (held : old ∈ members) :
 old ∈ members ++ [new] := SFT.Foundation.Count.TraceDerivation.memAppendLeft old members [new] held

theorem differentElementSuccessorRejected (anchor : Nuclide) (members : List Nuclide) (new : Nuclide)
 (different : ¬sameElement anchor new) : ¬admitted anchor (members ++ [new]) :=
 fun valid => different (valid.2.1 new (List.mem_append_right _ (List.Mem.head _)))

theorem nuclearRecordRetained (n : Nuclide) : n.atom.massNumber = atomicNumber n.atom + n.complementaryNuclearRecord.length := n.nucleonCount

inductive History (anchor : Nuclide) : List Nuclide → List Nuclide → Prop where
 | base (members : List Nuclide) (valid : admitted anchor members) : History anchor members members
 | next {first prior : List Nuclide} (history : History anchor first prior) (new : Nuclide)
   (same : sameElement anchor new)
   (fresh : ∀ a, a ∈ prior → a.atom.massNumber ≠ new.atom.massNumber) : History anchor first (prior ++ [new])

theorem historyAdmitted {anchor : Nuclide} {first last : List Nuclide} (history : History anchor first last) : admitted anchor last := by
 induction history with
 | base valid => exact valid
 | next prior new same fresh ih => exact successorAdmitted anchor _ new ih same fresh

theorem historyRetainsEveryMember {anchor : Nuclide} {first last : List Nuclide}
 (history : History anchor first last) (n : Nuclide) (held : n ∈ first) : n ∈ last := by
 induction history with
 | base => exact held
 | next prior new same fresh ih => exact priorNuclidesRetained _ new n ih
end SFT.Chemistry.IsotopeFamily
