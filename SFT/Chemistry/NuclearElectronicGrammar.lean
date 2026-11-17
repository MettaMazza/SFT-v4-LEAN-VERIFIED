import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.NuclearElectronicGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "detached-nuclear-and-electronic-records"
  | .admitted => "retained-joint-molecular-carrier"

inductive Nuclear where
  | rejected | admitted

def nuclearName : Nuclear → String
  | .rejected => "mass-number-without-occurrence-identity"
  | .admitted => "retained-occurrence-and-isotope-support"

inductive Electronic where
  | rejected | admitted

def electronicName : Electronic → String
  | .rejected => "isotope-replacement-erases-electronic-identity"
  | .admitted => "retained-electronic-support-and-state"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "nuclear-or-electronic-factor-erased"
  | .admitted => "finite-nuclear-electronic-joint-product"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "imported-continuum-separation"
  | .admitted => "exact-coordinate-partition-without-separation-parameter"

inductive Transport where
  | rejected | admitted

def transportName : Transport → String
  | .rejected => "isotopologue-coordinates-declared-invariant"
  | .admitted => "exact-isotope-labelled-coordinate-transport"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-or-signed-proof-value"
  | .admitted => "EmptyOne-or-held-external-inscription"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-common-state-highlights"
  | .admitted => "complete-isotopologue-and-vibronic-record"

structure Candidate where
  carrier : Carrier
  nuclear : Nuclear
  electronic : Electronic
  composition : Composition
  scale : Scale
  transport : Transport
  absence : Absence
  record : Record

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, nuclearName c.nuclear, electronicName c.electronic, compositionName c.composition, scaleName c.scale, transportName c.transport, absenceName c.absence, recordName c.record]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "nuclear=" (nuclearName c.nuclear), SFT.Host.Text.append "electronic=" (electronicName c.electronic), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "transport=" (transportName c.transport), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "record=" (recordName c.record)]
def survivorId : String := "retained-joint-molecular-carrier__retained-occurrence-and-isotope-support__retained-electronic-support-and-state__finite-nuclear-electronic-joint-product__exact-coordinate-partition-without-separation-parameter__exact-isotope-labelled-coordinate-transport__EmptyOne-or-held-external-inscription__complete-isotopologue-and-vibronic-record"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "retained-joint-molecular-carrier" &&
  SFT.Host.Text.equal (nuclearName c.nuclear) "retained-occurrence-and-isotope-support" &&
  SFT.Host.Text.equal (electronicName c.electronic) "retained-electronic-support-and-state" &&
  SFT.Host.Text.equal (compositionName c.composition) "finite-nuclear-electronic-joint-product" &&
  SFT.Host.Text.equal (scaleName c.scale) "exact-coordinate-partition-without-separation-parameter" &&
  SFT.Host.Text.equal (transportName c.transport) "exact-isotope-labelled-coordinate-transport" &&
  SFT.Host.Text.equal (absenceName c.absence) "EmptyOne-or-held-external-inscription" &&
  SFT.Host.Text.equal (recordName c.record) "complete-isotopologue-and-vibronic-record"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "retained-joint-molecular-carrier") then "Detached records do not identify one molecular state." else
  if !(SFT.Host.Text.equal (nuclearName c.nuclear) "retained-occurrence-and-isotope-support") then "A magnitude alone erases which nuclear occurrence carries an isotope." else
  if !(SFT.Host.Text.equal (electronicName c.electronic) "retained-electronic-support-and-state") then "Erasing electronic identity prevents lawful equal-support comparison." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "finite-nuclear-electronic-joint-product") then "Either erasure merges empirically distinguishable states." else
  if !(SFT.Host.Text.equal (scaleName c.scale) "exact-coordinate-partition-without-separation-parameter") then "A continuum scale approximation is not generated by Fold structure." else
  if !(SFT.Host.Text.equal (transportName c.transport) "exact-isotope-labelled-coordinate-transport") then "Invariant coordinates erase observed isotope transport." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "EmptyOne-or-held-external-inscription") then "Numerical zero and signed magnitudes are outside the SFT proof domain." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-isotopologue-and-vibronic-record") then "A selected intersection hides unmatched and absent source rows." else
  "retained-joint-molecular-carrier__retained-occurrence-and-isotope-support__retained-electronic-support-and-state__finite-nuclear-electronic-joint-product__exact-coordinate-partition-without-separation-parameter__exact-isotope-labelled-coordinate-transport__EmptyOne-or-held-external-inscription__complete-isotopologue-and-vibronic-record"

def generationRule : String := "Generate the literal product of carrier, nuclear, electronic, composition, scale, transport, absence and record forms. Decide all 256 only from admitted exact composition, isotope, electronic-state and configuration laws."
def grammarBoundary : String := "Every positive finite nuclear occurrence word jointly composed with one admitted molecular electronic state; externally tested against every state and cell in the complete NIST H2, HD and D2 diatomic tables."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Nuclear.rejected,Nuclear.admitted]).flatMap fun nuclear =>
  ([Electronic.rejected,Electronic.admitted]).flatMap fun electronic =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Transport.rejected,Transport.admitted]).flatMap fun transport =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Record.rejected,Record.admitted]).map fun record =>
  ⟨carrier,nuclear,electronic,composition,scale,transport,absence,record⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier nuclear electronic composition scale transport absence record =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnuclear : nuclear ∈ [Nuclear.rejected,Nuclear.admitted] := by
      cases nuclear <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helectronic : electronic ∈ [Electronic.rejected,Electronic.admitted] := by
      cases electronic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransport : transport ∈ [Transport.rejected,Transport.admitted] := by
      cases transport <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ nuclear _ hnuclear
    apply CommonRefinement.memFlatMap _ _ electronic _ helectronic
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ transport _ htransport
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    exact Count.TraceDerivation.memMap _ record _ hrecord

theorem sourceDecisionBlock0000 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,scale,transport,absence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0001 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,scale,transport,absence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0010 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,scale,transport,absence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0011 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,scale,transport,absence,record⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0100 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,scale,transport,absence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0101 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,scale,transport,absence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0110 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,scale,transport,absence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock0111 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,scale,transport,absence,record⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1000 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,scale,transport,absence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1001 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,scale,transport,absence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1010 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,scale,transport,absence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1011 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,scale,transport,absence,record⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1100 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,scale,transport,absence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1101 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,scale,transport,absence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1110 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,scale,transport,absence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionBlock1111 (scale : Scale) (transport : Transport) (absence : Absence) (record : Record) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,scale,transport,absence,record⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,scale,transport,absence,record⟩ := by
 cases scale <;> cases transport <;> cases absence <;> cases record <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier nuclear electronic composition scale transport absence record =>
  cases carrier <;> cases nuclear <;> cases electronic <;> cases composition
  · exact sourceDecisionBlock0000 scale transport absence record
  · exact sourceDecisionBlock0001 scale transport absence record
  · exact sourceDecisionBlock0010 scale transport absence record
  · exact sourceDecisionBlock0011 scale transport absence record
  · exact sourceDecisionBlock0100 scale transport absence record
  · exact sourceDecisionBlock0101 scale transport absence record
  · exact sourceDecisionBlock0110 scale transport absence record
  · exact sourceDecisionBlock0111 scale transport absence record
  · exact sourceDecisionBlock1000 scale transport absence record
  · exact sourceDecisionBlock1001 scale transport absence record
  · exact sourceDecisionBlock1010 scale transport absence record
  · exact sourceDecisionBlock1011 scale transport absence record
  · exact sourceDecisionBlock1100 scale transport absence record
  · exact sourceDecisionBlock1101 scale transport absence record
  · exact sourceDecisionBlock1110 scale transport absence record
  · exact sourceDecisionBlock1111 scale transport absence record

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "retained-joint-molecular-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem nuclearCriterion (value : Nuclear) : SFT.Host.Text.equal (nuclearName value) "retained-occurrence-and-isotope-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem electronicCriterion (value : Electronic) : SFT.Host.Text.equal (electronicName value) "retained-electronic-support-and-state" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "finite-nuclear-electronic-joint-product" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem scaleCriterion (value : Scale) : SFT.Host.Text.equal (scaleName value) "exact-coordinate-partition-without-separation-parameter" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem transportCriterion (value : Transport) : SFT.Host.Text.equal (transportName value) "exact-isotope-labelled-coordinate-transport" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "EmptyOne-or-held-external-inscription" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-isotopologue-and-vibronic-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, nuclearCriterion, electronicCriterion, compositionCriterion, scaleCriterion, transportCriterion, absenceCriterion, recordCriterion]
  cases c with
  | mk carrier nuclear electronic composition scale transport absence record =>
    cases carrier <;> cases nuclear <;> cases electronic <;> cases composition <;> cases scale <;> cases transport <;> cases absence <;> cases record
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.nuclear = .admitted ∧ c.electronic = .admitted ∧ c.composition = .admitted ∧ c.scale = .admitted ∧ c.transport = .admitted ∧ c.absence = .admitted ∧ c.record = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier nuclear electronic composition scale transport absence record =>
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

theorem nuclear_rejected_rejected (c : Candidate) (h : c.nuclear = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.nuclear eq
    rw [h] at field
    cases field

theorem electronic_rejected_rejected (c : Candidate) (h : c.electronic = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.electronic eq
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

theorem scale_rejected_rejected (c : Candidate) (h : c.scale = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scale eq
    rw [h] at field
    cases field

theorem transport_rejected_rejected (c : Candidate) (h : c.transport = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transport eq
    rw [h] at field
    cases field

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
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

end SFT.Chemistry.NuclearElectronicGrammar
