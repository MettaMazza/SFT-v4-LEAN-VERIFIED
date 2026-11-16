import SFT.Physics.CriticalityUniversality
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CriticalityUniversalityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Threshold where
  | rejected | admitted

def thresholdName : Threshold → String
  | .rejected => "measured-critical-temperature"
  | .admitted => "binary-self-antipodal-half-One"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "fitted-decimal-exponent"
  | .admitted => "square-excess-to-linear-order-carrier"

inductive Correlation where
  | rejected | admitted

def correlationName : Correlation → String
  | .rejected => "continuum-correlation-length-ansatz"
  | .admitted => "square-excess-to-linear-inverse-correlation"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "selected-response-power"
  | .admitted => "reciprocal-linear-excess-response"

inductive Field where
  | rejected | admitted

def fieldName : Field → String
  | .rejected => "imported-field-polynomial"
  | .admitted => "generator-three-order-cube"

inductive Identities where
  | rejected | admitted

def identitiesName : Identities → String
  | .rejected => "numerical-zero-residuals"
  | .admitted => "typed-empty-alpha-eta-with-exact-identities"

inductive Cascade where
  | rejected | admitted

def cascadeName : Cascade → String
  | .rejected => "dimensional-analysis-assumption"
  | .admitted => "three-branch-cube-to-square-transfer"

inductive Spectrum where
  | rejected | admitted

def spectrumName : Spectrum → String
  | .rejected => "fitted-negative-five-thirds"
  | .admitted => "falling-held-orientation-with-five-thirds-magnitude"

structure Candidate where
  threshold : Threshold
  order : Order
  correlation : Correlation
  response : Response
  field : Field
  identities : Identities
  cascade : Cascade
  spectrum : Spectrum

def sourceFields (c : Candidate) : List String := [thresholdName c.threshold, orderName c.order, correlationName c.correlation, responseName c.response, fieldName c.field, identitiesName c.identities, cascadeName c.cascade, spectrumName c.spectrum]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "threshold=" (thresholdName c.threshold), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "correlation=" (correlationName c.correlation), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "field=" (fieldName c.field), SFT.Host.Text.append "identities=" (identitiesName c.identities), SFT.Host.Text.append "cascade=" (cascadeName c.cascade), SFT.Host.Text.append "spectrum=" (spectrumName c.spectrum)]
def survivorId : String := "binary-self-antipodal-half-One__square-excess-to-linear-order-carrier__square-excess-to-linear-inverse-correlation__reciprocal-linear-excess-response__generator-three-order-cube__typed-empty-alpha-eta-with-exact-identities__three-branch-cube-to-square-transfer__falling-held-orientation-with-five-thirds-magnitude"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (thresholdName c.threshold) "binary-self-antipodal-half-One" &&
  SFT.Host.Text.equal (orderName c.order) "square-excess-to-linear-order-carrier" &&
  SFT.Host.Text.equal (correlationName c.correlation) "square-excess-to-linear-inverse-correlation" &&
  SFT.Host.Text.equal (responseName c.response) "reciprocal-linear-excess-response" &&
  SFT.Host.Text.equal (fieldName c.field) "generator-three-order-cube" &&
  SFT.Host.Text.equal (identitiesName c.identities) "typed-empty-alpha-eta-with-exact-identities" &&
  SFT.Host.Text.equal (cascadeName c.cascade) "three-branch-cube-to-square-transfer" &&
  SFT.Host.Text.equal (spectrumName c.spectrum) "falling-held-orientation-with-five-thirds-magnitude"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (thresholdName c.threshold) "binary-self-antipodal-half-One") then "A measured temperature would select the law." else
  if !(SFT.Host.Text.equal (orderName c.order) "square-excess-to-linear-order-carrier") then "A fitted exponent is not forced." else
  if !(SFT.Host.Text.equal (correlationName c.correlation) "square-excess-to-linear-inverse-correlation") then "A continuum ansatz is outside the Fold grammar." else
  if !(SFT.Host.Text.equal (responseName c.response) "reciprocal-linear-excess-response") then "A selected power adds a parameter." else
  if !(SFT.Host.Text.equal (fieldName c.field) "generator-three-order-cube") then "An imported polynomial is an independent model." else
  if !(SFT.Host.Text.equal (identitiesName c.identities) "typed-empty-alpha-eta-with-exact-identities") then "Conventional zero is not a proof scalar." else
  if !(SFT.Host.Text.equal (cascadeName c.cascade) "three-branch-cube-to-square-transfer") then "Named dimensional analysis does not force the branch count." else
  if !(SFT.Host.Text.equal (spectrumName c.spectrum) "falling-held-orientation-with-five-thirds-magnitude") then "A fitted signed exponent violates the grammar." else
  "For the binary self-antipodal local-order class, the threshold is 1/2 and the exact exponent carriers are beta=1/2, nu=1/2, gamma=1 and delta=3, with alpha and eta typed as empty One records. Widom gamma=beta(delta-1), Rushbrooke 2beta+gamma=2 and Fisher gamma=2nu all close exactly. For the distinct generator-three conserved cascade, the second-order structure exponent is 2/3 and the energy-spectrum exponent has falling orientation with positive magnitude 5/3. At every positive whole scale q and depth d, structure^3=length^2 and spectrum-divisor^3=wavenumber^5, providing depth-independent exact witnesses without irrational evaluation."

def generationRule : String := "Generate the complete product of critical threshold, order, correlation, response, critical-field, scaling-identity, cascade and spectrum forms."
def grammarBoundary : String := "The binary self-antipodal local-order class and the generator-three conserved-cascade class; every positive whole perfect-power scale base and depth; exact rational exponent carriers; and typed empty exponent records."

def candidates : List Candidate :=
  ([Threshold.rejected,Threshold.admitted]).flatMap fun threshold =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Correlation.rejected,Correlation.admitted]).flatMap fun correlation =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Field.rejected,Field.admitted]).flatMap fun field =>
  ([Identities.rejected,Identities.admitted]).flatMap fun identities =>
  ([Cascade.rejected,Cascade.admitted]).flatMap fun cascade =>
  ([Spectrum.rejected,Spectrum.admitted]).map fun spectrum =>
  ⟨threshold,order,correlation,response,field,identities,cascade,spectrum⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk threshold order correlation response field identities cascade spectrum =>
    have hthreshold : threshold ∈ [Threshold.rejected,Threshold.admitted] := by
      cases threshold <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcorrelation : correlation ∈ [Correlation.rejected,Correlation.admitted] := by
      cases correlation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfield : field ∈ [Field.rejected,Field.admitted] := by
      cases field <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentities : identities ∈ [Identities.rejected,Identities.admitted] := by
      cases identities <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcascade : cascade ∈ [Cascade.rejected,Cascade.admitted] := by
      cases cascade <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspectrum : spectrum ∈ [Spectrum.rejected,Spectrum.admitted] := by
      cases spectrum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ threshold _ hthreshold
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ correlation _ hcorrelation
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ field _ hfield
    apply CommonRefinement.memFlatMap _ _ identities _ hidentities
    apply CommonRefinement.memFlatMap _ _ cascade _ hcascade
    exact Count.TraceDerivation.memMap _ spectrum _ hspectrum

end SFT.Physics.CriticalityUniversalityGrammar
