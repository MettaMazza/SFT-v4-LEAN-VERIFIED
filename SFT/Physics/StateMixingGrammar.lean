import SFT.Physics.MatterMixing
import SFT.Physics.ObservationCarrier
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.StateMixingGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-scalar"
  | .admitted => "complete-fold-carrier"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "imported-or-fitted-relation"
  | .admitted => "nonaligned-partitions-with-cyclic-recurrence"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "unbound-provenance"
  | .admitted => "source-bound-proof-trace"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "target-readable-prediction"
  | .admitted => "capability-closed-prediction"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "proof-measurement-conflation"
  | .admitted => "separate-measurement-record"

inductive Rows where
  | rejected | admitted

def rowsName : Rows → String
  | .rejected => "selected-favourable-rows"
  | .admitted => "complete-registered-rows"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "finite-answer-lookup"
  | .admitted => "one-successor-closure"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  relation : Relation
  provenance : Provenance
  prediction : Prediction
  record : Record
  rows : Rows
  generality : Generality
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, relationName c.relation, provenanceName c.provenance, predictionName c.prediction, recordName c.record, rowsName c.rows, generalityName c.generality, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "rows=" (rowsName c.rows), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-fold-carrier__nonaligned-partitions-with-cyclic-recurrence__source-bound-proof-trace__capability-closed-prediction__separate-measurement-record__complete-registered-rows__one-successor-closure__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-fold-carrier" &&
  SFT.Host.Text.equal (relationName c.relation) "nonaligned-partitions-with-cyclic-recurrence" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "source-bound-proof-trace" &&
  SFT.Host.Text.equal (predictionName c.prediction) "capability-closed-prediction" &&
  SFT.Host.Text.equal (recordName c.record) "separate-measurement-record" &&
  SFT.Host.Text.equal (rowsName c.rows) "complete-registered-rows" &&
  SFT.Host.Text.equal (generalityName c.generality) "one-successor-closure" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-fold-carrier") then "An answer-only scalar erases the generated physical carrier." else
  if !(SFT.Host.Text.equal (relationName c.relation) "nonaligned-partitions-with-cyclic-recurrence") then "An imported or fitted relation lets consensus or target data select the law." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "source-bound-proof-trace") then "Unbound provenance cannot demonstrate which premises produced the result." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "capability-closed-prediction") then "A target-readable predictor can copy or optimize against the measurement." else
  if !(SFT.Host.Text.equal (recordName c.record) "separate-measurement-record") then "Treating an external decimal record as a proof scalar violates the measured-value boundary." else
  if !(SFT.Host.Text.equal (rowsName c.rows) "complete-registered-rows") then "Selecting favorable rows cannot falsify the relation." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "one-successor-closure") then "An answer lookup has no successor certificate." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A free constant, scale or exception can select the measured answer." else
  "Particle mixing is cyclic recurrence of one finite support viewed through nonaligned preparation and interaction partitions."

def generationRule : String := "Generate the complete constituent, composition/exchange, conserved-label, transition-channel, provenance, target-access, successor and extra-rule product."
def grammarBoundary : String := "All finite material forms generated from exact physical Fold words, held orientations, closed transfer, phase recurrence and complete observation support without imported particle taxonomy or fitted coupling."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Rows.rejected,Rows.admitted]).flatMap fun rows =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,relation,provenance,prediction,record,rows,generality,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier relation provenance prediction record rows generality extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrows : rows ∈ [Rows.rejected,Rows.admitted] := by
      cases rows <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ rows _ hrows
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier relation provenance prediction record rows generality extension =>
    cases carrier <;> cases relation <;> cases provenance <;> cases prediction <;> cases record <;> cases rows <;> cases generality <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier relation provenance prediction record rows generality extension =>
    cases carrier <;> cases relation <;> cases provenance <;> cases prediction <;> cases record <;> cases rows <;> cases generality <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.relation = .admitted ∧ c.provenance = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.rows = .admitted ∧ c.generality = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier relation provenance prediction record rows generality extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
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

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

theorem rows_rejected_rejected (c : Candidate) (h : c.rows = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rows eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.StateMixingGrammar
