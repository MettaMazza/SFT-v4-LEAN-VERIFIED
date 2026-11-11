import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ProtonGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "proton-count-only"
  | .admitted => "one-named-proton-carrier"

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "source-erased"
  | .admitted => "registered-donor"

inductive Destination where
  | rejected | admitted

def destinationName : Destination → String
  | .rejected => "destination-erased"
  | .admitted => "registered-acceptor"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "copy-or-delete"
  | .admitted => "donor-to-acceptor-transfer"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "before-after-carrier-change"
  | .admitted => "same-carrier-before-after"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "unpaired-composition-change"
  | .admitted => "complete-endpoint-closure"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "product-label-only"
  | .admitted => "carrier-endpoint-transition-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-proton-source"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  source : Source
  destination : Destination
  transition : Transition
  identity : Identity
  closure : Closure
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, sourceName c.source, destinationName c.destination, transitionName c.transition, identityName c.identity, closureName c.closure, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "destination=" (destinationName c.destination), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-named-proton-carrier__registered-donor__registered-acceptor__donor-to-acceptor-transfer__same-carrier-before-after__complete-endpoint-closure__carrier-endpoint-transition-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-named-proton-carrier" &&
  SFT.Host.Text.equal (sourceName c.source) "registered-donor" &&
  SFT.Host.Text.equal (destinationName c.destination) "registered-acceptor" &&
  SFT.Host.Text.equal (transitionName c.transition) "donor-to-acceptor-transfer" &&
  SFT.Host.Text.equal (identityName c.identity) "same-carrier-before-after" &&
  SFT.Host.Text.equal (closureName c.closure) "complete-endpoint-closure" &&
  SFT.Host.Text.equal (recordName c.record) "carrier-endpoint-transition-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-named-proton-carrier") then "A count cannot establish conservation of an occurrence." else
  if !(SFT.Host.Text.equal (sourceName c.source) "registered-donor") then "Without a donor, the carrier could be created freely." else
  if !(SFT.Host.Text.equal (destinationName c.destination) "registered-acceptor") then "Without an acceptor, the carrier could be lost." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "donor-to-acceptor-transfer") then "Copying or deleting violates carrier conservation." else
  if !(SFT.Host.Text.equal (identityName c.identity) "same-carrier-before-after") then "A changed carrier is not transfer conservation." else
  if !(SFT.Host.Text.equal (closureName c.closure) "complete-endpoint-closure") then "Unpaired change leaves the reaction record open." else
  if !(SFT.Host.Text.equal (recordName c.record) "carrier-endpoint-transition-trace") then "A product label cannot reconstruct the path." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A free source can force any reaction." else
  "one-named-proton-carrier__registered-donor__registered-acceptor__donor-to-acceptor-transfer__same-carrier-before-after"

def generationRule : String := "Generate the literal product of the registered proton carrier, source, destination, transition, identity, closure, record and extension choices."
def grammarBoundary : String := "Every finite chemical transition in which one named proton carrier leaves one registered donor occurrence and enters one distinct registered acceptor occurrence with identical carrier identity before and after."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Destination.rejected,Destination.admitted]).flatMap fun destination =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,source,destination,transition,identity,closure,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier source destination transition identity closure record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdestination : destination ∈ [Destination.rejected,Destination.admitted] := by
      cases destination <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ destination _ hdestination
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier source destination transition identity closure record extension =>
    cases carrier <;> cases source <;> cases destination <;> cases transition <;> cases identity <;> cases closure <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier source destination transition identity closure record extension =>
    cases carrier <;> cases source <;> cases destination <;> cases transition <;> cases identity <;> cases closure <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.source = .admitted ∧ c.destination = .admitted ∧ c.transition = .admitted ∧ c.identity = .admitted ∧ c.closure = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier source destination transition identity closure record extension =>
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

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
    rw [h] at field
    cases field

theorem destination_rejected_rejected (c : Candidate) (h : c.destination = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.destination eq
    rw [h] at field
    cases field

theorem transition_rejected_rejected (c : Candidate) (h : c.transition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transition eq
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

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
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

end SFT.Chemistry.ProtonGrammar
