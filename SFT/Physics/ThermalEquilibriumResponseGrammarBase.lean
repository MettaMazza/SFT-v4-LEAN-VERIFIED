import SFT.Physics.ThermalEquilibriumResponse
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ThermalEquilibriumResponseGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Temperature where
  | rejected | admitted

def temperatureName : Temperature → String
  | .rejected => "primitive-continuum-coordinate"
  | .admitted => "exact-positive-mean-throw"

inductive Total where
  | rejected | admitted

def totalName : Total → String
  | .rejected => "fitted-Boltzmann-coefficient"
  | .admitted => "population-count-times-mean"

inductive Equilibrium where
  | rejected | admitted

def equilibriumName : Equilibrium → String
  | .rejected => "selected-half-label"
  | .admitted => "unique-binomial-multiplicity-maximum"

inductive Canonical where
  | rejected | admitted

def canonicalName : Canonical → String
  | .rejected => "continuum-exponential"
  | .admitted => "normalized-dyadic-successor-ladder"

inductive Maximum where
  | rejected | admitted

def maximumName : Maximum → String
  | .rejected => "asserted-geometric-shape"
  | .admitted => "complete-fixed-count-throw-multinomial-maximum"

inductive Fluctuation where
  | rejected | admitted

def fluctuationName : Fluctuation → String
  | .rejected => "ontic-random-kick"
  | .admitted => "three-quarter-complementary-departure"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "free-dissipation-rate"
  | .admitted => "quarter-One-antipodal-response"

inductive Noise where
  | rejected | admitted

def noiseName : Noise → String
  | .rejected => "untracked-stochastic-source"
  | .admitted => "finite-periodic-orbit-readout"

structure Candidate where
  temperature : Temperature
  total : Total
  equilibrium : Equilibrium
  canonical : Canonical
  maximum : Maximum
  fluctuation : Fluctuation
  response : Response
  noise : Noise

def sourceFields (c : Candidate) : List String := [temperatureName c.temperature, totalName c.total, equilibriumName c.equilibrium, canonicalName c.canonical, maximumName c.maximum, fluctuationName c.fluctuation, responseName c.response, noiseName c.noise]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "temperature=" (temperatureName c.temperature), SFT.Host.Text.append "total=" (totalName c.total), SFT.Host.Text.append "equilibrium=" (equilibriumName c.equilibrium), SFT.Host.Text.append "canonical=" (canonicalName c.canonical), SFT.Host.Text.append "maximum=" (maximumName c.maximum), SFT.Host.Text.append "fluctuation=" (fluctuationName c.fluctuation), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "noise=" (noiseName c.noise)]
def survivorId : String := "exact-positive-mean-throw__population-count-times-mean__unique-binomial-multiplicity-maximum__normalized-dyadic-successor-ladder__complete-fixed-count-throw-multinomial-maximum__three-quarter-complementary-departure__quarter-One-antipodal-response__finite-periodic-orbit-readout"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (temperatureName c.temperature) "exact-positive-mean-throw" &&
  SFT.Host.Text.equal (totalName c.total) "population-count-times-mean" &&
  SFT.Host.Text.equal (equilibriumName c.equilibrium) "unique-binomial-multiplicity-maximum" &&
  SFT.Host.Text.equal (canonicalName c.canonical) "normalized-dyadic-successor-ladder" &&
  SFT.Host.Text.equal (maximumName c.maximum) "complete-fixed-count-throw-multinomial-maximum" &&
  SFT.Host.Text.equal (fluctuationName c.fluctuation) "three-quarter-complementary-departure" &&
  SFT.Host.Text.equal (responseName c.response) "quarter-One-antipodal-response" &&
  SFT.Host.Text.equal (noiseName c.noise) "finite-periodic-orbit-readout"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (temperatureName c.temperature) "exact-positive-mean-throw") then "A primitive continuum coordinate is not Fold-generated." else
  if !(SFT.Host.Text.equal (totalName c.total) "population-count-times-mean") then "A fitted coefficient adds a parameter." else
  if !(SFT.Host.Text.equal (equilibriumName c.equilibrium) "unique-binomial-multiplicity-maximum") then "A named midpoint alone is not a census." else
  if !(SFT.Host.Text.equal (canonicalName c.canonical) "normalized-dyadic-successor-ladder") then "An exponential is outside exact Fold arithmetic." else
  if !(SFT.Host.Text.equal (maximumName c.maximum) "complete-fixed-count-throw-multinomial-maximum") then "A shape assertion does not eliminate alternatives." else
  if !(SFT.Host.Text.equal (fluctuationName c.fluctuation) "three-quarter-complementary-departure") then "Ontic randomness is not forced." else
  if !(SFT.Host.Text.equal (responseName c.response) "quarter-One-antipodal-response") then "A free response adds a parameter." else
  if !(SFT.Host.Text.equal (noiseName c.noise) "finite-periodic-orbit-readout") then "An untracked source violates determinism." else
  "For every finite positive population, T=(sum throws)/N and total=N*T. Every paired binary population uniquely maximizes multiplicity at half-One. For L levels, exact canonical counts are (2^(L-1),...,1), weights divide by 2^L-1, sum to One and are the unique fixed-count/fixed-throw multinomial maximum. The least fluctuation/response pair is 3/4 and 1/4 around equilibrium 1/2, with equal departure 1/4; the complete deterministic cycle (1/4,1/2,3/4,1/2) has mean 1/2."

def generationRule : String := "Generate the complete product of temperature, total throw, equilibrium, canonical weighting, maximum-count, fluctuation, response and noise-orbit forms."
def grammarBoundary : String := "Every finite nonempty tuple of exact positive throws; every positive paired binary population; every finite generated level count at least two; every exact fixed-count/fixed-throw population vector; and every positive repetition of the complete deterministic response cycle."

def candidates : List Candidate :=
  ([Temperature.rejected,Temperature.admitted]).flatMap fun temperature =>
  ([Total.rejected,Total.admitted]).flatMap fun total =>
  ([Equilibrium.rejected,Equilibrium.admitted]).flatMap fun equilibrium =>
  ([Canonical.rejected,Canonical.admitted]).flatMap fun canonical =>
  ([Maximum.rejected,Maximum.admitted]).flatMap fun maximum =>
  ([Fluctuation.rejected,Fluctuation.admitted]).flatMap fun fluctuation =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Noise.rejected,Noise.admitted]).map fun noise =>
  ⟨temperature,total,equilibrium,canonical,maximum,fluctuation,response,noise⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk temperature total equilibrium canonical maximum fluctuation response noise =>
    have htemperature : temperature ∈ [Temperature.rejected,Temperature.admitted] := by
      cases temperature <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htotal : total ∈ [Total.rejected,Total.admitted] := by
      cases total <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequilibrium : equilibrium ∈ [Equilibrium.rejected,Equilibrium.admitted] := by
      cases equilibrium <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcanonical : canonical ∈ [Canonical.rejected,Canonical.admitted] := by
      cases canonical <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmaximum : maximum ∈ [Maximum.rejected,Maximum.admitted] := by
      cases maximum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfluctuation : fluctuation ∈ [Fluctuation.rejected,Fluctuation.admitted] := by
      cases fluctuation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnoise : noise ∈ [Noise.rejected,Noise.admitted] := by
      cases noise <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ temperature _ htemperature
    apply CommonRefinement.memFlatMap _ _ total _ htotal
    apply CommonRefinement.memFlatMap _ _ equilibrium _ hequilibrium
    apply CommonRefinement.memFlatMap _ _ canonical _ hcanonical
    apply CommonRefinement.memFlatMap _ _ maximum _ hmaximum
    apply CommonRefinement.memFlatMap _ _ fluctuation _ hfluctuation
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    exact Count.TraceDerivation.memMap _ noise _ hnoise

end SFT.Physics.ThermalEquilibriumResponseGrammar
