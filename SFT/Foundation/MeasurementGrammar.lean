import SFT.Foundation.MeasurementProtocol
import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.MeasurementGrammar
set_option maxRecDepth 20000

inductive Flow where
  | disconnected | outward | inward | bidirectional

def flowName : Flow → String
  | .disconnected => "disconnected"
  | .outward => "derivation-to-measurement"
  | .inward => "measurement-to-derivation"
  | .bidirectional => "bidirectional"

inductive Proof where
  | inexact | exact

def proofName : Proof → String
  | .inexact => "proof-inexact"
  | .exact => "proof-exact"

inductive Target where
  | beforeSeal | afterSeal

def targetName : Target → String
  | .beforeSeal => "target-before-seal"
  | .afterSeal => "target-after-seal"

inductive Rows where
  | selective | complete

def rowsName : Rows → String
  | .selective => "rows-selective"
  | .complete => "rows-complete"

inductive Source where
  | absent | identified

def sourceName : Source → String
  | .absent => "source-absent"
  | .identified => "source-identified"

inductive Law where
  | mutated | unchanged

def lawName : Law → String
  | .mutated => "law-mutated"
  | .unchanged => "law-unchanged"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  flow : Flow
  proof : Proof
  target : Target
  rows : Rows
  source : Source
  law : Law
  extra : Extra

def sourceFields (c : Candidate) : List String := [flowName c.flow, proofName c.proof, targetName c.target, rowsName c.rows, sourceName c.source, lawName c.law, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Measurement-boundary proposal has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]
def survivorId : String := "derivation-to-measurement__proof-exact__target-after-seal__rows-complete__source-identified__law-unchanged__no-extra"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (flowName c.flow) "derivation-to-measurement" &&
  SFT.Host.Text.equal (proofName c.proof) "proof-exact" &&
  SFT.Host.Text.equal (targetName c.target) "target-after-seal" &&
  SFT.Host.Text.equal (rowsName c.rows) "rows-complete" &&
  SFT.Host.Text.equal (sourceName c.source) "source-identified" &&
  SFT.Host.Text.equal (lawName c.law) "law-unchanged" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (flowName c.flow) "disconnected" then "A disconnected interface cannot test a derived consequence." else
  if SFT.Host.Text.equal (flowName c.flow) "measurement-to-derivation" then "Measured records flow backward and can select the law." else
  if SFT.Host.Text.equal (flowName c.flow) "bidirectional" then "Bidirectional flow permits target feedback into derivation." else
  if SFT.Host.Text.equal (proofName c.proof) "proof-inexact" then "An inexact value has entered the derivational proof domain." else
  if SFT.Host.Text.equal (targetName c.target) "target-before-seal" then "Target content is available before the derived consequence is sealed." else
  if SFT.Host.Text.equal (rowsName c.rows) "rows-selective" then "Selective retention can hide unfavorable or failed outcomes." else
  if SFT.Host.Text.equal (sourceName c.source) "source-absent" then "The measured record lacks an independently checkable source identity." else
  if SFT.Host.Text.equal (lawName c.law) "law-mutated" then "Measurement changes the already selected law." else
  if SFT.Host.Text.equal (extraName c.extra) "has-extra" then "The interface adds an unregistered selection or comparison rule." else
  "An exact law sends a sealed consequence outward; identified targets open afterward; all rows are retained; measurement cannot mutate or select the law."

def generationRule : String := "Generate the complete product of information-flow direction, proof-value exactness, target-opening order, row preservation, data-source identity, law mutation and unforced-extra-rule presence."
def grammarBoundary : String := "All interfaces between an admitted exact derivation and conventional external measurement records under the SFT empirical constitution."

def candidates : List Candidate :=
  ([Flow.disconnected,Flow.outward,Flow.inward,Flow.bidirectional]).flatMap fun flow =>
  ([Proof.inexact,Proof.exact]).flatMap fun proof =>
  ([Target.beforeSeal,Target.afterSeal]).flatMap fun target =>
  ([Rows.selective,Rows.complete]).flatMap fun rows =>
  ([Source.absent,Source.identified]).flatMap fun source =>
  ([Law.mutated,Law.unchanged]).flatMap fun law =>
  ([Extra.noExtra,Extra.hasExtra]).map fun extra =>
  ⟨flow,proof,target,rows,source,law,extra⟩

def survivor : Candidate := ⟨.outward,.exact,.afterSeal,.complete,.identified,.unchanged,.noExtra⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk flow proof target rows source law extra =>
    have hflow : flow ∈ [Flow.disconnected,Flow.outward,Flow.inward,Flow.bidirectional] := by
      cases flow <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hproof : proof ∈ [Proof.inexact,Proof.exact] := by
      cases proof <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.beforeSeal,Target.afterSeal] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrows : rows ∈ [Rows.selective,Rows.complete] := by
      cases rows <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsource : source ∈ [Source.absent,Source.identified] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlaw : law ∈ [Law.mutated,Law.unchanged] := by
      cases law <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.noExtra,Extra.hasExtra] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ flow _ hflow
    apply CommonRefinement.memFlatMap _ _ proof _ hproof
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ rows _ hrows
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ law _ hlaw
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk flow proof target rows source law extra =>
    cases flow <;> cases proof <;> cases target <;> cases rows <;> cases source <;> cases law <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk flow proof target rows source law extra =>
    cases flow <;> cases proof <;> cases target <;> cases rows <;> cases source <;> cases law <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.flow = .outward ∧ c.proof = .exact ∧ c.target = .afterSeal ∧ c.rows = .complete ∧ c.source = .identified ∧ c.law = .unchanged ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk flow proof target rows source law extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6
      rfl

theorem flow_disconnected_rejected (c : Candidate) (h : c.flow = .disconnected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.flow eq
    rw [h] at field
    cases field

theorem flow_inward_rejected (c : Candidate) (h : c.flow = .inward) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.flow eq
    rw [h] at field
    cases field

theorem flow_bidirectional_rejected (c : Candidate) (h : c.flow = .bidirectional) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.flow eq
    rw [h] at field
    cases field

theorem proof_inexact_rejected (c : Candidate) (h : c.proof = .inexact) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.proof eq
    rw [h] at field
    cases field

theorem target_beforeSeal_rejected (c : Candidate) (h : c.target = .beforeSeal) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
    rw [h] at field
    cases field

theorem rows_selective_rejected (c : Candidate) (h : c.rows = .selective) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rows eq
    rw [h] at field
    cases field

theorem source_absent_rejected (c : Candidate) (h : c.source = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
    rw [h] at field
    cases field

theorem law_mutated_rejected (c : Candidate) (h : c.law = .mutated) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.law eq
    rw [h] at field
    cases field

theorem extra_hasExtra_rejected (c : Candidate) (h : c.extra = .hasExtra) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Foundation.MeasurementGrammar
