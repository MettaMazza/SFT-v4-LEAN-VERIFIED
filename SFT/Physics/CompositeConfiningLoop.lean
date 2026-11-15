import SFT.Physics.CompositeConfiningBinding
import SFT.Foundation.CountTrace
namespace SFT.Physics.CompositeConfiningDerivation
open SFT.Physics.CompositeConfining SFT.Physics.GeneratorOperations
open SFT.Foundation.Count.TraceDerivation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- The source preserves the initial Boolean/int tag and uses integer Fold images thereafter. -/
def originalTaggedTick (d k : Nat) (initial : CountInput) : Nat → CountInput
 | 0 => initial
 | n+1 => .integer (.ofNat (originalTicks d k (n+1)))
def originalTaggedTrace (d k : Nat) (initial : CountInput) : Nat → List CountInput
 | 0 => []
 | n+1 => originalTaggedTrace d k initial n ++ [originalTaggedTick d k initial n]
theorem originalTaggedValue (d k n : Nat) (initial : CountInput)
 (value : labelInteger initial=Int.ofNat k) :
 labelInteger (originalTaggedTick d k initial n)=Int.ofNat (originalTicks d k n) := by
 cases n with
 | zero => exact value
 | succ n => rfl
theorem originalTraceMember (d k n : Nat) (initial x : CountInput) :
 x∈originalTaggedTrace d k initial n ↔ ∃ i, i<n ∧ originalTaggedTick d k initial i=x := by
 induction n with
 | zero =>
  constructor
  · intro h; cases h
  · intro h; obtain ⟨i,b,_⟩ := h; exact False.elim (Nat.not_lt_zero i b)
 | succ n ih =>
  constructor
  · intro h
    cases memAppendCases x (originalTaggedTrace d k initial n) [originalTaggedTick d k initial n] h with
    | inl h => obtain ⟨i,b,e⟩ := ih.mp h; exact ⟨i,Nat.lt_trans b (Nat.lt_succ_self n),e⟩
    | inr h =>
     cases h with
     | head => exact ⟨n,Nat.lt_succ_self n,rfl⟩
     | tail _ h => cases h
  · intro h
    obtain ⟨i,b,e⟩ := h
    by_cases last : i=n
    · rw [last] at e
      exact memAppendRight x _ _ (e ▸ List.Mem.head [])
    · exact memAppendLeft x _ _ (ih.mpr ⟨i,Nat.lt_of_le_of_ne (Nat.le_of_lt_succ b) last,e⟩)
theorem originalTraceFresh (d k period n : Nat) (initial : CountInput)
 (value : labelInteger initial=Int.ofNat k) (positive : 0<d) (odd : d%2=1)
 (kp : 0<k) (kb : k<d) (before : n<period)
 (first : ∀ j, 0<j → j<period → originalTicks d k j≠k) :
 (originalTaggedTrace d k initial n).any
  (fun x => labelInteger x=labelInteger (originalTaggedTick d k initial n))=false := by
 cases test : (originalTaggedTrace d k initial n).any
  (fun x => labelInteger x=labelInteger (originalTaggedTick d k initial n)) with
 | false => rfl
 | true =>
  obtain ⟨x,member,equal⟩ := (SFT.Mathematics.GeometryTopology.anyTrueIff _ _).mp test
  obtain ⟨i,ib,ix⟩ := (originalTraceMember d k n initial x).mp member
  have sameInt := of_decide_eq_true equal
  rw [← ix,originalTaggedValue d k i initial value,originalTaggedValue d k n initial value] at sameInt
  have same : originalTicks d k i=originalTicks d k n := congrArg Int.toNat sameInt
  have back := originalCollisionReturns d k i n positive odd kp kb ib same
  exact False.elim (first (n-i) (SFT.Foundation.ExactCast.subtractPositive n i ib)
   (Nat.lt_of_le_of_lt (Nat.sub_le n i) before) back)
theorem originalTraceRepeated (d k period : Nat) (initial : CountInput)
 (value : labelInteger initial=Int.ofNat k) (pp : 0<period) (returned : originalTicks d k period=k) :
 (originalTaggedTrace d k initial period).any
  (fun x => labelInteger x=labelInteger (originalTaggedTick d k initial period))=true := by
 apply (SFT.Mathematics.GeometryTopology.anyTrueIff _ _).mpr
 refine ⟨initial,(originalTraceMember d k period initial initial).mpr ⟨0,pp,rfl⟩,?_⟩
 apply decide_eq_true
 rw [originalTaggedValue d k period initial value,returned,value]

theorem originalLoopAtReturn (sector initial : CountInput) (d k period fuel : Nat)
 (value : labelInteger initial=Int.ofNat k) (pp : 0<period)
 (returned : originalTicks d k period=k) :
 orbitLoop sector initial fuel (originalTaggedTick d k initial period)
  (originalTaggedTrace d k initial period)=.ok (originalTaggedTrace d k initial period) := by
 unfold orbitLoop
 rw [originalTraceRepeated d k period initial value pp returned]
 change (if labelInteger (originalTaggedTick d k initial period)=labelInteger initial then
  Except.ok (originalTaggedTrace d k initial period) else
  Except.error "Fold mode entered a distinct recurrence before returning") = Except.ok _
 rw [originalTaggedValue d k period initial value,returned,value,ite_eq_left rfl]
/-- Exact guarded source loop execution through every position of its first return. -/
theorem originalLoopCompletes (sector initial : CountInput) (d k period fuel count : Nat)
 (held : heldDenominator sector=.ok d) (value : labelInteger initial=Int.ofNat k)
 (positive : 0<d) (odd : d%2=1) (kp : 0<k) (kb : k<d)
 (pp : 0<period) (returned : originalTicks d k period=k)
 (first : ∀ j, 0<j → j<period → originalTicks d k j≠k)
 (before : count≤period) (enough : period≤count+fuel) :
 orbitLoop sector initial fuel (originalTaggedTick d k initial count)
  (originalTaggedTrace d k initial count)=.ok (originalTaggedTrace d k initial period) := by
 induction fuel generalizing count with
 | zero =>
  have eq : count=period := Nat.le_antisymm before enough
  rw [eq]
  exact originalLoopAtReturn sector initial d k period 0 value pp returned
 | succ fuel ih =>
  by_cases eq : count=period
  · rw [eq]
    exact originalLoopAtReturn sector initial d k period (fuel+1) value pp returned
  · have earlier := Nat.lt_of_le_of_ne before eq
    unfold orbitLoop
    rw [originalTraceFresh d k period count initial value positive odd kp kb earlier first]
    have bounds := originalTicksConfined d k count positive odd kp kb
    have next := originalFoldOperation sector (originalTaggedTick d k initial count) d
     (originalTicks d k count) held (originalTaggedValue d k count initial value)
     positive odd bounds.1 bounds.2
    change (do
     let n ← foldModeLabel (originalTaggedTick d k initial count) sector
     orbitLoop sector initial fuel (.integer (.ofNat n))
      (originalTaggedTrace d k initial count ++ [originalTaggedTick d k initial count])) = _
    rw [next]
    change orbitLoop sector initial fuel (originalTaggedTick d k initial (count+1))
     (originalTaggedTrace d k initial (count+1))=.ok (originalTaggedTrace d k initial period)
    exact ih (count+1) earlier ((Nat.add_right_comm count fuel 1) ▸ enough)
/-- The exported original orbit operation returns the complete first-return row
with its exact initial tag; the derived d-1 budget never truncates a valid orbit. -/
theorem originalOrbitFromLabelCompletes (sector initial : CountInput) (d k : Nat)
 (held : heldDenominator sector=.ok d) (value : labelInteger initial=Int.ofNat k)
 (positive : 0<d) (odd : d%2=1) (kp : 0<k) (kb : k<d) :
 ∃ period, 0<period ∧ period≤d-1 ∧ originalTicks d k period=k ∧
 (∀ j, 0<j → j<period → originalTicks d k j≠k) ∧
 orbitFromLabel initial sector=.ok (originalTaggedTrace d k initial period) := by
 obtain ⟨period,_,pp,pb,returned,first⟩ := originalFirstReturnExists d k positive odd kp kb
 refine ⟨period,pp,pb,returned,first,?_⟩
 have present : (SFT.Mathematics.OrbitTilingCount.positiveRanks d).any
  (fun n => Int.ofNat n=labelInteger initial)=true := by
  apply (SFT.Mathematics.GeometryTopology.anyTrueIff _ _).mpr
  exact ⟨k,(SFT.Mathematics.OrbitTilingCount.positiveRankMember d k positive).mpr ⟨kp,kb⟩,decide_eq_true value.symm⟩
 have length : (SFT.Mathematics.OrbitTilingCount.positiveRanks d).length=d-1 :=
  (SFT.Mathematics.OrbitCycleSupport.mappedLength _ _).trans
   (SFT.Mathematics.OrbitCycleSupport.rangeLoopLength (d-1) [])
 unfold orbitFromLabel
 rw [originalStandingLabels sector d held]
 change (if (!(SFT.Mathematics.OrbitTilingCount.positiveRanks d).any
  (fun n => Int.ofNat n=labelInteger initial))=true then
  Except.error "orbit source lies outside the complete standing support"
  else orbitLoop sector initial (SFT.Mathematics.OrbitTilingCount.positiveRanks d).length initial []) = _
 rw [present]
 change orbitLoop sector initial (SFT.Mathematics.OrbitTilingCount.positiveRanks d).length initial [] = _
 rw [length]
 exact originalLoopCompletes sector initial d k period (d-1) 0 held value positive odd kp kb
  pp returned first (Nat.zero_le _) ((Nat.zero_add (d-1)).symm ▸ pb)
end SFT.Physics.CompositeConfiningDerivation
