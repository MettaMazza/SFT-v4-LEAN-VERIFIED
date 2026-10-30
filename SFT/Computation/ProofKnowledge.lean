import SFT.Computation.SecurityPartition
import SFT.Computation.StateTransition
namespace SFT.Computation.ProofKnowledge
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

structure Transcript where
  statement : String
  initial : String
  proverActions : List String
  proverTrace : List String
  interfaceState : String
  verifierActions : List String
  verifierTrace : List String
  deriving DecidableEq

structure Extraction where
  transcript : Transcript
  witness : String
  deriving DecidableEq

structure Model where
  statements : List String
  witnesses : List (String × String)
  prover : StateTransition.System
  verifier : StateTransition.System
  transcripts : List Transcript
  acceptance : List Transcript
  extractor : List Extraction
  adversary : List Transcript

def accepts (m : Model) (t : Transcript) : Bool :=
  has m.statements t.statement && has m.transcripts t && has m.acceptance t

def extractions (m : Model) (t : Transcript) : List Extraction :=
  m.extractor.filter (fun e => decide (e.transcript = t) && has m.witnesses (t.statement,e.witness))

theorem acceptanceMeaning (m : Model) (t : Transcript) : accepts m t = true ↔
    t.statement ∈ m.statements ∧ t ∈ m.transcripts ∧ t ∈ m.acceptance := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; have q := (andTrue _ _).mp p.1
    exact ⟨(hasIff _ _).mp q.1,(hasIff _ _).mp q.2,(hasIff _ _).mp p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr h.1,(hasIff _ _).mpr h.2.1⟩,(hasIff _ _).mpr h.2.2⟩

theorem extractionMeaning (m : Model) (t : Transcript) (e : Extraction) : e ∈ extractions m t ↔
    e ∈ m.extractor ∧ e.transcript = t ∧ (t.statement,e.witness) ∈ m.witnesses := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2
    exact ⟨p.1,of_decide_eq_true q.1,(hasIff _ _).mp q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr ⟨decide_eq_true h.2.1,(hasIff _ _).mpr h.2.2⟩⟩

def extractable (m : Model) (t : Transcript) : Bool := !(extractions m t).isEmpty

theorem exactExtraction (m : Model) (t : Transcript) : extractable m t = true ↔
    ∃ e, e ∈ m.extractor ∧ e.transcript = t ∧ (t.statement,e.witness) ∈ m.witnesses := by
  constructor
  · intro h
    cases rows : extractions m t with
    | nil => unfold extractable at h; rw [rows] at h; cases h
    | cons e es =>
      have held : e ∈ extractions m t := by rw [rows]; exact .head _
      exact ⟨e,(extractionMeaning _ _ _).mp held⟩
  · intro ⟨e,h⟩
    have held := (extractionMeaning _ _ _).mpr h
    cases rows : extractions m t with
    | nil => rw [rows] at held; cases held
    | cons a as => unfold extractable; rw [rows]; rfl

def knowledge (m : Model) : Bool :=
  m.adversary.all (fun t => if accepts m t then extractable m t else true)

theorem exactKnowledge (m : Model) : knowledge m = true ↔
    ∀ t, t ∈ m.adversary → accepts m t = true →
      ∃ e, e ∈ m.extractor ∧ e.transcript = t ∧ (t.statement,e.witness) ∈ m.witnesses := by
  constructor
  · intro h t held accepted
    have checked := allTrueAtMember _ _ h t held
    rw [accepted] at checked
    exact (exactExtraction _ _).mp checked
  · intro h; apply (allTrueIffMembers _ _).mpr
    intro t held
    cases accepted : accepts m t with
    | false => rfl
    | true => exact (exactExtraction _ _).mpr (h t held accepted)

structure Interaction (m : Model) where
  transcript : Transcript
  source : transcript ∈ m.transcripts
  statementHeld : transcript.statement ∈ m.statements
  proverRun : StateTransition.run m.prover transcript.initial transcript.proverActions = .ok transcript.proverTrace
  interfaceHeld : transcript.proverTrace.getLast? = some transcript.interfaceState
  verifierRun : StateTransition.run m.verifier transcript.interfaceState transcript.verifierActions = .ok transcript.verifierTrace

structure AcceptedInteraction (m : Model) extends Interaction m where
  accepted : accepts m transcript = true

theorem interactionRuns (m : Model) (i : Interaction m) :
    StateTransition.Execution m.prover i.transcript.initial i.transcript.proverActions i.transcript.proverTrace ∧
    StateTransition.Execution m.verifier i.transcript.interfaceState i.transcript.verifierActions i.transcript.verifierTrace := by
  exact ⟨(StateTransition.runFromMeaning _ _ _ _).mp ((StateTransition.runAdmission _ _ _ _).mp i.proverRun).2,
    (StateTransition.runFromMeaning _ _ _ _).mp ((StateTransition.runAdmission _ _ _ _).mp i.verifierRun).2⟩

theorem acceptedExtraction (m : Model) (checked : knowledge m = true)
    (i : AcceptedInteraction m) (held : i.transcript ∈ m.adversary) :
    ∃ e, e ∈ m.extractor ∧ e.transcript = i.transcript ∧ (i.transcript.statement,e.witness) ∈ m.witnesses :=
  (exactKnowledge m).mp checked _ held i.accepted

def failures (m : Model) : List Transcript :=
  m.adversary.filter (fun t => accepts m t && !extractable m t)

theorem failureMeaning (m : Model) (t : Transcript) : t ∈ failures m ↔
    t ∈ m.adversary ∧ accepts m t = true ∧ extractable m t = false := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2
    exact ⟨p.1,q.1,(notTrue _).mp q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr ⟨h.2.1,(notTrue _).mpr h.2.2⟩⟩

theorem missingStatement (m : Model) (t : Transcript) (absent : t.statement ∉ m.statements) : accepts m t ≠ true :=
  fun h => absent ((acceptanceMeaning _ _).mp h).1

structure Extension (first second : Model) : Prop where
  statements : ∀ x, x ∈ first.statements → x ∈ second.statements
  witnesses : ∀ x, x ∈ first.witnesses → x ∈ second.witnesses
  transcripts : ∀ x, x ∈ first.transcripts → x ∈ second.transcripts
  acceptance : ∀ x, x ∈ first.acceptance → x ∈ second.acceptance
  extractor : ∀ x, x ∈ first.extractor → x ∈ second.extractor
  adversary : ∀ x, x ∈ first.adversary → x ∈ second.adversary
  proverRuns : ∀ initial actions trace, StateTransition.run first.prover initial actions = .ok trace → StateTransition.run second.prover initial actions = .ok trace
  verifierRuns : ∀ initial actions trace, StateTransition.run first.verifier initial actions = .ok trace → StateTransition.run second.verifier initial actions = .ok trace

theorem acceptanceExtension (first second : Model) (inc : Extension first second) (t : Transcript)
    (h : accepts first t = true) : accepts second t = true := by
  have p := (acceptanceMeaning _ _).mp h
  exact (acceptanceMeaning _ _).mpr ⟨inc.statements _ p.1,inc.transcripts _ p.2.1,inc.acceptance _ p.2.2⟩

theorem extractionExtension (first second : Model) (inc : Extension first second) (t : Transcript)
    (h : extractable first t = true) : extractable second t = true := by
  obtain ⟨e,held,same,witness⟩ := (exactExtraction _ _).mp h
  exact (exactExtraction _ _).mpr ⟨e,inc.extractor _ held,same,inc.witnesses _ witness⟩

def extendInteraction (first second : Model) (inc : Extension first second) (i : Interaction first) : Interaction second :=
  ⟨i.transcript,inc.transcripts _ i.source,inc.statements _ i.statementHeld,
   inc.proverRuns _ _ _ i.proverRun,i.interfaceHeld,inc.verifierRuns _ _ _ i.verifierRun⟩

def extendAccepted (first second : Model) (inc : Extension first second) (i : AcceptedInteraction first) : AcceptedInteraction second :=
  ⟨extendInteraction _ _ inc i.toInteraction,acceptanceExtension _ _ inc _ i.accepted⟩

theorem extensionRetainsTranscript (first second : Model) (inc : Extension first second) (i : Interaction first) :
    (extendInteraction _ _ inc i).transcript = i.transcript := rfl

end SFT.Computation.ProofKnowledge
