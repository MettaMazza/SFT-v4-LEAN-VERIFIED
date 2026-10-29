import SFT.Computation.DescriptiveResources
namespace SFT.Computation.SearchTrace
open SFT.Mathematics.DiscreteObjects
open EnumerationTrace

def scan (target : String) : List String → Option Nat
 | [] => none
 | value :: rest => if value = target then some 0 else (scan target rest).map Nat.succ

def exactSearch (carrier : List String) (target : String) : Except String (String × String) :=
  if !distinct carrier then .error "ValueError: search carrier must contain unique generated identities"
  else if !has carrier target then .error "ValueError: target is not in the registered carrier"
  else match scan target carrier with
    | none => .error "AssertionError: complete finite carrier was not exhausted"
    | some index => .ok (SFT.Host.Text.append "position-" (toString (index+1)),target)

theorem scanComplete (carrier : List String) (target : String) (held : target ∈ carrier) :
    ∃ index, scan target carrier = some index := by
  induction carrier with
  | nil => cases held
  | cons value rest ih =>
    by_cases equal : value = target
    · refine ⟨0,?_⟩
      change (if value = target then some 0 else (scan target rest).map Nat.succ) = some 0
      rw [ite_eq_left equal]
    · have member : target ∈ rest := by
        cases held with
        | head => exact False.elim (equal rfl)
        | tail _ h => exact h
      obtain ⟨index,found⟩ := ih member
      refine ⟨index+1,?_⟩
      change (if value = target then some 0 else (scan target rest).map Nat.succ) = _
      rw [ite_eq_right equal,found]
      rfl

theorem scanPosition (carrier : List String) (target : String) (index : Nat)
    (found : scan target carrier = some index) : atPosition carrier index = some target := by
  induction carrier generalizing index with
  | nil => cases found
  | cons value rest ih =>
    unfold scan at found
    by_cases equal : value = target
    · rw [ite_eq_left equal] at found
      cases found; cases equal; rfl
    · rw [ite_eq_right equal] at found
      cases selected : scan target rest with
      | none => rw [selected] at found; cases found
      | some previous =>
        rw [selected] at found
        cases found
        exact ih previous selected

theorem scanTrace (carrier : List String) (target : String) (index : Nat)
    (found : scan target carrier = some index) :
    ∃ before after, carrier = before ++ target :: after ∧ before.length = index ∧
      ∀ value, value ∈ before → value ≠ target := by
  induction carrier generalizing index with
  | nil => cases found
  | cons value rest ih =>
    unfold scan at found
    by_cases equal : value = target
    · rw [ite_eq_left equal] at found
      cases found; cases equal
      exact ⟨[],rest,rfl,rfl,fun value impossible => by cases impossible⟩
    · rw [ite_eq_right equal] at found
      cases selected : scan target rest with
      | none => rw [selected] at found; cases found
      | some previous =>
        rw [selected] at found; cases found
        obtain ⟨before,after,split,length,misses⟩ := ih previous selected
        refine ⟨value :: before,after,congrArg (List.cons value) split,congrArg Nat.succ length,?_⟩
        intro item held
        cases held with
        | head => exact equal
        | tail _ h => exact misses item h

theorem admittedSearch (carrier : List String) (target : String)
    (unique : distinct carrier = true) (held : target ∈ carrier) :
    ∃ index, exactSearch carrier target = .ok (SFT.Host.Text.append "position-" (toString (index+1)),target) ∧
      atPosition carrier index = some target ∧
      ∃ before after, carrier = before ++ target :: after ∧ before.length = index ∧
        ∀ value, value ∈ before → value ≠ target := by
  obtain ⟨index,found⟩ := scanComplete carrier target held
  refine ⟨index,?_,scanPosition _ _ _ found,scanTrace _ _ _ found⟩
  unfold exactSearch
  rw [unique,(hasIff _ _).mpr held]
  change (match scan target carrier with | none => _ | some index => _) = _
  rw [found]

theorem duplicateCarrierRejected (carrier : List String) (target : String)
    (duplicate : distinct carrier = false) :
    exactSearch carrier target = .error "ValueError: search carrier must contain unique generated identities" := by
  unfold exactSearch; rw [duplicate]; rfl

theorem absentTargetRejected (carrier : List String) (target : String)
    (unique : distinct carrier = true) (absent : ¬ target ∈ carrier) :
    exactSearch carrier target = .error "ValueError: target is not in the registered carrier" := by
  have missing : has carrier target = false := by
    cases h : has carrier target with
    | false => rfl
    | true => exact False.elim (absent ((hasIff _ _).mp h))
  unfold exactSearch; rw [unique,missing]; rfl

theorem retainedScan (left right : List String) (target : String) (index : Nat)
    (found : scan target left = some index) : scan target (left ++ right) = some index := by
  induction left generalizing index with
  | nil => cases found
  | cons value rest ih =>
    unfold scan at found
    change (if value = target then some 0 else (scan target (rest ++ right)).map Nat.succ) = _
    by_cases equal : value = target
    · rw [ite_eq_left equal] at found ⊢; exact found
    · rw [ite_eq_right equal] at found ⊢
      cases selected : scan target rest with
      | none => rw [selected] at found; cases found
      | some previous => rw [selected] at found; rw [ih previous selected]; exact found

theorem oneSearch (value : String) : exactSearch [value] value = .ok ("position-1",value) := by
  have unique : distinct [value] = true := rfl
  have held : has [value] value = true := (hasIff _ _).mpr (.head [])
  unfold exactSearch
  rw [unique,held]
  change (match scan value [value] with | none => _ | some index => _) = _
  unfold scan
  rw [ite_eq_left (show value = value from rfl)]
  rfl

end SFT.Computation.SearchTrace
