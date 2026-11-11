import SFT.Chemistry.AmountCount
namespace SFT.Chemistry.ElementIdentity

-- elements_periodicity_batch_1.py ELEMENT_BOUNDARY/DIMENSIONS/SPECS[0].
structure Proton where
 label : String

structure Nucleus where
 first : Proton
 rest : List Proton

def protons (n : Nucleus) : List Proton := n.first :: n.rest
def count (n : Nucleus) : Nat := (protons n).length

def appendProton (n : Nucleus) (p : Proton) : Nucleus := ⟨n.first,n.rest ++ [p]⟩

structure Atom where
 nucleus : Nucleus
 massNumber : Nat
 positiveMass : 0 < massNumber
 electrons : List String

def identity (a : Atom) : Nat := count a.nucleus
def sameElement (a b : Atom) : Prop := identity a = identity b

-- The complete class quantifies over every generated atom, not a sampled list.
def classContains (anchor atom : Atom) : Prop := sameElement anchor atom

theorem positiveIdentity (a : Atom) : 0 < identity a := Nat.zero_lt_succ _
theorem completeClass (anchor atom : Atom) : classContains anchor atom ↔ count anchor.nucleus = count atom.nucleus := ⟨id,id⟩
theorem reflexive (a : Atom) : sameElement a a := rfl
theorem symmetric (a b : Atom) (same : sameElement a b) : sameElement b a := same.symm
theorem transitive (a b c : Atom) (ab : sameElement a b) (bc : sameElement b c) : sameElement a c := ab.trans bc

theorem equalCountIncluded (anchor atom : Atom) (same : count anchor.nucleus = count atom.nucleus) : classContains anchor atom := same

theorem differentCountExcluded (anchor atom : Atom) (different : count anchor.nucleus ≠ count atom.nucleus) : ¬ classContains anchor atom := different

theorem equalRepresentatives (a b : Atom) (same : sameElement a b) (atom : Atom) :
 classContains a atom ↔ classContains b atom :=
 ⟨fun member => same.symm.trans member,fun member => same.trans member⟩

theorem overlappingClassesAgree (a b atom : Atom) (left : classContains a atom) (right : classContains b atom) : sameElement a b := left.trans right.symm

def refineMass (a : Atom) (mass : Nat) (positive : 0 < mass) : Atom := {a with massNumber := mass, positiveMass := positive}
def changeElectrons (a : Atom) (electrons : List String) : Atom := {a with electrons := electrons}

theorem isotopeIdentity (a : Atom) (mass : Nat) (positive : 0 < mass) : sameElement a (refineMass a mass positive) := rfl

theorem massRefinementRetained (a : Atom) (mass : Nat) (positive : 0 < mass) : (refineMass a mass positive).massNumber = mass := rfl

theorem massRefinementDistinct (a : Atom) (mass : Nat) (positive : 0 < mass)
 (different : a.massNumber ≠ mass) : a ≠ refineMass a mass positive :=
 fun same => different (congrArg Atom.massNumber same)

theorem electronIdentity (a : Atom) (electrons : List String) : sameElement a (changeElectrons a electrons) := rfl

theorem massDoesNotMergeElements (a b : Atom) (_sameMass : a.massNumber = b.massNumber)
 (different : identity a ≠ identity b) : ¬ sameElement a b := different

-- A finite membership trace records construction; it does not restrict the class.
structure Trace (Substance : Type) where
 anchor : Atom
 members : List Atom
 substanceCorrespondence : Substance

variable {S : Type}
def admitted (t : Trace S) : Prop := t.members ≠ [] ∧ ∀ a, a ∈ t.members → classContains t.anchor a

def initial (a : Atom) (s : S) : Trace S := ⟨a,[a],s⟩
def appendAtom (t : Trace S) (a : Atom) : Trace S := {t with members := t.members ++ [a]}

theorem initialAdmitted (a : Atom) (s : S) : admitted (initial a s) := by
 refine ⟨(fun h => nomatch h),?_⟩
 intro row held
 cases held with
 | head => rfl
 | tail _ impossible => cases impossible

theorem successorAdmitted (t : Trace S) (a : Atom) (valid : admitted t)
 (same : classContains t.anchor a) : admitted (appendAtom t a) := by
 refine ⟨?_,?_⟩
 · intro empty
   have held : a ∈ (appendAtom t a).members := List.mem_append_right _ (List.Mem.head _)
   rw [empty] at held; cases held
 · intro row held
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases row t.members [a] held with
   | inl old => exact valid.2 row old
   | inr fresh =>
     cases fresh with
     | head => exact same
     | tail _ impossible => cases impossible

theorem priorMembersRetained (t : Trace S) (a prior : Atom) (held : prior ∈ t.members) : prior ∈ (appendAtom t a).members :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft prior t.members [a] held

theorem substanceBoundaryRetained (t : Trace S) (a : Atom) :
 (appendAtom t a).substanceCorrespondence = t.substanceCorrespondence := rfl

theorem substanceDoesNotSelectIdentity (t : Trace S) (s : S) (a : Atom) :
 classContains ({t with substanceCorrespondence := s}).anchor a ↔ classContains t.anchor a := ⟨id,id⟩

theorem countDeterminesClass (relation : Atom → Atom → Prop)
 (exactIdentity : ∀ a b, relation a b ↔ identity a = identity b) (a b : Atom) :
 relation a b ↔ sameElement a b := exactIdentity a b

inductive History : Trace S → Trace S → Prop where
 | base (t : Trace S) (valid : admitted t) : History t t
 | next {first prior : Trace S} (history : History first prior) (a : Atom)
   (same : classContains prior.anchor a) : History first (appendAtom prior a)

theorem historyAdmitted {first last : Trace S} (history : History first last) : admitted last := by
 induction history with
 | base valid => exact valid
 | next prior a same ih => exact successorAdmitted _ a ih same

theorem historyAnchor {first last : Trace S} (history : History first last) : last.anchor = first.anchor := by
 induction history with
 | base => rfl
 | next prior a same ih => exact ih

theorem historyRetainsMembers {first last : Trace S} (history : History first last)
 (a : Atom) (held : a ∈ first.members) : a ∈ last.members := by
 induction history with
 | base => exact held
 | next prior new same ih => exact priorMembersRetained _ new a ih
end SFT.Chemistry.ElementIdentity
