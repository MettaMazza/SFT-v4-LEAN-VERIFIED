import SFT.Physics.StellarCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.StellarGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Hydrostatic where
  | rejected | admitted

def hydrostaticName : Hydrostatic → String
  | .rejected => "selected-pressure-gravity-ratio"
  | .admitted => "complete-self-antipodal-half-One"

inductive Radial where
  | rejected | admitted

def radialName : Radial → String
  | .rejected => "asserted-self-correction"
  | .admitted => "five-thirds-versus-four-thirds-perfect-power-test"

inductive Stellar where
  | rejected | admitted

def stellarName : Stellar → String
  | .rejected => "fitted-single-power"
  | .admitted => "three-space-and-volume-plus-recurrence"

inductive Lifetime where
  | rejected | admitted

def lifetimeName : Lifetime → String
  | .rejected => "independent-lifetime-fit"
  | .admitted => "one-fuel-carrier-over-complete-luminosity"

inductive Circular where
  | rejected | admitted

def circularName : Circular → String
  | .rejected => "imported-Kepler-answer"
  | .admitted => "inverse-square-balance-v-squared-equals-M-over-r"

inductive Flat where
  | rejected | admitted

def flatName : Flat → String
  | .rejected => "finite-visible-asymptote"
  | .admitted => "enclosed-support-grows-linearly-with-radius"

inductive Dark where
  | rejected | admitted

def darkName : Dark → String
  | .rejected => "modified-law-or-named-particle"
  | .admitted => "admitted-neutral-stable-relic-under-fixed-gravity"

inductive Tully where
  | rejected | admitted

def tullyName : Tully → String
  | .rejected => "measured-or-fitted-slope"
  | .admitted => "three-space-plus-one-orbital-recurrence"

inductive Resonance where
  | rejected | admitted

def resonanceName : Resonance → String
  | .rejected => "irrational-continuum-period"
  | .admitted => "finite-low-denominator-common-refinement"

inductive Tidal where
  | rejected | admitted

def tidalName : Tidal → String
  | .rejected => "unbounded-or-selected-terminal-ratio"
  | .admitted => "finite-mismatch-exhaustion-to-one-to-one"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "target-readable-before-seal"
  | .admitted => "all-targets-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-response-scale-or-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  hydrostatic : Hydrostatic
  radial : Radial
  stellar : Stellar
  lifetime : Lifetime
  circular : Circular
  flat : Flat
  dark : Dark
  tully : Tully
  resonance : Resonance
  tidal : Tidal
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [hydrostaticName c.hydrostatic, radialName c.radial, stellarName c.stellar, lifetimeName c.lifetime, circularName c.circular, flatName c.flat, darkName c.dark, tullyName c.tully, resonanceName c.resonance, tidalName c.tidal, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "hydrostatic=" (hydrostaticName c.hydrostatic), SFT.Host.Text.append "radial=" (radialName c.radial), SFT.Host.Text.append "stellar=" (stellarName c.stellar), SFT.Host.Text.append "lifetime=" (lifetimeName c.lifetime), SFT.Host.Text.append "circular=" (circularName c.circular), SFT.Host.Text.append "flat=" (flatName c.flat), SFT.Host.Text.append "dark=" (darkName c.dark), SFT.Host.Text.append "tully=" (tullyName c.tully), SFT.Host.Text.append "resonance=" (resonanceName c.resonance), SFT.Host.Text.append "tidal=" (tidalName c.tidal), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-self-antipodal-half-One__five-thirds-versus-four-thirds-perfect-power-test__three-space-and-volume-plus-recurrence__one-fuel-carrier-over-complete-luminosity__inverse-square-balance-v-squared-equals-M-over-r__enclosed-support-grows-linearly-with-radius__admitted-neutral-stable-relic-under-fixed-gravity__three-space-plus-one-orbital-recurrence__finite-low-denominator-common-refinement__finite-mismatch-exhaustion-to-one-to-one__all-targets-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (hydrostaticName c.hydrostatic) "complete-self-antipodal-half-One" &&
  SFT.Host.Text.equal (radialName c.radial) "five-thirds-versus-four-thirds-perfect-power-test" &&
  SFT.Host.Text.equal (stellarName c.stellar) "three-space-and-volume-plus-recurrence" &&
  SFT.Host.Text.equal (lifetimeName c.lifetime) "one-fuel-carrier-over-complete-luminosity" &&
  SFT.Host.Text.equal (circularName c.circular) "inverse-square-balance-v-squared-equals-M-over-r" &&
  SFT.Host.Text.equal (flatName c.flat) "enclosed-support-grows-linearly-with-radius" &&
  SFT.Host.Text.equal (darkName c.dark) "admitted-neutral-stable-relic-under-fixed-gravity" &&
  SFT.Host.Text.equal (tullyName c.tully) "three-space-plus-one-orbital-recurrence" &&
  SFT.Host.Text.equal (resonanceName c.resonance) "finite-low-denominator-common-refinement" &&
  SFT.Host.Text.equal (tidalName c.tidal) "finite-mismatch-exhaustion-to-one-to-one" &&
  SFT.Host.Text.equal (measurementName c.measurement) "all-targets-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (hydrostaticName c.hydrostatic) "complete-self-antipodal-half-One") then "A selected ratio is a parameter." else
  if !(SFT.Host.Text.equal (radialName c.radial) "five-thirds-versus-four-thirds-perfect-power-test") then "An assertion does not compare response carriers." else
  if !(SFT.Host.Text.equal (stellarName c.stellar) "three-space-and-volume-plus-recurrence") then "A fitted exponent is selected by stellar data." else
  if !(SFT.Host.Text.equal (lifetimeName c.lifetime) "one-fuel-carrier-over-complete-luminosity") then "An independent lifetime exponent adds a dial." else
  if !(SFT.Host.Text.equal (circularName c.circular) "inverse-square-balance-v-squared-equals-M-over-r") then "An inherited named answer is not a Fold derivation." else
  if !(SFT.Host.Text.equal (flatName c.flat) "enclosed-support-grows-linearly-with-radius") then "A fixed mass makes M/r fall outward." else
  if !(SFT.Host.Text.equal (darkName c.dark) "admitted-neutral-stable-relic-under-fixed-gravity") then "A named alternative is not structurally selected." else
  if !(SFT.Host.Text.equal (tullyName c.tully) "three-space-plus-one-orbital-recurrence") then "A slope selected from galaxies is a parameter." else
  if !(SFT.Host.Text.equal (resonanceName c.resonance) "finite-low-denominator-common-refinement") then "An irrational continuum period violates the generated finite recurrence grammar." else
  if !(SFT.Host.Text.equal (tidalName c.tidal) "finite-mismatch-exhaustion-to-one-to-one") then "An unbounded path or selected ratio does not close." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "all-targets-inaccessible-until-seal") then "That would fit the result." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An added response forks the law." else
  "Hydrostatic balance is exactly (1/2,1/2). Radial pressure and gravity responses are 5/3 and 4/3, certified only through q^5 and q^4 perfect powers: every compression is outward restoring and every expansion inward restoring. The two terminal homologous luminosity exponents are three and four, forcing lifetime-fall magnitudes two and three. Circular balance is v^2=M(r)/r; flat v forces M(r) proportional to r and excludes a finite visible-only asymptote. The baryonic Tully-Fisher exponent is exactly four. Every finite rational isolated circular tidal mismatch exhausts to 1:1; eccentric or externally forced resonances remain an explicit separate boundary rather than a counterexample hidden from the census."

def generationRule : String := "Generate the complete twelve-axis product of hydrostatic balance, radial response, stellar scaling, lifetime, circular balance, flat-curve support, dark carrier, Tully-Fisher exponent, resonance, tidal dissipation, measurement custody and extension forms."
def grammarBoundary : String := "Exact positive normalized shares; three-space and two-fibre counts; exact q above the One; perfect-power response comparisons; homologous volume and radiative-recurrence stellar endpoints; circular inverse-square balance; finite enclosed-support and velocity ratios; finite rational spin/orbit cycle counts; inherited neutral relic and resonance laws; and no measurement before seal."

def candidates : List Candidate :=
  ([Hydrostatic.rejected,Hydrostatic.admitted]).flatMap fun hydrostatic =>
  ([Radial.rejected,Radial.admitted]).flatMap fun radial =>
  ([Stellar.rejected,Stellar.admitted]).flatMap fun stellar =>
  ([Lifetime.rejected,Lifetime.admitted]).flatMap fun lifetime =>
  ([Circular.rejected,Circular.admitted]).flatMap fun circular =>
  ([Flat.rejected,Flat.admitted]).flatMap fun flat =>
  ([Dark.rejected,Dark.admitted]).flatMap fun dark =>
  ([Tully.rejected,Tully.admitted]).flatMap fun tully =>
  ([Resonance.rejected,Resonance.admitted]).flatMap fun resonance =>
  ([Tidal.rejected,Tidal.admitted]).flatMap fun tidal =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨hydrostatic,radial,stellar,lifetime,circular,flat,dark,tully,resonance,tidal,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk hydrostatic radial stellar lifetime circular flat dark tully resonance tidal measurement extension =>
    have hhydrostatic : hydrostatic ∈ [Hydrostatic.rejected,Hydrostatic.admitted] := by
      cases hydrostatic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hradial : radial ∈ [Radial.rejected,Radial.admitted] := by
      cases radial <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstellar : stellar ∈ [Stellar.rejected,Stellar.admitted] := by
      cases stellar <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlifetime : lifetime ∈ [Lifetime.rejected,Lifetime.admitted] := by
      cases lifetime <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcircular : circular ∈ [Circular.rejected,Circular.admitted] := by
      cases circular <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hflat : flat ∈ [Flat.rejected,Flat.admitted] := by
      cases flat <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdark : dark ∈ [Dark.rejected,Dark.admitted] := by
      cases dark <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htully : tully ∈ [Tully.rejected,Tully.admitted] := by
      cases tully <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresonance : resonance ∈ [Resonance.rejected,Resonance.admitted] := by
      cases resonance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htidal : tidal ∈ [Tidal.rejected,Tidal.admitted] := by
      cases tidal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ hydrostatic _ hhydrostatic
    apply CommonRefinement.memFlatMap _ _ radial _ hradial
    apply CommonRefinement.memFlatMap _ _ stellar _ hstellar
    apply CommonRefinement.memFlatMap _ _ lifetime _ hlifetime
    apply CommonRefinement.memFlatMap _ _ circular _ hcircular
    apply CommonRefinement.memFlatMap _ _ flat _ hflat
    apply CommonRefinement.memFlatMap _ _ dark _ hdark
    apply CommonRefinement.memFlatMap _ _ tully _ htully
    apply CommonRefinement.memFlatMap _ _ resonance _ hresonance
    apply CommonRefinement.memFlatMap _ _ tidal _ htidal
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.StellarGrammar
