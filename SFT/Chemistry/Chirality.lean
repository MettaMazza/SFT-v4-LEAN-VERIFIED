import SFT.Chemistry.MolecularIsomer
namespace SFT.Chemistry.Chirality
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GraphOperations
open SFT.Mathematics.CombinatorialArrangements
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
-- Exact OrientedStructure constructor domain; no distinctness or endpoint guard is added.
structure Raw where
 composition : List PositiveCount
 adjacency : List (PositiveCount × PositiveCount)
 orientation : HeldLabel


def admit (r : Raw) : Except String Raw :=
 if r.composition.isEmpty || r.adjacency.isEmpty ||
 !(SFT.Host.Text.equal r.orientation.family "molecular-orientation") then
 .error "oriented molecular structure is incomplete" else .ok r

theorem emptyCompositionRejected (a : List (PositiveCount × PositiveCount)) (o : HeldLabel) :
 admit ⟨[],a,o⟩=.error "oriented molecular structure is incomplete" := rfl

theorem emptyAdjacencyRejected (c : List PositiveCount) (o : HeldLabel) :
 admit ⟨c,[],o⟩=.error "oriented molecular structure is incomplete" := by
 unfold admit
 cases c <;> rfl

theorem nonemptyAccepted (c : PositiveCount) (cs : List PositiveCount)
 (a : PositiveCount × PositiveCount) (ads : List (PositiveCount × PositiveCount))
 (o : HeldLabel) (family : SFT.Host.Text.equal o.family "molecular-orientation"=true) :
 admit ⟨c::cs,a::ads,o⟩=.ok ⟨c::cs,a::ads,o⟩ := by
 unfold admit
 rw [family]
 rfl

-- Complete map traces retain each generated order, including failed comparisons.
-- The entry-specific orientation and reflection construction binds the comparison.
def mapTrace (carrier : List String) (comparison : List String → Bool) :=
 (arrangementsCore carrier).map (fun order => (order,comparison order))

def superposable (carrier : List String) (comparison : List String → Bool) : Bool :=
 (arrangementsCore carrier).any comparison

theorem exhaustiveSuperposition (carrier : List String)
 (nonempty : carrier≠[]) (unique : distinct carrier=true)
 (comparison : List String → Bool) :
 superposable carrier comparison=true ↔
 ∃ order, List.Perm order carrier ∧ comparison order=true := by
 constructor
 · intro found
   obtain ⟨order,held,passed⟩ := (anyTrueWitness _ _).mp found
   exact ⟨order,everyArrangementPermutesCarrier carrier unique order held,passed⟩
 · intro found
   obtain ⟨order,perm,passed⟩ := found
   exact (anyTrueWitness _ _).mpr
    ⟨order,everyPermutationGenerated carrier nonempty unique order perm,passed⟩

theorem noSuperpositionExactly (carrier : List String)
 (nonempty : carrier≠[]) (unique : distinct carrier=true)
 (comparison : List String → Bool) :
 superposable carrier comparison=false ↔
 ∀ order, List.Perm order carrier → comparison order=false := by
 constructor
 · intro rejected order perm
   cases h : comparison order with
   | false => rfl
   | true =>
     have accepted := (exhaustiveSuperposition carrier nonempty unique comparison).mpr ⟨order,perm,h⟩
     rw [rejected] at accepted
     cases accepted
 · intro every
   cases h : superposable carrier comparison with
   | false => rfl
   | true =>
     obtain ⟨order,perm,passed⟩ := (exhaustiveSuperposition carrier nonempty unique comparison).mp h
     rw [every order perm] at passed
     cases passed

-- The explicit orientation reflection is also used by pinned
-- coordination_isomerism_law_v1._mirror: EmptyOne is retained and the
-- two held Fold fibre labels are exchanged. Other labels are retained.
inductive OrientationCell where
 | emptyOne
 | held (label : HeldLabel)


def reflectLabel (x : HeldLabel) : HeldLabel :=
 if x.label="fibre-one" then ⟨x.family,"fibre-two",x.familyHeld,rfl⟩
 else if x.label="fibre-two" then ⟨x.family,"fibre-one",x.familyHeld,rfl⟩
 else x

def reflectCell : OrientationCell → OrientationCell
 | .emptyOne => .emptyOne
 | .held x => .held (reflectLabel x)

theorem reflectLabelFamily (x : HeldLabel) : (reflectLabel x).family=x.family := by
 unfold reflectLabel
 split <;> first | rfl | (split <;> rfl)

theorem reflectLabelTwice (x : HeldLabel) : reflectLabel (reflectLabel x)=x := by
 cases x with
 | mk family label hf hl =>
   by_cases first : label="fibre-one"
   · cases first; rfl
   · by_cases second : label="fibre-two"
     · cases second; rfl
     · unfold reflectLabel
       rw [ite_eq_right first,ite_eq_right second,ite_eq_right first,ite_eq_right second]

theorem reflectCellTwice (x : OrientationCell) : reflectCell (reflectCell x)=x := by
 cases x with
 | emptyOne => rfl
 | held x => exact congrArg OrientationCell.held (reflectLabelTwice x)

abbrev OrientationWord := OrientationCell × OrientationCell × OrientationCell

def reflectWord (w : OrientationWord) : OrientationWord :=
 (reflectCell w.1,reflectCell w.2.1,reflectCell w.2.2)

theorem reflectWordTwice (w : OrientationWord) : reflectWord (reflectWord w)=w := by
 cases w with
 | mk a rest =>
   cases rest with
   | mk b c =>
     change (reflectCell (reflectCell a),reflectCell (reflectCell b),reflectCell (reflectCell c))=(a,b,c)
     rw [reflectCellTwice,reflectCellTwice,reflectCellTwice]

-- Full constituent fields of the source reflection; admission of a molecular
-- object is separate from this operation and is not replaced by a new guard.
structure OrientedForm where
 composition : List HeldLabel
 attachments : List HeldLabel
 orientations : List OrientationWord
 adjacency : List (PositiveCount × PositiveCount)


def reflectForm (f : OrientedForm) : OrientedForm :=
 {f with orientations := f.orientations.map reflectWord}

theorem reflectionRetainsComposition (f : OrientedForm) :
 (reflectForm f).composition=f.composition := rfl

theorem reflectionRetainsAttachments (f : OrientedForm) :
 (reflectForm f).attachments=f.attachments := rfl

theorem reflectionRetainsAdjacency (f : OrientedForm) :
 (reflectForm f).adjacency=f.adjacency := rfl

theorem reflectionRetainsSupport (f : OrientedForm) :
 (reflectForm f).orientations.length=f.orientations.length :=
 SFT.Foundation.CommonRefinement.mapLength reflectWord _

theorem reflectedWordsTwice (ws : List OrientationWord) :
 (ws.map reflectWord).map reflectWord=ws := by
 induction ws with
 | nil => rfl
 | cons w ws ih =>
   change reflectWord (reflectWord w)::((ws.map reflectWord).map reflectWord)=w::ws
   rw [reflectWordTwice,ih]

theorem reflectionTwice (f : OrientedForm) : reflectForm (reflectForm f)=f := by
 cases f with
 | mk c a o e =>
   change OrientedForm.mk c a ((o.map reflectWord).map reflectWord) e=OrientedForm.mk c a o e
   rw [reflectedWordsTwice]

def appendBranch (f : OrientedForm) (c a : HeldLabel) (o : OrientationWord)
 (newEdges : List (PositiveCount × PositiveCount)) : OrientedForm :=
 ⟨f.composition++[c],f.attachments++[a],f.orientations++[o],f.adjacency++newEdges⟩

theorem reflectionCommutesWithBranch (f : OrientedForm) (c a : HeldLabel)
 (o : OrientationWord) (newEdges : List (PositiveCount × PositiveCount)) :
 reflectForm (appendBranch f c a o newEdges)=
 appendBranch (reflectForm f) c a (reflectWord o) newEdges := by
 unfold reflectForm appendBranch
 rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend]
 rfl

-- An exact, nonempty reflected base orientation is built from the source fibres.
def firstFibre : HeldLabel := ⟨"fold-orientation-fibre","fibre-one",rfl,rfl⟩
def secondFibre : HeldLabel := ⟨"fold-orientation-fibre","fibre-two",rfl,rfl⟩
def baseOrientation : OrientationWord := (.held firstFibre,.emptyOne,.emptyOne)

theorem baseReflection : reflectWord baseOrientation=
 (.held secondFibre,.emptyOne,.emptyOne) := rfl

theorem baseOrientationDistinguished : baseOrientation≠reflectWord baseOrientation := by
 intro h
 have cell := congrArg (fun w : OrientationWord => w.1) h
 have label := OrientationCell.held.inj cell
 have impossible := congrArg (fun x : HeldLabel => x.label) label
 exact (by decide : "fibre-one"≠"fibre-two") impossible

-- Molecular geometry supplies occurrence names, identity-preserving atom/bond
-- maps and held relative orientation. No visual/coordinate tolerance is used.
structure OrientedMolecule where
 carrier : MolecularCarrier.Raw
 orientations : List (String × OrientationWord)

def wordAt (name : String) : List (String × OrientationWord) → Option OrientationWord
 | [] => none
 | row::rest => if name=row.1 then some row.2 else wordAt name rest

def mirrorMolecule (m : OrientedMolecule) : OrientedMolecule :=
 ⟨m.carrier,m.orientations.map (fun row => (row.1,reflectWord row.2))⟩

def cellEqual : OrientationCell → OrientationCell → Bool
 | .emptyOne,.emptyOne => true
 | .held a,.held b => decide (a.family=b.family) && decide (a.label=b.label)
 | .emptyOne,.held _ => false
 | .held _,.emptyOne => false

def wordEqual (a b : OrientationWord) : Bool :=
 cellEqual a.1 b.1 && cellEqual a.2.1 b.2.1 && cellEqual a.2.2 b.2.2

theorem heldLabelEquality (a b : HeldLabel) (family : a.family=b.family)
 (label : a.label=b.label) : a=b := by
 cases a with
 | mk af al ahf ahl =>
   cases b with
   | mk bf bl bhf bhl =>
     cases family
     cases label
     rfl

theorem cellEqualMeaning (a b : OrientationCell) : cellEqual a b=true ↔ a=b := by
 cases a with
 | emptyOne =>
   cases b with
   | emptyOne => exact ⟨fun _ => rfl,fun _ => rfl⟩
   | held b => constructor <;> intro h <;> cases h
 | held a =>
   cases b with
   | emptyOne => constructor <;> intro h <;> cases h
   | held b =>
     constructor
     · intro h
       have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp h
       exact congrArg OrientationCell.held
        (heldLabelEquality a b (of_decide_eq_true both.1) (of_decide_eq_true both.2))
     · intro h
       have same := OrientationCell.held.inj h
       cases same
       exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
        ⟨decide_eq_true rfl,decide_eq_true rfl⟩

theorem wordEqualMeaning (a b : OrientationWord) : wordEqual a b=true ↔ a=b := by
 constructor
 · intro h
   have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp h
   have first := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp both.1
   have x := (cellEqualMeaning _ _).mp first.1
   have y := (cellEqualMeaning _ _).mp first.2
   have z := (cellEqualMeaning _ _).mp both.2
   cases a with
   | mk aa ar =>
     cases ar with
     | mk ab ac =>
       cases b with
       | mk ba br =>
         cases br with
         | mk bb bc =>
           cases x; cases y; cases z; rfl
 · intro h
   cases h
   exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
    ⟨(SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
      ⟨(cellEqualMeaning _ _).mpr rfl,(cellEqualMeaning _ _).mpr rfl⟩,
     (cellEqualMeaning _ _).mpr rfl⟩

def orientationMatches (left right : OrientedMolecule) (order : List String) : Bool :=
 left.carrier.occurrences.all (fun name =>
  match wordAt name left.orientations,
    wordAt (MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order)) right.orientations with
  | some a,some b => wordEqual a b
  | none,none => false
  | none,some _ => false
  | some _,none => false)

def properMatches (left right : OrientedMolecule) (order : List String) : Bool :=
 MolecularIsomer.candidateMatches left.carrier right.carrier order && orientationMatches left right order

def hasProperSuperposition (left right : OrientedMolecule) : Bool :=
 decide (MolecularCarrier.compositionSignature left.carrier=MolecularCarrier.compositionSignature right.carrier) &&
 superposable right.carrier.occurrences (properMatches left right)

def chiral (m : OrientedMolecule) : Bool := !hasProperSuperposition m (mirrorMolecule m)

theorem properMatchRetainsConstitution (left right : OrientedMolecule) (order : List String)
 (h : properMatches left right order=true) :
 MolecularIsomer.respectsElements left.carrier right.carrier order=true ∧
 (∀ edge ∈ MolecularIsomer.mappedEdges left.carrier order, edge ∈ MolecularIsomer.edgeSet right.carrier) ∧
 (∀ edge ∈ MolecularIsomer.edgeSet right.carrier, edge ∈ MolecularIsomer.mappedEdges left.carrier order) :=
 (MolecularIsomer.candidateMeaning _ _ _).mp
  ((SFT.Mathematics.GeometryTopology.andTrue _ _).mp h).1

theorem properMatchRetainsOrientation (left right : OrientedMolecule) (order : List String)
 (h : properMatches left right order=true) : orientationMatches left right order=true :=
 ((SFT.Mathematics.GeometryTopology.andTrue _ _).mp h).2

theorem mirrorRetainsMolecularCarrier (m : OrientedMolecule) :
 (mirrorMolecule m).carrier=m.carrier := rfl

theorem mirroredLookup (name : String) (rows : List (String × OrientationWord)) :
 wordAt name (rows.map (fun row => (row.1,reflectWord row.2)))=
 (wordAt name rows).map reflectWord := by
 induction rows with
 | nil => rfl
 | cons row rows ih =>
   change (if name=row.1 then some (reflectWord row.2) else
    wordAt name (rows.map (fun row => (row.1,reflectWord row.2))))=
    (if name=row.1 then some row.2 else wordAt name rows).map reflectWord
   by_cases equal : name=row.1
   · rw [ite_eq_left equal,ite_eq_left equal]; rfl
   · rw [ite_eq_right equal,ite_eq_right equal]; exact ih

theorem mirroredRowsTwice (rows : List (String × OrientationWord)) :
 (rows.map (fun row => (row.1,reflectWord row.2))).map (fun row => (row.1,reflectWord row.2))=rows := by
 induction rows with
 | nil => rfl
 | cons row rows ih =>
   change (row.1,reflectWord (reflectWord row.2))::
    ((rows.map (fun row => (row.1,reflectWord row.2))).map (fun row => (row.1,reflectWord row.2)))=row::rows
   rw [reflectWordTwice,ih]

theorem mirrorMoleculeTwice (m : OrientedMolecule) : mirrorMolecule (mirrorMolecule m)=m := by
 cases m with
 | mk carrier rows =>
   change OrientedMolecule.mk carrier
    ((rows.map (fun row => (row.1,reflectWord row.2))).map (fun row => (row.1,reflectWord row.2)))=
    OrientedMolecule.mk carrier rows
   rw [mirroredRowsTwice]

theorem chiralityExactlyAllProperMapsFail (m : OrientedMolecule)
 (nonempty : m.carrier.occurrences≠[]) (unique : distinct m.carrier.occurrences=true) :
 chiral m=true ↔ ∀ order, List.Perm order m.carrier.occurrences →
 properMatches m (mirrorMolecule m) order=false := by
 have same : decide (MolecularCarrier.compositionSignature m.carrier=
  MolecularCarrier.compositionSignature (mirrorMolecule m).carrier)=true := decide_eq_true rfl
 unfold chiral hasProperSuperposition
 rw [same]
 change (!superposable m.carrier.occurrences (properMatches m (mirrorMolecule m)))=true ↔ _
 constructor
 · intro h
   apply (noSuperpositionExactly _ nonempty unique _).mp
   cases v : superposable m.carrier.occurrences (properMatches m (mirrorMolecule m))
   · rfl
   · rw [v] at h; cases h
 · intro h
   rw [(noSuperpositionExactly _ nonempty unique _).mpr h]
   rfl

def baseMolecule : OrientedMolecule :=
 ⟨⟨["a","b"],["first","second"],[("a","b")],[]⟩,
 [("a",baseOrientation),("b",baseOrientation)]⟩

theorem baseOrders : arrangementsCore ["a","b"]=[["a","b"],["b","a"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["b"]).map (List.cons "a") ++
  ((arrangementsCore ["a"]).map (List.cons "b") ++ [])=[["a","b"],["b","a"]]
 rw [arrangementsSingle,arrangementsSingle]
 rfl

theorem baseChiral : chiral baseMolecule=true := by
 unfold chiral hasProperSuperposition superposable
 change (!(true && (arrangementsCore ["a","b"]).any (properMatches baseMolecule (mirrorMolecule baseMolecule))))=true
 rw [baseOrders]
 rfl

theorem baseEveryProperMapFails : ∀ order, List.Perm order baseMolecule.carrier.occurrences →
 properMatches baseMolecule (mirrorMolecule baseMolecule) order=false :=
 (chiralityExactlyAllProperMapsFail baseMolecule (by intro h; cases h) (by decide)).mp baseChiral

-- The unique new occurrence extends the complete map census. Restriction is
-- deletion of that occurrence, not selection of a favored old mapping.
theorem appendFreshPermutation (nodes : List String) (fresh : String) :
 List.Perm (nodes++[fresh]) (fresh::nodes) := by
 induction nodes with
 | nil => exact List.Perm.refl _
 | cons n ns ih => exact (List.Perm.cons n ih).trans (List.Perm.swap fresh n ns)

theorem appendFreshDistinct (nodes : List String) (fresh : String)
 (unique : distinct nodes=true) (absent : ¬fresh∈nodes) : distinct (nodes++[fresh])=true :=
 permutationDistinct (appendFreshPermutation nodes fresh).symm
  ((distinctCons fresh nodes).mpr ⟨(absentIff nodes fresh).mpr absent,unique⟩)

theorem appendFreshRemoved (nodes : List String) (fresh : String)
 (absent : ¬fresh∈nodes) : remainder (nodes++[fresh]) fresh=nodes := by
 induction nodes with
 | nil => change (if fresh=fresh then [] else [fresh])=[]; rw [ite_eq_left rfl]
 | cons n ns ih =>
   have unequal : n≠fresh := by intro same; cases same; exact absent (.head _)
   have tailAbsent : ¬fresh∈ns := fun h => absent (.tail _ h)
   change (if n=fresh then remainder (ns++[fresh]) fresh else n::remainder (ns++[fresh]) fresh)=n::ns
   rw [ite_eq_right unequal,ih tailAbsent]

theorem everyExtendedMapRestricts (nodes : List String) (fresh : String)
 (absent : ¬fresh∈nodes) (order : List String)
 (perm : List.Perm order (nodes++[fresh])) : List.Perm (remainder order fresh) nodes := by
 have reduced := remainderPermutationPreserved perm fresh
 rw [appendFreshRemoved nodes fresh absent] at reduced
 exact reduced

theorem everyOldMapHasGeneratedExtension (nodes : List String) (fresh : String)
 (unique : distinct nodes=true) (absent : ¬fresh∈nodes)
 (order : List String) (perm : List.Perm order nodes) :
 fresh::order ∈ arrangementsCore (nodes++[fresh]) := by
 apply everyPermutationGenerated (nodes++[fresh])
 · intro empty
   have held : fresh∈nodes++[fresh] := SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head [])
   rw [empty] at held
   cases held
 · exact appendFreshDistinct nodes fresh unique absent
 · exact (List.Perm.cons fresh perm).trans (appendFreshPermutation nodes fresh).symm

theorem everyGeneratedExtensionRestrictsToOldCensus (nodes : List String) (fresh : String)
 (nonempty : nodes≠[]) (unique : distinct nodes=true) (absent : ¬fresh∈nodes)
 (order : List String) (held : order∈arrangementsCore (nodes++[fresh])) :
 remainder order fresh∈arrangementsCore nodes :=
 everyPermutationGenerated nodes nonempty unique _
  (everyExtendedMapRestricts nodes fresh absent order
   (everyArrangementPermutesCarrier _ (appendFreshDistinct nodes fresh unique absent) _ held))

-- Append one named oriented branch, retaining the complete previous records.
def appendMolecularBranch (m : OrientedMolecule) (fresh element : String)
 (orientation : OrientationWord) (links : List String) : OrientedMolecule :=
 ⟨⟨m.carrier.occurrences++[fresh],m.carrier.elements++[element],
    m.carrier.bonds++links.map (fun old => (old,fresh)),m.carrier.openChargeFibres⟩,
   m.orientations++[(fresh,orientation)]⟩

theorem molecularBranchReflection (m : OrientedMolecule) (fresh element : String)
 (orientation : OrientationWord) (links : List String) :
 mirrorMolecule (appendMolecularBranch m fresh element orientation links)=
 appendMolecularBranch (mirrorMolecule m) fresh element (reflectWord orientation) links := by
 unfold mirrorMolecule appendMolecularBranch
 rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend]
 rfl

theorem branchRetainsOldAtom (m : OrientedMolecule) (fresh element name : String)
 (orientation : OrientationWord) (links : List String) (held : name∈m.carrier.occurrences) :
 name∈(appendMolecularBranch m fresh element orientation links).carrier.occurrences :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem branchRetainsOldBond (m : OrientedMolecule) (fresh element : String)
 (orientation : OrientationWord) (links : List String) (edge : Edge) (held : edge∈m.carrier.bonds) :
 edge∈(appendMolecularBranch m fresh element orientation links).carrier.bonds :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem wordAtFreshAppendOther (rows : List (String × OrientationWord))
 (name fresh : String) (word : OrientationWord) (different : name≠fresh) :
 wordAt name (rows++[(fresh,word)])=wordAt name rows := by
 induction rows with
 | nil => change (if name=fresh then some word else none)=none; rw [ite_eq_right different]
 | cons row rows ih =>
   change (if name=row.1 then some row.2 else wordAt name (rows++[(fresh,word)]))=
    (if name=row.1 then some row.2 else wordAt name rows)
   by_cases equal : name=row.1
   · rw [ite_eq_left equal,ite_eq_left equal]
   · rw [ite_eq_right equal,ite_eq_right equal,ih]

theorem branchRetainsOldOrientation (m : OrientedMolecule) (fresh element name : String)
 (orientation : OrientationWord) (links : List String) (different : name≠fresh) :
 wordAt name (appendMolecularBranch m fresh element orientation links).orientations=
 wordAt name m.orientations := wordAtFreshAppendOther _ _ _ _ different

theorem lookupFreshAppendOther (rows : List (String × String)) (name fresh target : String)
 (different : name≠fresh) :
 MolecularIsomer.lookup name (rows++[(fresh,target)])=MolecularIsomer.lookup name rows := by
 induction rows with
 | nil => change (if name=fresh then target else "")=""; rw [ite_eq_right different]
 | cons row rows ih =>
   change (if name=row.1 then row.2 else MolecularIsomer.lookup name (rows++[(fresh,target)]))=
    (if name=row.1 then row.2 else MolecularIsomer.lookup name rows)
   by_cases equal : name=row.1
   · rw [ite_eq_left equal,ite_eq_left equal]
   · rw [ite_eq_right equal,ite_eq_right equal,ih]

theorem zipAppendPair (names values : List String) (sameLength : names.length=values.length)
 (name value : String) :
 (names++[name]).zip (values++[value])=names.zip values++[(name,value)] := by
 induction names generalizing values with
 | nil =>
   cases values with
   | nil => rfl
   | cons a rest => cases sameLength
 | cons a rest ih =>
   cases values with
   | nil => cases sameLength
   | cons b tail =>
     change (a,b)::((rest++[name]).zip (tail++[value]))=(a,b)::(rest.zip tail++[(name,value)])
     exact congrArg (List.cons (a,b)) (ih tail (Nat.succ.inj sameLength))

theorem lookupZippedMember (names targets : List String)
 (sameLength : names.length=targets.length) (name : String) (held : name∈names) :
 MolecularIsomer.lookup name (names.zip targets)∈targets := by
 induction names generalizing targets with
 | nil => cases held
 | cons a rest ih =>
   cases targets with
   | nil => cases sameLength
   | cons b tail =>
     change (if name=a then b else MolecularIsomer.lookup name (rest.zip tail))∈b::tail
     by_cases equal : name=a
     · rw [ite_eq_left equal]; exact .head _
     · rw [ite_eq_right equal]
       apply List.Mem.tail
       apply ih tail (Nat.succ.inj sameLength)
       cases held with
       | head => exact False.elim (equal rfl)
       | tail _ h => exact h

theorem extendedMappingAtOldName (m : OrientedMolecule) (fresh element name : String)
 (orientation : OrientationWord) (links order : List String)
 (sameLength : m.carrier.occurrences.length=order.length) (different : name≠fresh) :
 MolecularIsomer.lookup name
  (MolecularIsomer.mapping (appendMolecularBranch m fresh element orientation links).carrier (order++[fresh]))=
 MolecularIsomer.lookup name (MolecularIsomer.mapping m.carrier order) := by
 change MolecularIsomer.lookup name ((m.carrier.occurrences++[fresh]).zip (order++[fresh]))=
  MolecularIsomer.lookup name (m.carrier.occurrences.zip order)
 rw [zipAppendPair _ _ sameLength,lookupFreshAppendOther _ _ _ _ different]

theorem mapPermutationLength {a b : List String} (p : List.Perm a b) : a.length=b.length := by
 induction p with
 | nil => rfl
 | cons x p ih => exact congrArg Nat.succ ih
 | swap x y rest => rfl
 | trans p q ih jh => exact ih.trans jh

theorem alignedBranchOrientationRestricts (left right : OrientedMolecule)
 (fresh element : String) (lo ro : OrientationWord) (ll rl order : List String)
 (leftFresh : ¬fresh∈left.carrier.occurrences) (rightFresh : ¬fresh∈right.carrier.occurrences)
 (lengths : left.carrier.occurrences.length=right.carrier.occurrences.length)
 (perm : List.Perm order right.carrier.occurrences)
 (matched : orientationMatches (appendMolecularBranch left fresh element lo ll)
  (appendMolecularBranch right fresh element ro rl) (order++[fresh])=true) :
 orientationMatches left right order=true := by
 apply (allTrueIffMembers _ _).mpr
 intro name held
 have nameDifferent : name≠fresh := by intro same; cases same; exact leftFresh held
 have size : left.carrier.occurrences.length=order.length := lengths.trans (mapPermutationLength perm).symm
 have targetHeld := lookupZippedMember left.carrier.occurrences order size name held
 have targetOriginal := permutationMember perm _ targetHeld
 have targetDifferent : MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order)≠fresh := by
   intro same
   change MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order)∈right.carrier.occurrences at targetOriginal
   rw [same] at targetOriginal
   exact rightFresh targetOriginal
 have passed := SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ matched name
  (branchRetainsOldAtom left fresh element name lo ll held)
 change (match wordAt name (appendMolecularBranch left fresh element lo ll).orientations,
  wordAt (MolecularIsomer.lookup name (MolecularIsomer.mapping
   (appendMolecularBranch left fresh element lo ll).carrier (order++[fresh])))
   (appendMolecularBranch right fresh element ro rl).orientations with
  | some a,some b => wordEqual a b
  | none,none => false
  | none,some _ => false
  | some _,none => false)=true at passed
 rw [extendedMappingAtOldName _ _ _ _ _ _ _ size nameDifferent,
  branchRetainsOldOrientation _ _ _ _ _ _ nameDifferent,
  branchRetainsOldOrientation _ _ _ _ _ _ targetDifferent] at passed
 exact passed

theorem alignedBranchElementsRestrict (left right : OrientedMolecule)
 (fresh element : String) (lo ro : OrientationWord) (ll rl order : List String)
 (leftFresh : ¬fresh∈left.carrier.occurrences) (rightFresh : ¬fresh∈right.carrier.occurrences)
 (leftWidth : left.carrier.occurrences.length=left.carrier.elements.length)
 (rightWidth : right.carrier.occurrences.length=right.carrier.elements.length)
 (lengths : left.carrier.occurrences.length=right.carrier.occurrences.length)
 (perm : List.Perm order right.carrier.occurrences)
 (matched : MolecularIsomer.respectsElements (appendMolecularBranch left fresh element lo ll).carrier
  (appendMolecularBranch right fresh element ro rl).carrier (order++[fresh])=true) :
 MolecularIsomer.respectsElements left.carrier right.carrier order=true := by
 apply (allTrueIffMembers _ _).mpr
 intro name held
 have nameDifferent : name≠fresh := by intro same; cases same; exact leftFresh held
 have size : left.carrier.occurrences.length=order.length := lengths.trans (mapPermutationLength perm).symm
 have targetOriginal := permutationMember perm _
  (lookupZippedMember left.carrier.occurrences order size name held)
 have targetDifferent : MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order)≠fresh := by
   intro same
   change MolecularIsomer.lookup name (MolecularIsomer.mapping left.carrier order)∈right.carrier.occurrences at targetOriginal
   rw [same] at targetOriginal
   exact rightFresh targetOriginal
 have passed := SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ matched name
  (branchRetainsOldAtom left fresh element name lo ll held)
 change decide (MolecularIsomer.lookup name
  ((left.carrier.occurrences++[fresh]).zip (left.carrier.elements++[element]))=
  MolecularIsomer.lookup (MolecularIsomer.lookup name
   (MolecularIsomer.mapping (appendMolecularBranch left fresh element lo ll).carrier (order++[fresh])))
   ((right.carrier.occurrences++[fresh]).zip (right.carrier.elements++[element])))=true at passed
 rw [extendedMappingAtOldName _ _ _ _ _ _ _ size nameDifferent,
  zipAppendPair _ _ leftWidth,zipAppendPair _ _ rightWidth,
  lookupFreshAppendOther _ _ _ _ nameDifferent,
  lookupFreshAppendOther _ _ _ _ targetDifferent] at passed
 exact passed

theorem alignedOrientationFailurePreserved (left right : OrientedMolecule)
 (fresh element : String) (lo ro : OrientationWord) (ll rl order : List String)
 (leftFresh : ¬fresh∈left.carrier.occurrences) (rightFresh : ¬fresh∈right.carrier.occurrences)
 (lengths : left.carrier.occurrences.length=right.carrier.occurrences.length)
 (perm : List.Perm order right.carrier.occurrences)
 (failed : orientationMatches left right order=false) :
 properMatches (appendMolecularBranch left fresh element lo ll)
  (appendMolecularBranch right fresh element ro rl) (order++[fresh])=false := by
 cases h : properMatches (appendMolecularBranch left fresh element lo ll)
  (appendMolecularBranch right fresh element ro rl) (order++[fresh]) with
 | false => rfl
 | true =>
   have original := alignedBranchOrientationRestricts left right fresh element lo ro ll rl order
    leftFresh rightFresh lengths perm (properMatchRetainsOrientation _ _ _ h)
   rw [failed] at original
   cases original

theorem alignedElementFailurePreserved (left right : OrientedMolecule)
 (fresh element : String) (lo ro : OrientationWord) (ll rl order : List String)
 (leftFresh : ¬fresh∈left.carrier.occurrences) (rightFresh : ¬fresh∈right.carrier.occurrences)
 (leftWidth : left.carrier.occurrences.length=left.carrier.elements.length)
 (rightWidth : right.carrier.occurrences.length=right.carrier.elements.length)
 (lengths : left.carrier.occurrences.length=right.carrier.occurrences.length)
 (perm : List.Perm order right.carrier.occurrences)
 (failed : MolecularIsomer.respectsElements left.carrier right.carrier order=false) :
 properMatches (appendMolecularBranch left fresh element lo ll)
  (appendMolecularBranch right fresh element ro rl) (order++[fresh])=false := by
 cases h : properMatches (appendMolecularBranch left fresh element lo ll)
  (appendMolecularBranch right fresh element ro rl) (order++[fresh]) with
 | false => rfl
 | true =>
   have original := alignedBranchElementsRestrict left right fresh element lo ro ll rl order
    leftFresh rightFresh leftWidth rightWidth lengths perm
    (properMatchRetainsConstitution _ _ _ h).1
   rw [failed] at original
   cases original

theorem singleBranchUsesExistingAppend (m : OrientedMolecule) (fresh element anchor : String)
 (orientation : OrientationWord) :
 (appendMolecularBranch m fresh element orientation [anchor]).carrier=
 MolecularCarrier.appendOccurrence m.carrier fresh element anchor := rfl

def avoids (name : String) (edge : Edge) : Prop := edge.1≠name ∧ edge.2≠name

theorem normalizedAvoids (name : String) (edge : Edge) :
 avoids name (MolecularCarrier.normalizedEdge edge) ↔ avoids name edge := by
 unfold MolecularCarrier.normalizedEdge
 split
 · exact ⟨fun h => h,fun h => h⟩
 · exact ⟨fun h => ⟨h.2,h.1⟩,fun h => ⟨h.2,h.1⟩⟩

theorem edgeSetWitness (m : MolecularCarrier.Raw) (edge : Edge) :
 edge∈MolecularIsomer.edgeSet m ↔
 ∃ original∈m.bonds, MolecularCarrier.normalizedEdge original=edge := by
 constructor
 · intro held
   exact SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _
    ((MolecularGeometry.uniqueMeaning _ _).mp held)
 · intro witness
   obtain ⟨original,held,equal⟩ := witness
   exact (MolecularGeometry.uniqueMeaning _ _).mpr
    (equal ▸ SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held)

theorem branchEdgeSetRestricts (m : OrientedMolecule) (fresh element : String)
 (orientation : OrientationWord) (links : List String) (edge : Edge) (away : avoids fresh edge) :
 edge∈MolecularIsomer.edgeSet (appendMolecularBranch m fresh element orientation links).carrier ↔
 edge∈MolecularIsomer.edgeSet m.carrier := by
 constructor
 · intro held
   obtain ⟨original,member,equal⟩ := (edgeSetWitness _ _).mp held
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases original m.carrier.bonds
    (links.map (fun old => (old,fresh))) member with
   | inl old => exact (edgeSetWitness _ _).mpr ⟨original,old,equal⟩
   | inr added =>
     obtain ⟨anchor,_,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ added
     cases same
     have noFresh := (normalizedAvoids fresh (anchor,fresh)).mp (equal ▸ away)
     exact False.elim (noFresh.2 rfl)
 · intro held
   obtain ⟨original,member,equal⟩ := (edgeSetWitness _ _).mp held
   exact (edgeSetWitness _ _).mpr
    ⟨original,SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ member,equal⟩

theorem edgeSetEndpoints (m : MolecularCarrier.Raw)
 (covered : ∀ edge∈m.bonds, edge.1∈m.occurrences ∧ edge.2∈m.occurrences)
 (edge : Edge) (held : edge∈MolecularIsomer.edgeSet m) :
 edge.1∈m.occurrences ∧ edge.2∈m.occurrences := by
 obtain ⟨original,member,equal⟩ := (edgeSetWitness _ _).mp held
 have endpoints := covered original member
 rw [←equal]
 unfold MolecularCarrier.normalizedEdge
 split
 · exact endpoints
 · exact ⟨endpoints.2,endpoints.1⟩

theorem branchOldEdgesAvoidFresh (m : MolecularCarrier.Raw) (fresh : String)
 (covered : ∀ edge∈m.bonds, edge.1∈m.occurrences ∧ edge.2∈m.occurrences)
 (absent : ¬fresh∈m.occurrences) (edge : Edge) (held : edge∈MolecularIsomer.edgeSet m) :
 avoids fresh edge := by
 have endpoints := edgeSetEndpoints m covered edge held
 exact ⟨fun h => absent (h ▸ endpoints.1),fun h => absent (h ▸ endpoints.2)⟩

theorem mappedOldEdgeAvoidsFresh (left right : OrientedMolecule) (fresh : String)
 (covered : ∀ edge∈left.carrier.bonds,
  edge.1∈left.carrier.occurrences ∧ edge.2∈left.carrier.occurrences)
 (rightFresh : ¬fresh∈right.carrier.occurrences)
 (lengths : left.carrier.occurrences.length=right.carrier.occurrences.length)
 (order : List String) (perm : List.Perm order right.carrier.occurrences)
 (edge : Edge) (held : edge∈MolecularIsomer.edgeSet left.carrier) :
 avoids fresh (MolecularCarrier.normalizedEdge
  (MolecularIsomer.lookup edge.1 (MolecularIsomer.mapping left.carrier order),
   MolecularIsomer.lookup edge.2 (MolecularIsomer.mapping left.carrier order))) := by
 have endpoints := edgeSetEndpoints left.carrier covered edge held
 have size := lengths.trans (mapPermutationLength perm).symm
 have first := permutationMember perm _ (lookupZippedMember _ _ size _ endpoints.1)
 have second := permutationMember perm _ (lookupZippedMember _ _ size _ endpoints.2)
 apply (normalizedAvoids fresh _).mpr
 exact ⟨fun h => rightFresh (h ▸ first),fun h => rightFresh (h ▸ second)⟩

theorem alignedBranchOldMappedEdgeRetained (left : OrientedMolecule)
 (fresh element : String) (orientation : OrientationWord) (links order : List String)
 (covered : ∀ edge∈left.carrier.bonds,
  edge.1∈left.carrier.occurrences ∧ edge.2∈left.carrier.occurrences)
 (absent : ¬fresh∈left.carrier.occurrences)
 (size : left.carrier.occurrences.length=order.length)
 (edge : Edge) (held : edge∈MolecularIsomer.edgeSet left.carrier) :
 MolecularCarrier.normalizedEdge
  (MolecularIsomer.lookup edge.1 (MolecularIsomer.mapping left.carrier order),
   MolecularIsomer.lookup edge.2 (MolecularIsomer.mapping left.carrier order))∈
 MolecularIsomer.mappedEdges (appendMolecularBranch left fresh element orientation links).carrier (order++[fresh]) := by
 have endpoints := edgeSetEndpoints left.carrier covered edge held
 have first : edge.1≠fresh := fun h => absent (h ▸ endpoints.1)
 have second : edge.2≠fresh := fun h => absent (h ▸ endpoints.2)
 have kept := (branchEdgeSetRestricts left fresh element orientation links edge ⟨first,second⟩).mpr held
 apply (MolecularGeometry.uniqueMeaning _ _).mpr
 have mapped := SFT.Foundation.Count.TraceDerivation.memMap
  (fun e => MolecularCarrier.normalizedEdge
   (MolecularIsomer.lookup e.1 (MolecularIsomer.mapping
    (appendMolecularBranch left fresh element orientation links).carrier (order++[fresh])),
    MolecularIsomer.lookup e.2 (MolecularIsomer.mapping
    (appendMolecularBranch left fresh element orientation links).carrier (order++[fresh])))) edge _ kept
 rw [extendedMappingAtOldName _ _ _ _ _ _ _ size first,
  extendedMappingAtOldName _ _ _ _ _ _ _ size second] at mapped
 exact mapped

theorem alignedBranchForwardBondsRestrict (left right : OrientedMolecule)
 (fresh element : String) (lo ro : OrientationWord) (ll rl order : List String)
 (covered : ∀ edge∈left.carrier.bonds,
  edge.1∈left.carrier.occurrences ∧ edge.2∈left.carrier.occurrences)
 (leftFresh : ¬fresh∈left.carrier.occurrences) (rightFresh : ¬fresh∈right.carrier.occurrences)
 (lengths : left.carrier.occurrences.length=right.carrier.occurrences.length)
 (perm : List.Perm order right.carrier.occurrences)
 (matched : properMatches (appendMolecularBranch left fresh element lo ll)
  (appendMolecularBranch right fresh element ro rl) (order++[fresh])=true) :
 ∀ edge∈MolecularIsomer.mappedEdges left.carrier order, edge∈MolecularIsomer.edgeSet right.carrier := by
 intro edge held
 obtain ⟨original,member,equal⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _
  ((MolecularGeometry.uniqueMeaning _ _).mp held)
 have avoid := mappedOldEdgeAvoidsFresh left right fresh covered rightFresh lengths order perm original member
 have extended := alignedBranchOldMappedEdgeRetained left fresh element lo ll order covered leftFresh
  (lengths.trans (mapPermutationLength perm).symm) original member
 have target := (properMatchRetainsConstitution _ _ _ matched).2.1 _ extended
 exact equal ▸ (branchEdgeSetRestricts right fresh element ro rl _ avoid).mp target

theorem freshMappedToFresh (names order : List String) (fresh : String)
 (size : names.length=order.length) (absent : ¬fresh∈names) :
 MolecularIsomer.lookup fresh ((names++[fresh]).zip (order++[fresh]))=fresh := by
 induction names generalizing order with
 | nil =>
   cases order with
   | nil => change (if fresh=fresh then fresh else "")=fresh; rw [ite_eq_left rfl]
   | cons a rest => cases size
 | cons a rest ih =>
   cases order with
   | nil => cases size
   | cons b tail =>
     have different : fresh≠a := by intro h; cases h; exact absent (.head _)
     change (if fresh=a then b else MolecularIsomer.lookup fresh
      ((rest++[fresh]).zip (tail++[fresh])))=fresh
     rw [ite_eq_right different]
     exact ih tail (Nat.succ.inj size) (fun h => absent (.tail _ h))

theorem alignedBranchMappedEdgeRestricts (left : OrientedMolecule)
 (fresh element : String) (orientation : OrientationWord) (links order : List String)
 (covered : ∀ edge∈left.carrier.bonds,
  edge.1∈left.carrier.occurrences ∧ edge.2∈left.carrier.occurrences)
 (absent : ¬fresh∈left.carrier.occurrences)
 (size : left.carrier.occurrences.length=order.length)
 (edge : Edge) (away : avoids fresh edge)
 (held : edge∈MolecularIsomer.mappedEdges
  (appendMolecularBranch left fresh element orientation links).carrier (order++[fresh])) :
 edge∈MolecularIsomer.mappedEdges left.carrier order := by
 obtain ⟨normalized,member,equal⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _
  ((MolecularGeometry.uniqueMeaning _ _).mp held)
 obtain ⟨original,originalHeld,normalizedEqual⟩ := (edgeSetWitness _ _).mp member
 cases SFT.Foundation.Count.TraceDerivation.memAppendCases original left.carrier.bonds
  (links.map (fun old => (old,fresh))) originalHeld with
 | inl old =>
   have normalizedOld : normalized∈MolecularIsomer.edgeSet left.carrier :=
    (edgeSetWitness _ _).mpr ⟨original,old,normalizedEqual⟩
   have endpoints := edgeSetEndpoints left.carrier covered normalized normalizedOld
   have first : normalized.1≠fresh := fun h => absent (h ▸ endpoints.1)
   have second : normalized.2≠fresh := fun h => absent (h ▸ endpoints.2)
   change MolecularCarrier.normalizedEdge
    (MolecularIsomer.lookup normalized.1 (MolecularIsomer.mapping
     (appendMolecularBranch left fresh element orientation links).carrier (order++[fresh])),
     MolecularIsomer.lookup normalized.2 (MolecularIsomer.mapping
     (appendMolecularBranch left fresh element orientation links).carrier (order++[fresh])))=edge at equal
   rw [extendedMappingAtOldName _ _ _ _ _ _ _ size first,
    extendedMappingAtOldName _ _ _ _ _ _ _ size second] at equal
   exact (MolecularGeometry.uniqueMeaning _ _).mpr
    (equal ▸ SFT.Foundation.Count.TraceDerivation.memMap _ _ _ normalizedOld)
 | inr added =>
   obtain ⟨anchor,_,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ added
   cases same
   have avoidsMapped := (normalizedAvoids fresh _).mp (equal ▸ away)
   have fixes : MolecularIsomer.lookup fresh (MolecularIsomer.mapping
    (appendMolecularBranch left fresh element orientation links).carrier (order++[fresh]))=fresh :=
    freshMappedToFresh left.carrier.occurrences order fresh size absent
   rw [←normalizedEqual] at avoidsMapped
   unfold MolecularCarrier.normalizedEdge at avoidsMapped
   split at avoidsMapped
   · exact False.elim (avoidsMapped.2 fixes)
   · exact False.elim (avoidsMapped.1 fixes)

theorem alignedBranchReverseBondsRestrict (left right : OrientedMolecule)
 (fresh element : String) (lo ro : OrientationWord) (ll rl order : List String)
 (leftCovered : ∀ edge∈left.carrier.bonds,
  edge.1∈left.carrier.occurrences ∧ edge.2∈left.carrier.occurrences)
 (rightCovered : ∀ edge∈right.carrier.bonds,
  edge.1∈right.carrier.occurrences ∧ edge.2∈right.carrier.occurrences)
 (leftFresh : ¬fresh∈left.carrier.occurrences) (rightFresh : ¬fresh∈right.carrier.occurrences)
 (lengths : left.carrier.occurrences.length=right.carrier.occurrences.length)
 (perm : List.Perm order right.carrier.occurrences)
 (matched : properMatches (appendMolecularBranch left fresh element lo ll)
  (appendMolecularBranch right fresh element ro rl) (order++[fresh])=true) :
 ∀ edge∈MolecularIsomer.edgeSet right.carrier, edge∈MolecularIsomer.mappedEdges left.carrier order := by
 intro edge held
 have away := branchOldEdgesAvoidFresh right.carrier fresh rightCovered rightFresh edge held
 have extended := (branchEdgeSetRestricts right fresh element ro rl edge away).mpr held
 exact alignedBranchMappedEdgeRestricts left fresh element lo ll order leftCovered leftFresh
  (lengths.trans (mapPermutationLength perm).symm) edge away
  ((properMatchRetainsConstitution _ _ _ matched).2.2 edge extended)

theorem lookupLastFreshValue (names values : List String) (fresh value : String)
 (size : names.length=values.length) (absent : ¬fresh∈names) :
 MolecularIsomer.lookup fresh ((names++[fresh]).zip (values++[value]))=value := by
 induction names generalizing values with
 | nil =>
   cases values with
   | nil => change (if fresh=fresh then value else "")=value; rw [ite_eq_left rfl]
   | cons a rest => cases size
 | cons a rest ih =>
   cases values with
   | nil => cases size
   | cons b tail =>
     have different : fresh≠a := by intro h; cases h; exact absent (.head _)
     change (if fresh=a then b else MolecularIsomer.lookup fresh
      ((rest++[fresh]).zip (tail++[value])))=value
     rw [ite_eq_right different]
     exact ih tail (Nat.succ.inj size) (fun h => absent (.tail _ h))

theorem uniqueBranchLabelForcesFixedName (left right : OrientedMolecule)
 (fresh element : String) (lo ro : OrientationWord) (ll rl order : List String)
 (leftFresh : ¬fresh∈left.carrier.occurrences) (rightFresh : ¬fresh∈right.carrier.occurrences)
 (leftWidth : left.carrier.occurrences.length=left.carrier.elements.length)
 (rightWidth : right.carrier.occurrences.length=right.carrier.elements.length)
 (uniqueLabel : ¬element∈right.carrier.elements)
 (lengths : left.carrier.occurrences.length=right.carrier.occurrences.length)
 (perm : List.Perm order (right.carrier.occurrences++[fresh]))
 (matched : MolecularIsomer.respectsElements (appendMolecularBranch left fresh element lo ll).carrier
  (appendMolecularBranch right fresh element ro rl).carrier order=true) :
 MolecularIsomer.lookup fresh (MolecularIsomer.mapping
  (appendMolecularBranch left fresh element lo ll).carrier order)=fresh := by
 let target := MolecularIsomer.lookup fresh (MolecularIsomer.mapping
  (appendMolecularBranch left fresh element lo ll).carrier order)
 have size : (left.carrier.occurrences++[fresh]).length=order.length := by
   rw [SFT.Foundation.CommonRefinement.appendLength]
   rw [(mapPermutationLength perm),SFT.Foundation.CommonRefinement.appendLength,lengths]
 have freshHeld : fresh∈left.carrier.occurrences++[fresh] :=
  SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head [])
 have targetHeld := permutationMember perm _
  (lookupZippedMember (left.carrier.occurrences++[fresh]) order size fresh freshHeld)
 have passed := SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ matched fresh freshHeld
 have equal := of_decide_eq_true passed
 change MolecularIsomer.lookup fresh
  ((left.carrier.occurrences++[fresh]).zip (left.carrier.elements++[element]))=
  MolecularIsomer.lookup target
  ((right.carrier.occurrences++[fresh]).zip (right.carrier.elements++[element])) at equal
 rw [lookupLastFreshValue _ _ _ _ leftWidth leftFresh] at equal
 cases SFT.Foundation.Count.TraceDerivation.memAppendCases target right.carrier.occurrences [fresh] targetHeld with
 | inl old =>
   have different : target≠fresh := fun h => rightFresh (h ▸ old)
   rw [zipAppendPair _ _ rightWidth,lookupFreshAppendOther _ _ _ _ different] at equal
   have valueHeld := lookupZippedMember right.carrier.occurrences right.carrier.elements rightWidth target old
   exact False.elim (uniqueLabel (equal ▸ valueHeld))
 | inr added =>
   have only : ∀ x : String, x∈[fresh] → x=fresh := by
     intro x member
     cases member with
     | head => rfl
     | tail _ impossible => cases impossible
   exact only target added

theorem fixedLastMappingSplits (names order : List String) (fresh : String)
 (absent : ¬fresh∈names) (size : (names++[fresh]).length=order.length)
 (fixed : MolecularIsomer.lookup fresh ((names++[fresh]).zip order)=fresh) :
 ∃ old, order=old++[fresh] := by
 induction names generalizing order with
 | nil =>
   cases order with
   | nil => cases size
   | cons first rest =>
     cases rest with
     | nil =>
       change (if fresh=fresh then first else "")=fresh at fixed
       rw [ite_eq_left rfl] at fixed
       exact ⟨[],congrArg (fun x => [x]) fixed⟩
     | cons next tail => exact False.elim (Nat.noConfusion (Nat.succ.inj size))
 | cons name names ih =>
   cases order with
   | nil => cases size
   | cons first rest =>
     have different : fresh≠name := by intro h; cases h; exact absent (.head _)
     change (if fresh=name then first else MolecularIsomer.lookup fresh ((names++[fresh]).zip rest))=fresh at fixed
     rw [ite_eq_right different] at fixed
     obtain ⟨old,equal⟩ := ih rest (fun h => absent (.tail _ h)) (Nat.succ.inj size) fixed
     exact ⟨first::old,congrArg (List.cons first) equal⟩

theorem fixedBranchMapRestrictsPermutation (nodes order : List String) (fresh : String)
 (unique : distinct nodes=true) (absent : ¬fresh∈nodes)
 (perm : List.Perm (order++[fresh]) (nodes++[fresh])) : List.Perm order nodes := by
 have distinctExtended := permutationDistinct perm.symm (appendFreshDistinct nodes fresh unique absent)
 have headDistinct := permutationDistinct (appendFreshPermutation order fresh) distinctExtended
 have absentOld := (absentIff order fresh).mp ((distinctCons fresh order).mp headDistinct).1
 have reduced := everyExtendedMapRestricts nodes fresh absent (order++[fresh]) perm
 rw [appendFreshRemoved order fresh absentOld] at reduced
 exact reduced

theorem uniqueBranchProperRestriction (left right : OrientedMolecule)
 (fresh element : String) (lo ro : OrientationWord) (ll rl order : List String)
 (leftFresh : ¬fresh∈left.carrier.occurrences) (rightFresh : ¬fresh∈right.carrier.occurrences)
 (leftWidth : left.carrier.occurrences.length=left.carrier.elements.length)
 (rightWidth : right.carrier.occurrences.length=right.carrier.elements.length)
 (leftCovered : ∀ edge∈left.carrier.bonds,
  edge.1∈left.carrier.occurrences ∧ edge.2∈left.carrier.occurrences)
 (rightCovered : ∀ edge∈right.carrier.bonds,
  edge.1∈right.carrier.occurrences ∧ edge.2∈right.carrier.occurrences)
 (uniqueLabel : ¬element∈right.carrier.elements)
 (uniqueNames : distinct right.carrier.occurrences=true)
 (lengths : left.carrier.occurrences.length=right.carrier.occurrences.length)
 (perm : List.Perm order (right.carrier.occurrences++[fresh]))
 (matched : properMatches (appendMolecularBranch left fresh element lo ll)
  (appendMolecularBranch right fresh element ro rl) order=true) :
 ∃ old, List.Perm old right.carrier.occurrences ∧ properMatches left right old=true := by
 have fixed := uniqueBranchLabelForcesFixedName left right fresh element lo ro ll rl order
  leftFresh rightFresh leftWidth rightWidth uniqueLabel lengths perm
  (properMatchRetainsConstitution _ _ _ matched).1
 have size : (left.carrier.occurrences++[fresh]).length=order.length := by
   rw [SFT.Foundation.CommonRefinement.appendLength,(mapPermutationLength perm),
    SFT.Foundation.CommonRefinement.appendLength,lengths]
 obtain ⟨old,equal⟩ := fixedLastMappingSplits left.carrier.occurrences order fresh leftFresh size fixed
 subst order
 have oldPerm := fixedBranchMapRestrictsPermutation right.carrier.occurrences old fresh uniqueNames rightFresh perm
 refine ⟨old,oldPerm,?_⟩
 apply (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
 constructor
 · apply (MolecularIsomer.candidateMeaning _ _ _).mpr
   exact ⟨alignedBranchElementsRestrict left right fresh element lo ro ll rl old leftFresh rightFresh
     leftWidth rightWidth lengths oldPerm (properMatchRetainsConstitution _ _ _ matched).1,
    alignedBranchForwardBondsRestrict left right fresh element lo ro ll rl old leftCovered leftFresh rightFresh
     lengths oldPerm matched,
    alignedBranchReverseBondsRestrict left right fresh element lo ro ll rl old leftCovered rightCovered
     leftFresh rightFresh lengths oldPerm matched⟩
 · exact alignedBranchOrientationRestricts left right fresh element lo ro ll rl old
    leftFresh rightFresh lengths oldPerm (properMatchRetainsOrientation _ _ _ matched)

theorem uniqueBranchPreservesChirality (m : OrientedMolecule) (fresh element : String)
 (orientation : OrientationWord) (links : List String)
 (nonempty : m.carrier.occurrences≠[]) (uniqueNames : distinct m.carrier.occurrences=true)
 (freshName : ¬fresh∈m.carrier.occurrences) (freshLabel : ¬element∈m.carrier.elements)
 (width : m.carrier.occurrences.length=m.carrier.elements.length)
 (covered : ∀ edge∈m.carrier.bonds,
  edge.1∈m.carrier.occurrences ∧ edge.2∈m.carrier.occurrences)
 (original : chiral m=true) :
 chiral (appendMolecularBranch m fresh element orientation links)=true := by
 have noOld := (chiralityExactlyAllProperMapsFail m nonempty uniqueNames).mp original
 apply (chiralityExactlyAllProperMapsFail (appendMolecularBranch m fresh element orientation links)
  (by
    intro empty
    have held : fresh∈m.carrier.occurrences++[fresh] :=
      SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head [])
    change m.carrier.occurrences++[fresh]=[] at empty
    rw [empty] at held
    cases held)
  (appendFreshDistinct m.carrier.occurrences fresh uniqueNames freshName)).mpr
 intro order perm
 rw [molecularBranchReflection]
 cases matched : properMatches (appendMolecularBranch m fresh element orientation links)
  (appendMolecularBranch (mirrorMolecule m) fresh element (reflectWord orientation) links) order with
 | false => rfl
 | true =>
   obtain ⟨old,oldPerm,oldMatch⟩ := uniqueBranchProperRestriction m (mirrorMolecule m)
    fresh element orientation (reflectWord orientation) links links order
    freshName freshName width width covered covered freshLabel uniqueNames rfl perm matched
   rw [noOld old oldPerm] at oldMatch
   cases oldMatch

def originalRaw : Raw :=
 ⟨[⟨2,by decide⟩,⟨1,by decide⟩],[(⟨1,by decide⟩,⟨2,by decide⟩)],
  ⟨"molecular-orientation","right",rfl,rfl⟩⟩

theorem originalRawAccepted : admit originalRaw=.ok originalRaw := rfl

theorem originalWitnesses : originalRaw.composition.length=2 ∧
 originalRaw.adjacency.length=1 ∧ originalRaw.orientation.family="molecular-orientation" := ⟨rfl,rfl,rfl⟩

theorem admittedMoleculeShape (m : OrientedMolecule)
 (accepted : MolecularCarrier.admit m.carrier=.ok m.carrier) :
 m.carrier.occurrences≠[] ∧ distinct m.carrier.occurrences=true ∧
 m.carrier.occurrences.length=m.carrier.elements.length := by
 have conditions := MolecularCarrier.acceptedConditions _ _ accepted
 have p1 := (SFT.Foundation.Count.Representation.orFalse _ _).mp conditions.1
 have p2 := (SFT.Foundation.Count.Representation.orFalse _ _).mp p1.1
 have p3 := (SFT.Foundation.Count.Representation.orFalse _ _).mp p2.1
 have p4 := (SFT.Foundation.Count.Representation.orFalse _ _).mp p3.1
 refine ⟨?_,?_,?_⟩
 · intro empty
   have connected := conditions.2.2.1
   unfold MolecularCarrier.connected at connected
   rw [empty] at connected
   cases connected
 · cases h : distinct m.carrier.occurrences with
   | true => rfl
   | false => rw [h] at p3; cases p3.2
 · by_cases same : m.carrier.occurrences.length=m.carrier.elements.length
   · exact same
   · have impossible := p4.2
     rw [decide_eq_true same] at impossible
     cases impossible

theorem admittedUniqueBranchPreservesChirality (m : OrientedMolecule)
 (accepted : MolecularCarrier.admit m.carrier=.ok m.carrier)
 (fresh element : String) (orientation : OrientationWord) (links : List String)
 (freshName : ¬fresh∈m.carrier.occurrences) (freshLabel : ¬element∈m.carrier.elements)
 (original : chiral m=true) : chiral (appendMolecularBranch m fresh element orientation links)=true := by
 have shape := admittedMoleculeShape m accepted
 exact uniqueBranchPreservesChirality m fresh element orientation links
  shape.1 shape.2.1 freshName freshLabel shape.2.2
  (MolecularCarrier.allConstituentEndpoints ⟨m.carrier,accepted⟩) original

end SFT.Chemistry.Chirality
