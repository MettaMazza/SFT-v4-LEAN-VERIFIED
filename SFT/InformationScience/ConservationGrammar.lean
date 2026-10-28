import SFT.InformationScience.ConservationWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.ConservationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "partial-input-support"
  | .admitted => "complete-canonical-source"

inductive Map where
  | rejected | admitted

def mapName : Map → String
  | .rejected => "partial-or-multivalued-rule"
  | .admitted => "total-single-valued-map"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "image-only-output"
  | .admitted => "exact-predecessor-fibres"

inductive Accounting where
  | rejected | admitted

def accountingName : Accounting → String
  | .rejected => "output-cardinality-only"
  | .admitted => "complete-source-pair-partition"

inductive Loss where
  | rejected | admitted

def lossName : Loss → String
  | .rejected => "lower-score-assertion"
  | .admitted => "non-singleton-image-fibre"

inductive Reversal where
  | rejected | admitted

def reversalName : Reversal → String
  | .rejected => "assumed-inverse"
  | .admitted => "singleton-fibre-or-held-record"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "fresh-downstream-distinction"
  | .admitted => "retained-pair-subset"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "unchanged-scalar"
  | .admitted => "retained-plus-closed-exhaustion"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "sampled-transformations"
  | .admitted => "source-successor-map-cell"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "unrecorded-created-distinction"
  | .admitted => "no-extra-information-source"

structure Candidate where
  support : Support
  map : Map
  provenance : Provenance
  accounting : Accounting
  loss : Loss
  reversal : Reversal
  composition : Composition
  conservation : Conservation
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [supportName c.support, mapName c.map, provenanceName c.provenance, accountingName c.accounting, lossName c.loss, reversalName c.reversal, compositionName c.composition, conservationName c.conservation, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "map=" (mapName c.map), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "accounting=" (accountingName c.accounting), SFT.Host.Text.append "loss=" (lossName c.loss), SFT.Host.Text.append "reversal=" (reversalName c.reversal), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-source__total-single-valued-map__exact-predecessor-fibres__complete-source-pair-partition__non-singleton-image-fibre__singleton-fibre-or-held-record__retained-pair-subset__retained-plus-closed-exhaustion__source-successor-map-cell__no-extra-information-source"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-canonical-source" &&
  SFT.Host.Text.equal (mapName c.map) "total-single-valued-map" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "exact-predecessor-fibres" &&
  SFT.Host.Text.equal (accountingName c.accounting) "complete-source-pair-partition" &&
  SFT.Host.Text.equal (lossName c.loss) "non-singleton-image-fibre" &&
  SFT.Host.Text.equal (reversalName c.reversal) "singleton-fibre-or-held-record" &&
  SFT.Host.Text.equal (compositionName c.composition) "retained-pair-subset" &&
  SFT.Host.Text.equal (conservationName c.conservation) "retained-plus-closed-exhaustion" &&
  SFT.Host.Text.equal (generalityName c.generality) "source-successor-map-cell" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-information-source"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-canonical-source") then "Omission hides distinctions that may be lost." else
  if !(SFT.Host.Text.equal (mapName c.map) "total-single-valued-map") then "An incomplete or multivalued rule cannot account for every source." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "exact-predecessor-fibres") then "Image-only output erases which sources entered each result." else
  if !(SFT.Host.Text.equal (accountingName c.accounting) "complete-source-pair-partition") then "A count erases which distinctions survive." else
  if !(SFT.Host.Text.equal (lossName c.loss) "non-singleton-image-fibre") then "A score does not identify unavailable predecessors." else
  if !(SFT.Host.Text.equal (reversalName c.reversal) "singleton-fibre-or-held-record") then "An inverse cannot choose among merged predecessors." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "retained-pair-subset") then "A deterministic image map has no source for a distinction already closed." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "retained-plus-closed-exhaustion") then "An unchanged scalar can hide exchanges among distinctions." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "source-successor-map-cell") then "Examples do not prove a fresh source image accounted." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-information-source") then "A new distinction without source or record violates provenance." else
  "The transformation kernel is complete source support, a total held map, exact predecessor fibres, exhaustive retained/closed source distinctions, singleton-fibre reversibility, held reverse records, compositional retention monotonicity and no unrecorded information source."

def generationRule : String := "Generate the complete product of source support, totality, provenance, pair accounting, fibres, loss, reversibility, composition, generality and extra-source status."
def grammarBoundary : String := "All finite deterministic information transformations generated from complete canonical source support, total single-valued maps, exact image fibres, complete source-pair ledgers and transformation composition."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Map.rejected,Map.admitted]).flatMap fun map =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Accounting.rejected,Accounting.admitted]).flatMap fun accounting =>
  ([Loss.rejected,Loss.admitted]).flatMap fun loss =>
  ([Reversal.rejected,Reversal.admitted]).flatMap fun reversal =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨support,map,provenance,accounting,loss,reversal,composition,conservation,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support map provenance accounting loss reversal composition conservation generality addition =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmap : map ∈ [Map.rejected,Map.admitted] := by
      cases map <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haccounting : accounting ∈ [Accounting.rejected,Accounting.admitted] := by
      cases accounting <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hloss : loss ∈ [Loss.rejected,Loss.admitted] := by
      cases loss <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreversal : reversal ∈ [Reversal.rejected,Reversal.admitted] := by
      cases reversal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ map _ hmap
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ accounting _ haccounting
    apply CommonRefinement.memFlatMap _ _ loss _ hloss
    apply CommonRefinement.memFlatMap _ _ reversal _ hreversal
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support map provenance accounting loss reversal composition conservation generality addition =>
    cases support <;> cases map <;> cases provenance <;> cases accounting <;> cases loss <;> cases reversal <;> cases composition <;> cases conservation <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support map provenance accounting loss reversal composition conservation generality addition =>
    cases support <;> cases map <;> cases provenance <;> cases accounting <;> cases loss <;> cases reversal <;> cases composition <;> cases conservation <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.map = .admitted ∧ c.provenance = .admitted ∧ c.accounting = .admitted ∧ c.loss = .admitted ∧ c.reversal = .admitted ∧ c.composition = .admitted ∧ c.conservation = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support map provenance accounting loss reversal composition conservation generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem map_rejected_rejected (c : Candidate) (h : c.map = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.map eq
    rw [h] at field
    cases field

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
    rw [h] at field
    cases field

theorem accounting_rejected_rejected (c : Candidate) (h : c.accounting = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.accounting eq
    rw [h] at field
    cases field

theorem loss_rejected_rejected (c : Candidate) (h : c.loss = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.loss eq
    rw [h] at field
    cases field

theorem reversal_rejected_rejected (c : Candidate) (h : c.reversal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reversal eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem conservation_rejected_rejected (c : Candidate) (h : c.conservation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conservation eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
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

end SFT.InformationScience.ConservationGrammar
