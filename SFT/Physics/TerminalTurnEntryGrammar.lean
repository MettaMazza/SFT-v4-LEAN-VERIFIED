import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.TerminalTurnEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "imported-continuum-circle"
  | .admitted => "exact-generated-turn-carrier"

inductive Sectors where
  | rejected | admitted

def sectorsName : Sectors → String
  | .rejected => "selected-sector-count"
  | .admitted => "generator-three-complete-sectors"

inductive Return where
  | rejected | admitted

def returnName : Return → String
  | .rejected => "free-decimal-remainder"
  | .admitted => "one-positive-return"

inductive Depth where
  | rejected | admitted

def depthName : Depth → String
  | .rejected => "selected-return-depth"
  | .admitted => "forced-up-cover-depth-seven"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "unbounded-or-selected-support"
  | .admitted => "four-rung-binary-support-sixteen"

inductive Join where
  | rejected | admitted

def joinName : Join → String
  | .rejected => "untyped-sum-or-product"
  | .admitted => "nested-positive-return-ratio"

inductive Domain where
  | rejected | admitted

def domainName : Domain → String
  | .rejected => "irrational-or-floating-turn"
  | .admitted => "exact-rational-projection"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "target-readable-shortcut"
  | .admitted => "registered-observational-prediction-protocol"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-turn-term"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  sectors : Sectors
  «return» : Return
  depth : Depth
  support : Support
  join : Join
  domain : Domain
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, sectorsName c.sectors, returnName c.«return», depthName c.depth, supportName c.support, joinName c.join, domainName c.domain, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "sectors=" (sectorsName c.sectors), SFT.Host.Text.append "return=" (returnName c.«return»), SFT.Host.Text.append "depth=" (depthName c.depth), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "join=" (joinName c.join), SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "exact-generated-turn-carrier__generator-three-complete-sectors__one-positive-return__forced-up-cover-depth-seven__four-rung-binary-support-sixteen__nested-positive-return-ratio__exact-rational-projection__registered-observational-prediction-protocol__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "exact-generated-turn-carrier" &&
  SFT.Host.Text.equal (sectorsName c.sectors) "generator-three-complete-sectors" &&
  SFT.Host.Text.equal (returnName c.«return») "one-positive-return" &&
  SFT.Host.Text.equal (depthName c.depth) "forced-up-cover-depth-seven" &&
  SFT.Host.Text.equal (supportName c.support) "four-rung-binary-support-sixteen" &&
  SFT.Host.Text.equal (joinName c.join) "nested-positive-return-ratio" &&
  SFT.Host.Text.equal (domainName c.domain) "exact-rational-projection" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "registered-observational-prediction-protocol" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "imported-continuum-circle" then "A continuum circle imports an ungenerated object." else
  if SFT.Host.Text.equal (sectorsName c.sectors) "selected-sector-count" then "A selected count is a parameter." else
  if SFT.Host.Text.equal (returnName c.«return») "free-decimal-remainder" then "A decimal remainder is fitted." else
  if SFT.Host.Text.equal (depthName c.depth) "selected-return-depth" then "A selected depth can tune the projection." else
  if SFT.Host.Text.equal (supportName c.support) "unbounded-or-selected-support" then "An unbounded or selected support has no closure." else
  if SFT.Host.Text.equal (joinName c.join) "untyped-sum-or-product" then "Untyped composition loses return order." else
  if SFT.Host.Text.equal (domainName c.domain) "irrational-or-floating-turn" then "That violates the exact Fold domain." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "target-readable-shortcut" then "A shortcut cannot seal a generated prediction." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-turn-term" then "The four-rung object is terminal." else
  "The unique exact finite turn projection is 355/113 = 3 + 1/(7 + 1/16), with every count generated and no irrational or floating proof value."

def generationRule : String := "Generate the complete nine-axis product of turn carrier, complete sectors, return, up-depth, terminal support, join, exact domain, provenance and extension forms."
def grammarBoundary : String := "All diameter-normalized finite turn projections using the complete generator sectors and the sole terminal return through already admitted up-depth and finite promotion support."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Sectors.rejected,Sectors.admitted]).flatMap fun sectors =>
  ([Return.rejected,Return.admitted]).flatMap fun «return» =>
  ([Depth.rejected,Depth.admitted]).flatMap fun depth =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Join.rejected,Join.admitted]).flatMap fun join =>
  ([Domain.rejected,Domain.admitted]).flatMap fun domain =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,sectors,«return»,depth,support,join,domain,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier sectors «return» depth support join domain provenance extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsectors : sectors ∈ [Sectors.rejected,Sectors.admitted] := by
      cases sectors <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreturn : «return» ∈ [Return.rejected,Return.admitted] := by
      cases «return» <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdepth : depth ∈ [Depth.rejected,Depth.admitted] := by
      cases depth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjoin : join ∈ [Join.rejected,Join.admitted] := by
      cases join <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdomain : domain ∈ [Domain.rejected,Domain.admitted] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ sectors _ hsectors
    apply CommonRefinement.memFlatMap _ _ «return» _ hreturn
    apply CommonRefinement.memFlatMap _ _ depth _ hdepth
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ join _ hjoin
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier sectors «return» depth support join domain provenance extension =>
    cases carrier <;> cases sectors <;> cases «return» <;> cases depth <;> cases support <;> cases join <;> cases domain <;> cases provenance <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier sectors «return» depth support join domain provenance extension =>
    cases carrier <;> cases sectors <;> cases «return» <;> cases depth <;> cases support <;> cases join <;> cases domain <;> cases provenance <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.sectors = .admitted ∧ c.«return» = .admitted ∧ c.depth = .admitted ∧ c.support = .admitted ∧ c.join = .admitted ∧ c.domain = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier sectors «return» depth support join domain provenance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem sectors_rejected_rejected (c : Candidate) (h : c.sectors = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sectors eq
    rw [h] at field
    cases field

theorem return_rejected_rejected (c : Candidate) (h : c.«return» = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.«return» eq
    rw [h] at field
    cases field

theorem depth_rejected_rejected (c : Candidate) (h : c.depth = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.depth eq
    rw [h] at field
    cases field

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem join_rejected_rejected (c : Candidate) (h : c.join = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.join eq
    rw [h] at field
    cases field

theorem domain_rejected_rejected (c : Candidate) (h : c.domain = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.domain eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.TerminalTurnEntryGrammar
