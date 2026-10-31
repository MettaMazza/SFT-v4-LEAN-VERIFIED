import SFT.Mathematics.SelfSimilarWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.SelfSimilarGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "continuous-rescale"
  | .admitted => "fold-doubling"

inductive Separation where
  | rejected | admitted

def separationName : Separation → String
  | .rejected => "fitted-lyapunov"
  | .admitted => "exact-binary-expansion"

inductive Information where
  | rejected | admitted

def informationName : Information → String
  | .rejected => "logarithmic-value"
  | .admitted => "one-closed-label"

inductive Power where
  | rejected | admitted

def powerName : Power → String
  | .rejected => "selected-exponent"
  | .admitted => "unit-self-similar"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "binary-only"
  | .admitted => "m-to-depth"

inductive Series where
  | rejected | admitted

def seriesName : Series → String
  | .rejected => "irrational-limit"
  | .admitted => "rational-tail-bound"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "finite-table"
  | .admitted => "base-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-analytic-function"
  | .admitted => "no-extra-rule"

structure Candidate where
  scale : Scale
  separation : Separation
  information : Information
  power : Power
  support : Support
  series : Series
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [scaleName c.scale, separationName c.separation, informationName c.information, powerName c.power, supportName c.support, seriesName c.series, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "separation=" (separationName c.separation), SFT.Host.Text.append "information=" (informationName c.information), SFT.Host.Text.append "power=" (powerName c.power), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "series=" (seriesName c.series), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "fold-doubling__exact-binary-expansion__one-closed-label__unit-self-similar__m-to-depth__rational-tail-bound__base-successor__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (scaleName c.scale) "fold-doubling" &&
  SFT.Host.Text.equal (separationName c.separation) "exact-binary-expansion" &&
  SFT.Host.Text.equal (informationName c.information) "one-closed-label" &&
  SFT.Host.Text.equal (powerName c.power) "unit-self-similar" &&
  SFT.Host.Text.equal (supportName c.support) "m-to-depth" &&
  SFT.Host.Text.equal (seriesName c.series) "rational-tail-bound" &&
  SFT.Host.Text.equal (generalityName c.generality) "base-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (scaleName c.scale) "fold-doubling") then "A continuous scale group is not generated." else
  if !(SFT.Host.Text.equal (separationName c.separation) "exact-binary-expansion") then "A fitted rate is not a theorem." else
  if !(SFT.Host.Text.equal (informationName c.information) "one-closed-label") then "A logarithm is outside exact proof arithmetic." else
  if !(SFT.Host.Text.equal (powerName c.power) "unit-self-similar") then "A selected exponent is a parameter." else
  if !(SFT.Host.Text.equal (supportName c.support) "m-to-depth") then "The successor law is not tied to one label count." else
  if !(SFT.Host.Text.equal (seriesName c.series) "rational-tail-bound") then "The limit cannot enter as a proof value." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "base-successor") then "A depth table lacks a recurrence." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "Logarithm or exponential would add a model." else
  "The exact Fold rate is binary separation expansion and one closed label per step; unit rank power is the unique Fold-self-similar exponent, m-labelled support is m^d, and decreasing rational terms close convergence without importing their limit as a value."

def generationRule : String := "Exhaust scale action, separation, information, power exponent, support, series, generality and extra-function choices."
def grammarBoundary : String := "Exact generated finite scales, supports and rational partial sums."

def candidates : List Candidate :=
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Separation.rejected,Separation.admitted]).flatMap fun separation =>
  ([Information.rejected,Information.admitted]).flatMap fun information =>
  ([Power.rejected,Power.admitted]).flatMap fun power =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Series.rejected,Series.admitted]).flatMap fun series =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨scale,separation,information,power,support,series,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk scale separation information power support series generality addition =>
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hseparation : separation ∈ [Separation.rejected,Separation.admitted] := by
      cases separation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinformation : information ∈ [Information.rejected,Information.admitted] := by
      cases information <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpower : power ∈ [Power.rejected,Power.admitted] := by
      cases power <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hseries : series ∈ [Series.rejected,Series.admitted] := by
      cases series <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ separation _ hseparation
    apply CommonRefinement.memFlatMap _ _ information _ hinformation
    apply CommonRefinement.memFlatMap _ _ power _ hpower
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ series _ hseries
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition


end SFT.Mathematics.SelfSimilarGrammar
