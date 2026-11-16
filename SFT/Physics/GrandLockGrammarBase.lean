import SFT.Physics.GrandLockCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.GrandLockGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Ownership where
  | rejected | admitted

def ownershipName : Ownership → String
  | .rejected => "omitted-or-duplicate-owner"
  | .admitted => "unique-complete-physics-owner"

inductive Receipt where
  | rejected | admitted

def receiptName : Receipt → String
  | .rejected => "unbound-or-current-only-result"
  | .admitted => "receipt-and-certificate-hash-bound"

inductive Registration where
  | rejected | admitted

def registrationName : Registration → String
  | .rejected => "unstated-or-mutable-premises"
  | .admitted => "registration-and-dependencies-hash-bound"

inductive Dependency where
  | rejected | admitted

def dependencyName : Dependency → String
  | .rejected => "orphan-or-cycle"
  | .admitted => "complete-acyclic-dictionary"

inductive Root where
  | rejected | admitted

def rootName : Root → String
  | .rejected => "multiple-or-missing-roots"
  | .admitted => "foundational-One-root"

inductive Values where
  | rejected | admitted

def valuesName : Values → String
  | .rejected => "headline-selection-only"
  | .admitted => "all-claim-exact-result-vector"

inductive Perturbation where
  | rejected | admitted

def perturbationName : Perturbation → String
  | .rejected => "selected-values-move"
  | .admitted => "every-and-only-declared-dependent-value-moves"

inductive Invariants where
  | rejected | admitted

def invariantsName : Invariants → String
  | .rejected => "silent-global-retuning"
  | .admitted => "binary-space-boundary-held"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "duplicate-unrelated-numbers"
  | .admitted => "complete-cross-domain-identity-graph"

inductive Empirical where
  | rejected | admitted

def empiricalName : Empirical → String
  | .rejected => "favourable-rows-only"
  | .admitted => "complete-receipts-with-adverse-boundaries"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "permanently-locked-theory"
  | .admitted => "current-evidence-closed-extension-open"

inductive Rule where
  | rejected | admitted

def ruleName : Rule → String
  | .rejected => "free-extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  ownership : Ownership
  receipt : Receipt
  registration : Registration
  dependency : Dependency
  root : Root
  values : Values
  perturbation : Perturbation
  invariants : Invariants
  identity : Identity
  empirical : Empirical
  extension : Extension
  rule : Rule

def sourceFields (c : Candidate) : List String := [ownershipName c.ownership, receiptName c.receipt, registrationName c.registration, dependencyName c.dependency, rootName c.root, valuesName c.values, perturbationName c.perturbation, invariantsName c.invariants, identityName c.identity, empiricalName c.empirical, extensionName c.extension, ruleName c.rule]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "ownership=" (ownershipName c.ownership), SFT.Host.Text.append "receipt=" (receiptName c.receipt), SFT.Host.Text.append "registration=" (registrationName c.registration), SFT.Host.Text.append "dependency=" (dependencyName c.dependency), SFT.Host.Text.append "root=" (rootName c.root), SFT.Host.Text.append "values=" (valuesName c.values), SFT.Host.Text.append "perturbation=" (perturbationName c.perturbation), SFT.Host.Text.append "invariants=" (invariantsName c.invariants), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "empirical=" (empiricalName c.empirical), SFT.Host.Text.append "extension=" (extensionName c.extension), SFT.Host.Text.append "rule=" (ruleName c.rule)]
def survivorId : String := "unique-complete-physics-owner__receipt-and-certificate-hash-bound__registration-and-dependencies-hash-bound__complete-acyclic-dictionary__foundational-One-root__all-claim-exact-result-vector__every-and-only-declared-dependent-value-moves__binary-space-boundary-held__complete-cross-domain-identity-graph__complete-receipts-with-adverse-boundaries__current-evidence-closed-extension-open__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (ownershipName c.ownership) "unique-complete-physics-owner" &&
  SFT.Host.Text.equal (receiptName c.receipt) "receipt-and-certificate-hash-bound" &&
  SFT.Host.Text.equal (registrationName c.registration) "registration-and-dependencies-hash-bound" &&
  SFT.Host.Text.equal (dependencyName c.dependency) "complete-acyclic-dictionary" &&
  SFT.Host.Text.equal (rootName c.root) "foundational-One-root" &&
  SFT.Host.Text.equal (valuesName c.values) "all-claim-exact-result-vector" &&
  SFT.Host.Text.equal (perturbationName c.perturbation) "every-and-only-declared-dependent-value-moves" &&
  SFT.Host.Text.equal (invariantsName c.invariants) "binary-space-boundary-held" &&
  SFT.Host.Text.equal (identityName c.identity) "complete-cross-domain-identity-graph" &&
  SFT.Host.Text.equal (empiricalName c.empirical) "complete-receipts-with-adverse-boundaries" &&
  SFT.Host.Text.equal (extensionName c.extension) "current-evidence-closed-extension-open" &&
  SFT.Host.Text.equal (ruleName c.rule) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (ownershipName c.ownership) "unique-complete-physics-owner") then "That is not a complete branch census." else
  if !(SFT.Host.Text.equal (receiptName c.receipt) "receipt-and-certificate-hash-bound") then "That cannot detect replacement." else
  if !(SFT.Host.Text.equal (registrationName c.registration) "registration-and-dependencies-hash-bound") then "That erases the proof route." else
  if !(SFT.Host.Text.equal (dependencyName c.dependency) "complete-acyclic-dictionary") then "An orphan or cycle cannot derive from the One." else
  if !(SFT.Host.Text.equal (rootName c.root) "foundational-One-root") then "That adds an axiom or loses derivation." else
  if !(SFT.Host.Text.equal (valuesName c.values) "all-claim-exact-result-vector") then "Selecting favorable headlines permits omission." else
  if !(SFT.Host.Text.equal (perturbationName c.perturbation) "every-and-only-declared-dependent-value-moves") then "A selected subset cannot prove structural dependence." else
  if !(SFT.Host.Text.equal (invariantsName c.invariants) "binary-space-boundary-held") then "Global retuning cannot localize cause." else
  if !(SFT.Host.Text.equal (identityName c.identity) "complete-cross-domain-identity-graph") then "Coincidence without provenance is not identity." else
  if !(SFT.Host.Text.equal (empiricalName c.empirical) "complete-receipts-with-adverse-boundaries") then "Cherry-picking violates the empirical record." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "current-evidence-closed-extension-open") then "That would exclude lawful discovery." else
  if !(SFT.Host.Text.equal (ruleName c.rule) "no-extra-rule") then "An extra rule is a parameter." else
  "The frozen pre-lock Physics surface contains exactly 347 uniquely owned admitted claims and 534 transitive dependency nodes. Every Physics claim reaches SFT-FOUNDATION-ONE-001 in one acyclic dependency dictionary. Exactly 234 Physics claims carry empirical-test receipts, and every recorded unfavorable result or scope boundary remains bound. The current generator-three headline vector recomputes exactly, including inverse alpha 503846395469/3676744786, charged-lepton invariants 1, 1/6, 1/485 and 3/1454 plus the terminal product, quark products 1/383 and 1/3071, dark/baryon 27/5 with 27/32 and 5/32, Hubble 13/12 and 3305/3048, the terminal squared Planck/proton hierarchy, local vacuum floors 1/2^10 and 1/2^20, and normalized cosmological value 33/16. Under the complete generator successor three-to-four, every declared generator-dependent value changes while half-One, spatial rank three and boundary rank two remain fixed."

def generationRule : String := "Generate the complete twelve-axis product of ownership, receipt identity, registration identity, dependency closure, root reachability, value vector, generator perturbation, invariant control, cross-domain identity, empirical reconciliation, extension status and extra-rule forms."
def grammarBoundary : String := "All 347 admitted pre-lock Physics claims, all 534 nodes in their dependency closure, every bound exact-result and empirical certificate row, the complete generator-three to generator-four adverse perturbation, all shared structural carriers and all 4096 alternatives."

def candidates : List Candidate :=
  ([Ownership.rejected,Ownership.admitted]).flatMap fun ownership =>
  ([Receipt.rejected,Receipt.admitted]).flatMap fun receipt =>
  ([Registration.rejected,Registration.admitted]).flatMap fun registration =>
  ([Dependency.rejected,Dependency.admitted]).flatMap fun dependency =>
  ([Root.rejected,Root.admitted]).flatMap fun root =>
  ([Values.rejected,Values.admitted]).flatMap fun values =>
  ([Perturbation.rejected,Perturbation.admitted]).flatMap fun perturbation =>
  ([Invariants.rejected,Invariants.admitted]).flatMap fun invariants =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Empirical.rejected,Empirical.admitted]).flatMap fun empirical =>
  ([Extension.rejected,Extension.admitted]).flatMap fun extension =>
  ([Rule.rejected,Rule.admitted]).map fun rule =>
  ⟨ownership,receipt,registration,dependency,root,values,perturbation,invariants,identity,empirical,extension,rule⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk ownership receipt registration dependency root values perturbation invariants identity empirical extension rule =>
    have hownership : ownership ∈ [Ownership.rejected,Ownership.admitted] := by
      cases ownership <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreceipt : receipt ∈ [Receipt.rejected,Receipt.admitted] := by
      cases receipt <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hregistration : registration ∈ [Registration.rejected,Registration.admitted] := by
      cases registration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdependency : dependency ∈ [Dependency.rejected,Dependency.admitted] := by
      cases dependency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hroot : root ∈ [Root.rejected,Root.admitted] := by
      cases root <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvalues : values ∈ [Values.rejected,Values.admitted] := by
      cases values <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hperturbation : perturbation ∈ [Perturbation.rejected,Perturbation.admitted] := by
      cases perturbation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinvariants : invariants ∈ [Invariants.rejected,Invariants.admitted] := by
      cases invariants <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hempirical : empirical ∈ [Empirical.rejected,Empirical.admitted] := by
      cases empirical <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrule : rule ∈ [Rule.rejected,Rule.admitted] := by
      cases rule <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ ownership _ hownership
    apply CommonRefinement.memFlatMap _ _ receipt _ hreceipt
    apply CommonRefinement.memFlatMap _ _ registration _ hregistration
    apply CommonRefinement.memFlatMap _ _ dependency _ hdependency
    apply CommonRefinement.memFlatMap _ _ root _ hroot
    apply CommonRefinement.memFlatMap _ _ values _ hvalues
    apply CommonRefinement.memFlatMap _ _ perturbation _ hperturbation
    apply CommonRefinement.memFlatMap _ _ invariants _ hinvariants
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ empirical _ hempirical
    apply CommonRefinement.memFlatMap _ _ extension _ hextension
    exact Count.TraceDerivation.memMap _ rule _ hrule

end SFT.Physics.GrandLockGrammar
