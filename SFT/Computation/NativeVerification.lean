import SFT.Computation.NativeClosingDomain
namespace SFT.Computation.NativeVerification
open SFT.InformationScience.QuantitySupport NativeClosing

def verifyTrace (word : Word) (trace : List Word) : Except String Bool :=
 if trace.isEmpty then .ok false
 else if decide (trace.head? ≠ some word) then .ok false
 else if decide (trace.getLast? ≠ some emptyOne) then .ok false
 else match closingTrace word with
 | .error reason => .error reason
 | .ok expected => .ok (decide (trace=expected))

theorem acceptedTraceIsEvaluation (word : Word) (trace : List Word)
 (accepted : verifyTrace word trace=.ok true) : trace=suffixTrace word := by
 unfold verifyTrace at accepted
 split at accepted
 next bad => cases accepted
 next nonempty =>
  split at accepted
  next bad => cases accepted
  next source =>
   split at accepted
   next bad => cases accepted
   next terminal =>
    cases found : closingTrace word with
    | error reason => rw [found] at accepted; cases accepted
    | ok expected =>
      rw [found] at accepted
      have eq : trace=expected := of_decide_eq_true (Except.ok.inj accepted)
      unfold closingTrace at found
      split at found
      next bad => cases found
      next good => exact eq.trans (Except.ok.inj found).symm

theorem evaluationTerminal (word : Word) : (suffixTrace word).getLast?=some emptyOne := by
 induction word with
 | nil => rfl
 | cons x xs ih =>
   cases xs with
   | nil => rfl
   | cons y ys => exact ih

theorem evaluationAccepted (word : Word) (admitted : closingTrace word=.ok (suffixTrace word))
 (nonempty : word≠[]) : verifyTrace word (suffixTrace word)=.ok true := by
 cases word with
 | nil => exact False.elim (nonempty rfl)
 | cons x xs =>
  unfold verifyTrace
  change (if false then Except.ok false else if decide (some (x::xs)≠some (x::xs)) then .ok false else
    if decide ((suffixTrace (x::xs)).getLast?≠some emptyOne) then .ok false else
    match closingTrace (x::xs) with | .error reason => .error reason | .ok expected => .ok (decide (suffixTrace (x::xs)=expected))) = .ok true
  rw [evaluationTerminal,admitted]
  have no : ∀ {α : Type} (a : α) [Decidable (a≠a)], decide (a≠a)=false := fun a => decide_eq_false (fun h => h rfl)
  rw [no,no]
  exact congrArg Except.ok (decide_eq_true rfl)

theorem acceptedResources (word : Word) (trace : List Word)
 (accepted : verifyTrace word trace=.ok true) : trace.length-1=word.length := by
 rw [acceptedTraceIsEvaluation word trace accepted]
 exact exactHaltTime word

theorem everyGeneratedEvaluationAccepted (depth : Nat) (positive : 0<depth) (word : Word)
 (generated : word∈words labels depth) : verifyTrace word (suffixTrace word)=.ok true := by
 apply evaluationAccepted word (NativeClosingDomain.generatedWordAdmitted depth positive word generated)
 intro eq
 have length := ((wordCharacterization _ _ _).mp generated).1
 rw [eq] at length
 rw [← length] at positive
 cases positive

theorem bothContainments (depth : Nat) (positive : 0<depth) (word : Word)
 (generated : word∈words labels depth) (trace : List Word) :
 verifyTrace word trace=.ok true ↔ trace=suffixTrace word := by
 constructor
 · exact acceptedTraceIsEvaluation word trace
 · intro eq; rw [eq]; exact everyGeneratedEvaluationAccepted depth positive word generated

theorem exactResourceEquality (depth : Nat) (positive : 0<depth) (word : Word)
 (generated : word∈words labels depth) (trace : List Word)
 (accepted : verifyTrace word trace=.ok true) :
 (suffixTrace word).length-1=depth ∧ trace.length-1=depth := by
 have value := everyGeneratedWordHalts depth word generated
 exact ⟨value,(congrArg (fun rows : List Word => rows.length-1) (acceptedTraceIsEvaluation word trace accepted)).trans value⟩

def changedCertificate (word : Word) : List Word :=
 (if decide (word.reverse≠word) then word.reverse else emptyOne)::(suffixTrace word).tail

def nativePnpEqual (depth : Nat) : Bool :=
 (wordsThroughDepth depth).all (fun word =>
  match verifyTrace word (suffixTrace word) with
  | .error _ => false
  | .ok accepted => match verifyTrace word (changedCertificate word) with
    | .error _ => false
    | .ok changed => accepted && !changed)

theorem changedHeadRejected (word first : Word) (rest : List Word) (changed : first≠word) :
 verifyTrace word (first::rest)=.ok false := by
 unfold verifyTrace
 have different : (some first : Option Word)≠some word := fun h => changed (Option.some.inj h)
 change (if false then Except.ok false else if decide (some first≠some word) then .ok false else _) = .ok false
 rw [decide_eq_true different]
 rfl

theorem generatedNotEmptyOne (depth : Nat) (word : Word) (generated : word∈words labels depth) :
 word≠emptyOne := by
 intro eq
 have carrier := ((wordCharacterization _ _ _).mp generated).2
 have impossible : "empty-One"∈labels := carrier "empty-One" (eq ▸ List.Mem.head [])
 have reject : ∀ label, label∈labels → label≠"empty-One" := by
  intro label held
  cases held with
  | head => exact by decide
  | tail _ held => cases held with
    | head => exact by decide
    | tail _ bad => cases bad
 exact reject "empty-One" impossible rfl

theorem everyGeneratedTamperRejected (depth : Nat) (word : Word)
 (generated : word∈words labels depth) : verifyTrace word (changedCertificate word)=.ok false := by
 unfold changedCertificate
 split
 next changed => exact changedHeadRejected word word.reverse _ (of_decide_eq_true changed)
 next same => exact changedHeadRejected word emptyOne _ (fun eq => generatedNotEmptyOne depth word generated eq.symm)
end SFT.Computation.NativeVerification


