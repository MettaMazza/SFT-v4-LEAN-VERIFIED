import SFT.Physics.BaryogenesisDependency
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.BaryogenesisDependencyGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "preloaded-unpaired-residue"
  | .admitted => "exact-paired-particle-antiparticle-carrier"

inductive Tally where
  | rejected | admitted

def tallyName : Tally → String
  | .rejected => "every-transition-preserves-baryon-tally"
  | .admitted => "one-explicit-tally-changing-transition"

inductive Conjugacy where
  | rejected | admitted

def conjugacyName : Conjugacy → String
  | .rejected => "exactly-paired-conjugate-paths"
  | .admitted => "CP-carrier-distinguishes-conjugate-paths"

inductive Reverse where
  | rejected | admitted

def reverseName : Reverse → String
  | .rejected => "complete-reverse-recurrence"
  | .admitted => "nonequilibrium-reverse-completion-held"

inductive Ledger where
  | rejected | admitted

def ledgerName : Ledger → String
  | .rejected => "signed-or-unrecorded-net-number"
  | .admitted => "positive-oriented-residue-or-empty-One"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "named-independent-conditions"
  | .admitted => "single-three-condition-process-composition"

inductive Enumeration where
  | rejected | admitted

def enumerationName : Enumeration → String
  | .rejected => "selected-successful-combination"
  | .admitted => "all-eight-presence-absence-combinations"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "abundance-selects-dependency-law"
  | .admitted => "inherit-sealed-CKM-and-baryon-photon-records"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "mislabel-as-blind-discovery"
  | .admitted => "observational-reconstruction-explicit"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-efficiency-or-extra-condition"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  tally : Tally
  conjugacy : Conjugacy
  reverse : Reverse
  ledger : Ledger
  composition : Composition
  enumeration : Enumeration
  comparison : Comparison
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, tallyName c.tally, conjugacyName c.conjugacy, reverseName c.reverse, ledgerName c.ledger, compositionName c.composition, enumerationName c.enumeration, comparisonName c.comparison, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "tally=" (tallyName c.tally), SFT.Host.Text.append "conjugacy=" (conjugacyName c.conjugacy), SFT.Host.Text.append "reverse=" (reverseName c.reverse), SFT.Host.Text.append "ledger=" (ledgerName c.ledger), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "enumeration=" (enumerationName c.enumeration), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "exact-paired-particle-antiparticle-carrier__one-explicit-tally-changing-transition__CP-carrier-distinguishes-conjugate-paths__nonequilibrium-reverse-completion-held__positive-oriented-residue-or-empty-One__single-three-condition-process-composition__all-eight-presence-absence-combinations__inherit-sealed-CKM-and-baryon-photon-records__observational-reconstruction-explicit__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "exact-paired-particle-antiparticle-carrier" &&
  SFT.Host.Text.equal (tallyName c.tally) "one-explicit-tally-changing-transition" &&
  SFT.Host.Text.equal (conjugacyName c.conjugacy) "CP-carrier-distinguishes-conjugate-paths" &&
  SFT.Host.Text.equal (reverseName c.reverse) "nonequilibrium-reverse-completion-held" &&
  SFT.Host.Text.equal (ledgerName c.ledger) "positive-oriented-residue-or-empty-One" &&
  SFT.Host.Text.equal (compositionName c.composition) "single-three-condition-process-composition" &&
  SFT.Host.Text.equal (enumerationName c.enumeration) "all-eight-presence-absence-combinations" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "inherit-sealed-CKM-and-baryon-photon-records" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "observational-reconstruction-explicit" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "preloaded-unpaired-residue" then "A preloaded residue assumes the result." else
  if SFT.Host.Text.equal (tallyName c.tally) "every-transition-preserves-baryon-tally" then "A preserving transition cannot create a tally difference from paired support." else
  if SFT.Host.Text.equal (conjugacyName c.conjugacy) "exactly-paired-conjugate-paths" then "Equal conjugate appends preserve the paired tally." else
  if SFT.Host.Text.equal (reverseName c.reverse) "complete-reverse-recurrence" then "Complete reversal closes every newly appended carrier." else
  if SFT.Host.Text.equal (ledgerName c.ledger) "signed-or-unrecorded-net-number" then "A signed or missing ledger violates positive exact accounting." else
  if SFT.Host.Text.equal (compositionName c.composition) "named-independent-conditions" then "Names alone do not prove their joint necessity." else
  if SFT.Host.Text.equal (enumerationName c.enumeration) "selected-successful-combination" then "Selecting the familiar triple is not uniqueness." else
  if SFT.Host.Text.equal (comparisonName c.comparison) "abundance-selects-dependency-law" then "A measured abundance cannot choose the formal conditions." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "mislabel-as-blind-discovery" then "The dependency triple was known before this V3 reconstruction." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-efficiency-or-extra-condition" then "An inserted efficiency or condition is a free parameter." else
  "From exact paired particle/antiparticle support, a positive retained baryon residue exists exactly when baryon tally change, CP-distinguished conjugate paths and a nonequilibrium reverse-completion hold are all present; the other seven complete combinations return the empty-One residue record."

def generationRule : String := "Generate the complete product of initial carrier, baryon-tally action, conjugate-path relation, reverse-completion relation, residue ledger, dependency composition, enumeration, physical correspondence, provenance disclosure and extension forms."
def grammarBoundary : String := "Every finite minimal process beginning from one positive paired particle/antiparticle carrier, with each of baryon-tally change, conjugate-path distinction and reverse-completion hold either present or absent, plus the already admitted terminal CP and baryon-abundance comparison records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Tally.rejected,Tally.admitted]).flatMap fun tally =>
  ([Conjugacy.rejected,Conjugacy.admitted]).flatMap fun conjugacy =>
  ([Reverse.rejected,Reverse.admitted]).flatMap fun reverse =>
  ([Ledger.rejected,Ledger.admitted]).flatMap fun ledger =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Enumeration.rejected,Enumeration.admitted]).flatMap fun enumeration =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,tally,conjugacy,reverse,ledger,composition,enumeration,comparison,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier tally conjugacy reverse ledger composition enumeration comparison provenance extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htally : tally ∈ [Tally.rejected,Tally.admitted] := by
      cases tally <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconjugacy : conjugacy ∈ [Conjugacy.rejected,Conjugacy.admitted] := by
      cases conjugacy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreverse : reverse ∈ [Reverse.rejected,Reverse.admitted] := by
      cases reverse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hledger : ledger ∈ [Ledger.rejected,Ledger.admitted] := by
      cases ledger <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henumeration : enumeration ∈ [Enumeration.rejected,Enumeration.admitted] := by
      cases enumeration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ tally _ htally
    apply CommonRefinement.memFlatMap _ _ conjugacy _ hconjugacy
    apply CommonRefinement.memFlatMap _ _ reverse _ hreverse
    apply CommonRefinement.memFlatMap _ _ ledger _ hledger
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ enumeration _ henumeration
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.BaryogenesisDependencyGrammar
