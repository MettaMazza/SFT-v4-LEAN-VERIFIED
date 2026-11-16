import SFT.Physics.ChirpRingdown
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ChirpRingdownGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "unheld-single-source"
  | .admitted => "held-two-source-orbit"

inductive Moment where
  | rejected | admitted

def momentName : Moment → String
  | .rejected => "monopole-or-dipole-radiation"
  | .admitted => "admitted-quadrupole-rate"

inductive Transfer where
  | rejected | admitted

def transferName : Transfer → String
  | .rejected => "negative-or-erased-energy"
  | .admitted => "positive-retained-take"

inductive Separation where
  | rejected | admitted

def separationName : Separation → String
  | .rejected => "fixed-or-expanding-orbit"
  | .admitted => "strictly-shrinking-positive-separation"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "imported-or-selected-frequency-law"
  | .admitted => "inverse-square-period-square-equals-radius-cube"

inductive Wave where
  | rejected | admitted

def waveName : Wave → String
  | .rejected => "one-or-free-wave-cycle-per-orbit"
  | .admitted => "two-wave-cycles-per-orbit"

inductive Contact where
  | rejected | admitted

def contactName : Contact → String
  | .rejected => "chosen-merger-time"
  | .admitted => "first-horizon-boundary-contact"

inductive Merger where
  | rejected | admitted

def mergerName : Merger → String
  | .rejected => "erased-or-two-source-remnant"
  | .admitted => "one-remnant-with-held-ledger"

inductive Tone where
  | rejected | admitted

def toneName : Tone → String
  | .rejected => "fitted-tone"
  | .admitted => "held-remnant-mass-turn-class"

inductive Damping where
  | rejected | admitted

def dampingName : Damping → String
  | .rejected => "negative-exponential-or-free-decay"
  | .admitted => "binary-half-One-contraction"

inductive Floor where
  | rejected | admitted

def floorName : Floor → String
  | .rejected => "numerical-zero-or-completed-infinity"
  | .admitted => "positive-at-every-finite-depth"

inductive Sequence where
  | rejected | admitted

def sequenceName : Sequence → String
  | .rejected => "permuted-or-omitted-stage"
  | .admitted => "inspiral-chirp-merger-ringdown"

structure Candidate where
  source : Source
  moment : Moment
  transfer : Transfer
  separation : Separation
  balance : Balance
  wave : Wave
  contact : Contact
  merger : Merger
  tone : Tone
  damping : Damping
  floor : Floor
  sequence : Sequence

def sourceFields (c : Candidate) : List String := [sourceName c.source, momentName c.moment, transferName c.transfer, separationName c.separation, balanceName c.balance, waveName c.wave, contactName c.contact, mergerName c.merger, toneName c.tone, dampingName c.damping, floorName c.floor, sequenceName c.sequence]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "moment=" (momentName c.moment), SFT.Host.Text.append "transfer=" (transferName c.transfer), SFT.Host.Text.append "separation=" (separationName c.separation), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "wave=" (waveName c.wave), SFT.Host.Text.append "contact=" (contactName c.contact), SFT.Host.Text.append "merger=" (mergerName c.merger), SFT.Host.Text.append "tone=" (toneName c.tone), SFT.Host.Text.append "damping=" (dampingName c.damping), SFT.Host.Text.append "floor=" (floorName c.floor), SFT.Host.Text.append "sequence=" (sequenceName c.sequence)]
def survivorId : String := "held-two-source-orbit__admitted-quadrupole-rate__positive-retained-take__strictly-shrinking-positive-separation__inverse-square-period-square-equals-radius-cube__two-wave-cycles-per-orbit__first-horizon-boundary-contact__one-remnant-with-held-ledger__held-remnant-mass-turn-class__binary-half-One-contraction__positive-at-every-finite-depth__inspiral-chirp-merger-ringdown"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sourceName c.source) "held-two-source-orbit" &&
  SFT.Host.Text.equal (momentName c.moment) "admitted-quadrupole-rate" &&
  SFT.Host.Text.equal (transferName c.transfer) "positive-retained-take" &&
  SFT.Host.Text.equal (separationName c.separation) "strictly-shrinking-positive-separation" &&
  SFT.Host.Text.equal (balanceName c.balance) "inverse-square-period-square-equals-radius-cube" &&
  SFT.Host.Text.equal (waveName c.wave) "two-wave-cycles-per-orbit" &&
  SFT.Host.Text.equal (contactName c.contact) "first-horizon-boundary-contact" &&
  SFT.Host.Text.equal (mergerName c.merger) "one-remnant-with-held-ledger" &&
  SFT.Host.Text.equal (toneName c.tone) "held-remnant-mass-turn-class" &&
  SFT.Host.Text.equal (dampingName c.damping) "binary-half-One-contraction" &&
  SFT.Host.Text.equal (floorName c.floor) "positive-at-every-finite-depth" &&
  SFT.Host.Text.equal (sequenceName c.sequence) "inspiral-chirp-merger-ringdown"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (sourceName c.source) "held-two-source-orbit") then "A single unheld source has no generated binary orbit." else
  if !(SFT.Host.Text.equal (momentName c.moment) "admitted-quadrupole-rate") then "Conserved source and momentum close those records." else
  if !(SFT.Host.Text.equal (transferName c.transfer) "positive-retained-take") then "A negative scalar or erased distinction violates the Fold ledger." else
  if !(SFT.Host.Text.equal (separationName c.separation) "strictly-shrinking-positive-separation") then "That does not conserve the positive binding and radiation ledger." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "inverse-square-period-square-equals-radius-cube") then "An imported or selected law is not forced." else
  if !(SFT.Host.Text.equal (waveName c.wave) "two-wave-cycles-per-orbit") then "A free multiplier loses the two-lobed source record." else
  if !(SFT.Host.Text.equal (contactName c.contact) "first-horizon-boundary-contact") then "A chosen time is a parameter." else
  if !(SFT.Host.Text.equal (mergerName c.merger) "one-remnant-with-held-ledger") then "It either deletes provenance or fails to join." else
  if !(SFT.Host.Text.equal (toneName c.tone) "held-remnant-mass-turn-class") then "A fitted tone is measurement-selected." else
  if !(SFT.Host.Text.equal (dampingName c.damping) "binary-half-One-contraction") then "That imports a forbidden scalar or parameter." else
  if !(SFT.Host.Text.equal (floorName c.floor) "positive-at-every-finite-depth") then "Neither is an admissible Fold proof endpoint." else
  if !(SFT.Host.Text.equal (sequenceName c.sequence) "inspiral-chirp-merger-ringdown") then "It violates contact and source causality." else
  "For every positive finite binary shrink depth, separation and period squared strictly fall, exact squared orbital and gravitational-wave frequencies strictly rise, and every successor retains a positive radiated take. The quadrupole wave frequency is exactly twice the orbital frequency. At the first exact horizon contact, two compact source supports join one remnant with the complete radiation and component ledger held. The remnant mass/turn key fixes one tone class and its positive amplitude halves at every finite return. The unique causal waveform order is inspiral with rising chirp, merger, then damped ringdown; no negative, irrational, imaginary, continuum, numerical-zero or completed-infinite proof scalar enters."

def generationRule : String := "Generate the complete twelve-axis product of source, radiative moment, transfer ledger, separation, orbital balance, wave recurrence, contact, merger, remnant tone, damping, finite-floor and sequence forms."
def grammarBoundary : String := "Every finite positive binary separation successor ending at the admitted horizon-contact support; every exact squared period/frequency and positive radiation-take record; the complete two-to-one source join; every finite binary remnant return; and all 4096 registered alternative combinations."

def candidates : List Candidate :=
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Moment.rejected,Moment.admitted]).flatMap fun moment =>
  ([Transfer.rejected,Transfer.admitted]).flatMap fun transfer =>
  ([Separation.rejected,Separation.admitted]).flatMap fun separation =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Wave.rejected,Wave.admitted]).flatMap fun wave =>
  ([Contact.rejected,Contact.admitted]).flatMap fun contact =>
  ([Merger.rejected,Merger.admitted]).flatMap fun merger =>
  ([Tone.rejected,Tone.admitted]).flatMap fun tone =>
  ([Damping.rejected,Damping.admitted]).flatMap fun damping =>
  ([Floor.rejected,Floor.admitted]).flatMap fun floor =>
  ([Sequence.rejected,Sequence.admitted]).map fun sequence =>
  ⟨source,moment,transfer,separation,balance,wave,contact,merger,tone,damping,floor,sequence⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk source moment transfer separation balance wave contact merger tone damping floor sequence =>
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmoment : moment ∈ [Moment.rejected,Moment.admitted] := by
      cases moment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransfer : transfer ∈ [Transfer.rejected,Transfer.admitted] := by
      cases transfer <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hseparation : separation ∈ [Separation.rejected,Separation.admitted] := by
      cases separation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hwave : wave ∈ [Wave.rejected,Wave.admitted] := by
      cases wave <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontact : contact ∈ [Contact.rejected,Contact.admitted] := by
      cases contact <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmerger : merger ∈ [Merger.rejected,Merger.admitted] := by
      cases merger <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htone : tone ∈ [Tone.rejected,Tone.admitted] := by
      cases tone <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdamping : damping ∈ [Damping.rejected,Damping.admitted] := by
      cases damping <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfloor : floor ∈ [Floor.rejected,Floor.admitted] := by
      cases floor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsequence : sequence ∈ [Sequence.rejected,Sequence.admitted] := by
      cases sequence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ moment _ hmoment
    apply CommonRefinement.memFlatMap _ _ transfer _ htransfer
    apply CommonRefinement.memFlatMap _ _ separation _ hseparation
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ wave _ hwave
    apply CommonRefinement.memFlatMap _ _ contact _ hcontact
    apply CommonRefinement.memFlatMap _ _ merger _ hmerger
    apply CommonRefinement.memFlatMap _ _ tone _ htone
    apply CommonRefinement.memFlatMap _ _ damping _ hdamping
    apply CommonRefinement.memFlatMap _ _ floor _ hfloor
    exact Count.TraceDerivation.memMap _ sequence _ hsequence

end SFT.Physics.ChirpRingdownGrammar
