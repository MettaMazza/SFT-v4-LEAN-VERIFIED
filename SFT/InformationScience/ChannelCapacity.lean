import SFT.InformationScience.ChannelSelections
namespace SFT.InformationScience.ChannelCapacity
open ChannelRelation ChannelSelections SFT.Mathematics.DiscreteObjects

def largest : List (List String) → Nat
  | [] => 0
  | selection :: rest => if selection.length < largest rest then largest rest else selection.length

def greatestCodes (candidates : List (List String)) : List (List String) :=
  candidates.filter (fun selection => decide (selection.length = largest candidates))

def capacityFamily (channel : FiniteChannel) : Except String (List (List String)) :=
  if (codeCandidates channel).isEmpty then .error "ValueError: max() arg is an empty sequence"
  else .ok (greatestCodes (codeCandidates channel))

theorem memberBound (candidates : List (List String)) (selection : List String) (h : selection ∈ candidates) :
    selection.length ≤ largest candidates := by
  induction candidates with
  | nil => cases h
  | cons first rest ih =>
    unfold largest
    by_cases smaller : first.length < largest rest
    · rw [ite_eq_left smaller]
      cases h with
      | head => exact Nat.le_of_lt smaller
      | tail _ hm => exact ih hm
    · rw [ite_eq_right smaller]
      cases h with
      | head => exact Nat.le_refl _
      | tail _ hm => exact Nat.le_trans (ih hm) (Nat.le_of_not_gt smaller)

theorem largestBound (candidates : List (List String)) (bound : Nat)
    (h : ∀ selection, selection ∈ candidates → selection.length ≤ bound) : largest candidates ≤ bound := by
  induction candidates with
  | nil => exact Nat.zero_le _
  | cons first rest ih =>
    unfold largest
    by_cases smaller : first.length < largest rest
    · rw [ite_eq_left smaller]
      exact ih (fun selection hm => h selection (List.Mem.tail first hm))
    · rw [ite_eq_right smaller]
      exact h first (List.Mem.head _)

theorem largestAttained (candidates : List (List String)) (h : candidates.isEmpty = false) :
    ∃ selection, selection ∈ candidates ∧ selection.length = largest candidates := by
  induction candidates with
  | nil => cases h
  | cons first rest ih =>
    by_cases smaller : first.length < largest rest
    · have nonempty : rest.isEmpty = false := by
        cases rest with
        | nil => exact False.elim (Nat.not_lt_zero _ smaller)
        | cons _ _ => rfl
      obtain ⟨held,hm,eq⟩ := ih nonempty
      exact ⟨held,List.Mem.tail first hm,by unfold largest; rw [ite_eq_left smaller]; exact eq⟩
    · exact ⟨first,List.Mem.head _,by unfold largest; rw [ite_eq_right smaller]⟩

theorem greatestMeaning (candidates : List (List String)) (selection : List String) :
    selection ∈ greatestCodes candidates ↔ selection ∈ candidates ∧
      ∀ other, other ∈ candidates → other.length ≤ selection.length := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    have eq := of_decide_eq_true p.2
    exact ⟨p.1,fun other hm => by rw [eq]; exact memberBound _ _ hm⟩
  · intro h
    apply (filterMemberIff _ _ _).mpr
    exact ⟨h.1,decide_eq_true (Nat.le_antisymm (memberBound _ _ h.1) (largestBound _ _ h.2))⟩

theorem greatestNonempty (candidates : List (List String)) (h : candidates.isEmpty = false) :
    ∃ selection, selection ∈ greatestCodes candidates := by
  obtain ⟨selection,hm,eq⟩ := largestAttained _ h
  exact ⟨selection,(filterMemberIff _ _ _).mpr ⟨hm,decide_eq_true eq⟩⟩

theorem capacityResult (channel : FiniteChannel) (family : List (List String)) :
    capacityFamily channel = .ok family ↔
      (codeCandidates channel).isEmpty = false ∧ family = greatestCodes (codeCandidates channel) := by
  unfold capacityFamily
  cases empty : (codeCandidates channel).isEmpty with
  | true => constructor; intro h; cases h; intro h; cases h.1
  | false => constructor; intro h; exact ⟨rfl,(Except.ok.inj h).symm⟩; intro h; rw [h.2]; rfl

theorem capacityMeaning (channel : FiniteChannel) (family : List (List String))
    (h : capacityFamily channel = .ok family) (selection : List String) :
    selection ∈ family ↔ Chosen selection channel.inputs ∧ distinguishableCode channel selection = true ∧
      ∀ other, Chosen other channel.inputs → distinguishableCode channel other = true → other.length ≤ selection.length := by
  have p := (capacityResult _ _).mp h
  rw [p.2]
  constructor
  · intro hm
    have g := (greatestMeaning _ _).mp hm
    have c := (candidatesMeaning _ _).mp g.1
    exact ⟨c.1,c.2,fun other ho hv => g.2 other ((candidatesMeaning _ _).mpr ⟨ho,hv⟩)⟩
  · intro ⟨chosen,valid,maximal⟩
    apply (greatestMeaning _ _).mpr
    refine ⟨(candidatesMeaning _ _).mpr ⟨chosen,valid⟩,?_⟩
    intro other hm
    have c := (candidatesMeaning _ _).mp hm
    exact maximal other c.1 c.2

theorem admittedCapacity (inputs outputs : List String) (relation : List Cell) (channel : FiniteChannel)
    (h : makeChannel inputs outputs relation = .ok channel) :
    ∃ family, capacityFamily channel = .ok family ∧ ∃ selection, selection ∈ family := by
  obtain ⟨selection,hm⟩ := admittedCandidatesNonempty _ _ _ _ h
  have ne : (codeCandidates channel).isEmpty = false := by
    cases eq : codeCandidates channel with
    | nil => rw [eq] at hm; cases hm
    | cons _ _ => rfl
  exact ⟨greatestCodes (codeCandidates channel),(capacityResult _ _).mpr ⟨ne,rfl⟩,greatestNonempty _ ne⟩

theorem singletonCandidates (channel : FiniteChannel) (item : String) (inputs : channel.inputs = [item]) :
    codeCandidates channel = [[item]] := by
  have valid := singletonCode channel item (by rw [inputs]; exact List.Mem.head _)
  unfold codeCandidates
  rw [inputs]
  change ([[item]].filter (distinguishableCode channel)) = [[item]]
  rw [List.filter_cons_of_pos valid]
  rfl

theorem singletonCapacity (channel : FiniteChannel) (item : String) (inputs : channel.inputs = [item]) :
    capacityFamily channel = .ok [[item]] := by
  unfold capacityFamily
  rw [singletonCandidates _ _ inputs]
  rfl

theorem familyDistinct (channel : FiniteChannel) (family : List (List String))
    (h : capacityFamily channel = .ok family) (unique : distinct channel.inputs = true) : distinct family = true := by
  rw [((capacityResult _ _).mp h).2]
  exact filterDistinct _ _ (candidatesDistinct _ unique)

end SFT.InformationScience.ChannelCapacity
