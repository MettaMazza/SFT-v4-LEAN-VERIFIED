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

-- Raw undirected incidence of a retained identity-preserving constitution map.
def BondMatch (mapping : String → String) (left right : Edge) : Prop :=
 (mapping left.1=right.1 ∧ mapping left.2=right.2) ∨
 (mapping left.1=right.2 ∧ mapping left.2=right.1)

structure ConstitutionMap where
 left : OrientedMolecule
 right : OrientedMolecule
 order : List String
 orderPermutation : List.Perm order right.carrier.occurrences
 width : left.carrier.occurrences.length=order.length
 counts : ∀ label, MolecularCarrier.labelCount label left.carrier.elements=
  MolecularCarrier.labelCount label right.carrier.elements
 endpoints : ∀ edge∈left.carrier.bonds,
  edge.1∈left.carrier.occurrences ∧ edge.2∈left.carrier.occurrences
 forwardBonds : ∀ edge∈left.carrier.bonds, ∃ target∈right.carrier.bonds,
  BondMatch (fun name => MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order)) edge target
 reverseBonds : ∀ target∈right.carrier.bonds, ∃ edge∈left.carrier.bonds,
  BondMatch (fun name => MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order)) edge target

def mappedName (m : ConstitutionMap) (name : String) :=
 MolecularIsomer.lookup name (MolecularIsomer.mapping m.left.carrier m.order)

def transportedLinks (m : ConstitutionMap) (links : List String) := links.map (mappedName m)

def extendedName (m : ConstitutionMap) (fresh target : String) (name : String) :=
 MolecularIsomer.lookup name ((m.left.carrier.occurrences++[fresh]).zip (m.order++[target]))

theorem extendedOldName (m : ConstitutionMap) (fresh target name : String) (different : name≠fresh) :
 extendedName m fresh target name=mappedName m name := by
 unfold extendedName mappedName MolecularIsomer.mapping
 rw [zipAppendPair _ _ m.width,lookupFreshAppendOther _ _ _ _ different]

theorem extendedFreshName (m : ConstitutionMap) (fresh target : String)
 (absent : ¬fresh∈m.left.carrier.occurrences) : extendedName m fresh target fresh=target :=
 lookupLastFreshValue _ _ _ _ m.width absent

theorem oldBondTransportRetained (m : ConstitutionMap) (fresh target : String)
 (absent : ¬fresh∈m.left.carrier.occurrences) (edge : Edge)
 (held : edge∈m.left.carrier.bonds) (other : Edge)
 (matched : BondMatch (mappedName m) edge other) :
 BondMatch (extendedName m fresh target) edge other := by
 have ends := m.endpoints edge held
 have first : edge.1≠fresh := fun h => absent (h ▸ ends.1)
 have second : edge.2≠fresh := fun h => absent (h ▸ ends.2)
 unfold BondMatch
 rw [extendedOldName _ _ _ _ first,extendedOldName _ _ _ _ second]
 exact matched

theorem newBondTransport (m : ConstitutionMap) (fresh target anchor : String)
 (absent : ¬fresh∈m.left.carrier.occurrences) (held : anchor∈m.left.carrier.occurrences) :
 BondMatch (extendedName m fresh target) (anchor,fresh) (mappedName m anchor,target) := by
 have different : anchor≠fresh := fun h => absent (h ▸ held)
 exact Or.inl ⟨extendedOldName m fresh target anchor different,extendedFreshName m fresh target absent⟩

def extendedLeftCarrier (m : ConstitutionMap) (fresh element : String)
 (word : OrientationWord) (links : List String) := appendMolecularBranch m.left fresh element word links

def extendedRightCarrier (m : ConstitutionMap) (target element : String)
 (word : OrientationWord) (links : List String) :=
 appendMolecularBranch m.right target element word (transportedLinks m links)

theorem transportedForwardBonds (m : ConstitutionMap) (fresh target element : String)
 (leftWord rightWord : OrientationWord) (links : List String)
 (absent : ¬fresh∈m.left.carrier.occurrences)
 (linksHeld : ∀ anchor∈links, anchor∈m.left.carrier.occurrences) :
 ∀ edge∈(extendedLeftCarrier m fresh element leftWord links).carrier.bonds,
 ∃ other∈(extendedRightCarrier m target element rightWord links).carrier.bonds,
 BondMatch (extendedName m fresh target) edge other := by
 intro edge held
 cases SFT.Foundation.Count.TraceDerivation.memAppendCases edge m.left.carrier.bonds
  (links.map (fun anchor => (anchor,fresh))) held with
 | inl old =>
   obtain ⟨other,otherHeld,matched⟩ := m.forwardBonds edge old
   exact ⟨other,SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ otherHeld,
    oldBondTransportRetained m fresh target absent edge old other matched⟩
 | inr added =>
   obtain ⟨anchor,anchorHeld,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ added
   cases same
   refine ⟨(mappedName m anchor,target),?_,newBondTransport m fresh target anchor absent (linksHeld anchor anchorHeld)⟩
   apply SFT.Foundation.Count.TraceDerivation.memAppendRight
   exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _
    (SFT.Foundation.Count.TraceDerivation.memMap _ _ _ anchorHeld)

theorem transportedReverseBonds (m : ConstitutionMap) (fresh target element : String)
 (leftWord rightWord : OrientationWord) (links : List String)
 (absent : ¬fresh∈m.left.carrier.occurrences)
 (linksHeld : ∀ anchor∈links, anchor∈m.left.carrier.occurrences) :
 ∀ other∈(extendedRightCarrier m target element rightWord links).carrier.bonds,
 ∃ edge∈(extendedLeftCarrier m fresh element leftWord links).carrier.bonds,
 BondMatch (extendedName m fresh target) edge other := by
 intro other held
 cases SFT.Foundation.Count.TraceDerivation.memAppendCases other m.right.carrier.bonds
  ((transportedLinks m links).map (fun anchor => (anchor,target))) held with
 | inl old =>
   obtain ⟨edge,edgeHeld,matched⟩ := m.reverseBonds other old
   exact ⟨edge,SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ edgeHeld,
    oldBondTransportRetained m fresh target absent edge edgeHeld other matched⟩
 | inr added =>
   obtain ⟨mapped,mappedHeld,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ added
   obtain ⟨anchor,anchorHeld,mappedEqual⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ mappedHeld
   cases same
   cases mappedEqual
   exact ⟨(anchor,fresh),SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _
    (SFT.Foundation.Count.TraceDerivation.memMap _ _ _ anchorHeld),
    newBondTransport m fresh target anchor absent (linksHeld anchor anchorHeld)⟩

theorem transportedComposition (m : ConstitutionMap) (fresh target element : String)
 (leftWord rightWord : OrientationWord) (links : List String) :
 ∀ label, MolecularCarrier.labelCount label (extendedLeftCarrier m fresh element leftWord links).carrier.elements=
 MolecularCarrier.labelCount label (extendedRightCarrier m target element rightWord links).carrier.elements :=
 MolecularIsomer.matchedExtensionPreservesMultiplicity _ _ [element] m.counts

theorem appendPermutation {left right : List String} (p : List.Perm left right) (fresh : String) :
 List.Perm (left++[fresh]) (right++[fresh]) :=
 (appendFreshPermutation left fresh).trans ((List.Perm.cons fresh p).trans (appendFreshPermutation right fresh).symm)

theorem transportedOrder (m : ConstitutionMap) (target : String) :
 List.Perm (m.order++[target]) (m.right.carrier.occurrences++[target]) := appendPermutation m.orderPermutation target

theorem transportedTargetHeld (m : ConstitutionMap) (anchor : String)
 (held : anchor∈m.left.carrier.occurrences) : mappedName m anchor∈m.right.carrier.occurrences :=
 permutationMember m.orderPermutation _ (lookupZippedMember _ _ m.width anchor held)

theorem sourceMapCongruent {α β : Type} (items : List α) (f g : α → β)
 (same : ∀ x∈items, f x=g x) : items.map f=items.map g := by
 induction items with
 | nil => rfl
 | cons x xs ih =>
   change f x::xs.map f=g x::xs.map g
   rw [same x (.head _),ih (fun y h => same y (.tail _ h))]

theorem reconstructZippedValues (names values : List String)
 (unique : distinct names=true) (size : names.length=values.length) :
 names.map (fun name => MolecularIsomer.lookup name (names.zip values))=values := by
 induction names generalizing values with
 | nil =>
   cases values with
   | nil => rfl
   | cons a rest => cases size
 | cons name names ih =>
   cases values with
   | nil => cases size
   | cons value values =>
     have parts := (distinctCons _ _).mp unique
     have absent := (absentIff names name).mp parts.1
     change (if name=name then value else MolecularIsomer.lookup name (names.zip values))::
      names.map (fun n => if n=name then value else MolecularIsomer.lookup n (names.zip values))=value::values
     rw [ite_eq_left rfl]
     have rest : names.map (fun n => if n=name then value else MolecularIsomer.lookup n (names.zip values))=
      names.map (fun n => MolecularIsomer.lookup n (names.zip values)) := by
       apply sourceMapCongruent
       intro n held
       have different : n ≠ name := fun h => absent (h ▸ held)
       exact ite_eq_right different
     rw [rest,ih values parts.2 (Nat.succ.inj size)]

theorem sourceMapCompose {α β γ : Type} (xs : List α) (f : α → β) (g : β → γ) :
 (xs.map f).map g=xs.map (fun x => g (f x)) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons (g (f x))) ih

theorem permutationMappedCount {a b : List String} (perm : List.Perm a b)
 (value : String → String) (label : String) :
 MolecularCarrier.labelCount label (a.map value)=MolecularCarrier.labelCount label (b.map value) := by
 induction perm with
 | nil => rfl
 | cons x p ih =>
   change (if label=value x then 1+MolecularCarrier.labelCount label _ else MolecularCarrier.labelCount label _)=
    (if label=value x then 1+MolecularCarrier.labelCount label _ else MolecularCarrier.labelCount label _)
   rw [ih]
 | swap x y rest =>
   change (if label=value y then 1+(if label=value x then 1+MolecularCarrier.labelCount label _ else MolecularCarrier.labelCount label _) else
    (if label=value x then 1+MolecularCarrier.labelCount label _ else MolecularCarrier.labelCount label _))=
    (if label=value x then 1+(if label=value y then 1+MolecularCarrier.labelCount label _ else MolecularCarrier.labelCount label _) else
    (if label=value y then 1+MolecularCarrier.labelCount label _ else MolecularCarrier.labelCount label _))
   by_cases hx : label=value x <;> by_cases hy : label=value y <;>
    repeat first | rw [ite_eq_left hx] | rw [ite_eq_right hx] | rw [ite_eq_left hy] | rw [ite_eq_right hy]
   all_goals rfl
 | trans p q ih jh => exact ih.trans jh

theorem sourceElementCounts (left right : OrientedMolecule) (order : List String)
 (leftUnique : distinct left.carrier.occurrences=true) (rightUnique : distinct right.carrier.occurrences=true)
 (leftWidth : left.carrier.occurrences.length=left.carrier.elements.length)
 (rightWidth : right.carrier.occurrences.length=right.carrier.elements.length)
 (orderWidth : left.carrier.occurrences.length=order.length)
 (perm : List.Perm order right.carrier.occurrences)
 (elements : MolecularIsomer.respectsElements left.carrier right.carrier order=true) :
 ∀ label, MolecularCarrier.labelCount label left.carrier.elements=MolecularCarrier.labelCount label right.carrier.elements := by
 have transferred : left.carrier.elements=
  order.map (fun name => MolecularIsomer.lookup name (right.carrier.occurrences.zip right.carrier.elements)) := by
   calc
    left.carrier.elements = left.carrier.occurrences.map
     (fun name => MolecularIsomer.lookup name (left.carrier.occurrences.zip left.carrier.elements)) :=
      (reconstructZippedValues _ _ leftUnique leftWidth).symm
    _ = left.carrier.occurrences.map (fun name => MolecularIsomer.lookup
     (MolecularIsomer.lookup name (left.carrier.occurrences.zip order))
      (right.carrier.occurrences.zip right.carrier.elements)) := by
       apply sourceMapCongruent
       intro name held
       exact of_decide_eq_true (SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ elements name held)
    _ = (left.carrier.occurrences.map (fun name => MolecularIsomer.lookup name (left.carrier.occurrences.zip order))).map
     (fun name => MolecularIsomer.lookup name (right.carrier.occurrences.zip right.carrier.elements)) := (sourceMapCompose left.carrier.occurrences
      (fun name => MolecularIsomer.lookup name (left.carrier.occurrences.zip order))
      (fun name => MolecularIsomer.lookup name (right.carrier.occurrences.zip right.carrier.elements))).symm
    _ = _ := by rw [reconstructZippedValues _ _ leftUnique orderWidth]
 intro label
 rw [transferred]
 have counts := permutationMappedCount perm
  (fun name => MolecularIsomer.lookup name (right.carrier.occurrences.zip right.carrier.elements)) label
 rw [reconstructZippedValues _ _ rightUnique rightWidth] at counts
 exact counts

theorem normalizedMappedBond (f : String → String) (edge other : Edge)
 (same : MolecularCarrier.normalizedEdge
  (f (MolecularCarrier.normalizedEdge edge).1,f (MolecularCarrier.normalizedEdge edge).2)=
   MolecularCarrier.normalizedEdge other) : BondMatch f edge other := by
 unfold MolecularCarrier.normalizedEdge at same
 split at same <;> split at same <;> split at same
 all_goals first
  | exact Or.inl ⟨congrArg Prod.fst same,congrArg Prod.snd same⟩
  | exact Or.inl ⟨congrArg Prod.snd same,congrArg Prod.fst same⟩
  | exact Or.inr ⟨congrArg Prod.fst same,congrArg Prod.snd same⟩
  | exact Or.inr ⟨congrArg Prod.snd same,congrArg Prod.fst same⟩

theorem sourceForwardBonds (left right : OrientedMolecule) (order : List String)
 (matched : MolecularIsomer.candidateMatches left.carrier right.carrier order=true) :
 ∀ edge∈left.carrier.bonds, ∃ other∈right.carrier.bonds,
 BondMatch (fun name => MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order)) edge other := by
 intro edge held
 have normalizedHeld := (edgeSetWitness left.carrier _).mpr ⟨edge,held,rfl⟩
 have mappedHeld := (MolecularGeometry.uniqueMeaning _ _).mpr
  (SFT.Foundation.Count.TraceDerivation.memMap
   (fun (e : Edge) => MolecularCarrier.normalizedEdge
    (MolecularIsomer.lookup e.1 (MolecularIsomer.mapping left.carrier order),
     MolecularIsomer.lookup e.2 (MolecularIsomer.mapping left.carrier order))) _ _ normalizedHeld)
 have targetHeld := ((MolecularIsomer.candidateMeaning _ _ _).mp matched).2.1 _ mappedHeld
 obtain ⟨other,otherHeld,equal⟩ := (edgeSetWitness _ _).mp targetHeld
 exact ⟨other,otherHeld,normalizedMappedBond _ _ _ equal.symm⟩

theorem sourceReverseBonds (left right : OrientedMolecule) (order : List String)
 (matched : MolecularIsomer.candidateMatches left.carrier right.carrier order=true) :
 ∀ other∈right.carrier.bonds, ∃ edge∈left.carrier.bonds,
 BondMatch (fun name => MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order)) edge other := by
 intro other held
 have targetHeld := (edgeSetWitness right.carrier _).mpr ⟨other,held,rfl⟩
 have mappedHeld := ((MolecularIsomer.candidateMeaning _ _ _).mp matched).2.2 _ targetHeld
 obtain ⟨normalized,normalizedHeld,equal⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _
  ((MolecularGeometry.uniqueMeaning _ _).mp mappedHeld)
 obtain ⟨edge,edgeHeld,edgeEqual⟩ := (edgeSetWitness _ _).mp normalizedHeld
 cases edgeEqual
 exact ⟨edge,edgeHeld,normalizedMappedBond _ _ _ equal⟩

-- The source's generated constitutional witness supplies both bond directions.
-- Equal support size is explicit here; it is not inferred from a filename or count.
def sourceConstitutionMap (left right : OrientedMolecule) (order : List String)
 (leftUnique : distinct left.carrier.occurrences=true)
 (rightUnique : distinct right.carrier.occurrences=true)
 (leftWidth : left.carrier.occurrences.length=left.carrier.elements.length)
 (rightWidth : right.carrier.occurrences.length=right.carrier.elements.length)
 (orderWidth : left.carrier.occurrences.length=order.length)
 (perm : List.Perm order right.carrier.occurrences)
 (ends : ∀ edge∈left.carrier.bonds,
  edge.1∈left.carrier.occurrences ∧ edge.2∈left.carrier.occurrences)
 (matched : MolecularIsomer.candidateMatches left.carrier right.carrier order=true) : ConstitutionMap where
 left := left
 right := right
 order := order
 orderPermutation := perm
 width := orderWidth
 counts := sourceElementCounts left right order leftUnique rightUnique leftWidth rightWidth orderWidth perm
  ((MolecularIsomer.candidateMeaning _ _ _).mp matched).1
 endpoints := ends
 forwardBonds := sourceForwardBonds left right order matched
 reverseBonds := sourceReverseBonds left right order matched

theorem pairConstitutionTransport (p : Pair)
 (leftAdmitted : MolecularCarrier.admit p.left.carrier=.ok p.left.carrier)
 (rightAdmitted : MolecularCarrier.admit p.right.carrier=.ok p.right.carrier)
 (sameSize : p.left.carrier.occurrences.length=p.right.carrier.occurrences.length) :
 ∃ m : ConstitutionMap, m.left=p.left ∧ m.right=p.right := by
 obtain ⟨order,generated,matched⟩ := constitutionWitness p
 have ls := admittedMoleculeShape p.left leftAdmitted
 have rs := admittedMoleculeShape p.right rightAdmitted
 have perm := everyArrangementPermutesCarrier p.right.carrier.occurrences rs.2.1 order generated
 have width := sameSize.trans (mapPermutationLength perm).symm
 exact ⟨sourceConstitutionMap p.left p.right order ls.2.1 rs.2.1 ls.2.2 rs.2.2 width perm
  (MolecularCarrier.allConstituentEndpoints ⟨p.left.carrier,leftAdmitted⟩) matched,rfl,rfl⟩

theorem transportedElements (m : ConstitutionMap) (fresh target element : String)
 (lo ro : OrientationWord) (links : List String)
 (leftFresh : ¬fresh∈m.left.carrier.occurrences) (rightFresh : ¬target∈m.right.carrier.occurrences)
 (leftWidth : m.left.carrier.occurrences.length=m.left.carrier.elements.length)
 (rightWidth : m.right.carrier.occurrences.length=m.right.carrier.elements.length)
 (elements : MolecularIsomer.respectsElements m.left.carrier m.right.carrier m.order=true) :
 MolecularIsomer.respectsElements (extendedLeftCarrier m fresh element lo links).carrier
  (extendedRightCarrier m target element ro links).carrier (m.order++[target])=true := by
 apply (allTrueIffMembers _ _).mpr
 intro name held
 change decide (MolecularIsomer.lookup name
  ((m.left.carrier.occurrences++[fresh]).zip (m.left.carrier.elements++[element]))=
   MolecularIsomer.lookup (extendedName m fresh target name)
    ((m.right.carrier.occurrences++[target]).zip (m.right.carrier.elements++[element])))=true
 cases SFT.Foundation.Count.TraceDerivation.memAppendCases name m.left.carrier.occurrences [fresh] held with
 | inl old =>
   have different : name≠fresh := fun h => leftFresh (h ▸ old)
   have mappedHeld := transportedTargetHeld m name old
   have mappedDifferent : mappedName m name≠target := fun h => rightFresh (h ▸ mappedHeld)
   rw [extendedOldName _ _ _ _ different,zipAppendPair _ _ leftWidth,zipAppendPair _ _ rightWidth,
    lookupFreshAppendOther _ _ _ _ different,lookupFreshAppendOther _ _ _ _ mappedDifferent]
   exact SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ elements name old
 | inr added =>
   cases added with
   | head =>
     rw [extendedFreshName _ _ _ leftFresh,lookupLastFreshValue _ _ _ _ leftWidth leftFresh,
      lookupLastFreshValue _ _ _ _ rightWidth rightFresh]
     exact decide_eq_true rfl
   | tail _ impossible => cases impossible

theorem extendedEndpoints (m : ConstitutionMap) (fresh element : String)
 (word : OrientationWord) (links : List String)
 (linksHeld : ∀ anchor∈links, anchor∈m.left.carrier.occurrences) :
 ∀ edge∈(extendedLeftCarrier m fresh element word links).carrier.bonds,
 edge.1∈(extendedLeftCarrier m fresh element word links).carrier.occurrences ∧
 edge.2∈(extendedLeftCarrier m fresh element word links).carrier.occurrences := by
 intro edge held
 cases SFT.Foundation.Count.TraceDerivation.memAppendCases edge m.left.carrier.bonds
  (links.map (fun n => (n,fresh))) held with
 | inl old =>
   have ends := m.endpoints edge old
   exact ⟨SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ ends.1,
    SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ ends.2⟩
 | inr added =>
   obtain ⟨anchor,anchorHeld,equal⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ added
   cases equal
   exact ⟨SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ (linksHeld anchor anchorHeld),
    SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head [])⟩

def extendConstitutionMap (m : ConstitutionMap) (fresh target element : String)
 (lo ro : OrientationWord) (links : List String)
 (leftFresh : ¬fresh∈m.left.carrier.occurrences)
 (linksHeld : ∀ anchor∈links, anchor∈m.left.carrier.occurrences) : ConstitutionMap where
 left := extendedLeftCarrier m fresh element lo links
 right := extendedRightCarrier m target element ro links
 order := m.order++[target]
 orderPermutation := transportedOrder m target
 width := by
  change (m.left.carrier.occurrences++[fresh]).length=(m.order++[target]).length
  rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,m.width]
  rfl
 counts := transportedComposition m fresh target element lo ro links
 endpoints := extendedEndpoints m fresh element lo links linksHeld
 forwardBonds := transportedForwardBonds m fresh target element lo ro links leftFresh linksHeld
 reverseBonds := transportedReverseBonds m fresh target element lo ro links leftFresh linksHeld

structure CompleteConstitutionMap extends ConstitutionMap where
 elements : MolecularIsomer.respectsElements left.carrier right.carrier order=true
 leftWidth : left.carrier.occurrences.length=left.carrier.elements.length
 rightWidth : right.carrier.occurrences.length=right.carrier.elements.length

def extendCompleteConstitutionMap (m : CompleteConstitutionMap) (fresh target element : String)
 (lo ro : OrientationWord) (links : List String)
 (leftFresh : ¬fresh∈m.left.carrier.occurrences) (rightFresh : ¬target∈m.right.carrier.occurrences)
 (linksHeld : ∀ anchor∈links, anchor∈m.left.carrier.occurrences) : CompleteConstitutionMap where
 toConstitutionMap := extendConstitutionMap m.toConstitutionMap fresh target element lo ro links leftFresh linksHeld
 elements := transportedElements m.toConstitutionMap fresh target element lo ro links
  leftFresh rightFresh m.leftWidth m.rightWidth m.elements
 leftWidth := by
  change (m.left.carrier.occurrences++[fresh]).length=(m.left.carrier.elements++[element]).length
  rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,m.leftWidth]
  rfl
 rightWidth := by
  change (m.right.carrier.occurrences++[target]).length=(m.right.carrier.elements++[element]).length
  rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,m.rightWidth]
  rfl

theorem pairCompleteConstitutionTransport (p : Pair)
 (leftAdmitted : MolecularCarrier.admit p.left.carrier=.ok p.left.carrier)
 (rightAdmitted : MolecularCarrier.admit p.right.carrier=.ok p.right.carrier)
 (sameSize : p.left.carrier.occurrences.length=p.right.carrier.occurrences.length) :
 ∃ m : CompleteConstitutionMap, m.left=p.left ∧ m.right=p.right := by
 obtain ⟨order,generated,matched⟩ := constitutionWitness p
 have ls := admittedMoleculeShape p.left leftAdmitted
 have rs := admittedMoleculeShape p.right rightAdmitted
 have perm := everyArrangementPermutesCarrier p.right.carrier.occurrences rs.2.1 order generated
 have width := sameSize.trans (mapPermutationLength perm).symm
 exact ⟨⟨sourceConstitutionMap p.left p.right order ls.2.1 rs.2.1 ls.2.2 rs.2.2 width perm
  (MolecularCarrier.allConstituentEndpoints ⟨p.left.carrier,leftAdmitted⟩) matched,
  ((MolecularIsomer.candidateMeaning _ _ _).mp matched).1,ls.2.2,rs.2.2⟩,rfl,rfl⟩

def transportedTests (m : CompleteConstitutionMap) :=
 (arrangementsCore m.right.carrier.occurrences).map
  (fun order => (order,properMatches m.left m.right order,
   properMatches (mirrorMolecule m.left) m.right order))

theorem transportedCensusComplete (m : CompleteConstitutionMap)
 (nonempty : m.right.carrier.occurrences≠[]) (unique : distinct m.right.carrier.occurrences=true)
 (order : List String) (perm : List.Perm order m.right.carrier.occurrences) :
 (order,properMatches m.left m.right order,properMatches (mirrorMolecule m.left) m.right order)
 ∈ transportedTests m := by
 apply SFT.Foundation.Count.TraceDerivation.memMap
 exact everyPermutationGenerated m.right.carrier.occurrences nonempty unique order perm

end SFT.Chemistry.Diastereomer
