import SFT.InformationScience.SymbolObservation
namespace SFT.InformationScience.SymbolClasses
open SymbolObservation SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations
open SFT.Mathematics.ProbabilityIndependence SFT.Foundation.Count.TraceDerivation

def collectRows (observation : Observation) : List Symbol → Except String Observation
  | [] => .ok []
  | symbol :: rest => match observedLabel observation symbol with
    | .error e => .error e
    | .ok label => match collectRows observation rest with
      | .error e => .error e
      | .ok rows => .ok ((symbol,label) :: rows)

def fibre (rows : Observation) (label : String) : List Symbol :=
  (rows.filter (fun row => decide (row.2 = label))).map Prod.fst

def classRows (rows : Observation) : List (String × List Symbol) :=
  (firstLabels (rows.map Prod.snd)).map (fun label => (label,fibre rows label))

def observationClasses (alphabet : List Symbol) (observation : Observation) : Except String (List (String × List Symbol)) :=
  if validateObservation alphabet observation then
    match collectRows observation alphabet with
    | .error e => .error e
    | .ok rows => .ok (classRows rows)
  else .error "observation is not total and source-bound"

theorem collectionExists (alphabet : List Symbol) (observation : Observation)
    (total : ∀ symbol, symbol ∈ alphabet → ∃ label, observedLabel observation symbol = .ok label) :
    ∃ rows, collectRows observation alphabet = .ok rows := by
  induction alphabet with
  | nil => exact ⟨[],rfl⟩
  | cons symbol rest ih =>
    obtain ⟨label,hl⟩ := total symbol (List.Mem.head _)
    obtain ⟨rows,hr⟩ := ih (fun s hm => total s (List.Mem.tail symbol hm))
    refine ⟨(symbol,label)::rows,?_⟩
    unfold collectRows; rw [hl,hr]

theorem collectionSources (alphabet : List Symbol) (observation rows : Observation)
    (h : collectRows observation alphabet = .ok rows) : rows.map Prod.fst = alphabet := by
  induction alphabet generalizing rows with
  | nil => cases h; rfl
  | cons symbol rest ih =>
    unfold collectRows at h
    cases hl : observedLabel observation symbol with
    | error e => rw [hl] at h; cases h
    | ok label =>
      rw [hl] at h
      cases hr : collectRows observation rest with
      | error e => rw [hr] at h; cases h
      | ok tail =>
        rw [hr] at h; cases h
        exact congrArg (List.cons symbol) (ih tail hr)

theorem collectionMembership (alphabet : List Symbol) (observation rows : Observation)
    (h : collectRows observation alphabet = .ok rows) (symbol : Symbol) (label : String) :
    (symbol,label) ∈ rows ↔ symbol ∈ alphabet ∧ observedLabel observation symbol = .ok label := by
  induction alphabet generalizing rows with
  | nil => cases h; constructor; intro h; cases h; intro h; cases h.1
  | cons first rest ih =>
    unfold collectRows at h
    cases hl : observedLabel observation first with
    | error e => rw [hl] at h; cases h
    | ok value =>
      rw [hl] at h
      cases hr : collectRows observation rest with
      | error e => rw [hr] at h; cases h
      | ok tail =>
        rw [hr] at h; cases h
        constructor
        · intro hm
          cases hm with
          | head => exact ⟨List.Mem.head _,hl⟩
          | tail _ hm => have p := (ih tail hr).mp hm; exact ⟨List.Mem.tail first p.1,p.2⟩
        · intro hm
          cases hm.1 with
          | head =>
            have eq := Except.ok.inj (hl.symm.trans hm.2)
            cases eq; exact List.Mem.head _
          | tail _ member => exact List.Mem.tail _ ((ih tail hr).mpr ⟨member,hm.2⟩)

theorem fibreMembership (rows : Observation) (label : String) (symbol : Symbol) :
    symbol ∈ fibre rows label ↔ (symbol,label) ∈ rows := by
  constructor
  · intro h
    obtain ⟨row,hm,eq⟩ := memMapPreimage Prod.fst symbol _ h
    have p := (filterMemberIff _ _ _).mp hm
    have value : row.2 = label := of_decide_eq_true p.2
    cases row with
    | mk source observed =>
      cases eq; cases value; exact p.1
  · intro h
    apply memMap Prod.fst (symbol,label)
    exact (filterMemberIff _ _ _).mpr ⟨h,decide_eq_true rfl⟩

theorem classMembership (rows : Observation) (label : String) (members : List Symbol) :
    (label,members) ∈ classRows rows ↔ label ∈ rows.map Prod.snd ∧ members = fibre rows label := by
  constructor
  · intro h
    obtain ⟨value,hm,eq⟩ := memMapPreimage (fun label => (label,fibre rows label)) (label,members) _ h
    have he := congrArg Prod.fst eq
    cases he
    exact ⟨(firstLabelsMembership _ _).mp hm,(congrArg Prod.snd eq).symm⟩
  · intro h
    cases h.2
    exact memMap (fun label => (label,fibre rows label)) label _ ((firstLabelsMembership _ _).mpr h.1)

theorem classNonempty (rows : Observation) (label : String) (members : List Symbol)
    (h : (label,members) ∈ classRows rows) : ∃ symbol, symbol ∈ members := by
  have p := (classMembership _ _ _).mp h
  obtain ⟨row,hr,eq⟩ := memMapPreimage Prod.snd label rows p.1
  cases row with
  | mk symbol value =>
    cases eq
    refine ⟨symbol,?_⟩
    rw [p.2]
    exact (fibreMembership _ _ _).mpr hr

theorem collectedFibre (alphabet : List Symbol) (observation rows : Observation)
    (h : collectRows observation alphabet = .ok rows) (symbol : Symbol) (label : String) :
    symbol ∈ fibre rows label ↔ symbol ∈ alphabet ∧ observedLabel observation symbol = .ok label :=
  ⟨fun hm => (collectionMembership _ _ _ h _ _).mp ((fibreMembership _ _ _).mp hm),
   fun hm => (fibreMembership _ _ _).mpr ((collectionMembership _ _ _ h _ _).mpr hm)⟩

theorem fibresDisjoint (alphabet : List Symbol) (observation rows : Observation)
    (h : collectRows observation alphabet = .ok rows) (symbol : Symbol) (left right : String)
    (hl : symbol ∈ fibre rows left) (hr : symbol ∈ fibre rows right) : left = right := by
  have l := ((collectedFibre _ _ _ h _ _).mp hl).2
  have r := ((collectedFibre _ _ _ h _ _).mp hr).2
  exact Except.ok.inj (l.symm.trans r)

theorem classesCover (alphabet : List Symbol) (observation rows : Observation)
    (h : collectRows observation alphabet = .ok rows) (symbol : Symbol) (hm : symbol ∈ alphabet) :
    ∃ label members, (label,members) ∈ classRows rows ∧ symbol ∈ members := by
  have member : symbol ∈ rows.map Prod.fst := by rw [collectionSources _ _ _ h]; exact hm
  obtain ⟨row,hr,eq⟩ := memMapPreimage Prod.fst symbol rows member
  cases row with
  | mk source label =>
    cases eq
    exact ⟨label,fibre rows label,(classMembership _ _ _).mpr ⟨memMap Prod.snd (source,label) rows hr,rfl⟩,
      (fibreMembership _ _ _).mpr hr⟩

theorem validatedClasses (alphabet : List Symbol) (observation : Observation)
    (valid : validateObservation alphabet observation = true) :
    ∃ rows, collectRows observation alphabet = .ok rows ∧ observationClasses alphabet observation = .ok (classRows rows) := by
  obtain ⟨rows,hr⟩ := collectionExists alphabet observation (fun symbol hm => by
    obtain ⟨label,hl,_⟩ := validatedLookup _ _ valid symbol hm
    exact ⟨label,hl⟩)
  refine ⟨rows,hr,?_⟩
  unfold observationClasses; rw [valid,hr]; rfl

theorem invalidClassesRejected (alphabet : List Symbol) (observation : Observation)
    (invalid : validateObservation alphabet observation = false) :
    observationClasses alphabet observation = .error "observation is not total and source-bound" := by
  unfold observationClasses; rw [invalid]; rfl


theorem mappedLabels (labels : List String) (rows : Observation) :
    (labels.map (fun label => (label,fibre rows label))).map Prod.fst = labels := by
  induction labels with
  | nil => rfl
  | cons label rest ih => exact congrArg (List.cons label) ih

theorem classLabels (rows : Observation) :
    (classRows rows).map Prod.fst = firstLabels (rows.map Prod.snd) := mappedLabels _ _

theorem classLabelsDistinct (rows : Observation) : distinct ((classRows rows).map Prod.fst) = true := by
  rw [classLabels]
  exact firstLabelsDistinct _

end SFT.InformationScience.SymbolClasses
