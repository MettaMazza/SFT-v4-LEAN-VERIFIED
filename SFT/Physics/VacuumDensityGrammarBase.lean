import SFT.Physics.VacuumDensity
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.VacuumDensityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Volume where
  | rejected | admitted

def volumeName : Volume → String
  | .rejected => "borrowed-cosmic-volume"
  | .admitted => "generator-three-cubed-volume"

inductive Cover where
  | rejected | admitted

def coverName : Cover → String
  | .rejected => "selected-depth-ten-or-twenty"
  | .admitted => "least-cover-depth-five"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "one-label-per-depth"
  | .admitted => "both-held-labels-per-depth"

inductive Observable where
  | rejected | admitted

def observableName : Observable → String
  | .rejected => "amplitude-relabeled-as-energy"
  | .admitted => "two-leg-energy-self-composition"

inductive Floor where
  | rejected | admitted

def floorName : Floor → String
  | .rejected => "named-one-over-two-to-twenty"
  | .admitted => "complete-boundary-energy-floor"

inductive Radiative where
  | rejected | admitted

def radiativeName : Radiative → String
  | .rejected => "unbounded-mode-sum-as-local-density"
  | .admitted => "complete-finite-ledger-and-half-One-mean"

inductive Cosmic where
  | rejected | admitted

def cosmicName : Cosmic → String
  | .rejected => "local-floor-equals-cosmic-fraction"
  | .admitted => "terminal-eleven-sixteenths-share"

inductive Geometry where
  | rejected | admitted

def geometryName : Geometry → String
  | .rejected => "borrowed-continuum-coefficient"
  | .admitted => "three-space-squared-rate-carrier"

inductive Typing where
  | rejected | admitted

def typingName : Typing → String
  | .rejected => "untyped-number-identification-or-rubber-stamp"
  | .admitted => "distinct-typed-quantities-and-prior-correction"

inductive Transport where
  | rejected | admitted

def transportName : Transport → String
  | .rejected => "fitted-dimensional-value"
  | .admitted => "postseal-rate-squared-over-speed-squared"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "measurement-readable-before-seal"
  | .admitted => "postseal-only-comparison"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-vacuum-scale"
  | .admitted => "no-extra-rule"

structure Candidate where
  volume : Volume
  cover : Cover
  boundary : Boundary
  observable : Observable
  floor : Floor
  radiative : Radiative
  cosmic : Cosmic
  geometry : Geometry
  typing : Typing
  transport : Transport
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [volumeName c.volume, coverName c.cover, boundaryName c.boundary, observableName c.observable, floorName c.floor, radiativeName c.radiative, cosmicName c.cosmic, geometryName c.geometry, typingName c.typing, transportName c.transport, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "volume=" (volumeName c.volume), SFT.Host.Text.append "cover=" (coverName c.cover), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "observable=" (observableName c.observable), SFT.Host.Text.append "floor=" (floorName c.floor), SFT.Host.Text.append "radiative=" (radiativeName c.radiative), SFT.Host.Text.append "cosmic=" (cosmicName c.cosmic), SFT.Host.Text.append "geometry=" (geometryName c.geometry), SFT.Host.Text.append "typing=" (typingName c.typing), SFT.Host.Text.append "transport=" (transportName c.transport), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "generator-three-cubed-volume__least-cover-depth-five__both-held-labels-per-depth__two-leg-energy-self-composition__complete-boundary-energy-floor__complete-finite-ledger-and-half-One-mean__terminal-eleven-sixteenths-share__three-space-squared-rate-carrier__distinct-typed-quantities-and-prior-correction__postseal-rate-squared-over-speed-squared__postseal-only-comparison__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (volumeName c.volume) "generator-three-cubed-volume" &&
  SFT.Host.Text.equal (coverName c.cover) "least-cover-depth-five" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "both-held-labels-per-depth" &&
  SFT.Host.Text.equal (observableName c.observable) "two-leg-energy-self-composition" &&
  SFT.Host.Text.equal (floorName c.floor) "complete-boundary-energy-floor" &&
  SFT.Host.Text.equal (radiativeName c.radiative) "complete-finite-ledger-and-half-One-mean" &&
  SFT.Host.Text.equal (cosmicName c.cosmic) "terminal-eleven-sixteenths-share" &&
  SFT.Host.Text.equal (geometryName c.geometry) "three-space-squared-rate-carrier" &&
  SFT.Host.Text.equal (typingName c.typing) "distinct-typed-quantities-and-prior-correction" &&
  SFT.Host.Text.equal (transportName c.transport) "postseal-rate-squared-over-speed-squared" &&
  SFT.Host.Text.equal (measurementName c.measurement) "postseal-only-comparison" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (volumeName c.volume) "generator-three-cubed-volume") then "A borrowed volume imports a model." else
  if !(SFT.Host.Text.equal (coverName c.cover) "least-cover-depth-five") then "Selecting the desired exponent is circular." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "both-held-labels-per-depth") then "One label omits half the Fold fibre." else
  if !(SFT.Host.Text.equal (observableName c.observable) "two-leg-energy-self-composition") then "A one-leg support is not a complete energy observation." else
  if !(SFT.Host.Text.equal (floorName c.floor) "complete-boundary-energy-floor") then "Naming the prior value does not force it." else
  if !(SFT.Host.Text.equal (radiativeName c.radiative) "complete-finite-ledger-and-half-One-mean") then "An unbounded sum erases finite support, common scale and quantity type." else
  if !(SFT.Host.Text.equal (cosmicName c.cosmic) "terminal-eleven-sixteenths-share") then "The quantities have different supports and types." else
  if !(SFT.Host.Text.equal (geometryName c.geometry) "three-space-squared-rate-carrier") then "A conventional field equation cannot be a premise." else
  if !(SFT.Host.Text.equal (typingName c.typing) "distinct-typed-quantities-and-prior-correction") then "Equal-looking numbers without scale carriers are not one quantity, and preserving an old label cannot excuse a type error." else
  if !(SFT.Host.Text.equal (transportName c.transport) "postseal-rate-squared-over-speed-squared") then "A fitted unit magnitude is a parameter." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "postseal-only-comparison") then "That would fit the magnitude." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A second vacuum ruler violates the one-axis law." else
  "The unique complete local vacuum boundary-energy floor is One/2^20=(One/2^10)^2. At every finite radiative depth k, the complete 2^k half-spacing modes sum to 2^(k-1) and have common-scale mean 1/2. The terminal cosmic vacuum fraction is separately 11/16. The normalized cosmological magnitude is Lambda(c/H)^2=33/16, and dimensional transport is Lambda=(33/16)H^2/c^2 after held external scale references are supplied. Equating the local floor, a raw mode total, the global fraction or a dimensional cosmological density is rejected as a type error."

def generationRule : String := "Generate the complete product of generator volume, binary cover, boundary-label scope, observable composition, local floor, finite radiative ledger, cosmic share, spatial rate multiplicity, typed prior-claim correction, scale transport, measurement custody and extension form."
def grammarBoundary : String := "The generated volume 3^3; every binary support until the unique least cover; one-label versus complete-two-label boundary support; amplitude versus two-leg energy composition; every finite positive-depth complete half-spacing mode ledger; exact 11/16 terminal vacuum share; three-space rate transport; every exact positive rational held rate/speed reference; and no untyped equality between a local floor, density fraction and dimensional cosmological constant."

def candidates : List Candidate :=
  ([Volume.rejected,Volume.admitted]).flatMap fun volume =>
  ([Cover.rejected,Cover.admitted]).flatMap fun cover =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Observable.rejected,Observable.admitted]).flatMap fun observable =>
  ([Floor.rejected,Floor.admitted]).flatMap fun floor =>
  ([Radiative.rejected,Radiative.admitted]).flatMap fun radiative =>
  ([Cosmic.rejected,Cosmic.admitted]).flatMap fun cosmic =>
  ([Geometry.rejected,Geometry.admitted]).flatMap fun geometry =>
  ([Typing.rejected,Typing.admitted]).flatMap fun typing =>
  ([Transport.rejected,Transport.admitted]).flatMap fun transport =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨volume,cover,boundary,observable,floor,radiative,cosmic,geometry,typing,transport,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk volume cover boundary observable floor radiative cosmic geometry typing transport measurement extension =>
    have hvolume : volume ∈ [Volume.rejected,Volume.admitted] := by
      cases volume <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcover : cover ∈ [Cover.rejected,Cover.admitted] := by
      cases cover <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservable : observable ∈ [Observable.rejected,Observable.admitted] := by
      cases observable <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfloor : floor ∈ [Floor.rejected,Floor.admitted] := by
      cases floor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hradiative : radiative ∈ [Radiative.rejected,Radiative.admitted] := by
      cases radiative <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcosmic : cosmic ∈ [Cosmic.rejected,Cosmic.admitted] := by
      cases cosmic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgeometry : geometry ∈ [Geometry.rejected,Geometry.admitted] := by
      cases geometry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htyping : typing ∈ [Typing.rejected,Typing.admitted] := by
      cases typing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransport : transport ∈ [Transport.rejected,Transport.admitted] := by
      cases transport <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ volume _ hvolume
    apply CommonRefinement.memFlatMap _ _ cover _ hcover
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ observable _ hobservable
    apply CommonRefinement.memFlatMap _ _ floor _ hfloor
    apply CommonRefinement.memFlatMap _ _ radiative _ hradiative
    apply CommonRefinement.memFlatMap _ _ cosmic _ hcosmic
    apply CommonRefinement.memFlatMap _ _ geometry _ hgeometry
    apply CommonRefinement.memFlatMap _ _ typing _ htyping
    apply CommonRefinement.memFlatMap _ _ transport _ htransport
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension


end SFT.Physics.VacuumDensityGrammar
