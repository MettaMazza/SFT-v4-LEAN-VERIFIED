import SFT.Computation.StructuralTyping
import SFT.Computation.SymbolicTrace
namespace SFT.Computation.ScientificSymbolic
open SymbolicEvaluation SymbolicContext SymbolicTrace StructuralTyping NumericalError
open SFT.Foundation.ExactOperations SFT.Mathematics.DiscreteObjects

def normalForm (environment : Environment) (expression : Expr) : Except String Expr :=
  (evaluate environment expression).map fun value => .value (some value)

theorem normalizationSource (environment : Environment) (expression : Expr) (value : Number)
    (accepted : evaluate environment expression = .ok value) :
    normalForm environment expression = .ok (.value (some value)) := by
  unfold normalForm
  rw [accepted]
  rfl

theorem typedNormalization (environment : Environment) (expression : Expr)
    (unique : distinct (environment.map Prod.fst) = true) (typed : Typed environment expression) :
    ∃ part : PositiveFraction,
      normalForm environment expression = .ok (.value (some (.positive part))) ∧
      evaluate environment expression = .ok (.positive part) ∧
      evaluate environment (.value (some (.positive part))) = .ok (.positive part) := by
  obtain ⟨part,derivation⟩ := preservesEvaluation _ _ typed
  have value := SymbolicEvaluation.replay _ _ _ unique derivation
  exact ⟨part,normalizationSource _ _ _ value,value,SymbolicEvaluation.replay _ _ _ unique (.value part)⟩

structure Model where
  environment : Environment
  unique : distinct (environment.map Prod.fst) = true
  rules : List Rule

structure Rewrite (model : Model) where
  record : Record
  admitted : Admitted model.environment model.rules record
  sourceTyped : Typed model.environment (source record)
  targetTyped : Typed model.environment (target record)

theorem rewriteValue (model : Model) (rewrite : Rewrite model) :
    SameValue model.environment (source rewrite.record) (target rewrite.record) :=
  rewriteEquivalence _ _ _ rewrite.admitted

theorem normalizedLiteral (environment : Environment) (part : PositiveFraction)
    (unique : distinct (environment.map Prod.fst) = true) :
    normalForm environment (.value (some (.positive part))) = .ok (.value (some (.positive part))) :=
  normalizationSource _ _ _ (SymbolicEvaluation.replay _ _ _ unique (.value part))

theorem rewriteNormalization (model : Model) (rewrite : Rewrite model) :
    normalForm model.environment (source rewrite.record) =
      normalForm model.environment (target rewrite.record) := by
  obtain ⟨part,proof⟩ := preservesEvaluation _ _ rewrite.sourceTyped
  have first := SymbolicEvaluation.replay _ _ _ model.unique proof
  have second := (rewriteValue model rewrite (.positive part)).mp first
  rw [normalizationSource _ _ _ first,normalizationSource _ _ _ second]

inductive TypedTrace (model : Model) : Expr → List Record → Expr → Prop where
  | identity (expression : Expr) (typed : Typed model.environment expression) :
      TypedTrace model expression [] expression
  | step (rewrite : Rewrite model) (rest : List Record) (terminal : Expr)
      (tail : TypedTrace model (target rewrite.record) rest terminal) :
      TypedTrace model (source rewrite.record) (rewrite.record::rest) terminal

theorem sourceTrace (model : Model) (first last : Expr) (records : List Record)
    (trace : TypedTrace model first records last) : Trace model.environment model.rules first records last := by
  induction trace with
  | identity expression typed => exact .identity _ (formation _ _ typed)
  | step rewrite rest terminal tail ih => exact .next _ _ _ rewrite.admitted ih

theorem traceTypes (model : Model) (first last : Expr) (records : List Record)
    (trace : TypedTrace model first records last) : Typed model.environment first ∧ Typed model.environment last := by
  induction trace with
  | identity expression typed => exact ⟨typed,typed⟩
  | step rewrite rest terminal tail ih => exact ⟨rewrite.sourceTyped,ih.2⟩

theorem traceNormalization (model : Model) (first last : Expr) (records : List Record)
    (trace : TypedTrace model first records last) :
    normalForm model.environment first = normalForm model.environment last := by
  induction trace with
  | identity => rfl
  | step rewrite rest terminal tail ih => exact (rewriteNormalization _ rewrite).trans ih

theorem traceEvaluation (model : Model) (first last : Expr) (records : List Record)
    (trace : TypedTrace model first records last) :
    ∃ part : PositiveFraction, evaluate model.environment first = .ok (.positive part) ∧
      evaluate model.environment last = .ok (.positive part) := by
  obtain ⟨part,derivation⟩ := preservesEvaluation _ _ (traceTypes _ _ _ _ trace).1
  have value := SymbolicEvaluation.replay _ _ _ model.unique derivation
  exact ⟨part,value,(traceEquivalence _ _ _ _ _ (sourceTrace _ _ _ _ trace) (.positive part)).mp value⟩

theorem composeTraces (model : Model) (first middle last : Expr) (left right : List Record)
    (a : TypedTrace model first left middle) (b : TypedTrace model middle right last) :
    TypedTrace model first (left++right) last := by
  induction a with
  | identity => exact b
  | step rewrite rest terminal tail ih => exact .step _ _ _ (ih b)

theorem appendRewrite (model : Model) (first : Expr) (records : List Record) (rewrite : Rewrite model)
    (trace : TypedTrace model first records (source rewrite.record)) :
    TypedTrace model first (records++[rewrite.record]) (target rewrite.record) :=
  composeTraces _ _ _ _ _ _ trace (.step rewrite [] _ (.identity _ rewrite.targetTyped))

theorem everyRegisteredRule (model : Model) (first last : Expr) (records : List Record)
    (trace : TypedTrace model first records last) :
    ∀ record, record ∈ records → record.rule ∈ model.rules :=
  fun record held => (eachRule _ _ _ _ _ (sourceTrace _ _ _ _ trace) record held).1

theorem normalizationBoundary (model : Model) (first last : Expr) (records : List Record)
    (trace : TypedTrace model first records last) (normal : Normal model.environment model.rules last) :
    Normalized model.environment model.rules first records last := ⟨sourceTrace _ _ _ _ trace,normal⟩

end SFT.Computation.ScientificSymbolic
