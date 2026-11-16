import SFT.Physics.SmithionSpectrum
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.SmithionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Sector where
  | rejected | admitted

def sectorName : Sector → String
  | .rejected => "selected-particle-sector"
  | .admitted => "both-forced-prime-sectors"

inductive Kind where
  | rejected | admitted

def kindName : Kind → String
  | .rejected => "one-selected-kind"
  | .admitted => "complete-down-up-dual"

inductive Depth where
  | rejected | admitted

def depthName : Depth → String
  | .rejected => "chosen-depth"
  | .admitted => "least-binary-cover-of-sector-power"

inductive Invariant where
  | rejected | admitted

def invariantName : Invariant → String
  | .rejected => "independent-mass-parameter"
  | .admitted => "same-coloured-product-family"

inductive Roots where
  | rejected | admitted

def rootsName : Roots → String
  | .rejected => "chosen-decimal-roots"
  | .admitted => "complete-grid-and-rational-halving"

inductive Ratios where
  | rejected | admitted

def ratiosName : Ratios → String
  | .rejected => "floating-central-estimates"
  | .admitted => "squared-rational-enclosures-with-light-lift"

inductive Relic where
  | rejected | admitted

def relicName : Relic → String
  | .rejected => "named-dark-particle"
  | .admitted => "least-complete-neutral-singlet"

inductive Abundance where
  | rejected | admitted

def abundanceName : Abundance → String
  | .rejected => "freezeout-fit-or-density-input"
  | .admitted => "generation-volume-over-cover-depth"

inductive Flavour where
  | rejected | admitted

def flavourName : Flavour → String
  | .rejected => "fitted-branching-fractions"
  | .admitted => "squared-separation-times-parent-part"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "search-result-readable-before-seal"
  | .admitted => "all-targets-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-scale-sector-or-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  sector : Sector
  kind : Kind
  depth : Depth
  invariant : Invariant
  roots : Roots
  ratios : Ratios
  relic : Relic
  abundance : Abundance
  flavour : Flavour
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [sectorName c.sector, kindName c.kind, depthName c.depth, invariantName c.invariant, rootsName c.roots, ratiosName c.ratios, relicName c.relic, abundanceName c.abundance, flavourName c.flavour, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "sector=" (sectorName c.sector), SFT.Host.Text.append "kind=" (kindName c.kind), SFT.Host.Text.append "depth=" (depthName c.depth), SFT.Host.Text.append "invariant=" (invariantName c.invariant), SFT.Host.Text.append "roots=" (rootsName c.roots), SFT.Host.Text.append "ratios=" (ratiosName c.ratios), SFT.Host.Text.append "relic=" (relicName c.relic), SFT.Host.Text.append "abundance=" (abundanceName c.abundance), SFT.Host.Text.append "flavour=" (flavourName c.flavour), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "both-forced-prime-sectors__complete-down-up-dual__least-binary-cover-of-sector-power__same-coloured-product-family__complete-grid-and-rational-halving__squared-rational-enclosures-with-light-lift__least-complete-neutral-singlet__generation-volume-over-cover-depth__squared-separation-times-parent-part__all-targets-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sectorName c.sector) "both-forced-prime-sectors" &&
  SFT.Host.Text.equal (kindName c.kind) "complete-down-up-dual" &&
  SFT.Host.Text.equal (depthName c.depth) "least-binary-cover-of-sector-power" &&
  SFT.Host.Text.equal (invariantName c.invariant) "same-coloured-product-family" &&
  SFT.Host.Text.equal (rootsName c.roots) "complete-grid-and-rational-halving" &&
  SFT.Host.Text.equal (ratiosName c.ratios) "squared-rational-enclosures-with-light-lift" &&
  SFT.Host.Text.equal (relicName c.relic) "least-complete-neutral-singlet" &&
  SFT.Host.Text.equal (abundanceName c.abundance) "generation-volume-over-cover-depth" &&
  SFT.Host.Text.equal (flavourName c.flavour) "squared-separation-times-parent-part" &&
  SFT.Host.Text.equal (measurementName c.measurement) "all-targets-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (sectorName c.sector) "both-forced-prime-sectors") then "A selected sector is not a complete census." else
  if !(SFT.Host.Text.equal (kindName c.kind) "complete-down-up-dual") then "One kind omits half the generated spectrum." else
  if !(SFT.Host.Text.equal (depthName c.depth) "least-binary-cover-of-sector-power") then "A chosen exponent fits a hierarchy." else
  if !(SFT.Host.Text.equal (invariantName c.invariant) "same-coloured-product-family") then "A mass parameter forks the law." else
  if !(SFT.Host.Text.equal (rootsName c.roots) "complete-grid-and-rational-halving") then "Chosen decimals import an irrational model." else
  if !(SFT.Host.Text.equal (ratiosName c.ratios) "squared-rational-enclosures-with-light-lift") then "A central decimal loses exact root custody." else
  if !(SFT.Host.Text.equal (relicName c.relic) "least-complete-neutral-singlet") then "A name does not force stability or neutrality." else
  if !(SFT.Host.Text.equal (abundanceName c.abundance) "generation-volume-over-cover-depth") then "A cross-section or density would be a parameter." else
  if !(SFT.Host.Text.equal (flavourName c.flavour) "squared-separation-times-parent-part") then "Fitted rates cannot force a ratio." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "all-targets-inaccessible-until-seal") then "That would tune the theory to current limits." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "Any added choice violates zero parameters." else
  "Four exact penta/hepta cubics at depths (7,10,9,12) each have three disjoint positive roots, yielding twelve exact rationally enclosed Smithion mass-ratio predictions. Their coloured product family cross-locks the two quark values 3/1454 and 3/13118. Complete neutral p-member singlets and unique lightest roots force the stable relic class within the closed grammar. Dark/baryon is 27/5 and matter/baryon 32/5. Flavour weights are exactly 1/32, 5/96 and 5/24, reducing to 3:5:20 with tau-to-e over tau-to-mu equal to 4. Sector beta slopes are p-1."

def generationRule : String := "Generate the complete product of sector, kind, depth, invariant, root-census, mass-ratio, neutral-singlet, stability, abundance, flavour-weight, measurement-boundary and extension forms."
def grammarBoundary : String := "Prime sectors five and seven; down/up cover powers three/four; the complete exact cubic grid; all three root intervals; complete neutral sector fibres; all three lepton transitions; exact positive whole/fraction carriers; and no physical target before seal."

def candidates : List Candidate :=
  ([Sector.rejected,Sector.admitted]).flatMap fun sector =>
  ([Kind.rejected,Kind.admitted]).flatMap fun kind =>
  ([Depth.rejected,Depth.admitted]).flatMap fun depth =>
  ([Invariant.rejected,Invariant.admitted]).flatMap fun invariant =>
  ([Roots.rejected,Roots.admitted]).flatMap fun roots =>
  ([Ratios.rejected,Ratios.admitted]).flatMap fun ratios =>
  ([Relic.rejected,Relic.admitted]).flatMap fun relic =>
  ([Abundance.rejected,Abundance.admitted]).flatMap fun abundance =>
  ([Flavour.rejected,Flavour.admitted]).flatMap fun flavour =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨sector,kind,depth,invariant,roots,ratios,relic,abundance,flavour,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk sector kind depth invariant roots ratios relic abundance flavour measurement extension =>
    have hsector : sector ∈ [Sector.rejected,Sector.admitted] := by
      cases sector <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hkind : kind ∈ [Kind.rejected,Kind.admitted] := by
      cases kind <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdepth : depth ∈ [Depth.rejected,Depth.admitted] := by
      cases depth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinvariant : invariant ∈ [Invariant.rejected,Invariant.admitted] := by
      cases invariant <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hroots : roots ∈ [Roots.rejected,Roots.admitted] := by
      cases roots <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hratios : ratios ∈ [Ratios.rejected,Ratios.admitted] := by
      cases ratios <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelic : relic ∈ [Relic.rejected,Relic.admitted] := by
      cases relic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habundance : abundance ∈ [Abundance.rejected,Abundance.admitted] := by
      cases abundance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hflavour : flavour ∈ [Flavour.rejected,Flavour.admitted] := by
      cases flavour <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ sector _ hsector
    apply CommonRefinement.memFlatMap _ _ kind _ hkind
    apply CommonRefinement.memFlatMap _ _ depth _ hdepth
    apply CommonRefinement.memFlatMap _ _ invariant _ hinvariant
    apply CommonRefinement.memFlatMap _ _ roots _ hroots
    apply CommonRefinement.memFlatMap _ _ ratios _ hratios
    apply CommonRefinement.memFlatMap _ _ relic _ hrelic
    apply CommonRefinement.memFlatMap _ _ abundance _ habundance
    apply CommonRefinement.memFlatMap _ _ flavour _ hflavour
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.SmithionGrammar
