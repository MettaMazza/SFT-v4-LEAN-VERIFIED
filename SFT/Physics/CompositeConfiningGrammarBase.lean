import SFT.Physics.CompositeConfiningOrbits
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CompositeConfiningGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Scope where
  | rejected | admitted

def scopeName : Scope → String
  | .rejected => "five-selected-case-table"
  | .admitted => "every-generated-even-sector"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "borrowed-or-measured-denominator"
  | .admitted => "positive-predecessor-denominator"

inductive Modes where
  | rejected | admitted

def modesName : Modes → String
  | .rejected => "selected-mode-subset"
  | .admitted => "all-nonempty-predecessor-labels"

inductive Action where
  | rejected | admitted

def actionName : Action → String
  | .rejected => "selected-orbit-permutation"
  | .admitted => "double-and-cast-denominator-wholes"

inductive Confinement where
  | rejected | admitted

def confinementName : Confinement → String
  | .rejected => "finite-table-assertion"
  | .admitted => "odd-support-exact-inverse"

inductive Orbits where
  | rejected | admitted

def orbitsName : Orbits → String
  | .rejected => "named-or-overlapping-orbits"
  | .admitted => "complete-disjoint-first-return-partition"

inductive Antipodes where
  | rejected | admitted

def antipodesName : Antipodes → String
  | .rejected => "borrowed-pairing-rule"
  | .admitted => "unique-positive-One-complements"

inductive Pair_count where
  | rejected | admitted

def pair_countName : Pair_count → String
  | .rejected => "ambiguous-sector-minus-one-over-two"
  | .admitted => "predecessor-of-denominator-over-two"

inductive Coupling where
  | rejected | admitted

def couplingName : Coupling → String
  | .rejected => "measured-or-fitted-coupling"
  | .admitted => "all-but-one-predecessor-over-sector"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "unobserved-cases-counted-as-confirmed"
  | .admitted => "sealed-eight-anchor-and-explicit-standing-cases"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-orbit-or-coupling-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  scope : Scope
  support : Support
  modes : Modes
  action : Action
  confinement : Confinement
  orbits : Orbits
  antipodes : Antipodes
  pair_count : Pair_count
  coupling : Coupling
  comparison : Comparison
  extension : Extension

def sourceFields (c : Candidate) : List String := [scopeName c.scope, supportName c.support, modesName c.modes, actionName c.action, confinementName c.confinement, orbitsName c.orbits, antipodesName c.antipodes, pair_countName c.pair_count, couplingName c.coupling, comparisonName c.comparison, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "scope=" (scopeName c.scope), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "modes=" (modesName c.modes), SFT.Host.Text.append "action=" (actionName c.action), SFT.Host.Text.append "confinement=" (confinementName c.confinement), SFT.Host.Text.append "orbits=" (orbitsName c.orbits), SFT.Host.Text.append "antipodes=" (antipodesName c.antipodes), SFT.Host.Text.append "pair_count=" (pair_countName c.pair_count), SFT.Host.Text.append "coupling=" (couplingName c.coupling), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "every-generated-even-sector__positive-predecessor-denominator__all-nonempty-predecessor-labels__double-and-cast-denominator-wholes__odd-support-exact-inverse__complete-disjoint-first-return-partition__unique-positive-One-complements__predecessor-of-denominator-over-two__all-but-one-predecessor-over-sector__sealed-eight-anchor-and-explicit-standing-cases__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (scopeName c.scope) "every-generated-even-sector" &&
  SFT.Host.Text.equal (supportName c.support) "positive-predecessor-denominator" &&
  SFT.Host.Text.equal (modesName c.modes) "all-nonempty-predecessor-labels" &&
  SFT.Host.Text.equal (actionName c.action) "double-and-cast-denominator-wholes" &&
  SFT.Host.Text.equal (confinementName c.confinement) "odd-support-exact-inverse" &&
  SFT.Host.Text.equal (orbitsName c.orbits) "complete-disjoint-first-return-partition" &&
  SFT.Host.Text.equal (antipodesName c.antipodes) "unique-positive-One-complements" &&
  SFT.Host.Text.equal (pair_countName c.pair_count) "predecessor-of-denominator-over-two" &&
  SFT.Host.Text.equal (couplingName c.coupling) "all-but-one-predecessor-over-sector" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "sealed-eight-anchor-and-explicit-standing-cases" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (scopeName c.scope) "every-generated-even-sector") then "A selected table does not prove the next even sector." else
  if !(SFT.Host.Text.equal (supportName c.support) "positive-predecessor-denominator") then "A named or measured denominator can select the orbit." else
  if !(SFT.Host.Text.equal (modesName c.modes) "all-nonempty-predecessor-labels") then "A subset cannot establish exhaustive confinement." else
  if !(SFT.Host.Text.equal (actionName c.action) "double-and-cast-denominator-wholes") then "A listed permutation imports its answer." else
  if !(SFT.Host.Text.equal (confinementName c.confinement) "odd-support-exact-inverse") then "A table alone does not close arbitrary successor depth." else
  if !(SFT.Host.Text.equal (orbitsName c.orbits) "complete-disjoint-first-return-partition") then "Named or overlapping rows omit a complete partition proof." else
  if !(SFT.Host.Text.equal (antipodesName c.antipodes) "unique-positive-One-complements") then "A borrowed pair rule does not prove exhaustiveness." else
  if !(SFT.Host.Text.equal (pair_countName c.pair_count) "predecessor-of-denominator-over-two") then "That notation is not a whole count for even s." else
  if !(SFT.Host.Text.equal (couplingName c.coupling) "all-but-one-predecessor-over-sector") then "Measurement cannot select a holding law." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "sealed-eight-anchor-and-explicit-standing-cases") then "A standing prediction is not a measurement." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An inserted row or correction is a free parameter." else
  "The complete composite-sector census is: sector 8, denominator 7, orbits (1,2,4)/(3,6,5), three antipodal pairs and coupling 7/8; sector 12, denominator 11, one ten-mode orbit, five pairs and 11/12; sector 18, denominator 17, two eight-mode orbits, eight pairs and 17/18; sector 24, denominator 23, two eleven-mode orbits, eleven pairs and 23/24; sector 30, denominator 29, one twenty-eight-mode orbit, fourteen pairs and 29/30. The general odd-support inverse proves denominator confinement and complete recurrence at every positive finite Fold depth."

def generationRule : String := "Generate the complete product of sector scope, held support, standing-mode census, Fold action, confinement, orbit partition, antipodal closure, pair-count law, holding coupling, external correspondence boundary and extension form."
def grammarBoundary : String := "Every positive finite even sector beyond two; its odd positive predecessor denominator; every nonempty numerator label; every exact Fold successor and first return; every complement pair; the five registered composite-sector instances; and the already sealed force-sector anchor boundary."

def candidates : List Candidate :=
  ([Scope.rejected,Scope.admitted]).flatMap fun scope =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Modes.rejected,Modes.admitted]).flatMap fun modes =>
  ([Action.rejected,Action.admitted]).flatMap fun action =>
  ([Confinement.rejected,Confinement.admitted]).flatMap fun confinement =>
  ([Orbits.rejected,Orbits.admitted]).flatMap fun orbits =>
  ([Antipodes.rejected,Antipodes.admitted]).flatMap fun antipodes =>
  ([Pair_count.rejected,Pair_count.admitted]).flatMap fun pair_count =>
  ([Coupling.rejected,Coupling.admitted]).flatMap fun coupling =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨scope,support,modes,action,confinement,orbits,antipodes,pair_count,coupling,comparison,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk scope support modes action confinement orbits antipodes pair_count coupling comparison extension =>
    have hscope : scope ∈ [Scope.rejected,Scope.admitted] := by
      cases scope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmodes : modes ∈ [Modes.rejected,Modes.admitted] := by
      cases modes <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haction : action ∈ [Action.rejected,Action.admitted] := by
      cases action <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconfinement : confinement ∈ [Confinement.rejected,Confinement.admitted] := by
      cases confinement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horbits : orbits ∈ [Orbits.rejected,Orbits.admitted] := by
      cases orbits <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hantipodes : antipodes ∈ [Antipodes.rejected,Antipodes.admitted] := by
      cases antipodes <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpair_count : pair_count ∈ [Pair_count.rejected,Pair_count.admitted] := by
      cases pair_count <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoupling : coupling ∈ [Coupling.rejected,Coupling.admitted] := by
      cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ scope _ hscope
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ modes _ hmodes
    apply CommonRefinement.memFlatMap _ _ action _ haction
    apply CommonRefinement.memFlatMap _ _ confinement _ hconfinement
    apply CommonRefinement.memFlatMap _ _ orbits _ horbits
    apply CommonRefinement.memFlatMap _ _ antipodes _ hantipodes
    apply CommonRefinement.memFlatMap _ _ pair_count _ hpair_count
    apply CommonRefinement.memFlatMap _ _ coupling _ hcoupling
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.CompositeConfiningGrammar
