import SFT.Physics.CollapseObservationWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CollapseObservationGrammar
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
  | .admitted => "sealed-stellar-nuclear-collapse-law-versus-complete-five-source-record"

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
def survivorId : String := "complete-fold-carrier__sealed-stellar-nuclear-collapse-law-versus-complete-five-source-record__source-bound-proof-trace__capability-closed-prediction__separate-measurement-record__complete-registered-rows__one-successor-closure__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-fold-carrier" &&
  SFT.Host.Text.equal (relationName c.relation) "sealed-stellar-nuclear-collapse-law-versus-complete-five-source-record" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "source-bound-proof-trace" &&
  SFT.Host.Text.equal (predictionName c.prediction) "capability-closed-prediction" &&
  SFT.Host.Text.equal (recordName c.record) "separate-measurement-record" &&
  SFT.Host.Text.equal (rowsName c.rows) "complete-registered-rows" &&
  SFT.Host.Text.equal (generalityName c.generality) "one-successor-closure" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "answer-only-scalar" then "An answer-only scalar erases the generated physical carrier." else
  if SFT.Host.Text.equal (relationName c.relation) "imported-or-fitted-relation" then "An imported or fitted relation lets consensus or target data select the law." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "unbound-provenance" then "Unbound provenance cannot demonstrate which premises produced the result." else
  if SFT.Host.Text.equal (predictionName c.prediction) "target-readable-prediction" then "A target-readable predictor can copy or optimize against the measurement." else
  if SFT.Host.Text.equal (recordName c.record) "proof-measurement-conflation" then "Treating an external decimal record as a proof scalar violates the measured-value boundary." else
  if SFT.Host.Text.equal (rowsName c.rows) "selected-favourable-rows" then "Selecting favorable rows cannot falsify the relation." else
  if SFT.Host.Text.equal (generalityName c.generality) "finite-answer-lookup" then "An answer lookup has no successor certificate." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-extra-rule" then "A free constant, scale or exception can select the measured answer." else
  "The complete six NASA stage temperatures are (3/100,1/5,4/5,3/2,2,33/10) billion kelvin and strictly increase in the formal stage order; all durations (10000000,1000000,1000,1/10,2,1/100 years) remain and are not falsely called monotonic. Borexino reports 36/5 +3 -17/10 cpd per 100 tonnes, minimum significance five sigma at 99/100 confidence. SN1987A neutrinos were recorded by three detectors; the reported two-component preference exceeds 100:1 and the sub-One-second accretion component remains model-assisted. SN2014J records 847 and 1238 keV cobalt lines with fluxes 73/20 +/- 121/100 and 227/100 +/- 69/100 in 10^-4 photon units; the measured ratio 31/50 +/- 7/25 contains 17/25 and the spectrum significance is 113/10 sigma. GW170817 records the 810 nm strontium feature from 3/2 to 10 days, with 1/5-c broadening and 23/100-c blueshift."

def generationRule : String := "Generate the complete eight-axis product of sealed carrier, source custody, complete stage table, direct fusion-neutrino row, collapse-neutrino vector, thermonuclear gamma vector, neutron-capture spectrum and no-extra-rule."
def grammarBoundary : String := "The sealed Claim 069 receipt; all five immutable sources; all six stage temperatures and durations; Borexino rate and asymmetric errors; all three SN1987A detectors and model boundary; both SN2014J lines, fluxes, errors, ratio and significance; the complete registered GW170817 strontium row; and no target access before seal."

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

end SFT.Physics.CollapseObservationGrammar
