import SFT.Computation.Inference
namespace SFT.Computation.LearningLimits
open SFT.Computation.Inference
open SFT.Mathematics.DiscreteObjects

def observed (inputs : List String) (h : Hypothesis) : List Evidence := h.2.filter (fun e => has inputs e.1)
theorem observedMeaning (inputs : List String) (h : Hypothesis) (e : Evidence) :
    e ∈ observed inputs h ↔ e ∈ h.2 ∧ e.1 ∈ inputs := by
  constructor
  · intro held; have p := (filterMemberIff _ _ _).mp held; exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro held; exact (filterMemberIff _ _ _).mpr ⟨held.1,(hasIff _ _).mpr held.2⟩

structure Pair where
  inputs : List String
  left : Hypothesis
  right : Hypothesis
  target : String
  leftRequired : String
  rightRequired : String
  sameEvidence : observed inputs left = observed inputs right
  unobserved : target ∉ inputs
  leftSource : (target,leftRequired) ∈ left.2
  rightSource : (target,rightRequired) ∈ right.2
  different : leftRequired ≠ rightRequired

abbrev Learner := List Evidence → String → String

theorem sameDecision (pair : Pair) (learner : Learner) :
    learner (observed pair.inputs pair.left) pair.target = learner (observed pair.inputs pair.right) pair.target :=
  congrArg (fun evidence => learner evidence pair.target) pair.sameEvidence

theorem notBothCorrect (pair : Pair) (learner : Learner)
    (left : learner (observed pair.inputs pair.left) pair.target = pair.leftRequired) :
    learner (observed pair.inputs pair.right) pair.target ≠ pair.rightRequired := by
  intro right
  exact pair.different (left.symm.trans ((sameDecision _ _).trans right))

theorem counterexample (pair : Pair) (learner : Learner) :
    learner (observed pair.inputs pair.left) pair.target ≠ pair.leftRequired ∨
    learner (observed pair.inputs pair.right) pair.target ≠ pair.rightRequired := by
  cases test : decide (learner (observed pair.inputs pair.left) pair.target = pair.leftRequired) with
  | false =>
    exact .inl (fun same => by have yes := decide_eq_true same; rw [test] at yes; cases yes)
  | true => exact .inr (notBothCorrect _ _ (of_decide_eq_true test))

inductive Counterexample (pair : Pair) (learner : Learner) where
 | left (failed : learner (observed pair.inputs pair.left) pair.target ≠ pair.leftRequired)
 | right (failed : learner (observed pair.inputs pair.right) pair.target ≠ pair.rightRequired)

def constructCounterexample (pair : Pair) (learner : Learner) : Counterexample pair learner :=
  if h : learner (observed pair.inputs pair.left) pair.target = pair.leftRequired then
    .right (notBothCorrect _ _ h)
  else .left h
theorem counterexampleSource (pair : Pair) (learner : Learner) :
    pair.target ∉ pair.inputs ∧
    (((pair.target,pair.leftRequired) ∈ pair.left.2 ∧
       learner (observed pair.inputs pair.left) pair.target ≠ pair.leftRequired) ∨
     ((pair.target,pair.rightRequired) ∈ pair.right.2 ∧
       learner (observed pair.inputs pair.right) pair.target ≠ pair.rightRequired)) := by
  refine ⟨pair.unobserved,?_⟩
  cases counterexample pair learner with
  | inl failed => exact .inl ⟨pair.leftSource,failed⟩
  | inr failed => exact .inr ⟨pair.rightSource,failed⟩

theorem processingPreservesIndistinguishability (pair : Pair) (process : List Evidence → List Evidence)
    (learner : Learner) : learner (process (observed pair.inputs pair.left)) pair.target =
      learner (process (observed pair.inputs pair.right)) pair.target :=
  congrArg (fun evidence => learner (process evidence) pair.target) pair.sameEvidence

def extendPair (pair : Pair) (left right : Hypothesis)
    (leftEvidence : observed pair.inputs left = observed pair.inputs pair.left)
    (rightEvidence : observed pair.inputs right = observed pair.inputs pair.right)
    (leftRows : ∀ e, e ∈ pair.left.2 → e ∈ left.2)
    (rightRows : ∀ e, e ∈ pair.right.2 → e ∈ right.2) : Pair :=
  ⟨pair.inputs,left,right,pair.target,pair.leftRequired,pair.rightRequired,
    leftEvidence.trans (pair.sameEvidence.trans rightEvidence.symm),pair.unobserved,
    leftRows _ pair.leftSource,rightRows _ pair.rightSource,pair.different⟩

theorem extensionCounterexample (pair : Pair) (left right : Hypothesis)
    (leftEvidence : observed pair.inputs left = observed pair.inputs pair.left)
    (rightEvidence : observed pair.inputs right = observed pair.inputs pair.right)
    (leftRows : ∀ e, e ∈ pair.left.2 → e ∈ left.2)
    (rightRows : ∀ e, e ∈ pair.right.2 → e ∈ right.2) (learner : Learner) :
    learner (observed pair.inputs left) pair.target ≠ pair.leftRequired ∨
    learner (observed pair.inputs right) pair.target ≠ pair.rightRequired :=
  counterexample (extendPair pair left right leftEvidence rightEvidence leftRows rightRows) learner
end SFT.Computation.LearningLimits
