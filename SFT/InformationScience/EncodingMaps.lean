import SFT.InformationScience.EncodingDecoder
namespace SFT.InformationScience.EncodingMaps
open EncodingClasses SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Mathematics.AlgebraOperations SFT.Foundation.Count.TraceDerivation

def lookupFirst {α β : Type} [DecidableEq α] : List (α × β) → α → Option β
  | [], _ => none
  | (source,value) :: rest, key => if source = key then some value else lookupFirst rest key

def interfaceValid (first : Encoding) (second : List (Codeword × Codeword)) : Bool :=
  distinct (second.map Prod.fst) && first.all (fun row => has (second.map Prod.fst) row.2)

def applyInterface (second : List (Codeword × Codeword)) : Encoding → Except String Encoding
  | [] => .ok []
  | (source,code) :: rest => match lookupFirst second code with
    | none => .error "encoding composition requires a complete exact interface map"
    | some image => match applyInterface second rest with
      | .error e => .error e
      | .ok tail => .ok ((source,image)::tail)

def composeEncodings (first : Encoding) (second : List (Codeword × Codeword)) : Except String Encoding :=
  if interfaceValid first second then applyInterface second first
  else .error "encoding composition requires a complete exact interface map"

theorem lookupRow {α β : Type} [DecidableEq α] (rows : List (α × β)) (key : α) (value : β)
    (h : lookupFirst rows key = some value) : (key,value) ∈ rows := by
  induction rows with
  | nil => cases h
  | cons row rest ih =>
    cases row with
    | mk source image =>
      unfold lookupFirst at h
      by_cases same : source = key
      · rw [ite_eq_left same] at h; cases same; cases h; exact List.Mem.head _
      · rw [ite_eq_right same] at h; exact List.Mem.tail _ (ih h)

theorem lookupDefined {α β : Type} [DecidableEq α] (rows : List (α × β)) (key : α) :
    (∃ value, lookupFirst rows key = some value) ↔ key ∈ rows.map Prod.fst := by
  constructor
  · intro ⟨value,h⟩; exact memMap Prod.fst (key,value) rows (lookupRow _ _ _ h)
  · intro hm
    induction rows with
    | nil => cases hm
    | cons row rest ih =>
      cases row with
      | mk source image =>
        by_cases same : source = key
        · exact ⟨image,by rw [lookupFirst,ite_eq_left same]⟩
        · have tail : key ∈ rest.map Prod.fst := by
            cases hm with
            | head => exact False.elim (same rfl)
            | tail _ h => exact h
          obtain ⟨value,hv⟩ := ih tail
          exact ⟨value,by rw [lookupFirst,ite_eq_right same,hv]⟩

theorem lookupUnique {α β : Type} [DecidableEq α] (rows : List (α × β)) (key : α) (value : β)
    (hd : distinct (rows.map Prod.fst) = true) (hm : (key,value) ∈ rows) : lookupFirst rows key = some value := by
  induction rows with
  | nil => cases hm
  | cons row rest ih =>
    cases row with
    | mk source image =>
      have p := (andTrue _ _).mp hd
      have absent := (absentIff _ _).mp ((notTrue _).mp p.1)
      cases hm with
      | head => rw [lookupFirst,ite_eq_left rfl]
      | tail _ member =>
        have different : source ≠ key := by
          intro same; cases same
          exact absent (memMap Prod.fst (key,value) rest member)
        rw [lookupFirst,ite_eq_right different]
        exact ih p.2 member

theorem admittedSourceCode (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (item : String) (member : item ∈ source) :
    ∃ code, lookupFirst encoding item = some code ∧ code ∈ support := by
  have v := (validationMeaning _ _ _).mp valid
  have keys := (keysMeaning _ _).mp v.2.2.2.2.2.1
  obtain ⟨code,lookup⟩ := (lookupDefined encoding item).mpr (keys.2 item member)
  exact ⟨code,lookup,(sourceProvenance _ _ _ valid _ _ (lookupRow _ _ _ lookup)).2⟩

theorem admittedRowLookup (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (item : String) (code : Codeword)
    (member : (item,code) ∈ encoding) : lookupFirst encoding item = some code :=
  lookupUnique _ _ _ ((validationMeaning _ _ _).mp valid).2.2.2.2.2.2.1 member

theorem interfaceMeaning (first : Encoding) (second : List (Codeword × Codeword)) :
    interfaceValid first second = true ↔ distinct (second.map Prod.fst) = true ∧
      ∀ row, row ∈ first → row.2 ∈ second.map Prod.fst := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    exact ⟨p.1,fun row hm => (hasIff _ _).mp (allTrueAtMember _ _ p.2 row hm)⟩
  · intro h
    exact (andTrue _ _).mpr ⟨h.1,(allTrueIffMembers _ _).mpr (fun row hm => (hasIff _ _).mpr (h.2 row hm))⟩

theorem interfaceExists (first : Encoding) (second : List (Codeword × Codeword))
    (covered : ∀ row, row ∈ first → row.2 ∈ second.map Prod.fst) :
    ∃ result, applyInterface second first = .ok result := by
  induction first with
  | nil => exact ⟨[],rfl⟩
  | cons row rest ih =>
    cases row with
    | mk source code =>
      obtain ⟨image,hi⟩ := (lookupDefined second code).mpr (covered (source,code) (List.Mem.head _))
      obtain ⟨tail,ht⟩ := ih (fun row hm => covered row (List.Mem.tail _ hm))
      refine ⟨(source,image)::tail,?_⟩
      unfold applyInterface; rw [hi,ht]

theorem compositionExists (first : Encoding) (second : List (Codeword × Codeword)) :
    (∃ result, composeEncodings first second = .ok result) ↔ interfaceValid first second = true := by
  constructor
  · intro ⟨result,h⟩
    unfold composeEncodings at h
    cases hv : interfaceValid first second with
    | true => rfl
    | false => rw [hv] at h; cases h
  · intro h
    obtain ⟨result,hr⟩ := interfaceExists _ _ ((interfaceMeaning _ _).mp h).2
    exact ⟨result,by unfold composeEncodings; rw [h]; exact hr⟩

theorem compositionResult (first : Encoding) (second : List (Codeword × Codeword)) (result : Encoding)
    (h : composeEncodings first second = .ok result) : applyInterface second first = .ok result := by
  unfold composeEncodings at h
  cases hv : interfaceValid first second with
  | false => rw [hv] at h; cases h
  | true => rw [hv] at h; exact h

theorem preservesSources (first : Encoding) (second : List (Codeword × Codeword)) (result : Encoding)
    (h : applyInterface second first = .ok result) : result.map Prod.fst = first.map Prod.fst := by
  induction first generalizing result with
  | nil => cases h; rfl
  | cons row rest ih =>
    cases row with
    | mk source code =>
      unfold applyInterface at h
      cases hi : lookupFirst second code with
      | none => rw [hi] at h; cases h
      | some image =>
        rw [hi] at h
        cases ht : applyInterface second rest with
        | error e => rw [ht] at h; cases h
        | ok tail => rw [ht] at h; cases h; exact congrArg (List.cons source) (ih tail ht)

theorem compositionProvenance (first : Encoding) (second : List (Codeword × Codeword)) (result : Encoding)
    (h : composeEncodings first second = .ok result) : result.map Prod.fst = first.map Prod.fst :=
  preservesSources _ _ _ (compositionResult _ _ _ h)


theorem interfaceMembership (first : Encoding) (second : List (Codeword × Codeword)) (result : Encoding)
    (h : applyInterface second first = .ok result) (source : String) (image : Codeword) :
    (source,image) ∈ result ↔ ∃ code, (source,code) ∈ first ∧ lookupFirst second code = some image := by
  induction first generalizing result with
  | nil =>
    cases h
    constructor
    · intro hm; cases hm
    · intro ⟨code,hm,_⟩; cases hm
  | cons row rest ih =>
    cases row with
    | mk origin code =>
      unfold applyInterface at h
      cases hl : lookupFirst second code with
      | none => rw [hl] at h; cases h
      | some value =>
        rw [hl] at h
        cases ht : applyInterface second rest with
        | error e => rw [ht] at h; cases h
        | ok tail =>
          rw [ht] at h; cases h
          constructor
          · intro hm
            cases hm with
            | head => exact ⟨code,List.Mem.head _,hl⟩
            | tail _ hm =>
              obtain ⟨c,hc,hi⟩ := (ih tail ht).mp hm
              exact ⟨c,List.Mem.tail _ hc,hi⟩
          · intro ⟨c,hc,hi⟩
            cases hc with
            | head =>
              have eq := Option.some.inj (hl.symm.trans hi)
              cases eq; exact List.Mem.head _
            | tail _ member => exact List.Mem.tail _ ((ih tail ht).mpr ⟨c,member,hi⟩)

theorem composedRow (first : Encoding) (second : List (Codeword × Codeword)) (result : Encoding)
    (h : composeEncodings first second = .ok result) (source : String) (image : Codeword) :
    (source,image) ∈ result ↔ ∃ code, (source,code) ∈ first ∧ (code,image) ∈ second := by
  have valid := (compositionExists _ _).mp ⟨result,h⟩
  have unique := ((interfaceMeaning _ _).mp valid).1
  constructor
  · intro hm
    obtain ⟨code,hc,hi⟩ := (interfaceMembership _ _ _ (compositionResult _ _ _ h) _ _).mp hm
    exact ⟨code,hc,lookupRow _ _ _ hi⟩
  · intro ⟨code,hc,hi⟩
    exact (interfaceMembership _ _ _ (compositionResult _ _ _ h) _ _).mpr ⟨code,hc,lookupUnique _ _ _ unique hi⟩

end SFT.InformationScience.EncodingMaps
