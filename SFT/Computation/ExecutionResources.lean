import SFT.Computation.InputExtent
namespace SFT.Computation.ExecutionResources
open ResourceRecord StateTransition StateComposition MachineExecution
open SFT.Foundation.Count.TraceDerivation

-- The source labels every retained observation, including the initial state.
theorem retainedHistory (trace occupied : List String) (ledger : Ledger)
    (recorded : resourceLedger trace occupied = .ok ledger) :
    ledger.timeTrace.map Prod.snd = trace ∧ ledger.spaceSupport = occupied := by
  have recovered := recordReconstructs _ _ _ recorded
  exact ⟨recovered.1,recovered.2.1⟩

theorem historyReconstructionUnique (left right a b : List String) (one two : Ledger)
    (first : resourceLedger left a = .ok one) (second : resourceLedger right b = .ok two)
    (same : one.timeTrace = two.timeTrace) : left = right := by
  have l := (retainedHistory _ _ _ first).1
  have r := (retainedHistory _ _ _ second).1
  exact l.symm.trans ((congrArg (List.map Prod.snd) same).trans r)

theorem terminalResourceTrace (system : System) (initial terminal : String)
    (actions before occupied : List String) (ledger : Ledger)
    (halt : Halted system initial terminal actions before)
    (recorded : resourceLedger (before ++ [terminal]) occupied = .ok ledger) :
    ledger.timeCount = actions.length + 1 ∧
      ledger.timeTrace.map Prod.snd = before ++ [terminal] ∧
      ∀ action target, step system terminal action ≠ .ok target :=
  ⟨executionObservationCount _ _ _ _ _ _ (haltReconstructs _ _ _ _ _ halt).1 recorded,
    (retainedHistory _ _ _ recorded).1,haltHasNoContinuation _ _ _ _ _ halt⟩

theorem timeRowsAppend (left right : List String) (start : Nat) :
    timeRows start (left ++ right) = timeRows start left ++ timeRows (start + left.length) right := by
  induction left generalizing start with
  | nil => rfl
  | cons state rest ih =>
    change (SFT.Host.Text.append "transition-" (toString start),state) ::
      timeRows (start+1) (rest ++ right) = _
    rw [ih,EnumerationTrace.shiftedIndex]
    rfl

theorem successorResources (trace occupied : List String) (next fresh : String) (before after : Ledger)
    (old : resourceLedger trace occupied = .ok before)
    (extended : resourceLedger (trace ++ [next]) (occupied ++ [fresh]) = .ok after) :
    after.timeCount = before.timeCount + 1 ∧ after.spaceCount = before.spaceCount + 1 ∧
      after.timeTrace = before.timeTrace ++ [(SFT.Host.Text.append "transition-" (toString (1+trace.length)),next)] := by
  have one := (ledgerMeaning _ _ _).mp old |>.2.2.2
  have two := (ledgerMeaning _ _ _).mp extended |>.2.2.2
  rw [one,two]
  exact ⟨InputExtent.appendCount _ _,InputExtent.appendCount _ _,timeRowsAppend trace [next] 1⟩

-- A finite nonempty configuration record has an attained peak support class.
-- Its counts remain the original host reports; no numerical scale is added.
theorem peakSupport (head : Ledger) (rest : List Ledger) :
    ∃ peak, peak ∈ head :: rest ∧ ∀ ledger, ledger ∈ head :: rest → ledger.spaceCount ≤ peak.spaceCount := by
  induction rest generalizing head with
  | nil =>
    refine ⟨head,.head [],?_⟩
    intro ledger member
    cases member with
    | head => exact Nat.le_refl _
    | tail _ impossible => cases impossible
  | cons next rest ih =>
    obtain ⟨peak,member,bound⟩ := ih next
    cases Nat.le_total head.spaceCount peak.spaceCount with
    | inl smaller =>
      refine ⟨peak,.tail head member,?_⟩
      intro ledger held
      cases held with
      | head => exact smaller
      | tail _ previous => exact bound ledger previous
    | inr larger =>
      refine ⟨head,.head _,?_⟩
      intro ledger held
      cases held with
      | head => exact Nat.le_refl _
      | tail _ previous => exact Nat.le_trans (bound ledger previous) larger

theorem peakMeasuredSupport (ledger : Ledger) (trace occupied : List String)
    (recorded : resourceLedger trace occupied = .ok ledger) (peak : Ledger)
    (bound : ledger.spaceCount ≤ peak.spaceCount) : occupied.length ≤ peak.spaceCount := by
  rw [← (recordReconstructs _ _ _ recorded).2.2.2]
  exact bound

-- Shared serial boundaries are counted once in the joined trace.
theorem serialObservationCount (system : System) (initial middle terminal : String)
    (left right before after occupied : List String) (ledger : Ledger)
    (held : initial ∈ system.states)
    (first : Path system initial left before middle) (second : Path system middle right after terminal)
    (recorded : resourceLedger ((before ++ after) ++ [terminal]) occupied = .ok ledger) :
    ledger.timeCount = left.length + right.length + 1 := by
  have counted := executionObservationCount _ _ _ _ _ _
    (nativeComposition _ _ _ _ _ _ _ _ held first second) recorded
  rw [InputExtent.appendCount] at counted
  exact counted

-- Repeated terminal labels alone cannot reconstruct retained history.
theorem terminalLabelDoesNotRecoverHistory :
    run RecognitionTrace.loop "held" [] = .ok ["held"] ∧
    run RecognitionTrace.loop "held" ["fold"] = .ok ["held","held"] ∧
    (["held"] : List String) ≠ ["held","held"] := by
  exact ⟨rfl,rfl,by intro impossible; cases impossible⟩
end SFT.Computation.ExecutionResources
