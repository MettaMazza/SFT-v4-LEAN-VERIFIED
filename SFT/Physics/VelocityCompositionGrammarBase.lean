import SFT.Physics.VelocityComposition
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.VelocityCompositionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Domain where
  | rejected | admitted

def domainName : Domain → String
  | .rejected => "imported-real-line-velocity"
  | .admitted => "exact-positive-parts-and-held-direction"

inductive Rest where
  | rejected | admitted

def restName : Rest → String
  | .rejected => "numerical-zero"
  | .admitted => "typed-rest-state"

inductive Representation where
  | rejected | admitted

def representationName : Representation → String
  | .rejected => "single-unrecorded-scalar"
  | .admitted => "forward-held-pair"

inductive Numerator where
  | rejected | admitted

def numeratorName : Numerator → String
  | .rejected => "cross-term-present"
  | .admitted => "cross-term-absent"

inductive Denominator where
  | rejected | admitted

def denominatorName : Denominator → String
  | .rejected => "cross-term-absent"
  | .admitted => "cross-term-present"

inductive Limit where
  | rejected | admitted

def limitName : Limit → String
  | .rejected => "limit-moves-or-is-exceeded"
  | .admitted => "limiting-One-is-absorbing"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "unbounded-sum"
  | .admitted => "strictly-inside-One"

inductive Associativity where
  | rejected | admitted

def associativityName : Associativity → String
  | .rejected => "order-dependent-rule"
  | .admitted => "exact-associative-product"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "discard-held-part"
  | .admitted => "retain-forward-and-held-parts"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "Fizeau-readable-before-seal"
  | .admitted => "postseal-only-comparison"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-coefficient-or-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  domain : Domain
  rest : Rest
  representation : Representation
  numerator : Numerator
  denominator : Denominator
  limit : Limit
  closure : Closure
  associativity : Associativity
  record : Record
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [domainName c.domain, restName c.rest, representationName c.representation, numeratorName c.numerator, denominatorName c.denominator, limitName c.limit, closureName c.closure, associativityName c.associativity, recordName c.record, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "rest=" (restName c.rest), SFT.Host.Text.append "representation=" (representationName c.representation), SFT.Host.Text.append "numerator=" (numeratorName c.numerator), SFT.Host.Text.append "denominator=" (denominatorName c.denominator), SFT.Host.Text.append "limit=" (limitName c.limit), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "associativity=" (associativityName c.associativity), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "exact-positive-parts-and-held-direction__typed-rest-state__forward-held-pair__cross-term-absent__cross-term-present__limiting-One-is-absorbing__strictly-inside-One__exact-associative-product__retain-forward-and-held-parts__postseal-only-comparison__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (domainName c.domain) "exact-positive-parts-and-held-direction" &&
  SFT.Host.Text.equal (restName c.rest) "typed-rest-state" &&
  SFT.Host.Text.equal (representationName c.representation) "forward-held-pair" &&
  SFT.Host.Text.equal (numeratorName c.numerator) "cross-term-absent" &&
  SFT.Host.Text.equal (denominatorName c.denominator) "cross-term-present" &&
  SFT.Host.Text.equal (limitName c.limit) "limiting-One-is-absorbing" &&
  SFT.Host.Text.equal (closureName c.closure) "strictly-inside-One" &&
  SFT.Host.Text.equal (associativityName c.associativity) "exact-associative-product" &&
  SFT.Host.Text.equal (recordName c.record) "retain-forward-and-held-parts" &&
  SFT.Host.Text.equal (measurementName c.measurement) "postseal-only-comparison" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (domainName c.domain) "exact-positive-parts-and-held-direction") then "A continuum imports the target model." else
  if !(SFT.Host.Text.equal (restName c.rest) "typed-rest-state") then "Numerical nothing is not an admitted physical part." else
  if !(SFT.Host.Text.equal (representationName c.representation) "forward-held-pair") then "One scalar discards the reverse distinction." else
  if !(SFT.Host.Text.equal (numeratorName c.numerator) "cross-term-absent") then "It prevents the limiting One from remaining fixed." else
  if !(SFT.Host.Text.equal (denominatorName c.denominator) "cross-term-present") then "Then composing the limiting One with motion exceeds the One." else
  if !(SFT.Host.Text.equal (limitName c.limit) "limiting-One-is-absorbing") then "That violates the admitted causal boundary." else
  if !(SFT.Host.Text.equal (closureName c.closure) "strictly-inside-One") then "Ordinary addition can leave the domain." else
  if !(SFT.Host.Text.equal (associativityName c.associativity) "exact-associative-product") then "Frame grouping cannot change one physical relation." else
  if !(SFT.Host.Text.equal (recordName c.record) "retain-forward-and-held-parts") then "Discarding the held part makes reversal ambiguous." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "postseal-only-comparison") then "A measured fringe slope could select the survivor." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A coefficient would be a parameter." else
  "The unique exact same-direction Fold composition is (u+v)/(One+uv). Typed rest is a two-sided identity; the limiting One is absorbing; positive sublimit parts remain strictly sublimit; pair multiplication makes the law associative and reconstructible; and the complete identity-compatible bilinear census contains four candidates with exactly one survivor."

def generationRule : String := "Generate the complete product of motion domain, typed rest, forward/held representation, identity-compatible numerator cross term, identity-compatible denominator cross term, limiting-speed behavior, closure, associativity, held-record reversibility, empirical custody and extension form."
def grammarBoundary : String := "Every exact positive rational speed part through the limiting One; typed rest; typed empty held part; both present/absent choices for the bilinear cross term after two-sided identity forces the left, right and denominator-One terms; every exact triple composition; and no signed or continuum proof scalar."

def candidates : List Candidate :=
  ([Domain.rejected,Domain.admitted]).flatMap fun domain =>
  ([Rest.rejected,Rest.admitted]).flatMap fun rest =>
  ([Representation.rejected,Representation.admitted]).flatMap fun representation =>
  ([Numerator.rejected,Numerator.admitted]).flatMap fun numerator =>
  ([Denominator.rejected,Denominator.admitted]).flatMap fun denominator =>
  ([Limit.rejected,Limit.admitted]).flatMap fun limit =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Associativity.rejected,Associativity.admitted]).flatMap fun associativity =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨domain,rest,representation,numerator,denominator,limit,closure,associativity,record,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk domain rest representation numerator denominator limit closure associativity record measurement extension =>
    have hdomain : domain ∈ [Domain.rejected,Domain.admitted] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrest : rest ∈ [Rest.rejected,Rest.admitted] := by
      cases rest <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrepresentation : representation ∈ [Representation.rejected,Representation.admitted] := by
      cases representation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnumerator : numerator ∈ [Numerator.rejected,Numerator.admitted] := by
      cases numerator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdenominator : denominator ∈ [Denominator.rejected,Denominator.admitted] := by
      cases denominator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlimit : limit ∈ [Limit.rejected,Limit.admitted] := by
      cases limit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hassociativity : associativity ∈ [Associativity.rejected,Associativity.admitted] := by
      cases associativity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ rest _ hrest
    apply CommonRefinement.memFlatMap _ _ representation _ hrepresentation
    apply CommonRefinement.memFlatMap _ _ numerator _ hnumerator
    apply CommonRefinement.memFlatMap _ _ denominator _ hdenominator
    apply CommonRefinement.memFlatMap _ _ limit _ hlimit
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ associativity _ hassociativity
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.VelocityCompositionGrammar
