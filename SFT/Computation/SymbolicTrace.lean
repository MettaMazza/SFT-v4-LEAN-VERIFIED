import SFT.Computation.SymbolicContext
namespace SFT.Computation.SymbolicTrace
open SymbolicEvaluation SymbolicContext NumericalError

structure Rule where
  identity : String
  pattern : Expr
  replacement : Expr

structure Record where
  rule : Rule
  context : Context

def source (record : Record) : Expr := plug record.context record.rule.pattern
def target (record : Record) : Expr := plug record.context record.rule.replacement

def Admitted (environment : Environment) (rules : List Rule) (record : Record) : Prop :=
  record.rule ∈ rules ∧ GeneratedContext record.context ∧ Generated record.rule.pattern ∧
    Generated record.rule.replacement ∧ SameValue environment record.rule.pattern record.rule.replacement

theorem admittedSource (environment : Environment) (rules : List Rule) (record : Record)
    (accepted : Admitted environment rules record) : Generated (source record) :=
  plugGenerated _ _ accepted.2.1 accepted.2.2.1

theorem admittedTarget (environment : Environment) (rules : List Rule) (record : Record)
    (accepted : Admitted environment rules record) : Generated (target record) :=
  plugGenerated _ _ accepted.2.1 accepted.2.2.2.1

theorem rewriteEquivalence (environment : Environment) (rules : List Rule) (record : Record)
    (accepted : Admitted environment rules record) : SameValue environment (source record) (target record) :=
  contextualEquivalence _ _ _ _ accepted.2.2.2.2

theorem occurrenceIdentity (record : Record) :
    focus (source record) (address record.context) = some record.rule.pattern ∧
      focus (target record) (address record.context) = some record.rule.replacement :=
  ⟨heldOccurrence _ _,heldOccurrence _ _⟩

inductive Trace (environment : Environment) (rules : List Rule) : Expr → List Record → Expr → Prop where
 | identity (expression : Expr) (generated : Generated expression) : Trace environment rules expression [] expression
 | next (record : Record) (rest : List Record) (terminal : Expr)
     (accepted : Admitted environment rules record) (tail : Trace environment rules (target record) rest terminal) :
     Trace environment rules (source record) (record::rest) terminal

theorem traceEquivalence (environment : Environment) (rules : List Rule) (initial terminal : Expr) (records : List Record)
    (trace : Trace environment rules initial records terminal) : SameValue environment initial terminal := by
  induction trace with
  | identity expression generated => exact sameIdentity _ _
  | next record rest terminal accepted tail ih => exact sameComposition _ _ _ _ (rewriteEquivalence _ _ _ accepted) ih

theorem traceGenerated (environment : Environment) (rules : List Rule) (initial terminal : Expr) (records : List Record)
    (trace : Trace environment rules initial records terminal) : Generated initial ∧ Generated terminal := by
  induction trace with
  | identity expression generated => exact ⟨generated,generated⟩
  | next record rest terminal accepted tail ih => exact ⟨admittedSource _ _ _ accepted,ih.2⟩

theorem eachRule (environment : Environment) (rules : List Rule) (initial terminal : Expr) (records : List Record)
    (trace : Trace environment rules initial records terminal) :
    ∀ record, record ∈ records → Admitted environment rules record := by
  induction trace with
  | identity => intro record impossible; cases impossible
  | next record rest terminal accepted tail ih =>
    intro selected member
    cases member with
    | head => exact accepted
    | tail _ member => exact ih selected member

theorem composition (environment : Environment) (rules : List Rule) (initial middle terminal : Expr) (left right : List Record)
    (first : Trace environment rules initial left middle) (second : Trace environment rules middle right terminal) :
    Trace environment rules initial (left++right) terminal := by
  induction first with
  | identity => exact second
  | next record rest middle accepted tail ih => exact .next _ _ _ accepted (ih second)

theorem successor (environment : Environment) (rules : List Rule) (initial : Expr) (records : List Record) (record : Record)
    (prior : Trace environment rules initial records (source record)) (accepted : Admitted environment rules record) :
    Trace environment rules initial (records++[record]) (target record) :=
  composition _ _ _ _ _ _ _ prior (.next _ _ _ accepted (.identity _ (admittedTarget _ _ _ accepted)))

def Normal (environment : Environment) (rules : List Rule) (expression : Expr) : Prop :=
  Generated expression ∧ ∀ record, Admitted environment rules record → source record ≠ expression

def Normalized (environment : Environment) (rules : List Rule) (initial : Expr) (records : List Record) (terminal : Expr) : Prop :=
  Trace environment rules initial records terminal ∧ Normal environment rules terminal

theorem normalIdentityOnly (environment : Environment) (rules : List Rule) (initial terminal : Expr) (records : List Record)
    (normal : Normal environment rules initial) (trace : Trace environment rules initial records terminal) :
    records = [] ∧ terminal = initial := by
  cases trace with
  | identity => exact ⟨rfl,rfl⟩
  | next record rest terminal accepted tail => exact False.elim (normal.2 record accepted rfl)

theorem normalizationReconstructs (environment : Environment) (rules : List Rule) (initial terminal : Expr) (records : List Record)
    (certificate : Normalized environment rules initial records terminal) (value : Number)
    (original : evaluate environment initial = .ok value) :
    evaluate environment terminal = .ok value ∧ Generated terminal ∧ Normal environment rules terminal :=
  ⟨(traceEquivalence _ _ _ _ _ certificate.1 value).mp original,(traceGenerated _ _ _ _ _ certificate.1).2,certificate.2⟩

theorem frozenRuleBoundary (environment : Environment) (rules larger : List Rule) (initial terminal : Expr) (records : List Record)
    (contained : ∀ rule, rule ∈ rules → rule ∈ larger) (trace : Trace environment rules initial records terminal) :
    Trace environment larger initial records terminal := by
  induction trace with
  | identity expression generated => exact .identity _ generated
  | next record rest terminal accepted tail ih => exact .next _ _ _ ⟨contained _ accepted.1,accepted.2⟩ ih


theorem intermediateValues (environment : Environment) (rules : List Rule) (initial terminal : Expr) (records : List Record)
    (trace : Trace environment rules initial records terminal) (value : Number)
    (original : evaluate environment initial = .ok value) :
    ∀ record, record ∈ records → evaluate environment (source record) = .ok value ∧
      evaluate environment (target record) = .ok value := by
  induction trace generalizing value with
  | identity => intro record impossible; cases impossible
  | next record rest terminal accepted tail ih =>
    have nextValue := (rewriteEquivalence _ _ _ accepted value).mp original
    intro selected member
    cases member with
    | head => exact ⟨original,nextValue⟩
    | tail _ member => exact ih value nextValue selected member

theorem outsideExcluded (environment : Environment) (rules : List Rule) (tag : String) (terminal : Expr) (records : List Record) :
    ¬ Trace environment rules (.outside tag) records terminal := by
  intro trace
  have impossible := (traceGenerated _ _ _ _ _ trace).1
  cases impossible


def PositiveEnvironment (environment : Environment) : Prop :=
  ∀ name value, (name,value) ∈ environment → ∃ part : SFT.Foundation.ExactOperations.PositiveFraction, value = .positive part

theorem positiveEvaluation (environment : Environment) (expression : Expr) (value : Number)
    (positive : PositiveEnvironment environment) (accepted : evaluate environment expression = .ok value) :
    ∃ part : SFT.Foundation.ExactOperations.PositiveFraction, value = .positive part := by
  have derivation := SymbolicEvaluation.reconstruct _ _ _ accepted
  clear accepted
  induction derivation with
  | value part => exact ⟨part,rfl⟩
  | name label value bound => exact positive _ _ (SFT.InformationScience.EncodingMaps.lookupRow _ _ _ bound)
  | join left right a b first second il ir =>
    obtain ⟨x,hx⟩ := il
    obtain ⟨y,hy⟩ := ir
    cases hx; cases hy
    exact ⟨SymbolicValues.positiveSum x y,rfl⟩

structure ScientificNormalization (environment : Environment) (rules : List Rule)
    (initial : Expr) (records : List Record) (terminal : Expr) : Prop where
  uniqueBindings : SFT.Mathematics.DiscreteObjects.distinct (environment.map Prod.fst) = true
  positiveBindings : PositiveEnvironment environment
  certificate : Normalized environment rules initial records terminal

theorem scientificResult (environment : Environment) (rules : List Rule) (initial terminal : Expr) (records : List Record)
    (certificate : ScientificNormalization environment rules initial records terminal) (value : Number)
    (original : evaluate environment initial = .ok value) :
    evaluate environment terminal = .ok value ∧ ∃ part : SFT.Foundation.ExactOperations.PositiveFraction, value = .positive part :=
  ⟨(normalizationReconstructs _ _ _ _ _ certificate.certificate _ original).1,
    positiveEvaluation _ _ _ certificate.positiveBindings original⟩

end SFT.Computation.SymbolicTrace
