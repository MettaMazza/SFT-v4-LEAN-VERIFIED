import SFT.Mathematics.OrbitWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.OrbitGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Domain where
  | rejected | admitted

def domainName : Domain → String
  | .rejected => "arbitrary-real"
  | .admitted => "finite-rational"

inductive Reduction where
  | rejected | admitted

def reductionName : Reduction → String
  | .rejected => "untracked-factor"
  | .admitted => "lowest-terms"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "sampled-map"
  | .admitted => "double-and-cast"

inductive Period where
  | rejected | admitted

def periodName : Period → String
  | .rejected => "observed-cycle"
  | .admitted => "multiplicative-order"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "overlap-cover"
  | .admitted => "cyclotomic-tiling"

inductive Transient where
  | rejected | admitted

def transientName : Transient → String
  | .rejected => "eternal-even-core"
  | .admitted => "counted-binary-depth"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "bounded-prime-list"
  | .admitted => "definition-identity"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-number-law"
  | .admitted => "no-extra-rule"

structure Candidate where
  domain : Domain
  reduction : Reduction
  transition : Transition
  period : Period
  partition : Partition
  transient : Transient
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [domainName c.domain, reductionName c.reduction, transitionName c.transition, periodName c.period, partitionName c.partition, transientName c.transient, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "reduction=" (reductionName c.reduction), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "period=" (periodName c.period), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "transient=" (transientName c.transient), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "finite-rational__lowest-terms__double-and-cast__multiplicative-order__cyclotomic-tiling__counted-binary-depth__definition-identity__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (domainName c.domain) "finite-rational" &&
  SFT.Host.Text.equal (reductionName c.reduction) "lowest-terms" &&
  SFT.Host.Text.equal (transitionName c.transition) "double-and-cast" &&
  SFT.Host.Text.equal (periodName c.period) "multiplicative-order" &&
  SFT.Host.Text.equal (partitionName c.partition) "cyclotomic-tiling" &&
  SFT.Host.Text.equal (transientName c.transient) "counted-binary-depth" &&
  SFT.Host.Text.equal (generalityName c.generality) "definition-identity" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (domainName c.domain) "finite-rational") then "An arbitrary real imports infinite information." else
  if !(SFT.Host.Text.equal (reductionName c.reduction) "lowest-terms") then "An untracked common factor duplicates state identity." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "double-and-cast") then "A sampled map is not the Fold." else
  if !(SFT.Host.Text.equal (periodName c.period) "multiplicative-order") then "An observed cycle has no arithmetic identity." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "cyclotomic-tiling") then "Overlapping cycles duplicate residues." else
  if !(SFT.Host.Text.equal (transientName c.transient) "counted-binary-depth") then "A binary factor cannot remain under repeated Fold." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "definition-identity") then "A bounded list is not the theorem." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "An imported number-theory theorem would select the answer." else
  "Fold return and binary multiplicative order are one exact remainder identity; odd reduced residues tile into cyclotomic orbits and each binary denominator factor contributes one transient Fold."

def generationRule : String := "Exhaust denominator domain, reduction, transition, period, partition, transient, generality and extra-rule choices."
def grammarBoundary : String := "All supplied positive finite reduced rational parts, with odd cores and counted binary factors."

def candidates : List Candidate :=
  ([Domain.rejected,Domain.admitted]).flatMap fun domain =>
  ([Reduction.rejected,Reduction.admitted]).flatMap fun reduction =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Period.rejected,Period.admitted]).flatMap fun period =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Transient.rejected,Transient.admitted]).flatMap fun transient =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨domain,reduction,transition,period,partition,transient,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk domain reduction transition period partition transient generality addition =>
    have hdomain : domain ∈ [Domain.rejected,Domain.admitted] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreduction : reduction ∈ [Reduction.rejected,Reduction.admitted] := by
      cases reduction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hperiod : period ∈ [Period.rejected,Period.admitted] := by
      cases period <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransient : transient ∈ [Transient.rejected,Transient.admitted] := by
      cases transient <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ reduction _ hreduction
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ period _ hperiod
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ transient _ htransient
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition


end SFT.Mathematics.OrbitGrammar
