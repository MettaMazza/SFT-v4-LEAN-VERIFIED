import SFT.Physics.MediatorRangeChannel
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.MediatorRangeChannelGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "untracked-field-value"
  | .admitted => "held-forward-and-rest-carriers"

inductive Channel where
  | rejected | admitted

def channelName : Channel → String
  | .rejected => "named-unbroken-channel"
  | .admitted => "combination-reassembling-the-One"

inductive Mass where
  | rejected | admitted

def massName : Mass → String
  | .rejected => "assigned-mass-label"
  | .admitted => "positive-shortfall-or-empty-record"

inductive Transfer where
  | rejected | admitted

def transferName : Transfer → String
  | .rejected => "sink-or-imported-exponential"
  | .admitted => "exact-positive-forward-to-rest-transfer"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "forward-loss-without-ledger"
  | .admitted => "forward-plus-rest-reassembles-One"

inductive Range where
  | rejected | admitted

def rangeName : Range → String
  | .rejected => "selected-cutoff-distance"
  | .admitted => "positive-trace-and-reciprocal-mass-scale"

inductive Ordering where
  | rejected | admitted

def orderingName : Ordering → String
  | .rejected => "independent-range-order"
  | .admitted => "larger-mass-shorter-range"

inductive Massless where
  | rejected | admitted

def masslessName : Massless → String
  | .rejected => "finite-hard-stop"
  | .admitted => "held-forward-and-positive-finite-radius"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "W-Z-photon-selected-before-law"
  | .admitted => "inherit-sealed-electroweak-and-range-records"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-Yukawa-or-cutoff-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  channel : Channel
  mass : Mass
  transfer : Transfer
  conservation : Conservation
  range : Range
  ordering : Ordering
  massless : Massless
  comparison : Comparison
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, channelName c.channel, massName c.mass, transferName c.transfer, conservationName c.conservation, rangeName c.range, orderingName c.ordering, masslessName c.massless, comparisonName c.comparison, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "channel=" (channelName c.channel), SFT.Host.Text.append "mass=" (massName c.mass), SFT.Host.Text.append "transfer=" (transferName c.transfer), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "range=" (rangeName c.range), SFT.Host.Text.append "ordering=" (orderingName c.ordering), SFT.Host.Text.append "massless=" (masslessName c.massless), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-forward-and-rest-carriers__combination-reassembling-the-One__positive-shortfall-or-empty-record__exact-positive-forward-to-rest-transfer__forward-plus-rest-reassembles-One__positive-trace-and-reciprocal-mass-scale__larger-mass-shorter-range__held-forward-and-positive-finite-radius__inherit-sealed-electroweak-and-range-records__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "held-forward-and-rest-carriers" &&
  SFT.Host.Text.equal (channelName c.channel) "combination-reassembling-the-One" &&
  SFT.Host.Text.equal (massName c.mass) "positive-shortfall-or-empty-record" &&
  SFT.Host.Text.equal (transferName c.transfer) "exact-positive-forward-to-rest-transfer" &&
  SFT.Host.Text.equal (conservationName c.conservation) "forward-plus-rest-reassembles-One" &&
  SFT.Host.Text.equal (rangeName c.range) "positive-trace-and-reciprocal-mass-scale" &&
  SFT.Host.Text.equal (orderingName c.ordering) "larger-mass-shorter-range" &&
  SFT.Host.Text.equal (masslessName c.massless) "held-forward-and-positive-finite-radius" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "inherit-sealed-electroweak-and-range-records" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "untracked-field-value" then "An untracked value cannot conserve transferred support." else
  if SFT.Host.Text.equal (channelName c.channel) "named-unbroken-channel" then "A name does not prove completion." else
  if SFT.Host.Text.equal (massName c.mass) "assigned-mass-label" then "An assigned label imports the classification." else
  if SFT.Host.Text.equal (transferName c.transfer) "sink-or-imported-exponential" then "A sink loses support and an exponential is not generated." else
  if SFT.Host.Text.equal (conservationName c.conservation) "forward-loss-without-ledger" then "That violates closed transfer." else
  if SFT.Host.Text.equal (rangeName c.range) "selected-cutoff-distance" then "A selected cutoff is a free parameter." else
  if SFT.Host.Text.equal (orderingName c.ordering) "independent-range-order" then "Independent ordering can contradict the carrier." else
  if SFT.Host.Text.equal (masslessName c.massless) "finite-hard-stop" then "No generated positive mass exists to supply a stop." else
  if SFT.Host.Text.equal (comparisonName c.comparison) "W-Z-photon-selected-before-law" then "Named targets cannot select the discriminator." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-Yukawa-or-cutoff-rule" then "A free profile or cutoff adds a parameter." else
  "Complete-One channels have an empty mass record and no finite transport endpoint; proper channels have positive shortfall, exact conserved forward/rest transfer, a finite native trace and reciprocal mass range; larger mass means shorter range, while massless inverse-square response remains positive at every finite radius."

def generationRule : String := "Generate the complete product of carrier, channel completion, mass record, forward/rest transfer, conservation, range scale, mass ordering, massless transport, post-seal comparison and extension forms."
def grammarBoundary : String := "Every exact positive proper Fold channel and every complete channel sum; every positive finite mass share, its complete positive subtraction trace and reciprocal range; every exact positive finite radius; and the already sealed W/Z, electroweak-share and mediator-range comparison records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Channel.rejected,Channel.admitted]).flatMap fun channel =>
  ([Mass.rejected,Mass.admitted]).flatMap fun mass =>
  ([Transfer.rejected,Transfer.admitted]).flatMap fun transfer =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Range.rejected,Range.admitted]).flatMap fun range =>
  ([Ordering.rejected,Ordering.admitted]).flatMap fun ordering =>
  ([Massless.rejected,Massless.admitted]).flatMap fun massless =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,channel,mass,transfer,conservation,range,ordering,massless,comparison,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier channel mass transfer conservation range ordering massless comparison extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchannel : channel ∈ [Channel.rejected,Channel.admitted] := by
      cases channel <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmass : mass ∈ [Mass.rejected,Mass.admitted] := by
      cases mass <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransfer : transfer ∈ [Transfer.rejected,Transfer.admitted] := by
      cases transfer <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrange : range ∈ [Range.rejected,Range.admitted] := by
      cases range <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hordering : ordering ∈ [Ordering.rejected,Ordering.admitted] := by
      cases ordering <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmassless : massless ∈ [Massless.rejected,Massless.admitted] := by
      cases massless <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ channel _ hchannel
    apply CommonRefinement.memFlatMap _ _ mass _ hmass
    apply CommonRefinement.memFlatMap _ _ transfer _ htransfer
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ range _ hrange
    apply CommonRefinement.memFlatMap _ _ ordering _ hordering
    apply CommonRefinement.memFlatMap _ _ massless _ hmassless
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.MediatorRangeChannelGrammar
