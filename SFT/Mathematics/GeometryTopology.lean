import SFT.Mathematics.GraphOperations
import SFT.Foundation.AssemblySets
namespace SFT.Mathematics.GeometryTopology
open DiscreteObjects AlgebraOperations SFT.Foundation.Count.TraceDerivation

abbrev Boundary := List (String × String)
abbrev OpenFamily := List (List String)

def incidenceWellFormed (cells : List String) (boundary : Boundary) : Bool :=
  !cells.isEmpty && distinct cells && distinct boundary &&
    boundary.all (fun edge => has cells edge.1 && has cells edge.2 && !decide (edge.1 = edge.2))

def faces (boundary : Boundary) (cell : String) : List String :=
  (boundary.filter (fun edge => decide (edge.2 = cell))).map Prod.fst

def adjacent (boundary : Boundary) (left right : String) : Bool :=
  !decide (left = right) && (faces boundary left).any (has (faces boundary right))

def normalizeOpen (points held : List String) : List String :=
  let result := points.filter (has held)
  if result.isEmpty then emptyOne else result

def canonicalOpens (points : List String) (opens : OpenFamily) : OpenFamily :=
  SFT.Foundation.AssemblySets.distinctWords (opens.map (normalizeOpen points))

def openUnion (points left right : List String) : List String :=
  let result := points.filter (fun point => has left point || has right point)
  if result.isEmpty then emptyOne else result

def openIntersection (points left right : List String) : List String :=
  let result := points.filter (fun point => has left point && has right point)
  if result.isEmpty then emptyOne else result

def finiteTopology (points : List String) (opens : OpenFamily) : Bool :=
  let canonical := canonicalOpens points opens
  !points.isEmpty && distinct points && decide (canonical.length = opens.length) &&
    has canonical emptyOne && has canonical points &&
    canonical.all (fun left => canonical.all (fun right =>
      has canonical (openUnion points left right) && has canonical (openIntersection points left right)))

/-! dict(mapping) retains the last row for each key, including repeated keys. -/
def image (mapping : List (String × String)) (point : String) : Option String :=
  match mapping with
  | [] => none
  | (key,value)::rest => match image rest point with
    | some result => some result
    | none => if key = point then some value else none

def inverseOpen (points : List String) (mapping : List (String × String)) (held : List String) : List String :=
  let result := points.filter (fun point => match image mapping point with
    | none => false
    | some value => has held value)
  if result.isEmpty then emptyOne else result

def continuous (points : List String) (sourceOpens targetOpens : OpenFamily)
    (mapping : List (String × String)) : Bool :=
  (mapping.map Prod.fst).all (has points) && points.all (has (mapping.map Prod.fst)) &&
    targetOpens.all (fun held => has sourceOpens (inverseOpen points mapping held))

theorem andTrue (a b : Bool) : (a && b) = true ↔ a = true ∧ b = true := by
  cases a <;> cases b <;> decide

theorem notTrue (b : Bool) : (!b) = true ↔ b = false := by
  cases b <;> constructor <;> intro h <;> first | rfl | cases h

theorem incidenceMeaning (cells : List String) (boundary : Boundary) :
    incidenceWellFormed cells boundary = true ↔
      cells.isEmpty = false ∧ distinct cells = true ∧ distinct boundary = true ∧
      ∀ edge, edge ∈ boundary → edge.1 ∈ cells ∧ edge.2 ∈ cells ∧ edge.1 ≠ edge.2 := by
  constructor
  · intro h
    have h1 := (andTrue _ _).mp h
    have h2 := (andTrue _ _).mp h1.1
    have h3 := (andTrue _ _).mp h2.1
    refine ⟨(notTrue _).mp h3.1,h3.2,h2.2,?_⟩
    intro edge member
    have h4 := (andTrue _ _).mp (allTrueAtMember _ _ h1.2 edge member)
    have h5 := (andTrue _ _).mp h4.1
    refine ⟨(hasIff _ _).mp h5.1,(hasIff _ _).mp h5.2,?_⟩
    intro eq
    have deq : decide (edge.1 = edge.2) = true := decide_eq_true eq
    rw [deq] at h4
    cases h4.2
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,h.2.1⟩,h.2.2.1⟩,?_⟩
    apply (allTrueIffMembers _ _).mpr
    intro edge member
    have fields := h.2.2.2 edge member
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr fields.1,(hasIff _ _).mpr fields.2.1⟩,?_⟩
    have no : decide (edge.1 = edge.2) = false := decide_eq_false fields.2.2
    rw [no]
    rfl

theorem facesMeaning (boundary : Boundary) (cell face : String) :
    face ∈ faces boundary cell ↔ (face,cell) ∈ boundary := by
  constructor
  · intro h
    obtain ⟨edge, member, eq⟩ := memMapPreimage _ _ _ h
    have parts := (filterMemberIff _ _ _).mp member
    have target := of_decide_eq_true parts.2
    cases edge with
    | mk first second =>
      change first = face at eq
      cases eq
      cases target
      exact parts.1
  · intro h
    exact memMap Prod.fst (face,cell) _ ((filterMemberIff _ _ _).mpr ⟨h,decide_eq_true rfl⟩)

theorem anyTrueIff {α : Type} (test : α → Bool) (items : List α) :
    items.any test = true ↔ ∃ item, item ∈ items ∧ test item = true := by
  induction items with
  | nil =>
    constructor
    · intro h; cases h
    · intro h; obtain ⟨x,m,_⟩ := h; cases m
  | cons x xs ih =>
    cases hx : test x with
    | true =>
      constructor
      · intro _; exact ⟨x,List.Mem.head _,hx⟩
      · intro _; change (test x || xs.any test) = true; rw [hx]; rfl
    | false =>
      constructor
      · intro h
        change (test x || xs.any test) = true at h
        rw [hx] at h
        obtain ⟨y,hy,ht⟩ := ih.mp h
        exact ⟨y,List.Mem.tail _ hy,ht⟩
      · intro h
        obtain ⟨y,hy,ht⟩ := h
        change (test x || xs.any test) = true
        rw [hx]
        cases hy with
        | head => rw [hx] at ht; cases ht
        | tail _ hy => exact ih.mpr ⟨y,hy,ht⟩

theorem adjacencyMeaning (boundary : Boundary) (left right : String) :
    adjacent boundary left right = true ↔
      left ≠ right ∧ ∃ face, (face,left) ∈ boundary ∧ (face,right) ∈ boundary := by
  constructor
  · intro h
    have parts := (andTrue _ _).mp h
    refine ⟨?_,?_⟩
    · intro eq
      have yes : decide (left = right) = true := decide_eq_true eq
      rw [yes] at parts
      cases parts.1
    · obtain ⟨face,hl,hr⟩ := (anyTrueIff _ _).mp parts.2
      exact ⟨face,(facesMeaning _ _ _).mp hl,(facesMeaning _ _ _).mp ((hasIff _ _).mp hr)⟩
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨?_,(anyTrueIff _ _).mpr ?_⟩
    · have no : decide (left = right) = false := decide_eq_false h.1
      rw [no]; rfl
    · obtain ⟨face,hl,hr⟩ := h.2
      exact ⟨face,(facesMeaning _ _ _).mpr hl,(hasIff _ _).mpr ((facesMeaning _ _ _).mpr hr)⟩

theorem adjacencySymmetric (boundary : Boundary) (left right : String)
    (h : adjacent boundary left right = true) : adjacent boundary right left = true := by
  have parts := (adjacencyMeaning _ _ _).mp h
  obtain ⟨face,hl,hr⟩ := parts.2
  exact (adjacencyMeaning _ _ _).mpr ⟨fun eq => parts.1 eq.symm,face,hr,hl⟩

theorem adjacencyIrreflexive (boundary : Boundary) (cell : String) : adjacent boundary cell cell = false := by
  unfold adjacent
  have yes : decide (cell = cell) = true := decide_eq_true rfl
  rw [yes]; rfl

theorem normalizeEmpty (points : List String) : normalizeOpen points [] = emptyOne := by
  unfold normalizeOpen
  have empty : points.filter (has []) = [] := by
    induction points with
    | nil => rfl
    | cons x xs ih => exact ih
  rw [empty]; rfl

theorem imageLastWins (mapping : List (String × String)) (key value : String) :
    image (mapping ++ [(key,value)]) key = some value := by
  induction mapping with
  | nil => change (if key = key then some value else none) = some value
           rw [ite_eq_left rfl]
  | cons pair rest ih =>
    cases pair with
    | mk k v => change (match image (rest ++ [(key,value)]) key with
        | some result => some result
        | none => if k = key then some v else none) = some value
                rw [ih]

theorem continuousMeaning (points : List String) (sourceOpens targetOpens : OpenFamily)
    (mapping : List (String × String)) : continuous points sourceOpens targetOpens mapping = true ↔
      (∀ key, key ∈ mapping.map Prod.fst → key ∈ points) ∧
      (∀ point, point ∈ points → point ∈ mapping.map Prod.fst) ∧
      (∀ held, held ∈ targetOpens → inverseOpen points mapping held ∈ sourceOpens) := by
  constructor
  · intro h
    have parts := (andTrue _ _).mp h
    have keys := (andTrue _ _).mp parts.1
    exact ⟨fun k hk => (hasIff _ _).mp (allTrueAtMember _ _ keys.1 k hk),
      fun p hp => (hasIff _ _).mp (allTrueAtMember _ _ keys.2 p hp),
      fun o ho => (hasIff _ _).mp (allTrueAtMember _ _ parts.2 o ho)⟩
  · intro h
    apply (andTrue _ _).mpr
    exact ⟨(andTrue _ _).mpr ⟨(allTrueIffMembers _ _).mpr (fun k hk => (hasIff _ _).mpr (h.1 k hk)),
      (allTrueIffMembers _ _).mpr (fun p hp => (hasIff _ _).mpr (h.2.1 p hp))⟩,
      (allTrueIffMembers _ _).mpr (fun o ho => (hasIff _ _).mpr (h.2.2 o ho))⟩

theorem topologyMeaning (points : List String) (opens : OpenFamily) :
    finiteTopology points opens = true ↔
      points.isEmpty = false ∧ distinct points = true ∧
      (canonicalOpens points opens).length = opens.length ∧
      emptyOne ∈ canonicalOpens points opens ∧ points ∈ canonicalOpens points opens ∧
      ∀ left, left ∈ canonicalOpens points opens →
        ∀ right, right ∈ canonicalOpens points opens →
          openUnion points left right ∈ canonicalOpens points opens ∧
          openIntersection points left right ∈ canonicalOpens points opens := by
  constructor
  · intro h
    have p1 := (andTrue _ _).mp h
    have p2 := (andTrue _ _).mp p1.1
    have p3 := (andTrue _ _).mp p2.1
    have p4 := (andTrue _ _).mp p3.1
    have p5 := (andTrue _ _).mp p4.1
    refine ⟨(notTrue _).mp p5.1,p5.2,of_decide_eq_true p4.2,
      (hasIff _ _).mp p3.2,(hasIff _ _).mp p2.2,?_⟩
    intro left hl right hr
    have checks := (andTrue _ _).mp (allTrueAtMember _ _ (allTrueAtMember _ _ p1.2 left hl) right hr)
    exact ⟨(hasIff _ _).mp checks.1,(hasIff _ _).mp checks.2⟩
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr
      ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,h.2.1⟩,decide_eq_true h.2.2.1⟩,
      (hasIff _ _).mpr h.2.2.2.1⟩,(hasIff _ _).mpr h.2.2.2.2.1⟩,?_⟩
    apply (allTrueIffMembers _ _).mpr
    intro left hl
    apply (allTrueIffMembers _ _).mpr
    intro right hr
    have parts := h.2.2.2.2.2 left hl right hr
    exact (andTrue _ _).mpr ⟨(hasIff _ _).mpr parts.1,(hasIff _ _).mpr parts.2⟩

def generatedJoin (points : List String) : OpenFamily → List String
  | [] => emptyOne
  | held::rest => openUnion points held (generatedJoin points rest)

def generatedIntersection (points : List String) : OpenFamily → List String
  | [] => points
  | held::rest => openIntersection points held (generatedIntersection points rest)

theorem generatedJoinAdmitted (points : List String) (opens held : OpenFamily)
    (h : finiteTopology points opens = true)
    (included : ∀ member, member ∈ held → member ∈ canonicalOpens points opens) :
    generatedJoin points held ∈ canonicalOpens points opens := by
  have conditions := (topologyMeaning points opens).mp h
  induction held with
  | nil => exact conditions.2.2.2.1
  | cons first rest ih =>
    exact (conditions.2.2.2.2.2 first (included first (List.Mem.head _)) _
      (ih (fun member hm => included member (List.Mem.tail _ hm)))).1

theorem generatedIntersectionAdmitted (points : List String) (opens held : OpenFamily)
    (h : finiteTopology points opens = true)
    (included : ∀ member, member ∈ held → member ∈ canonicalOpens points opens) :
    generatedIntersection points held ∈ canonicalOpens points opens := by
  have conditions := (topologyMeaning points opens).mp h
  induction held with
  | nil => exact conditions.2.2.2.2.1
  | cons first rest ih =>
    exact (conditions.2.2.2.2.2 first (included first (List.Mem.head _)) _
      (ih (fun member hm => included member (List.Mem.tail _ hm)))).2

theorem normalizeWhenNonempty (points held : List String)
    (h : (points.filter (has held)).isEmpty = false) :
    normalizeOpen points held = points.filter (has held) := by
  unfold normalizeOpen
  dsimp only
  rw [h]; rfl

theorem normalizedMembership (points held : List String) (point : String)
    (h : (points.filter (has held)).isEmpty = false) :
    point ∈ normalizeOpen points held ↔ point ∈ points ∧ point ∈ held := by
  rw [normalizeWhenNonempty points held h]
  constructor
  · intro member
    have parts := (filterMemberIff _ _ _).mp member
    exact ⟨parts.1,(hasIff _ _).mp parts.2⟩
  · intro member
    exact (filterMemberIff _ _ _).mpr ⟨member.1,(hasIff _ _).mpr member.2⟩

def witnessCells : List String := ["p","q","r","pq","qr","triangle"]
def witnessBoundary : Boundary := [("p","pq"),("q","pq"),("q","qr"),("r","qr"),("pq","triangle"),("qr","triangle")]
def witnessPoints : List String := ["a","b"]
def witnessOpens : OpenFamily := [emptyOne,["a"],["b"],witnessPoints]

theorem sourceIncidenceWitness : incidenceWellFormed witnessCells witnessBoundary = true := rfl

theorem sourceAdjacencyWitness : adjacent witnessBoundary "pq" "qr" = true := rfl

theorem sourceTopologyWitness : finiteTopology witnessPoints witnessOpens = true := rfl

theorem sourceContinuityWitness : continuous witnessPoints witnessOpens witnessOpens [("a","a"),("b","b")] = true := rfl

end SFT.Mathematics.GeometryTopology
