import SFT.Physics.LandauerDemonLedger
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.LandauerDemonLedgerGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "sampled-memory-state"
  | .admitted => "complete-two-preimage-fibre"

inductive Image where
  | rejected | admitted

def imageName : Image → String
  | .rejected => "selected-reset-state"
  | .admitted => "common-half-One-image"

inductive Distinction where
  | rejected | admitted

def distinctionName : Distinction → String
  | .rejected => "unquantified-information-loss"
  | .admitted => "exactly-one-binary-distinction"

inductive Throw where
  | rejected | admitted

def throwName : Throw → String
  | .rejected => "free-or-vanishing-cost"
  | .admitted => "half-One-preimage-separation"

inductive Reverse where
  | rejected | admitted

def reverseName : Reverse → String
  | .rejected => "infer-erased-predecessor"
  | .admitted => "retain-one-predecessor-label"

inductive Sorting where
  | rejected | admitted

def sortingName : Sorting → String
  | .rejected => "unrecorded-sorting-gain"
  | .admitted => "one-held-gas-distinction"

inductive Memory where
  | rejected | admitted

def memoryName : Memory → String
  | .rejected => "memory-without-two-states"
  | .admitted => "two-label-Fold-memory"

inductive Environment where
  | rejected | admitted

def environmentName : Environment → String
  | .rejected => "erased-without-external-record"
  | .admitted => "one-environment-reverse-label"

inductive Thermal where
  | rejected | admitted

def thermalName : Thermal → String
  | .rejected => "import-kT-log-two-as-premise"
  | .admitted => "postseal-dimensional-correspondence"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-cost-or-demon-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  support : Support
  image : Image
  distinction : Distinction
  throw : Throw
  reverse : Reverse
  sorting : Sorting
  memory : Memory
  environment : Environment
  thermal : Thermal
  extension : Extension

def sourceFields (c : Candidate) : List String := [supportName c.support, imageName c.image, distinctionName c.distinction, throwName c.throw, reverseName c.reverse, sortingName c.sorting, memoryName c.memory, environmentName c.environment, thermalName c.thermal, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "image=" (imageName c.image), SFT.Host.Text.append "distinction=" (distinctionName c.distinction), SFT.Host.Text.append "throw=" (throwName c.throw), SFT.Host.Text.append "reverse=" (reverseName c.reverse), SFT.Host.Text.append "sorting=" (sortingName c.sorting), SFT.Host.Text.append "memory=" (memoryName c.memory), SFT.Host.Text.append "environment=" (environmentName c.environment), SFT.Host.Text.append "thermal=" (thermalName c.thermal), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-two-preimage-fibre__common-half-One-image__exactly-one-binary-distinction__half-One-preimage-separation__retain-one-predecessor-label__one-held-gas-distinction__two-label-Fold-memory__one-environment-reverse-label__postseal-dimensional-correspondence__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-two-preimage-fibre" &&
  SFT.Host.Text.equal (imageName c.image) "common-half-One-image" &&
  SFT.Host.Text.equal (distinctionName c.distinction) "exactly-one-binary-distinction" &&
  SFT.Host.Text.equal (throwName c.throw) "half-One-preimage-separation" &&
  SFT.Host.Text.equal (reverseName c.reverse) "retain-one-predecessor-label" &&
  SFT.Host.Text.equal (sortingName c.sorting) "one-held-gas-distinction" &&
  SFT.Host.Text.equal (memoryName c.memory) "two-label-Fold-memory" &&
  SFT.Host.Text.equal (environmentName c.environment) "one-environment-reverse-label" &&
  SFT.Host.Text.equal (thermalName c.thermal) "postseal-dimensional-correspondence" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (supportName c.support) "sampled-memory-state" then "A sampled state cannot establish a two-to-one reset." else
  if SFT.Host.Text.equal (imageName c.image) "selected-reset-state" then "A selected state has no Fold trace." else
  if SFT.Host.Text.equal (distinctionName c.distinction) "unquantified-information-loss" then "An unquantified loss cannot balance a cycle." else
  if SFT.Host.Text.equal (throwName c.throw) "free-or-vanishing-cost" then "A free or vanishing cost violates the exact fibre separation." else
  if SFT.Host.Text.equal (reverseName c.reverse) "infer-erased-predecessor" then "The common image cannot identify its source." else
  if SFT.Host.Text.equal (sortingName c.sorting) "unrecorded-sorting-gain" then "An unrecorded distinction is outside the closed system." else
  if SFT.Host.Text.equal (memoryName c.memory) "memory-without-two-states" then "A one-state memory cannot encode the decision." else
  if SFT.Host.Text.equal (environmentName c.environment) "erased-without-external-record" then "That would destroy the predecessor distinction from the closed ledger." else
  if SFT.Host.Text.equal (thermalName c.thermal) "import-kT-log-two-as-premise" then "A conventional thermal formula cannot select the Fold law." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-cost-or-demon-exception" then "A free exception defeats closure." else
  "Resetting the complete quarter-One/three-quarter-One Fold fibre to half-One closes exactly one binary distinction with native throw half-One; reversal requires one predecessor label; and a closed Maxwell-demon cycle exports exactly that one label to its environment."

def generationRule : String := "Generate the complete product of reset support, image, distinction, native throw, reverse record, sorting, memory, environment, thermal translation and extension forms."
def grammarBoundary : String := "Every exact reset of the complete two-preimage Fold fibre to one held ready image; every finite closed sorting-memory-reset-environment cycle; and every retained predecessor-label assignment."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Image.rejected,Image.admitted]).flatMap fun image =>
  ([Distinction.rejected,Distinction.admitted]).flatMap fun distinction =>
  ([Throw.rejected,Throw.admitted]).flatMap fun throw =>
  ([Reverse.rejected,Reverse.admitted]).flatMap fun reverse =>
  ([Sorting.rejected,Sorting.admitted]).flatMap fun sorting =>
  ([Memory.rejected,Memory.admitted]).flatMap fun memory =>
  ([Environment.rejected,Environment.admitted]).flatMap fun environment =>
  ([Thermal.rejected,Thermal.admitted]).flatMap fun thermal =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨support,image,distinction,throw,reverse,sorting,memory,environment,thermal,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support image distinction throw reverse sorting memory environment thermal extension =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have himage : image ∈ [Image.rejected,Image.admitted] := by
      cases image <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistinction : distinction ∈ [Distinction.rejected,Distinction.admitted] := by
      cases distinction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hthrow : throw ∈ [Throw.rejected,Throw.admitted] := by
      cases throw <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreverse : reverse ∈ [Reverse.rejected,Reverse.admitted] := by
      cases reverse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsorting : sorting ∈ [Sorting.rejected,Sorting.admitted] := by
      cases sorting <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmemory : memory ∈ [Memory.rejected,Memory.admitted] := by
      cases memory <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henvironment : environment ∈ [Environment.rejected,Environment.admitted] := by
      cases environment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hthermal : thermal ∈ [Thermal.rejected,Thermal.admitted] := by
      cases thermal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ image _ himage
    apply CommonRefinement.memFlatMap _ _ distinction _ hdistinction
    apply CommonRefinement.memFlatMap _ _ throw _ hthrow
    apply CommonRefinement.memFlatMap _ _ reverse _ hreverse
    apply CommonRefinement.memFlatMap _ _ sorting _ hsorting
    apply CommonRefinement.memFlatMap _ _ memory _ hmemory
    apply CommonRefinement.memFlatMap _ _ environment _ henvironment
    apply CommonRefinement.memFlatMap _ _ thermal _ hthermal
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.LandauerDemonLedgerGrammar
