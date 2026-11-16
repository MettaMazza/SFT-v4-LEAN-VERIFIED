import SFT.Physics.ThermalHistory
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ThermalHistoryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "named-cosmological-chronology"
  | .admitted => "admitted-threshold-and-transport-dependencies"

inductive Temperature where
  | rejected | admitted

def temperatureName : Temperature → String
  | .rejected => "same-direction-or-fitted-cooling"
  | .admitted => "exact-inverse-scale-transport"

inductive Threshold where
  | rejected | admitted

def thresholdName : Threshold → String
  | .rejected => "named-epoch-list"
  | .admitted => "descending-distinct-binding-thresholds"

inductive Freezeout where
  | rejected | admitted

def freezeoutName : Freezeout → String
  | .rejected => "one-seventh-ratio-rubber-stamp"
  | .admitted => "least-live-neutron-share"

inductive Decay where
  | rejected | admitted

def decayName : Decay → String
  | .rejected => "selected-decay-correction"
  | .admitted => "least-complete-binary-cover-successor"

inductive Capture where
  | rejected | admitted

def captureName : Capture → String
  | .rejected => "named-quarter-abundance"
  | .admitted => "paired-neutron-helium-and-hydrogen-families"

inductive Recombination where
  | rejected | admitted

def recombinationName : Recombination → String
  | .rejected => "instantaneous-zero-width-collapse"
  | .admitted => "half-One-midpoint-with-finite-visibility"

inductive Acoustic where
  | rejected | admitted

def acousticName : Acoustic → String
  | .rejected => "observed-multipoles-assumed-exact-integers"
  | .admitted => "internal-whole-modes-parity-and-projection-record"

structure Candidate where
  provenance : Provenance
  temperature : Temperature
  threshold : Threshold
  freezeout : Freezeout
  decay : Decay
  capture : Capture
  recombination : Recombination
  acoustic : Acoustic

def sourceFields (c : Candidate) : List String := [provenanceName c.provenance, temperatureName c.temperature, thresholdName c.threshold, freezeoutName c.freezeout, decayName c.decay, captureName c.capture, recombinationName c.recombination, acousticName c.acoustic]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "temperature=" (temperatureName c.temperature), SFT.Host.Text.append "threshold=" (thresholdName c.threshold), SFT.Host.Text.append "freezeout=" (freezeoutName c.freezeout), SFT.Host.Text.append "decay=" (decayName c.decay), SFT.Host.Text.append "capture=" (captureName c.capture), SFT.Host.Text.append "recombination=" (recombinationName c.recombination), SFT.Host.Text.append "acoustic=" (acousticName c.acoustic)]
def survivorId : String := "admitted-threshold-and-transport-dependencies__exact-inverse-scale-transport__descending-distinct-binding-thresholds__least-live-neutron-share__least-complete-binary-cover-successor__paired-neutron-helium-and-hydrogen-families__half-One-midpoint-with-finite-visibility__internal-whole-modes-parity-and-projection-record"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (provenanceName c.provenance) "admitted-threshold-and-transport-dependencies" &&
  SFT.Host.Text.equal (temperatureName c.temperature) "exact-inverse-scale-transport" &&
  SFT.Host.Text.equal (thresholdName c.threshold) "descending-distinct-binding-thresholds" &&
  SFT.Host.Text.equal (freezeoutName c.freezeout) "least-live-neutron-share" &&
  SFT.Host.Text.equal (decayName c.decay) "least-complete-binary-cover-successor" &&
  SFT.Host.Text.equal (captureName c.capture) "paired-neutron-helium-and-hydrogen-families" &&
  SFT.Host.Text.equal (recombinationName c.recombination) "half-One-midpoint-with-finite-visibility" &&
  SFT.Host.Text.equal (acousticName c.acoustic) "internal-whole-modes-parity-and-projection-record"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "admitted-threshold-and-transport-dependencies") then "A familiar chronology cannot select a Fold law." else
  if !(SFT.Host.Text.equal (temperatureName c.temperature) "exact-inverse-scale-transport") then "A named cooling curve or fitted exponent adds a rule." else
  if !(SFT.Host.Text.equal (thresholdName c.threshold) "descending-distinct-binding-thresholds") then "Names do not prove order." else
  if !(SFT.Host.Text.equal (freezeoutName c.freezeout) "least-live-neutron-share") then "The old label conflates a constituent share with a pair ratio." else
  if !(SFT.Host.Text.equal (decayName c.decay) "least-complete-binary-cover-successor") then "A fitted decay fraction is inadmissible." else
  if !(SFT.Host.Text.equal (captureName c.capture) "paired-neutron-helium-and-hydrogen-families") then "Naming one quarter does not force it." else
  if !(SFT.Host.Text.equal (recombinationName c.recombination) "half-One-midpoint-with-finite-visibility") then "A zero-width event erases physical visibility support." else
  if !(SFT.Host.Text.equal (acousticName c.acoustic) "internal-whole-modes-parity-and-projection-record") then "Projection and driving cannot be erased to preserve an old slogan." else
  "For every exact positive scale growth g, T_later=T_earlier/g and T_later*g=T_earlier. Distinct binding thresholds are crossed in unique descending order. The depth-seven binary orbit (1,2,4)/7 forces freeze-out neutron/proton shares 1/7 and 6/7 and ratio 1/6. The least complete binary-cover successor forces capture-entry shares 1/8 and 7/8 and ratio 1/7. Complete retained-neutron pairing forces helium-family mass share 1/4 and hydrogen-family share 3/4. Recombination has an exact half-One classification midpoint and a finite positive visibility ledger at every generated radius. Acoustic standing modes are positive whole labels with exact odd/even compression-rarefaction parity; observed angular positions retain their projection and are not proof identical to the internal whole labels."

def generationRule : String := "Generate the complete product of provenance, temperature transport, threshold order, freeze-out carrier, complete-cover transport, nuclear capture, recombination support and acoustic observation form."
def grammarBoundary : String := "Every exact positive rational temperature and scale carrier; every finite set of distinct positive binding thresholds; the complete binary orbit of the least part on depth seven; the least complete depth-three binary cover; every finite positive visibility radius; every finite positive internal acoustic mode count; exact generated-finite sound-horizon segments; and strict separation of internal mode labels from observed projection."

def candidates : List Candidate :=
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Temperature.rejected,Temperature.admitted]).flatMap fun temperature =>
  ([Threshold.rejected,Threshold.admitted]).flatMap fun threshold =>
  ([Freezeout.rejected,Freezeout.admitted]).flatMap fun freezeout =>
  ([Decay.rejected,Decay.admitted]).flatMap fun decay =>
  ([Capture.rejected,Capture.admitted]).flatMap fun capture =>
  ([Recombination.rejected,Recombination.admitted]).flatMap fun recombination =>
  ([Acoustic.rejected,Acoustic.admitted]).map fun acoustic =>
  ⟨provenance,temperature,threshold,freezeout,decay,capture,recombination,acoustic⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk provenance temperature threshold freezeout decay capture recombination acoustic =>
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htemperature : temperature ∈ [Temperature.rejected,Temperature.admitted] := by
      cases temperature <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hthreshold : threshold ∈ [Threshold.rejected,Threshold.admitted] := by
      cases threshold <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfreezeout : freezeout ∈ [Freezeout.rejected,Freezeout.admitted] := by
      cases freezeout <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdecay : decay ∈ [Decay.rejected,Decay.admitted] := by
      cases decay <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcapture : capture ∈ [Capture.rejected,Capture.admitted] := by
      cases capture <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecombination : recombination ∈ [Recombination.rejected,Recombination.admitted] := by
      cases recombination <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hacoustic : acoustic ∈ [Acoustic.rejected,Acoustic.admitted] := by
      cases acoustic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ temperature _ htemperature
    apply CommonRefinement.memFlatMap _ _ threshold _ hthreshold
    apply CommonRefinement.memFlatMap _ _ freezeout _ hfreezeout
    apply CommonRefinement.memFlatMap _ _ decay _ hdecay
    apply CommonRefinement.memFlatMap _ _ capture _ hcapture
    apply CommonRefinement.memFlatMap _ _ recombination _ hrecombination
    exact Count.TraceDerivation.memMap _ acoustic _ hacoustic

end SFT.Physics.ThermalHistoryGrammar
