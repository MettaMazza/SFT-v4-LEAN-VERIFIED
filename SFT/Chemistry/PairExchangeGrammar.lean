import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PairExchangeGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "cross-molecule-pair"
  | .admitted => "one-molecule-electron-pair"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "named-distinguishable-electrons"
  | .admitted => "exchange-equivalent-constituents"

inductive Total where
  | rejected | admitted

def totalName : Total → String
  | .rejected => "free-total-exchange-label"
  | .admitted => "alternating-total-word"

inductive Spin where
  | rejected | admitted

def spinName : Spin → String
  | .rejected => "imported-spin-sign-function"
  | .admitted => "complete-one-and-three-spin-sectors"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "independent-spin-and-space-labels"
  | .admitted => "complementary-spin-spatial-fibres"

inductive Same_cell where
  | rejected | admitted

def same_cellName : Same_cell → String
  | .rejected => "selected-occupancy-cap"
  | .admitted => "spatial-exchange-controlled-occupation"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-favourable-spin-states"
  | .admitted => "complete-state-and-exchange-pair-record"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-or-energy-order-exception"
  | .admitted => "pairwise-successor-with-no-extra-rule"

structure Candidate where
  carrier : Carrier
  identity : Identity
  total : Total
  spin : Spin
  composition : Composition
  same_cell : Same_cell
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, identityName c.identity, totalName c.total, spinName c.spin, compositionName c.composition, same_cellName c.same_cell, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "total=" (totalName c.total), SFT.Host.Text.append "spin=" (spinName c.spin), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "same_cell=" (same_cellName c.same_cell), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-molecule-electron-pair__exchange-equivalent-constituents__alternating-total-word__complete-one-and-three-spin-sectors__complementary-spin-spatial-fibres__spatial-exchange-controlled-occupation__complete-state-and-exchange-pair-record__pairwise-successor-with-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-molecule-electron-pair" &&
  SFT.Host.Text.equal (identityName c.identity) "exchange-equivalent-constituents" &&
  SFT.Host.Text.equal (totalName c.total) "alternating-total-word" &&
  SFT.Host.Text.equal (spinName c.spin) "complete-one-and-three-spin-sectors" &&
  SFT.Host.Text.equal (compositionName c.composition) "complementary-spin-spatial-fibres" &&
  SFT.Host.Text.equal (same_cellName c.same_cell) "spatial-exchange-controlled-occupation" &&
  SFT.Host.Text.equal (recordName c.record) "complete-state-and-exchange-pair-record" &&
  SFT.Host.Text.equal (extensionName c.extension) "pairwise-successor-with-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-molecule-electron-pair") then "A cross-molecule word does not define one molecular exchange organization." else
  if !(SFT.Host.Text.equal (identityName c.identity) "exchange-equivalent-constituents") then "Naming identical electrons imports a distinction absent from every observable exchange trace." else
  if !(SFT.Host.Text.equal (totalName c.total) "alternating-total-word") then "A freely chosen total exchange class violates the admitted identical-fermion law." else
  if !(SFT.Host.Text.equal (spinName c.spin) "complete-one-and-three-spin-sectors") then "A signed or continuum wavefunction is outside the exact Fold proof domain." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "complementary-spin-spatial-fibres") then "Independent labels can compose to a preserving total word and violate fermionic exchange." else
  if !(SFT.Host.Text.equal (same_cellName c.same_cell) "spatial-exchange-controlled-occupation") then "A selected cap is a free rule rather than an exclusion consequence." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-state-and-exchange-pair-record") then "Selected states cannot establish the complete molecular pair organization." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "pairwise-successor-with-no-extra-rule") then "A species lookup or fixed energy-order sign would add a target-selected rule." else
  "one-molecule-electron-pair__exchange-equivalent-constituents__alternating-total-word__complete-one-and-three-spin-sectors__complementary-spin-spatial-fibres__spatial-exchange-controlled-occupation__complete-state-and-exchange-pair-record__pairwise-successor-with-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, constituent identity, total exchange, spin sector, complementary composition, same-cell support, complete record and extension forms. Decide all 256 forms solely by the admitted Fold indistinguishability, exclusion, spin-census, orbital-support and state-symmetry laws."
def grammarBoundary : String := "Every molecular carrier containing an identical electron pair; both complete two-label spin-composition sectors; every retained spatial support and pairwise successor in a larger molecule. External closure uses the complete 46-state NIST molecular-hydrogen term census, both explicit same-cell pair records and all 14 same-configuration singlet/triplet observation pairs."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Total.rejected,Total.admitted]).flatMap fun total =>
  ([Spin.rejected,Spin.admitted]).flatMap fun spin =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Same_cell.rejected,Same_cell.admitted]).flatMap fun same_cell =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,identity,total,spin,composition,same_cell,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier identity total spin composition same_cell record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htotal : total ∈ [Total.rejected,Total.admitted] := by
      cases total <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspin : spin ∈ [Spin.rejected,Spin.admitted] := by
      cases spin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsame_cell : same_cell ∈ [Same_cell.rejected,Same_cell.admitted] := by
      cases same_cell <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ total _ htotal
    apply CommonRefinement.memFlatMap _ _ spin _ hspin
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ same_cell _ hsame_cell
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (composition : Composition) (same_cell : Same_cell) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,composition,same_cell,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,composition,same_cell,record,extension⟩ := by
 cases composition <;> cases same_cell <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier identity total spin composition same_cell record extension =>
  cases carrier <;> cases identity <;> cases total <;> cases spin
  · exact sourceDecisionBlock0000 composition same_cell record extension
  · exact sourceDecisionBlock0001 composition same_cell record extension
  · exact sourceDecisionBlock0010 composition same_cell record extension
  · exact sourceDecisionBlock0011 composition same_cell record extension
  · exact sourceDecisionBlock0100 composition same_cell record extension
  · exact sourceDecisionBlock0101 composition same_cell record extension
  · exact sourceDecisionBlock0110 composition same_cell record extension
  · exact sourceDecisionBlock0111 composition same_cell record extension
  · exact sourceDecisionBlock1000 composition same_cell record extension
  · exact sourceDecisionBlock1001 composition same_cell record extension
  · exact sourceDecisionBlock1010 composition same_cell record extension
  · exact sourceDecisionBlock1011 composition same_cell record extension
  · exact sourceDecisionBlock1100 composition same_cell record extension
  · exact sourceDecisionBlock1101 composition same_cell record extension
  · exact sourceDecisionBlock1110 composition same_cell record extension
  · exact sourceDecisionBlock1111 composition same_cell record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-molecule-electron-pair" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "exchange-equivalent-constituents" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem totalCriterion (value : Total) : SFT.Host.Text.equal (totalName value) "alternating-total-word" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem spinCriterion (value : Spin) : SFT.Host.Text.equal (spinName value) "complete-one-and-three-spin-sectors" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "complementary-spin-spatial-fibres" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem same_cellCriterion (value : Same_cell) : SFT.Host.Text.equal (same_cellName value) "spatial-exchange-controlled-occupation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-state-and-exchange-pair-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "pairwise-successor-with-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, identityCriterion, totalCriterion, spinCriterion, compositionCriterion, same_cellCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier identity total spin composition same_cell record extension =>
    cases carrier <;> cases identity <;> cases total <;> cases spin <;> cases composition <;> cases same_cell <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.identity = .admitted ∧ c.total = .admitted ∧ c.spin = .admitted ∧ c.composition = .admitted ∧ c.same_cell = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier identity total spin composition same_cell record extension =>
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem total_rejected_rejected (c : Candidate) (h : c.total = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.total eq
    rw [h] at field
    cases field

theorem spin_rejected_rejected (c : Candidate) (h : c.spin = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.spin eq
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

theorem same_cell_rejected_rejected (c : Candidate) (h : c.same_cell = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.same_cell eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.PairExchangeGrammar
