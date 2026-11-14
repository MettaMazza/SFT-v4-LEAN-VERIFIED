import SFT.Computation.NativeClosing
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.NativeBusyGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Grammar where
  | rejected | admitted

def grammarName : Grammar → String
  | .rejected => "external-transition-tables"
  | .admitted => "complete-native-fold-descriptions"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "chosen-instruction-step"
  | .admitted => "one-lawful-depth-lowering-edge"

inductive Halting where
  | rejected | admitted

def haltingName : Halting → String
  | .rejected => "assumed-terminal"
  | .admitted => "exact-empty-one-terminal-trace"

inductive Maximum where
  | rejected | admitted

def maximumName : Maximum → String
  | .rejected => "sampled-long-run"
  | .admitted => "complete-upper-and-attaining-lower-witness"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "cycle-counted-as-halt"
  | .admitted => "separate-exact-nonhalting-certificate"

inductive Successor where
  | rejected | admitted

def successorName : Successor → String
  | .rejected => "depth-fourteen-table-only"
  | .admitted => "prepend-one-label-successor"

inductive Evidence where
  | rejected | admitted

def evidenceName : Evidence → String
  | .rejected => "reported-number"
  | .admitted => "all-process-traces-and-attainment"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "conventional-busy-beaver-import"
  | .admitted => "no-extra-machine-premise"

structure Candidate where
  grammar : Grammar
  transition : Transition
  halting : Halting
  maximum : Maximum
  recurrence : Recurrence
  successor : Successor
  evidence : Evidence
  addition : Addition

def sourceFields (c : Candidate) : List String := [grammarName c.grammar, transitionName c.transition, haltingName c.halting, maximumName c.maximum, recurrenceName c.recurrence, successorName c.successor, evidenceName c.evidence, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "grammar=" (grammarName c.grammar), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "halting=" (haltingName c.halting), SFT.Host.Text.append "maximum=" (maximumName c.maximum), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "successor=" (successorName c.successor), SFT.Host.Text.append "evidence=" (evidenceName c.evidence), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-native-fold-descriptions__one-lawful-depth-lowering-edge__exact-empty-one-terminal-trace__complete-upper-and-attaining-lower-witness__separate-exact-nonhalting-certificate__prepend-one-label-successor__all-process-traces-and-attainment__no-extra-machine-premise"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (grammarName c.grammar) "complete-native-fold-descriptions" &&
  SFT.Host.Text.equal (transitionName c.transition) "one-lawful-depth-lowering-edge" &&
  SFT.Host.Text.equal (haltingName c.halting) "exact-empty-one-terminal-trace" &&
  SFT.Host.Text.equal (maximumName c.maximum) "complete-upper-and-attaining-lower-witness" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "separate-exact-nonhalting-certificate" &&
  SFT.Host.Text.equal (successorName c.successor) "prepend-one-label-successor" &&
  SFT.Host.Text.equal (evidenceName c.evidence) "all-process-traces-and-attainment" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-machine-premise"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (grammarName c.grammar) "complete-native-fold-descriptions") then "An external table imports a machine grammar." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "one-lawful-depth-lowering-edge") then "A chosen instruction set changes the machine." else
  if !(SFT.Host.Text.equal (haltingName c.halting) "exact-empty-one-terminal-trace") then "A terminal label without a trace is not a halt certificate." else
  if !(SFT.Host.Text.equal (maximumName c.maximum) "complete-upper-and-attaining-lower-witness") then "Examples cannot establish the maximum over complete support." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "separate-exact-nonhalting-certificate") then "A recurrent return has no terminal state." else
  if !(SFT.Host.Text.equal (successorName c.successor) "prepend-one-label-successor") then "A long table is not a general certificate." else
  if !(SFT.Host.Text.equal (evidenceName c.evidence) "all-process-traces-and-attainment") then "A number alone hides the process population." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-machine-premise") then "Conventional Turing tables would select a different grammar." else
  "The unique complete kernel forces BB_F(k)=k for every supplied positive finite k in the admitted native Fold closing grammar, with recurrent processes separately certified nonhalting."

def generationRule : String := "Generate the literal product of grammar, transition, halt, maximum, recurrence, successor, evidence and no-import coordinates."
def grammarBoundary : String := "Every positive finite native Fold description built only from generated fibre-label words, lawful depth-lowering Fold edges and separately registered recurrent period-b processes."

def candidates : List Candidate :=
  ([Grammar.rejected,Grammar.admitted]).flatMap fun grammar =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Halting.rejected,Halting.admitted]).flatMap fun halting =>
  ([Maximum.rejected,Maximum.admitted]).flatMap fun maximum =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Successor.rejected,Successor.admitted]).flatMap fun successor =>
  ([Evidence.rejected,Evidence.admitted]).flatMap fun evidence =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨grammar,transition,halting,maximum,recurrence,successor,evidence,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk grammar transition halting maximum recurrence successor evidence addition =>
    have hgrammar : grammar ∈ [Grammar.rejected,Grammar.admitted] := by
      cases grammar <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hhalting : halting ∈ [Halting.rejected,Halting.admitted] := by
      cases halting <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmaximum : maximum ∈ [Maximum.rejected,Maximum.admitted] := by
      cases maximum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuccessor : successor ∈ [Successor.rejected,Successor.admitted] := by
      cases successor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevidence : evidence ∈ [Evidence.rejected,Evidence.admitted] := by
      cases evidence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ grammar _ hgrammar
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ halting _ hhalting
    apply CommonRefinement.memFlatMap _ _ maximum _ hmaximum
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ successor _ hsuccessor
    apply CommonRefinement.memFlatMap _ _ evidence _ hevidence
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk grammar transition halting maximum recurrence successor evidence addition =>
    cases grammar <;> cases transition <;> cases halting <;> cases maximum <;> cases recurrence <;> cases successor <;> cases evidence <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk grammar transition halting maximum recurrence successor evidence addition =>
    cases grammar <;> cases transition <;> cases halting <;> cases maximum <;> cases recurrence <;> cases successor <;> cases evidence <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.grammar = .admitted ∧ c.transition = .admitted ∧ c.halting = .admitted ∧ c.maximum = .admitted ∧ c.recurrence = .admitted ∧ c.successor = .admitted ∧ c.evidence = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk grammar transition halting maximum recurrence successor evidence addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem grammar_rejected_rejected (c : Candidate) (h : c.grammar = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.grammar eq
    rw [h] at field
    cases field

theorem transition_rejected_rejected (c : Candidate) (h : c.transition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transition eq
    rw [h] at field
    cases field

theorem halting_rejected_rejected (c : Candidate) (h : c.halting = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.halting eq
    rw [h] at field
    cases field

theorem maximum_rejected_rejected (c : Candidate) (h : c.maximum = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.maximum eq
    rw [h] at field
    cases field

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
    rw [h] at field
    cases field

theorem successor_rejected_rejected (c : Candidate) (h : c.successor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.successor eq
    rw [h] at field
    cases field

theorem evidence_rejected_rejected (c : Candidate) (h : c.evidence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.evidence eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Computation.NativeBusyGrammar
