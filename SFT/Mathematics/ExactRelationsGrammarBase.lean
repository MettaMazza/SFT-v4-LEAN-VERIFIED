import SFT.Mathematics.ExactRelationsWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.ExactRelationsGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "borrowed-field"
  | .admitted => "generated-parts"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "rounded-scalar"
  | .admitted => "exact-ratio"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-gap"
  | .admitted => "held-shorter-gap"

inductive Threshold where
  | rejected | admitted

def thresholdName : Threshold → String
  | .rejected => "selected-angle"
  | .admitted => "unique-complement"

inductive Transport where
  | rejected | admitted

def transportName : Transport → String
  | .rejected => "fitted-rate"
  | .admitted => "fold-factor"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "sampled-return"
  | .admitted => "least-common-return"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "fixed-table"
  | .admitted => "finite-family-induction"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  provenance : Provenance
  relation : Relation
  orientation : Orientation
  threshold : Threshold
  transport : Transport
  composition : Composition
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [provenanceName c.provenance, relationName c.relation, orientationName c.orientation, thresholdName c.threshold, transportName c.transport, compositionName c.composition, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "threshold=" (thresholdName c.threshold), SFT.Host.Text.append "transport=" (transportName c.transport), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "generated-parts__exact-ratio__held-shorter-gap__unique-complement__fold-factor__least-common-return__finite-family-induction__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (provenanceName c.provenance) "generated-parts" &&
  SFT.Host.Text.equal (relationName c.relation) "exact-ratio" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-shorter-gap" &&
  SFT.Host.Text.equal (thresholdName c.threshold) "unique-complement" &&
  SFT.Host.Text.equal (transportName c.transport) "fold-factor" &&
  SFT.Host.Text.equal (compositionName c.composition) "least-common-return" &&
  SFT.Host.Text.equal (generalityName c.generality) "finite-family-induction" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "generated-parts") then "A borrowed field imports the result." else
  if !(SFT.Host.Text.equal (relationName c.relation) "exact-ratio") then "Rounding destroys exact identity." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-shorter-gap") then "Signed magnitude is outside the domain." else
  if !(SFT.Host.Text.equal (thresholdName c.threshold) "unique-complement") then "A selected angle adds a parameter." else
  if !(SFT.Host.Text.equal (transportName c.transport) "fold-factor") then "A fitted rate is not derived." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "least-common-return") then "Sampling cannot prove joint return." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "finite-family-induction") then "A fixed table has no successor certificate." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "An extra rule violates zero-parameter closure." else
  "The unique exact relation kernel is generated-part ratio, held shorter separation, unique complement threshold, Fold-factor transport and least-common-return composition with finite-family induction."

def generationRule : String := "Exhaust the provenance, relation, orientation, threshold, transport, composition and generality choices."
def grammarBoundary : String := "Exact positive generated parts, held orientation and supplied positive finite cycle families."

def candidates : List Candidate :=
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Threshold.rejected,Threshold.admitted]).flatMap fun threshold =>
  ([Transport.rejected,Transport.admitted]).flatMap fun transport =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨provenance,relation,orientation,threshold,transport,composition,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk provenance relation orientation threshold transport composition generality addition =>
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hthreshold : threshold ∈ [Threshold.rejected,Threshold.admitted] := by
      cases threshold <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransport : transport ∈ [Transport.rejected,Transport.admitted] := by
      cases transport <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ threshold _ hthreshold
    apply CommonRefinement.memFlatMap _ _ transport _ htransport
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition


end SFT.Mathematics.ExactRelationsGrammar
