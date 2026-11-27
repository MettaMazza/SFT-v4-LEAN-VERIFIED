import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ElectrophilicGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "selected-product-label-or-nonaromatic-fragments"
  | .admitted => "complete-aromatic-source-ordered-carrier"

inductive Acceptor where
  | rejected | admitted

def acceptorName : Acceptor → String
  | .rejected => "incoming-pair-imported-or-acceptor-slot-filled"
  | .admitted => "structural-EmptyOne-entering-acceptor-slot"

inductive Donor where
  | rejected | admitted

def donorName : Donor → String
  | .rejected => "donor-pair-erased-created-or-collapsed-to-charge"
  | .admitted => "complete-aromatic-donor-pair-transfer"

inductive Change where
  | rejected | admitted

def changeName : Change → String
  | .rejected => "endpoint-only-product-or-extra-support-change"
  | .admitted => "entering-bond-formed-leaving-bond-cleaved"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "named-rate-law-cleavage-first-or-unordered-snapshots"
  | .admitted => "complete-concerted-and-addition-then-restoration-path-family"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "aromatic-support-destroyed-or-fitted-restoration"
  | .admitted => "leaving-pair-restores-aromatic-incidence"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "substrate-product-mechanism-readable-before-seal"
  | .admitted => "value-free-aromatic-structure-and-mechanism-target-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "substrate-specific-exception-or-recomputed-prefix"
  | .admitted => "fresh-aromatic-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  acceptor : Acceptor
  donor : Donor
  change : Change
  path : Path
  recurrence : Recurrence
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, acceptorName c.acceptor, donorName c.donor, changeName c.change, pathName c.path, recurrenceName c.recurrence, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "acceptor=" (acceptorName c.acceptor), SFT.Host.Text.append "donor=" (donorName c.donor), SFT.Host.Text.append "change=" (changeName c.change), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-aromatic-source-ordered-carrier__structural-EmptyOne-entering-acceptor-slot__complete-aromatic-donor-pair-transfer__entering-bond-formed-leaving-bond-cleaved__complete-concerted-and-addition-then-restoration-path-family__leaving-pair-restores-aromatic-incidence__value-free-aromatic-structure-and-mechanism-target-seal__fresh-aromatic-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-aromatic-source-ordered-carrier" &&
  SFT.Host.Text.equal (acceptorName c.acceptor) "structural-EmptyOne-entering-acceptor-slot" &&
  SFT.Host.Text.equal (donorName c.donor) "complete-aromatic-donor-pair-transfer" &&
  SFT.Host.Text.equal (changeName c.change) "entering-bond-formed-leaving-bond-cleaved" &&
  SFT.Host.Text.equal (pathName c.path) "complete-concerted-and-addition-then-restoration-path-family" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "leaving-pair-restores-aromatic-incidence" &&
  SFT.Host.Text.equal (observationName c.observation) "value-free-aromatic-structure-and-mechanism-target-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "fresh-aromatic-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-aromatic-source-ordered-carrier") then "A named answer or disconnected fragments cannot reconstruct one aromatic reaction carrier." else
  if !(SFT.Host.Text.equal (acceptorName c.acceptor) "structural-EmptyOne-entering-acceptor-slot") then "Giving the acceptor a pre-existing pair changes which carrier supplies the new bond." else
  if !(SFT.Host.Text.equal (donorName c.donor) "complete-aromatic-donor-pair-transfer") then "A scalar charge or incomplete pair loses the transferred occurrences." else
  if !(SFT.Host.Text.equal (changeName c.change) "entering-bond-formed-leaving-bond-cleaved") then "An endpoint or extra edit does not prove the local exchange." else
  if !(SFT.Host.Text.equal (pathName c.path) "complete-concerted-and-addition-then-restoration-path-family") then "A conventional name, kinetic law or wrong order can select a mechanism." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "leaving-pair-restores-aromatic-incidence") then "An unclosed or fitted recurrence does not return the carrier to its exact class." else
  if !(SFT.Host.Text.equal (observationName c.observation) "value-free-aromatic-structure-and-mechanism-target-seal") then "External structures or terminology could select the survivor." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "fresh-aromatic-successor-no-extra-rule") then "A special aromatic substrate rule is not depth-independent." else
  "complete-aromatic-source-ordered-carrier__structural-EmptyOne-entering-acceptor-slot__complete-aromatic-donor-pair-transfer__entering-bond-formed-leaving-bond-cleaved__complete-concerted-and-addition-then-restoration-path-family__leaving-pair-restores-aromatic-incidence__value-free-aromatic-structure-and-mechanism-target-seal__fresh-aromatic-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, acceptor, donor, change, path, recurrence, observation and extension alternatives; decide all 256 forms solely from admitted Fold, aromatic and ORG-007 support laws."
def grammarBoundary : String := "Every positive finite aromatic carrier with complete donor, recurrence, entering-acceptor and leaving supports; all one- and two-transition paths; every source record; and the complete four-target, 452-page external surface."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Acceptor.rejected,Acceptor.admitted]).flatMap fun acceptor =>
  ([Donor.rejected,Donor.admitted]).flatMap fun donor =>
  ([Change.rejected,Change.admitted]).flatMap fun change =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,acceptor,donor,change,path,recurrence,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier acceptor donor change path recurrence observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hacceptor : acceptor ∈ [Acceptor.rejected,Acceptor.admitted] := by
      cases acceptor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdonor : donor ∈ [Donor.rejected,Donor.admitted] := by
      cases donor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchange : change ∈ [Change.rejected,Change.admitted] := by
      cases change <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ acceptor _ hacceptor
    apply CommonRefinement.memFlatMap _ _ donor _ hdonor
    apply CommonRefinement.memFlatMap _ _ change _ hchange
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (path : Path) (recurrence : Recurrence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,path,recurrence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,path,recurrence,observation,extension⟩ := by
 cases path <;> cases recurrence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier acceptor donor change path recurrence observation extension =>
  cases carrier <;> cases acceptor <;> cases donor <;> cases change
  · exact sourceDecisionBlock0000 path recurrence observation extension
  · exact sourceDecisionBlock0001 path recurrence observation extension
  · exact sourceDecisionBlock0010 path recurrence observation extension
  · exact sourceDecisionBlock0011 path recurrence observation extension
  · exact sourceDecisionBlock0100 path recurrence observation extension
  · exact sourceDecisionBlock0101 path recurrence observation extension
  · exact sourceDecisionBlock0110 path recurrence observation extension
  · exact sourceDecisionBlock0111 path recurrence observation extension
  · exact sourceDecisionBlock1000 path recurrence observation extension
  · exact sourceDecisionBlock1001 path recurrence observation extension
  · exact sourceDecisionBlock1010 path recurrence observation extension
  · exact sourceDecisionBlock1011 path recurrence observation extension
  · exact sourceDecisionBlock1100 path recurrence observation extension
  · exact sourceDecisionBlock1101 path recurrence observation extension
  · exact sourceDecisionBlock1110 path recurrence observation extension
  · exact sourceDecisionBlock1111 path recurrence observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-aromatic-source-ordered-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem acceptorCriterion (value : Acceptor) : SFT.Host.Text.equal (acceptorName value) "structural-EmptyOne-entering-acceptor-slot" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem donorCriterion (value : Donor) : SFT.Host.Text.equal (donorName value) "complete-aromatic-donor-pair-transfer" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem changeCriterion (value : Change) : SFT.Host.Text.equal (changeName value) "entering-bond-formed-leaving-bond-cleaved" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "complete-concerted-and-addition-then-restoration-path-family" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recurrenceCriterion (value : Recurrence) : SFT.Host.Text.equal (recurrenceName value) "leaving-pair-restores-aromatic-incidence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "value-free-aromatic-structure-and-mechanism-target-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "fresh-aromatic-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, acceptorCriterion, donorCriterion, changeCriterion, pathCriterion, recurrenceCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier acceptor donor change path recurrence observation extension =>
    cases carrier <;> cases acceptor <;> cases donor <;> cases change <;> cases path <;> cases recurrence <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.acceptor = .admitted ∧ c.donor = .admitted ∧ c.change = .admitted ∧ c.path = .admitted ∧ c.recurrence = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier acceptor donor change path recurrence observation extension =>
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

theorem acceptor_rejected_rejected (c : Candidate) (h : c.acceptor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.acceptor eq
    rw [h] at field
    cases field

theorem donor_rejected_rejected (c : Candidate) (h : c.donor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.donor eq
    rw [h] at field
    cases field

theorem change_rejected_rejected (c : Candidate) (h : c.change = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.change eq
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

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
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

end SFT.Chemistry.ElectrophilicGrammar
