import SFT.Computation.RecognitionTrace
namespace SFT.Computation.HaltingBoundary
open StateTransition StateComposition MachineExecution RecognitionDomain
open SFT.Foundation.Count.TraceDerivation

def Halts (system : System) (initial : String) : Prop :=
  ∃ actions before terminal, Halted system initial terminal actions before

def Verdict (label : String) : Prop := label = "accept" ∨ label = "reject"

def Correct (label : String) (system : System) (initial : String) : Prop :=
  (label = "accept" → Halts system initial) ∧ (label = "reject" → ¬ Halts system initial)

theorem complementHasNoFixedPoint (label : String) (held : Verdict label) :
    selfNegatingBoundary label ≠ .ok label := by
  cases held with
  | inl accept =>
    cases accept
    intro eq
    exact (by decide : ("reject" : String) ≠ "accept") (Except.ok.inj eq)
  | inr reject =>
    cases reject
    intro eq
    exact (by decide : ("accept" : String) ≠ "reject") (Except.ok.inj eq)

theorem complementContradiction (prediction opposite : String) (system : System) (initial : String)
    (held : Verdict prediction) (complement : selfNegatingBoundary prediction = .ok opposite)
    (predicted : Correct prediction system initial) (executed : Correct opposite system initial) : False := by
  cases held with
  | inl accept =>
    cases accept
    have eq : "reject" = opposite := Except.ok.inj complement
    cases eq
    exact executed.2 rfl (predicted.1 rfl)
  | inr reject =>
    cases reject
    have eq : "accept" = opposite := Except.ok.inj complement
    cases eq
    exact predicted.2 rfl (executed.1 rfl)

-- Both constructions use the original generated transition kernel.
def stop : System := ⟨["held"],["fold"],[]⟩

theorem stopAdmitted : create stop.states stop.actions stop.transitions = .ok stop := rfl

theorem stopHalts : Halts stop "held" := by
  refine ⟨[],[],"held",.head [],.identity "held",.head [],?_⟩
  intro action target impossible
  cases impossible

theorem loopNeverHalts : ¬ Halts RecognitionTrace.loop "held" := by
  intro ⟨actions,before,terminal,halted⟩
  have member := executionStates _ _ _ _ RecognitionTrace.loopAdmitted "held" (.head []) _ _
    (pathExecution _ _ _ _ _ halted.2.1) terminal
    (memAppendRight terminal before [terminal] (.head []))
  change terminal ∈ ["held"] at member
  cases member with
  | head => exact haltHasNoContinuation _ _ _ _ _ halted "fold" "held" rfl
  | tail _ impossible => cases impossible

-- A complement record retains the actual original complement operation and
-- the generated process whose terminal behavior realizes its held answer.
def ComplementRecord (prediction : String) (system : System) : Prop :=
  ∃ opposite, selfNegatingBoundary prediction = .ok opposite ∧ Correct opposite system "held"

theorem acceptComplement : ComplementRecord "accept" RecognitionTrace.loop := by
  refine ⟨"reject",rfl,?_,fun _ => loopNeverHalts⟩
  intro impossible
  exact False.elim ((by decide : ("reject" : String) ≠ "accept") impossible)

theorem rejectComplement : ComplementRecord "reject" stop := by
  refine ⟨"accept",rfl,fun _ => stopHalts,?_⟩
  intro impossible
  exact False.elim ((by decide : ("accept" : String) ≠ "reject") impossible)

theorem generatedComplement (prediction : String) (held : Verdict prediction) :
    ∃ system, create system.states system.actions system.transitions = .ok system ∧
      ComplementRecord prediction system := by
  cases held with
  | inl accept => cases accept; exact ⟨RecognitionTrace.loop,RecognitionTrace.loopAdmitted,acceptComplement⟩
  | inr reject => cases reject; exact ⟨stop,stopAdmitted,rejectComplement⟩

theorem retainedTerminalWitness (system : System) (initial : String) (halting : Halts system initial) :
    ∃ actions before terminal, run system initial actions = .ok (before ++ [terminal]) ∧
      BindingTrace.Normal system terminal := by
  obtain ⟨actions,before,terminal,halted⟩ := halting
  exact ⟨actions,before,terminal,(haltReconstructs _ _ _ _ _ halted).1,halted.2.2⟩

open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder

-- Source self-description support is explicit: the predictor is evaluated
-- at the same decoded held description that selects its complement process.
-- The conclusion is scoped to this registered self-application, not every
-- arbitrary finite grammar or an imported conventional universal machine.
theorem registeredPredictionContradiction (registry : List (String × System)) (decoder : Decoder)
    (code : Codeword) (name prediction : String) (system : System)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some system)
    (predictor : Codeword → Except String String) (answered : predictor code = .ok prediction)
    (held : Verdict prediction) (complement : ComplementRecord prediction system)
    (correct : ∀ encoded description machine answer,
      decode encoded decoder = .ok description → lookupFirst registry description = some machine →
      predictor encoded = .ok answer → Correct answer machine "held") : False := by
  obtain ⟨opposite,opposed,execution⟩ := complement
  exact complementContradiction _ _ _ _ held opposed
    (correct code name system prediction decoded selected answered) execution

-- Totality must include the retained self-description; its supported
-- complementary execution then contradicts correctness at that same code.
theorem totalInternalPredictionExcluded (registry : List (String × System)) (decoder : Decoder)
    (predictor : Codeword → Except String String)
    (selfSupport : ∃ code name, decode code decoder = .ok name ∧
      ∀ answer, predictor code = .ok answer → ∃ system,
        lookupFirst registry name = some system ∧ ComplementRecord answer system)
    (total : ∀ code name, decode code decoder = .ok name →
      ∃ answer, Verdict answer ∧ predictor code = .ok answer)
    (correct : ∀ code name system answer, decode code decoder = .ok name →
      lookupFirst registry name = some system → predictor code = .ok answer →
      Correct answer system "held") : False := by
  obtain ⟨code,name,decoded,supported⟩ := selfSupport
  obtain ⟨answer,held,answered⟩ := total code name decoded
  obtain ⟨system,selected,complement⟩ := supported answer answered
  exact registeredPredictionContradiction _ _ _ _ _ _ decoded selected _ answered held complement correct

end SFT.Computation.HaltingBoundary
