import SFT.Foundation.FoldAssemblyGrammar
namespace SFT.Foundation.FoldAssemblyTrace
open FoldAssembly CommonRefinement Count.TraceDerivation

-- Source predecessor/label/successor construction records.
structure Transition where
  predecessor : Word
  label : String
  successor : Word

def transitions (words : List Word) : List Transition :=
  words.flatMap fun p => labels.map fun label => ⟨p,label,appendLabel p label⟩

def returns (words : List Word) : List (Word × Word) :=
  (transitions words).map fun t => (t.successor,t.predecessor)

def generationTrace : Nat → List (List Word)
  | 0 => [supportAfterExtensions 0]
  | n+1 => generationTrace n ++ [supportAfterExtensions (n+1)]

def transitionTrace : Nat → List Transition
  | 0 => []
  | n+1 => transitionTrace n ++ transitions (supportAfterExtensions n)

def returnTrace (n : Nat) : List (Word × Word) :=
  (transitionTrace n).map fun t => (t.successor,t.predecessor)

theorem transitionMembership (words : List Word) (t : Transition) :
    t ∈ transitions words ↔ t.predecessor ∈ words ∧ t.label ∈ labels ∧
      t.successor = appendLabel t.predecessor t.label := by
  constructor
  · intro h
    obtain ⟨p,hp,row⟩ := memFlatMapOrigin (fun p => labels.map fun label => Transition.mk p label (appendLabel p label)) words t h
    obtain ⟨label,hl,eq⟩ := memMapPreimage (fun label => Transition.mk p label (appendLabel p label)) t labels row
    cases eq
    exact ⟨hp,hl,rfl⟩
  · cases t with
    | mk p label child =>
      intro ⟨hp,hl,eq⟩
      change child = appendLabel p label at eq
      subst child
      exact memFlatMap _ words p _ hp (memMap (fun label => Transition.mk p label (appendLabel p label)) label labels hl)

theorem transitionReturns (words : List Word) (t : Transition) (h : t ∈ transitions words) :
    returnWord t.successor = some t.predecessor := by
  have eq := ((transitionMembership words t).mp h).2.2
  rw [eq]
  exact appendReturns _ _

theorem transitionSuccessorGenerated (words : List Word) (t : Transition) (h : t ∈ transitions words) :
    t.successor ∈ extend words := by
  obtain ⟨hp,hl,eq⟩ := (transitionMembership words t).mp h
  exact (successorMembership _ _).mpr ⟨t.predecessor,hp,t.label,hl,eq.symm⟩

theorem everySuccessorHasTransition (words : List Word) (w : Word) (h : w ∈ extend words) :
    ∃ t, t ∈ transitions words ∧ t.successor = w := by
  obtain ⟨p,hp,label,hl,eq⟩ := (successorMembership words w).mp h
  exact ⟨⟨p,label,w⟩,(transitionMembership _ _).mpr ⟨hp,hl,eq.symm⟩,rfl⟩

theorem transitionDeterminedBySuccessor (words : List Word) (t u : Transition)
    (ht : t ∈ transitions words) (hu : u ∈ transitions words) (eq : t.successor = u.successor) : t = u := by
  obtain ⟨_,_,teq⟩ := (transitionMembership words t).mp ht
  obtain ⟨_,_,ueq⟩ := (transitionMembership words u).mp hu
  have parts := appendInjective t.predecessor u.predecessor t.label u.label (teq.symm.trans (eq.trans ueq))
  cases t with
  | mk p label child =>
    cases u with
    | mk q other otherChild =>
      obtain ⟨parents,lasts⟩ := parts
      cases parents; cases lasts; cases eq
      rfl

theorem everySuccessorHasReturnRecord (words : List Word) (w : Word) (h : w ∈ extend words) :
    ∃ p, (w,p) ∈ returns words ∧ returnWord w = some p := by
  obtain ⟨t,ht,eq⟩ := everySuccessorHasTransition words w h
  cases eq
  exact ⟨t.predecessor,memMap (fun t : Transition => (t.successor,t.predecessor)) t _ ht,
    transitionReturns words t ht⟩

theorem returnRecordSound (words : List Word) (child parent : Word) (h : (child,parent) ∈ returns words) :
    returnWord child = some parent := by
  obtain ⟨t,ht,eq⟩ := memMapPreimage (fun t : Transition => (t.successor,t.predecessor)) (child,parent) _ h
  cases eq
  exact transitionReturns words t ht

theorem lastStageRecorded (n : Nat) : supportAfterExtensions n ∈ generationTrace n := by
  cases n with
  | zero => exact List.Mem.head _
  | succ n => exact memAppendRight _ _ _ (List.Mem.head _)

theorem everyStageRecorded (k n : Nat) (h : k ≤ n) : supportAfterExtensions k ∈ generationTrace n := by
  induction h with
  | refl => exact lastStageRecorded k
  | @step n h ih => exact memAppendLeft _ _ _ ih

theorem onlyGeneratedStagesRecorded (n : Nat) (row : List Word) (h : row ∈ generationTrace n) :
    ∃ k, k ≤ n ∧ row = supportAfterExtensions k := by
  induction n with
  | zero => cases h with
    | head => exact ⟨0,Nat.le.refl,rfl⟩
    | tail _ impossible => cases impossible
  | succ n ih =>
    cases memAppendCases row (generationTrace n) [supportAfterExtensions (n+1)] h with
    | inl earlier =>
      obtain ⟨k,hk,eq⟩ := ih earlier
      exact ⟨k,Nat.le.step hk,eq⟩
    | inr last => cases last with
      | head => exact ⟨n+1,Nat.le.refl,rfl⟩
      | tail _ impossible => cases impossible

theorem everyTransitionReturns (n : Nat) (t : Transition) (h : t ∈ transitionTrace n) :
    returnWord t.successor = some t.predecessor := by
  induction n with
  | zero => cases h
  | succ n ih =>
    cases memAppendCases t (transitionTrace n) (transitions (supportAfterExtensions n)) h with
    | inl old => exact ih old
    | inr current => exact transitionReturns _ _ current

theorem everyTransitionReturnRecorded (n : Nat) (t : Transition) (h : t ∈ transitionTrace n) :
    (t.successor,t.predecessor) ∈ returnTrace n :=
  memMap (fun t : Transition => (t.successor,t.predecessor)) t _ h

theorem allReturnRecordsSound (n : Nat) (child parent : Word) (h : (child,parent) ∈ returnTrace n) :
    returnWord child = some parent := by
  obtain ⟨t,ht,eq⟩ := memMapPreimage (fun t : Transition => (t.successor,t.predecessor)) (child,parent) _ h
  cases eq
  exact everyTransitionReturns n t ht

theorem everyLevelTransitionRecorded (k n : Nat) (hk : k < n) (t : Transition)
    (ht : t ∈ transitions (supportAfterExtensions k)) : t ∈ transitionTrace n := by
  have bound : k+1 ≤ n := hk
  induction bound with
  | refl => exact memAppendRight _ _ _ ht
  | @step n h ih => exact memAppendLeft _ _ _ (ih h)

theorem onlyGeneratedTransitionsRecorded (n : Nat) (t : Transition) (h : t ∈ transitionTrace n) :
    ∃ k, k < n ∧ t ∈ transitions (supportAfterExtensions k) := by
  induction n with
  | zero => cases h
  | succ n ih =>
    cases memAppendCases t (transitionTrace n) (transitions (supportAfterExtensions n)) h with
    | inl old =>
      obtain ⟨k,hk,ht⟩ := ih old
      exact ⟨k,Nat.le.step hk,ht⟩
    | inr current => exact ⟨n,Nat.le.refl,current⟩

theorem everyGeneratedChildReturnRecorded (k n : Nat) (hk : k < n) (child : Word)
    (hchild : child ∈ supportAfterExtensions (k+1)) :
    ∃ parent, parent ∈ supportAfterExtensions k ∧ (child,parent) ∈ returnTrace n ∧
      returnWord child = some parent := by
  obtain ⟨t,ht,eq⟩ := everySuccessorHasTransition (supportAfterExtensions k) child hchild
  have full := everyLevelTransitionRecorded k n hk t ht
  cases eq
  exact ⟨t.predecessor,((transitionMembership _ _).mp ht).1,
    everyTransitionReturnRecorded n t full,everyTransitionReturns n t full⟩

theorem everySupportNonempty (n : Nat) : ∃ w, w ∈ supportAfterExtensions n := by
  induction n with
  | zero => exact ⟨[],List.Mem.head _⟩
  | succ n ih =>
    obtain ⟨w,hw⟩ := ih
    exact ⟨appendLabel w "held-a",(bothBranchesGenerated _ _ hw).1⟩

theorem allReturnRecordsGenerated (n : Nat) (child parent : Word)
    (h : (child,parent) ∈ returnTrace n) :
    ∃ k, k < n ∧ parent ∈ supportAfterExtensions k ∧
      ∃ label, label ∈ labels ∧ child = appendLabel parent label := by
  obtain ⟨t,ht,eq⟩ := memMapPreimage (fun t : Transition => (t.successor,t.predecessor)) (child,parent) _ h
  obtain ⟨k,hk,atLevel⟩ := onlyGeneratedTransitionsRecorded n t ht
  obtain ⟨hp,hl,construction⟩ := (transitionMembership _ _).mp atLevel
  cases eq
  exact ⟨k,hk,hp,t.label,hl,construction⟩

-- Proof obligations interpreting the source's seven accepted relation fields
-- on the concrete canonical construction, not a classifier for arbitrary proposals.
structure AssemblyFacts (n : Nat) : Prop where
  coverage : ∀ k, k ≤ n → supportAfterExtensions k ∈ generationTrace n
  lengths : ∀ k, k ≤ n → ∀ w, w ∈ supportAfterExtensions k → w.length = k
  support : ∀ k, k ≤ n → ∀ w, w ∈ supportAfterExtensions k ↔ GeneratedWord k w
  uniqueness : ∀ k, k ≤ n → (supportAfterExtensions k).Nodup
  transitions : ∀ k, k < n → ∀ w, w ∈ supportAfterExtensions (k+1) →
    ∃ t, t ∈ transitionTrace n ∧ t.successor = w
  returns : ∀ k, k < n → ∀ w, w ∈ supportAfterExtensions (k+1) →
    ∃ p, p ∈ supportAfterExtensions k ∧ (w,p) ∈ returnTrace n ∧ returnWord w = some p
  noExtraStages : ∀ row, row ∈ generationTrace n → ∃ k, k ≤ n ∧ row = supportAfterExtensions k
  noExtraTransitions : ∀ t, t ∈ transitionTrace n → ∃ k, k < n ∧ t ∈ FoldAssemblyTrace.transitions (supportAfterExtensions k)
  noExtraReturns : ∀ child parent, (child,parent) ∈ returnTrace n →
    ∃ k, k < n ∧ parent ∈ supportAfterExtensions k ∧ ∃ label, label ∈ labels ∧ child = appendLabel parent label

theorem canonicalAssemblyFacts (n : Nat) : AssemblyFacts n where
  coverage := fun k hk => everyStageRecorded k n hk
  lengths := fun k _ w hw => supportWordLength k w hw
  support := fun k _ w => exactFiniteSupport k w
  uniqueness := fun k _ => allFiniteSupportsUnique k
  transitions := by
    intro k hk w hw
    obtain ⟨t,ht,eq⟩ := everySuccessorHasTransition (supportAfterExtensions k) w hw
    exact ⟨t,everyLevelTransitionRecorded k n hk t ht,eq⟩
  returns := fun k hk w hw => everyGeneratedChildReturnRecorded k n hk w hw
  noExtraStages := fun row h => onlyGeneratedStagesRecorded n row h
  noExtraTransitions := fun t h => onlyGeneratedTransitionsRecorded n t h
  noExtraReturns := fun child parent h => allReturnRecordsGenerated n child parent h

theorem canonicalAcceptedWitnessRealised (n : Nat) :
    FoldAssemblyGrammar.survives FoldAssemblyGrammar.survivor = true ∧ AssemblyFacts (n+1) :=
  ⟨FoldAssemblyGrammar.survivorAccepted,canonicalAssemblyFacts (n+1)⟩

end SFT.Foundation.FoldAssemblyTrace
