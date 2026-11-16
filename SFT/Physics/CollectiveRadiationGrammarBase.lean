import SFT.Physics.CollectiveRadiation
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CollectiveRadiationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Occupation where
  | rejected | admitted

def occupationName : Occupation → String
  | .rejected => "continuum-exponential-premise"
  | .admitted => "complete-finite-boson-word-census"

inductive Radiation where
  | rejected | admitted

def radiationName : Radiation → String
  | .rejected => "fitted-Stefan-exponent"
  | .admitted => "three-mode-powers-plus-one-energy-power"

inductive Acoustic where
  | rejected | admitted

def acousticName : Acoustic → String
  | .rejected => "selected-frequency-list"
  | .admitted => "positive-whole-harmonic-ladder"

inductive Stimulated where
  | rejected | admitted

def stimulatedName : Stimulated → String
  | .rejected => "unrelated-spontaneous-output"
  | .admitted => "duplicated-identical-held-mode"

inductive Threshold where
  | rejected | admitted

def thresholdName : Threshold → String
  | .rejected => "free-gain-setting"
  | .admitted => "gain-loss-equality-with-strict-half-One-inversion"

inductive Linewidth where
  | rejected | admitted

def linewidthName : Linewidth → String
  | .rejected => "zero-width-monochromatic-idealization"
  | .admitted => "positive-reciprocal-coherence-carrier"

inductive Plasma where
  | rejected | admitted

def plasmaName : Plasma → String
  | .rejected => "named-empirical-fit"
  | .admitted => "charge-stiffness-over-inertia-and-thermal-balance"

inductive Magnetofluid where
  | rejected | admitted

def magnetofluidName : Magnetofluid → String
  | .rejected => "selected-wave-speed"
  | .admitted => "magnetic-tension-over-fluid-inertia"

structure Candidate where
  occupation : Occupation
  radiation : Radiation
  acoustic : Acoustic
  stimulated : Stimulated
  threshold : Threshold
  linewidth : Linewidth
  plasma : Plasma
  magnetofluid : Magnetofluid

def sourceFields (c : Candidate) : List String := [occupationName c.occupation, radiationName c.radiation, acousticName c.acoustic, stimulatedName c.stimulated, thresholdName c.threshold, linewidthName c.linewidth, plasmaName c.plasma, magnetofluidName c.magnetofluid]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "occupation=" (occupationName c.occupation), SFT.Host.Text.append "radiation=" (radiationName c.radiation), SFT.Host.Text.append "acoustic=" (acousticName c.acoustic), SFT.Host.Text.append "stimulated=" (stimulatedName c.stimulated), SFT.Host.Text.append "threshold=" (thresholdName c.threshold), SFT.Host.Text.append "linewidth=" (linewidthName c.linewidth), SFT.Host.Text.append "plasma=" (plasmaName c.plasma), SFT.Host.Text.append "magnetofluid=" (magnetofluidName c.magnetofluid)]
def survivorId : String := "complete-finite-boson-word-census__three-mode-powers-plus-one-energy-power__positive-whole-harmonic-ladder__duplicated-identical-held-mode__gain-loss-equality-with-strict-half-One-inversion__positive-reciprocal-coherence-carrier__charge-stiffness-over-inertia-and-thermal-balance__magnetic-tension-over-fluid-inertia"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (occupationName c.occupation) "complete-finite-boson-word-census" &&
  SFT.Host.Text.equal (radiationName c.radiation) "three-mode-powers-plus-one-energy-power" &&
  SFT.Host.Text.equal (acousticName c.acoustic) "positive-whole-harmonic-ladder" &&
  SFT.Host.Text.equal (stimulatedName c.stimulated) "duplicated-identical-held-mode" &&
  SFT.Host.Text.equal (thresholdName c.threshold) "gain-loss-equality-with-strict-half-One-inversion" &&
  SFT.Host.Text.equal (linewidthName c.linewidth) "positive-reciprocal-coherence-carrier" &&
  SFT.Host.Text.equal (plasmaName c.plasma) "charge-stiffness-over-inertia-and-thermal-balance" &&
  SFT.Host.Text.equal (magnetofluidName c.magnetofluid) "magnetic-tension-over-fluid-inertia"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (occupationName c.occupation) "complete-finite-boson-word-census") then "An imported exponential violates finite exact generation." else
  if !(SFT.Host.Text.equal (radiationName c.radiation) "three-mode-powers-plus-one-energy-power") then "A fitted exponent is target-selected." else
  if !(SFT.Host.Text.equal (acousticName c.acoustic) "positive-whole-harmonic-ladder") then "A named spectrum cannot select the law." else
  if !(SFT.Host.Text.equal (stimulatedName c.stimulated) "duplicated-identical-held-mode") then "An unrelated output does not amplify a held mode." else
  if !(SFT.Host.Text.equal (thresholdName c.threshold) "gain-loss-equality-with-strict-half-One-inversion") then "A free setting adds a parameter." else
  if !(SFT.Host.Text.equal (linewidthName c.linewidth) "positive-reciprocal-coherence-carrier") then "A numerical-zero width erases the finite record." else
  if !(SFT.Host.Text.equal (plasmaName c.plasma) "charge-stiffness-over-inertia-and-thermal-balance") then "A named fit cannot select the carrier." else
  if !(SFT.Host.Text.equal (magnetofluidName c.magnetofluid) "magnetic-tension-over-fluid-inertia") then "A measured speed is not a derivation." else
  "Every finite cavity occupation is an exact rational mean over the complete microcanonical word census; all modes above total support are empty and common scale changes preserve the complete word set. Wien covariance is exact at the relation level. In stable three-space P(gT)/P(T)=g^4, so doubling gives 16. Acoustic modes are f_n=n f_1. Laser inversion is greater than 1/2, threshold is gain=loss, above-threshold requires gain>loss, and linewidth times coherence ticks is One. Plasma omega_p^2=nq^2/(m epsilon), lambda_D^2=epsilon T/(nq^2), and Alfvén v_A^2=B^2/(mu rho), all as exact positive rational carriers."

def generationRule : String := "Generate the complete product of finite occupation, radiative dimension, acoustic boundary, stimulated mode, gain threshold, linewidth, plasma balance and magnetofluid response forms."
def grammarBoundary : String := "Every finite positive-whole mode-cost list and positive total-quanta support; every common positive-whole scale; every exact positive temperature ratio; every positive acoustic mode count; every positive laser population, gain, loss and coherence count; and every exact positive charge, mass, permittivity, temperature, field, permeability and density carrier. Empty occupation is a structural empty record, not a physical zero magnitude."

def candidates : List Candidate :=
  ([Occupation.rejected,Occupation.admitted]).flatMap fun occupation =>
  ([Radiation.rejected,Radiation.admitted]).flatMap fun radiation =>
  ([Acoustic.rejected,Acoustic.admitted]).flatMap fun acoustic =>
  ([Stimulated.rejected,Stimulated.admitted]).flatMap fun stimulated =>
  ([Threshold.rejected,Threshold.admitted]).flatMap fun threshold =>
  ([Linewidth.rejected,Linewidth.admitted]).flatMap fun linewidth =>
  ([Plasma.rejected,Plasma.admitted]).flatMap fun plasma =>
  ([Magnetofluid.rejected,Magnetofluid.admitted]).map fun magnetofluid =>
  ⟨occupation,radiation,acoustic,stimulated,threshold,linewidth,plasma,magnetofluid⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk occupation radiation acoustic stimulated threshold linewidth plasma magnetofluid =>
    have hoccupation : occupation ∈ [Occupation.rejected,Occupation.admitted] := by
      cases occupation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hradiation : radiation ∈ [Radiation.rejected,Radiation.admitted] := by
      cases radiation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hacoustic : acoustic ∈ [Acoustic.rejected,Acoustic.admitted] := by
      cases acoustic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstimulated : stimulated ∈ [Stimulated.rejected,Stimulated.admitted] := by
      cases stimulated <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hthreshold : threshold ∈ [Threshold.rejected,Threshold.admitted] := by
      cases threshold <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlinewidth : linewidth ∈ [Linewidth.rejected,Linewidth.admitted] := by
      cases linewidth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hplasma : plasma ∈ [Plasma.rejected,Plasma.admitted] := by
      cases plasma <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnetofluid : magnetofluid ∈ [Magnetofluid.rejected,Magnetofluid.admitted] := by
      cases magnetofluid <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ occupation _ hoccupation
    apply CommonRefinement.memFlatMap _ _ radiation _ hradiation
    apply CommonRefinement.memFlatMap _ _ acoustic _ hacoustic
    apply CommonRefinement.memFlatMap _ _ stimulated _ hstimulated
    apply CommonRefinement.memFlatMap _ _ threshold _ hthreshold
    apply CommonRefinement.memFlatMap _ _ linewidth _ hlinewidth
    apply CommonRefinement.memFlatMap _ _ plasma _ hplasma
    exact Count.TraceDerivation.memMap _ magnetofluid _ hmagnetofluid

end SFT.Physics.CollectiveRadiationGrammar
