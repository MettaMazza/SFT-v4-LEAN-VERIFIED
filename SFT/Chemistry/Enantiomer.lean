import SFT.Chemistry.Chirality
namespace SFT.Chemistry.Enantiomer
open Chirality
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GraphOperations
open SFT.Mathematics.CombinatorialArrangements

-- The reflected member is constructed, retaining both complete records.
structure MirrorPair where
 left : OrientedMolecule
 right : OrientedMolecule
 reflection : right=mirrorMolecule left

def generate (left : OrientedMolecule) : MirrorPair := ⟨left,mirrorMolecule left,rfl⟩
def classify (pair : MirrorPair) : Bool := chiral pair.left

theorem completeConstitution (pair : MirrorPair) : pair.right.carrier=pair.left.carrier := by
 rw [pair.reflection]
 rfl

theorem equalComposition (pair : MirrorPair) :
 pair.right.carrier.elements=pair.left.carrier.elements := congrArg (fun m => m.elements) (completeConstitution pair)

theorem equalConnectivity (pair : MirrorPair) :
 pair.right.carrier.bonds=pair.left.carrier.bonds := congrArg (fun m => m.bonds) (completeConstitution pair)

theorem opposedConfiguration (pair : MirrorPair) (name : String) :
 wordAt name pair.right.orientations=(wordAt name pair.left.orientations).map reflectWord := by
 rw [pair.reflection]
 exact mirroredLookup name pair.left.orientations

theorem reverseReflection (pair : MirrorPair) : pair.left=mirrorMolecule pair.right := by
 rw [pair.reflection,mirrorMoleculeTwice]

def reverse (pair : MirrorPair) : MirrorPair := ⟨pair.right,pair.left,reverseReflection pair⟩

theorem reverseTwiceLeft (pair : MirrorPair) : (reverse (reverse pair)).left=pair.left := rfl

theorem reverseTwiceRight (pair : MirrorPair) : (reverse (reverse pair)).right=pair.right := rfl

theorem classificationExactlyAllProperMapsFail (pair : MirrorPair)
 (nonempty : pair.left.carrier.occurrences≠[])
 (unique : distinct pair.left.carrier.occurrences=true) :
 classify pair=true ↔ ∀ order, List.Perm order pair.left.carrier.occurrences →
 properMatches pair.left pair.right order=false := by
 unfold classify
 rw [pair.reflection]
 exact chiralityExactlyAllProperMapsFail pair.left nonempty unique

def comparisonTrace (pair : MirrorPair) :=
 mapTrace pair.right.carrier.occurrences (properMatches pair.left pair.right)

theorem traceIsComplete (pair : MirrorPair) : comparisonTrace pair=
 (arrangementsCore pair.right.carrier.occurrences).map
  (fun order => (order,properMatches pair.left pair.right order)) := rfl

theorem wordReflectionTransfer (a b : OrientationWord) :
 wordEqual (reflectWord a) b=wordEqual a (reflectWord b) := by
 cases left : wordEqual (reflectWord a) b with
 | true =>
   have same := (wordEqualMeaning _ _).mp left
   have reflected := congrArg reflectWord same
   rw [reflectWordTwice] at reflected
   exact ((wordEqualMeaning _ _).mpr reflected).symm
 | false =>
   cases right : wordEqual a (reflectWord b) with
   | false => rfl
   | true =>
     have same := (wordEqualMeaning _ _).mp right
     have reflected := congrArg reflectWord same
     rw [reflectWordTwice] at reflected
     have impossible := (wordEqualMeaning _ _).mpr reflected
     rw [left] at impossible
     cases impossible

def compareWords : Option OrientationWord → Option OrientationWord → Bool
 | some a,some b => wordEqual a b
 | none,none => false
 | none,some _ => false
 | some _,none => false

theorem optionalReflectionTransfer (a b : Option OrientationWord) :
 compareWords (a.map reflectWord) b=compareWords a (b.map reflectWord) := by
 cases a with
 | none => cases b <;> rfl
 | some a =>
   cases b with
   | none => rfl
   | some b => exact wordReflectionTransfer a b

theorem allComparisonsEqual (names : List String) (first second : String → Bool)
 (same : ∀ n∈names, first n=second n) : names.all first=names.all second := by
 induction names with
 | nil => rfl
 | cons n ns ih =>
   change (first n && ns.all first)=(second n && ns.all second)
   rw [same n (.head _),ih (fun x h => same x (.tail _ h))]

theorem orientationReflectionTransfer (left right : OrientedMolecule) (order : List String) :
 orientationMatches (mirrorMolecule left) right order=
 orientationMatches left (mirrorMolecule right) order := by
 apply allComparisonsEqual
 intro name _
 change compareWords (wordAt name (mirrorMolecule left).orientations)
  (wordAt (MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order)) right.orientations)=
  compareWords (wordAt name left.orientations)
   (wordAt (MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order))
    (mirrorMolecule right).orientations)
 unfold mirrorMolecule
 rw [mirroredLookup,mirroredLookup]
 exact optionalReflectionTransfer _ _

theorem properReflectionTransfer (left right : OrientedMolecule) (order : List String) :
 properMatches (mirrorMolecule left) right order=properMatches left (mirrorMolecule right) order := by
 unfold properMatches
 rw [orientationReflectionTransfer]
 rfl

theorem pairedTestsSymmetric (pair : MirrorPair) (order : List String) :
 properMatches pair.right pair.left order=properMatches pair.left pair.right order := by
 rw [pair.reflection]
 exact properReflectionTransfer pair.left pair.left order

theorem classifiedPairSymmetric (pair : MirrorPair)
 (nonempty : pair.left.carrier.occurrences≠[]) (unique : distinct pair.left.carrier.occurrences=true)
 (classified : classify pair=true) : classify (reverse pair)=true := by
 have failed := (classificationExactlyAllProperMapsFail pair nonempty unique).mp classified
 have carrierSame := completeConstitution pair
 apply (classificationExactlyAllProperMapsFail (reverse pair)
  (by change pair.right.carrier.occurrences≠[]; rw [carrierSame]; exact nonempty)
  (by change distinct pair.right.carrier.occurrences=true; rw [carrierSame]; exact unique)).mpr
 intro order perm
 change List.Perm order pair.right.carrier.occurrences at perm
 rw [carrierSame] at perm
 change properMatches pair.right pair.left order=false
 rw [pairedTestsSymmetric]
 exact failed order perm

def appendMatched (pair : MirrorPair) (fresh element : String)
 (word : OrientationWord) (links : List String) : MirrorPair :=
 ⟨appendMolecularBranch pair.left fresh element word links,
  appendMolecularBranch pair.right fresh element (reflectWord word) links,
  by rw [pair.reflection,molecularBranchReflection]⟩

theorem matchedExtensionConstitution (pair : MirrorPair) (fresh element : String)
 (word : OrientationWord) (links : List String) :
 (appendMatched pair fresh element word links).right.carrier=
 (appendMatched pair fresh element word links).left.carrier := completeConstitution _

theorem matchedExtensionEveryOldMap (pair : MirrorPair) (fresh element : String)
 (word : OrientationWord) (links order : List String)
 (unique : distinct pair.left.carrier.occurrences=true) (freshName : ¬fresh∈pair.left.carrier.occurrences)
 (perm : List.Perm order pair.left.carrier.occurrences) :
 fresh::order ∈ arrangementsCore (appendMatched pair fresh element word links).left.carrier.occurrences :=
 everyOldMapHasGeneratedExtension _ _ unique freshName _ perm

def basePair : MirrorPair := generate baseMolecule

theorem basePairClassified : classify basePair=true := baseChiral

-- Contextual observations retain source, method and resolving environment;
-- no universal response difference is asserted by molecular pairing alone.
structure Observation where
 pair : MirrorPair
 environment : HeldLabel
 method : HeldLabel
 conditions : SFT.Host.Canonical.Value
 source : SFT.Host.Canonical.Value
 leftResponse : SFT.Host.Canonical.Value
 rightResponse : SFT.Host.Canonical.Value

def changeEnvironment (o : Observation) (environment : HeldLabel) : Observation :=
 {o with environment := environment}

theorem environmentDoesNotSelectPair (o : Observation) (environment : HeldLabel) :
 (changeEnvironment o environment).pair=o.pair := rfl

theorem environmentDoesNotChangeClassification (o : Observation) (environment : HeldLabel) :
 classify (changeEnvironment o environment).pair=classify o.pair := rfl

end SFT.Chemistry.Enantiomer
