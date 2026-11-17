import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ConfigurationOrderGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "coordinate-only-surface"
  | .admitted => "retained-molecular-carrier"

inductive Configuration where
  | rejected | admitted

def configurationName : Configuration → String
  | .rejected => "continuum-point-premise"
  | .admitted => "generated-configuration-nodes"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "signed-or-floating-energy"
  | .admitted => "exact-positive-order-or-EmptyOne"

inductive Stability where
  | rejected | admitted

def stabilityName : Stability → String
  | .rejected => "named-stable-structure"
  | .admitted => "local-minimum-by-complete-neighbours"

inductive Barrier where
  | rejected | admitted

def barrierName : Barrier → String
  | .rejected => "imported-saddle-formula"
  | .admitted => "local-barrier-by-complete-neighbours"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "endpoint-only-reaction"
  | .admitted => "connected-complete-configuration-path"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "open-curve-assumption"
  | .admitted => "exact-periodic-endpoint-identity"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-minima-and-maxima"
  | .admitted => "complete-favourable-and-adverse-vector"

structure Candidate where
  carrier : Carrier
  configuration : Configuration
  order : Order
  stability : Stability
  barrier : Barrier
  path : Path
  recurrence : Recurrence
  record : Record

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, configurationName c.configuration, orderName c.order, stabilityName c.stability, barrierName c.barrier, pathName c.path, recurrenceName c.recurrence, recordName c.record]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "configuration=" (configurationName c.configuration), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "stability=" (stabilityName c.stability), SFT.Host.Text.append "barrier=" (barrierName c.barrier), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "record=" (recordName c.record)]
def survivorId : String := "retained-molecular-carrier__generated-configuration-nodes__exact-positive-order-or-EmptyOne__local-minimum-by-complete-neighbours__local-barrier-by-complete-neighbours__connected-complete-configuration-path__exact-periodic-endpoint-identity__complete-favourable-and-adverse-vector"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "retained-molecular-carrier" &&
  SFT.Host.Text.equal (configurationName c.configuration) "generated-configuration-nodes" &&
  SFT.Host.Text.equal (orderName c.order) "exact-positive-order-or-EmptyOne" &&
  SFT.Host.Text.equal (stabilityName c.stability) "local-minimum-by-complete-neighbours" &&
  SFT.Host.Text.equal (barrierName c.barrier) "local-barrier-by-complete-neighbours" &&
  SFT.Host.Text.equal (pathName c.path) "connected-complete-configuration-path" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "exact-periodic-endpoint-identity" &&
  SFT.Host.Text.equal (recordName c.record) "complete-favourable-and-adverse-vector"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "retained-molecular-carrier") then "Coordinates without the molecular carrier do not identify one chemical configuration space." else
  if !(SFT.Host.Text.equal (configurationName c.configuration) "generated-configuration-nodes") then "A continuum potential coordinate imports an ungenerated domain." else
  if !(SFT.Host.Text.equal (orderName c.order) "exact-positive-order-or-EmptyOne") then "Signed or floating magnitudes violate the exact Fold domain." else
  if !(SFT.Host.Text.equal (stabilityName c.stability) "local-minimum-by-complete-neighbours") then "A stability name alone does not decide neighbouring alternatives." else
  if !(SFT.Host.Text.equal (barrierName c.barrier) "local-barrier-by-complete-neighbours") then "A continuum saddle formula is unnecessary and ungenerated." else
  if !(SFT.Host.Text.equal (pathName c.path) "connected-complete-configuration-path") then "Endpoints erase intermediates and barriers." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "exact-periodic-endpoint-identity") then "An internal rotation that erases closure duplicates rather than identifies its terminal configuration." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-favourable-and-adverse-vector") then "Keeping extrema alone hides the empirical path." else
  "retained-molecular-carrier__generated-configuration-nodes__exact-positive-order-or-EmptyOne__local-minimum-by-complete-neighbours__local-barrier-by-complete-neighbours__connected-complete-configuration-path__exact-periodic-endpoint-identity__complete-favourable-and-adverse-vector"

def generationRule : String := "Generate the literal product of carrier, configuration, order, stability, barrier, path, recurrence and record forms. Decide all 256 only from admitted exact order, graph, state-transition and molecular observation laws."
def grammarBoundary : String := "Every positive finite generated configuration graph and periodic successor, tested against both complete 25-coordinate NIST experimental ethanol internal-rotation paths."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Configuration.rejected,Configuration.admitted]).flatMap fun configuration =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Stability.rejected,Stability.admitted]).flatMap fun stability =>
  ([Barrier.rejected,Barrier.admitted]).flatMap fun barrier =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Record.rejected,Record.admitted]).map fun record =>
  ⟨carrier,configuration,order,stability,barrier,path,recurrence,record⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier configuration order stability barrier path recurrence record =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconfiguration : configuration ∈ [Configuration.rejected,Configuration.admitted] := by
      cases configuration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstability : stability ∈ [Stability.rejected,Stability.admitted] := by
      cases stability <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbarrier : barrier ∈ [Barrier.rejected,Barrier.admitted] := by
      cases barrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ configuration _ hconfiguration
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ stability _ hstability
    apply CommonRefinement.memFlatMap _ _ barrier _ hbarrier
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    exact Count.TraceDerivation.memMap _ record _ hrecord

theorem sourceDecisionBlock0000 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock0001 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock0010 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock0011 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock0100 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock0101 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock0110 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock0111 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock1000 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock1001 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock1010 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock1011 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock1100 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock1101 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock1110 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionBlock1111 (barrier : Barrier) (path : Path) (recurrence : Recurrence) (record : Record) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,barrier,path,recurrence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,barrier,path,recurrence,record⟩ := by
 cases barrier <;> cases path <;> cases recurrence <;> cases record <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier configuration order stability barrier path recurrence record =>
  cases carrier <;> cases configuration <;> cases order <;> cases stability
  · exact sourceDecisionBlock0000 barrier path recurrence record
  · exact sourceDecisionBlock0001 barrier path recurrence record
  · exact sourceDecisionBlock0010 barrier path recurrence record
  · exact sourceDecisionBlock0011 barrier path recurrence record
  · exact sourceDecisionBlock0100 barrier path recurrence record
  · exact sourceDecisionBlock0101 barrier path recurrence record
  · exact sourceDecisionBlock0110 barrier path recurrence record
  · exact sourceDecisionBlock0111 barrier path recurrence record
  · exact sourceDecisionBlock1000 barrier path recurrence record
  · exact sourceDecisionBlock1001 barrier path recurrence record
  · exact sourceDecisionBlock1010 barrier path recurrence record
  · exact sourceDecisionBlock1011 barrier path recurrence record
  · exact sourceDecisionBlock1100 barrier path recurrence record
  · exact sourceDecisionBlock1101 barrier path recurrence record
  · exact sourceDecisionBlock1110 barrier path recurrence record
  · exact sourceDecisionBlock1111 barrier path recurrence record

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "retained-molecular-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem configurationCriterion (value : Configuration) : SFT.Host.Text.equal (configurationName value) "generated-configuration-nodes" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orderCriterion (value : Order) : SFT.Host.Text.equal (orderName value) "exact-positive-order-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem stabilityCriterion (value : Stability) : SFT.Host.Text.equal (stabilityName value) "local-minimum-by-complete-neighbours" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem barrierCriterion (value : Barrier) : SFT.Host.Text.equal (barrierName value) "local-barrier-by-complete-neighbours" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "connected-complete-configuration-path" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recurrenceCriterion (value : Recurrence) : SFT.Host.Text.equal (recurrenceName value) "exact-periodic-endpoint-identity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-favourable-and-adverse-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, configurationCriterion, orderCriterion, stabilityCriterion, barrierCriterion, pathCriterion, recurrenceCriterion, recordCriterion]
  cases c with
  | mk carrier configuration order stability barrier path recurrence record =>
    cases carrier <;> cases configuration <;> cases order <;> cases stability <;> cases barrier <;> cases path <;> cases recurrence <;> cases record
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.configuration = .admitted ∧ c.order = .admitted ∧ c.stability = .admitted ∧ c.barrier = .admitted ∧ c.path = .admitted ∧ c.recurrence = .admitted ∧ c.record = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier configuration order stability barrier path recurrence record =>
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

theorem configuration_rejected_rejected (c : Candidate) (h : c.configuration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.configuration eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
    rw [h] at field
    cases field

theorem stability_rejected_rejected (c : Candidate) (h : c.stability = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.stability eq
    rw [h] at field
    cases field

theorem barrier_rejected_rejected (c : Candidate) (h : c.barrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.barrier eq
    rw [h] at field
    cases field

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
    rw [h] at field
    cases field

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
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

end SFT.Chemistry.ConfigurationOrderGrammar
