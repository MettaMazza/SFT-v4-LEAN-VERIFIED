import SFT.Chemistry.Enantiomer
namespace SFT.Chemistry.Diastereomer
open Chirality
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GraphOperations
open SFT.Mathematics.CombinatorialArrangements

-- Constitution is tested by the existing exhaustive elemental/bond maps.
-- Independent occurrence names are retained on both sides.
structure Pair where
 left : OrientedMolecule
 right : OrientedMolecule
 constitution : MolecularIsomer.structurallyEquivalent left.carrier right.carrier=true

def configurationDistinct (left right : OrientedMolecule) : Bool :=
 !hasProperSuperposition left right && !hasProperSuperposition (mirrorMolecule left) right

def classify (p : Pair) : Bool := configurationDistinct p.left p.right

theorem sameComposition (p : Pair) :
 MolecularCarrier.compositionSignature p.left.carrier=MolecularCarrier.compositionSignature p.right.carrier :=
 ((MolecularIsomer.equivalenceExactlyGeneratedMatch _ _).mp p.constitution).1

theorem constitutionWitness (p : Pair) :
 ∃ order∈arrangementsCore p.right.carrier.occurrences,
 MolecularIsomer.candidateMatches p.left.carrier p.right.carrier order=true :=
 ((MolecularIsomer.equivalenceExactlyGeneratedMatch _ _).mp p.constitution).2

theorem boolNotTrue (b : Bool) : (!b)=true ↔ b=false := by
 cases b <;> constructor <;> intro h <;> first | rfl | cases h

theorem noProperExactly (left right : OrientedMolecule)
 (same : MolecularCarrier.compositionSignature left.carrier=MolecularCarrier.compositionSignature right.carrier)
 (nonempty : right.carrier.occurrences≠[]) (unique : distinct right.carrier.occurrences=true) :
 hasProperSuperposition left right=false ↔ ∀ order, List.Perm order right.carrier.occurrences →
 properMatches left right order=false := by
 unfold hasProperSuperposition
 rw [decide_eq_true same]
 exact noSuperpositionExactly right.carrier.occurrences nonempty unique _

theorem exactClassification (p : Pair)
 (nonempty : p.right.carrier.occurrences≠[]) (unique : distinct p.right.carrier.occurrences=true) :
 classify p=true ↔
 (∀ order, List.Perm order p.right.carrier.occurrences → properMatches p.left p.right order=false) ∧
 (∀ order, List.Perm order p.right.carrier.occurrences → properMatches (mirrorMolecule p.left) p.right order=false) := by
 constructor
 · intro yes
   have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp yes
   exact ⟨(noProperExactly _ _ (sameComposition p) nonempty unique).mp ((boolNotTrue _).mp both.1),
    (noProperExactly (mirrorMolecule p.left) p.right (sameComposition p) nonempty unique).mp ((boolNotTrue _).mp both.2)⟩
 · intro both
   exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
    ⟨(boolNotTrue _).mpr ((noProperExactly _ _ (sameComposition p) nonempty unique).mpr both.1),
     (boolNotTrue _).mpr ((noProperExactly (mirrorMolecule p.left) p.right (sameComposition p) nonempty unique).mpr both.2)⟩

theorem superposableExcluded (p : Pair) (matched : hasProperSuperposition p.left p.right=true) :
 classify p=false := by unfold classify configurationDistinct; rw [matched]; rfl

theorem mirrorRelatedExcluded (p : Pair)
 (matched : hasProperSuperposition (mirrorMolecule p.left) p.right=true) : classify p=false := by
 unfold classify configurationDistinct
 rw [matched]
 cases hasProperSuperposition p.left p.right <;> rfl

def classificationTrace (p : Pair) :=
 (arrangementsCore p.right.carrier.occurrences).map
  (fun order => (order,MolecularIsomer.candidateMatches p.left.carrier p.right.carrier order,
   properMatches p.left p.right order,properMatches (mirrorMolecule p.left) p.right order))

theorem traceRetainsAllTests (p : Pair) : classificationTrace p=
 (arrangementsCore p.right.carrier.occurrences).map
  (fun order => (order,MolecularIsomer.candidateMatches p.left.carrier p.right.carrier order,
   properMatches p.left p.right order,properMatches (mirrorMolecule p.left) p.right order)) := rfl

def mixedMolecule : OrientedMolecule :=
 ⟨baseMolecule.carrier,[("a",baseOrientation),("b",reflectWord baseOrientation)]⟩

theorem baseSameConstitution :
 MolecularIsomer.structurallyEquivalent baseMolecule.carrier mixedMolecule.carrier=true := by
 apply (MolecularIsomer.completeRelabellingSearch _ _ (by intro h; cases h) (by decide)).mpr
 exact ⟨rfl,["a","b"],List.Perm.refl _,by decide⟩

def basePair : Pair := ⟨baseMolecule,mixedMolecule,baseSameConstitution⟩

theorem baseClassified : classify basePair=true := by
 unfold classify configurationDistinct hasProperSuperposition superposable
 change (!(true && (arrangementsCore ["a","b"]).any (properMatches baseMolecule mixedMolecule)) &&
  !(true && (arrangementsCore ["a","b"]).any (properMatches (mirrorMolecule baseMolecule) mixedMolecule)))=true
 rw [baseOrders]
 rfl

theorem baseAllIdentityAndMirrorMapsFail :
 (∀ order, List.Perm order ["a","b"] → properMatches baseMolecule mixedMolecule order=false) ∧
 (∀ order, List.Perm order ["a","b"] → properMatches (mirrorMolecule baseMolecule) mixedMolecule order=false) :=
 (exactClassification basePair (by intro h; cases h) (by decide)).mp baseClassified

structure Observation where
 pair : Pair
 conditions : SFT.Host.Canonical.Value
 method : HeldLabel
 source : SFT.Host.Canonical.Value
 leftResponse : SFT.Host.Canonical.Value
 rightResponse : SFT.Host.Canonical.Value

def changeResponses (o : Observation) (left right : SFT.Host.Canonical.Value) : Observation :=
 {o with leftResponse := left, rightResponse := right}

theorem responsesDoNotSelectClass (o : Observation) (left right : SFT.Host.Canonical.Value) :
 classify (changeResponses o left right).pair=classify o.pair := rfl

-- Apply the same added constitution in a common named carrier frame;
-- the two independently retained orientation words need not be reflections.
def extendLeft (p : Pair) (fresh element : String) (word : OrientationWord) (links : List String) :=
 appendMolecularBranch p.left fresh element word links

def extendRight (p : Pair) (fresh element : String) (word : OrientationWord) (links : List String) :=
 appendMolecularBranch p.right fresh element word links

theorem matchedCarrierExtension (p : Pair) (same : p.left.carrier=p.right.carrier)
 (fresh element : String) (leftWord rightWord : OrientationWord) (links : List String) :
 (extendLeft p fresh element leftWord links).carrier=(extendRight p fresh element rightWord links).carrier := by
 change MolecularCarrier.Raw.mk (p.left.carrier.occurrences++[fresh]) (p.left.carrier.elements++[element])
  (p.left.carrier.bonds++links.map (fun n => (n,fresh))) p.left.carrier.openChargeFibres=
  MolecularCarrier.Raw.mk (p.right.carrier.occurrences++[fresh]) (p.right.carrier.elements++[element])
  (p.right.carrier.bonds++links.map (fun n => (n,fresh))) p.right.carrier.openChargeFibres
 rw [same]

theorem matchedCompositionCounts (p : Pair)
 (same : ∀ label, MolecularCarrier.labelCount label p.left.carrier.elements=
  MolecularCarrier.labelCount label p.right.carrier.elements)
 (fresh element : String) (leftWord rightWord : OrientationWord) (links : List String) :
 ∀ label, MolecularCarrier.labelCount label (extendLeft p fresh element leftWord links).carrier.elements=
  MolecularCarrier.labelCount label (extendRight p fresh element rightWord links).carrier.elements :=
 MolecularIsomer.matchedExtensionPreservesMultiplicity _ _ [element] same

theorem leftConfigurationRetained (p : Pair) (fresh element name : String)
 (word : OrientationWord) (links : List String) (different : name≠fresh) :
 wordAt name (extendLeft p fresh element word links).orientations=wordAt name p.left.orientations :=
 branchRetainsOldOrientation p.left fresh element name word links different

theorem rightConfigurationRetained (p : Pair) (fresh element name : String)
 (word : OrientationWord) (links : List String) (different : name≠fresh) :
 wordAt name (extendRight p fresh element word links).orientations=wordAt name p.right.orientations :=
 branchRetainsOldOrientation p.right fresh element name word links different

theorem extendedReflectionRetained (p : Pair) (fresh element : String)
 (word : OrientationWord) (links : List String) :
 mirrorMolecule (extendLeft p fresh element word links)=
 appendMolecularBranch (mirrorMolecule p.left) fresh element (reflectWord word) links :=
 molecularBranchReflection p.left fresh element word links

def extendedTests (p : Pair) (fresh element : String) (leftWord rightWord : OrientationWord)
 (links : List String) :=
 (arrangementsCore (extendRight p fresh element rightWord links).carrier.occurrences).map
  (fun order => (order,
   properMatches (extendLeft p fresh element leftWord links) (extendRight p fresh element rightWord links) order,
   properMatches (mirrorMolecule (extendLeft p fresh element leftWord links))
    (extendRight p fresh element rightWord links) order))

theorem extendedCensusCoversEveryPermutation (p : Pair) (fresh element : String)
 (leftWord rightWord : OrientationWord) (links order : List String)
 (unique : distinct p.right.carrier.occurrences=true) (freshName : ¬fresh∈p.right.carrier.occurrences)
 (perm : List.Perm order (p.right.carrier.occurrences++[fresh])) :
 (order,properMatches (extendLeft p fresh element leftWord links) (extendRight p fresh element rightWord links) order,
  properMatches (mirrorMolecule (extendLeft p fresh element leftWord links))
   (extendRight p fresh element rightWord links) order)∈extendedTests p fresh element leftWord rightWord links := by
 apply SFT.Foundation.Count.TraceDerivation.memMap
 apply everyPermutationGenerated (p.right.carrier.occurrences++[fresh])
 · intro empty
   have held : fresh∈p.right.carrier.occurrences++[fresh] :=
    SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head [])
   rw [empty] at held
   cases held
 · exact appendFreshDistinct _ _ unique freshName
 · exact perm

end SFT.Chemistry.Diastereomer
