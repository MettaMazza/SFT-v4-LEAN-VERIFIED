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

end SFT.Chemistry.Chirality
