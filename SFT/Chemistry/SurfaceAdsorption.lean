import SFT.Chemistry.ChemicalPhase
import SFT.Chemistry.ReactionRate
namespace SFT.Chemistry.SurfaceAdsorption
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
structure Raw where
 firstPhase : HeldLabel
 secondPhase : HeldLabel
 carriers : PositiveCount

def admit (r : Raw) : Except String Raw :=
 if !(SFT.Host.Text.equal r.firstPhase.family "phase") ||
 !(SFT.Host.Text.equal r.secondPhase.family "phase") || decide (r.firstPhase=r.secondPhase) then
 .error "interface requires two retained phase identities" else .ok r

structure Boundary where
 raw : Raw
 accepted : admit raw=.ok raw
 surfacePhase : ChemicalPhase.Record
 bulkPhase : ChemicalPhase.Record
 surfaceBinding : raw.firstPhase.label=surfacePhase.raw.identity
 bulkBinding : raw.secondPhase.label=bulkPhase.raw.identity
 interface : ChemicalPhase.Interface surfacePhase.boundary surfacePhase.root
 bulkBoundaryBinding : bulkPhase.boundary=surfacePhase.boundary
 bulkRootBinding : bulkPhase.root=interface.outside
 adsorbent : HeldLabel
 adsorbate : HeldLabel
 conditions : SFT.Host.Canonical.Value
 sourceRecord : SFT.Host.Canonical.Value

theorem phaseIdentitiesDiffer (b : Boundary) : b.raw.firstPhase≠b.raw.secondPhase := by
 intro same
 have h := b.accepted
 unfold admit at h
 rw [decide_eq_true same] at h
 cases x : !(SFT.Host.Text.equal b.raw.firstPhase.family "phase") <;>
 cases y : !(SFT.Host.Text.equal b.raw.secondPhase.family "phase") <;> rw [x,y] at h <;> cases h

theorem surfaceSeparated (b : Boundary) :
 ChemicalPhase.InPhase b.surfacePhase.boundary b.surfacePhase.root b.interface.inside ∧
 ¬ChemicalPhase.InPhase b.surfacePhase.boundary b.surfacePhase.root b.interface.outside :=
 ChemicalPhase.interfaceSeparates _ _ _

structure State where
 surface : List HeldLabel
 bulk : List HeldLabel
 deriving DecidableEq

def arrive (s : State) : Option State := match s.bulk with
 | [] => none
 | c::rest => some ⟨c::s.surface,rest⟩
def depart (s : State) : Option State := match s.surface with
 | [] => none
 | c::rest => some ⟨rest,c::s.bulk⟩

def count (test : HeldLabel → Bool) : List HeldLabel → Nat
 | [] => 0
 | c::rest => if test c then count test rest+1 else count test rest

def total (test : HeldLabel → Bool) (s : State) := count test s.surface+count test s.bulk

theorem arrivalExact (surface rest : List HeldLabel) (c : HeldLabel) :
 arrive ⟨surface,c::rest⟩=some ⟨c::surface,rest⟩ := rfl

theorem departureExact (rest bulk : List HeldLabel) (c : HeldLabel) :
 depart ⟨c::rest,bulk⟩=some ⟨rest,c::bulk⟩ := rfl

theorem departureRestoresArrival (surface rest : List HeldLabel) (c : HeldLabel) :
 depart ⟨c::surface,rest⟩=some ⟨surface,c::rest⟩ := rfl

theorem arrivalRestoresDeparture (rest bulk : List HeldLabel) (c : HeldLabel) :
 arrive ⟨rest,c::bulk⟩=some ⟨c::rest,bulk⟩ := rfl

theorem arrivalPreservesEveryCarrier (test : HeldLabel → Bool) (surface rest : List HeldLabel) (c : HeldLabel) :
 total test ⟨surface,c::rest⟩=total test ⟨c::surface,rest⟩ := by
 change count test surface+(if test c then count test rest+1 else count test rest)=
  (if test c then count test surface+1 else count test surface)+count test rest
 cases h : test c
 · rfl
 · exact (Nat.add_assoc _ _ _).symm.trans (Nat.add_right_comm _ _ _)

theorem departurePreservesEveryCarrier (test : HeldLabel → Bool) (rest bulk : List HeldLabel) (c : HeldLabel) :
 total test ⟨c::rest,bulk⟩=total test ⟨rest,c::bulk⟩ :=
 (arrivalPreservesEveryCarrier _ _ _ _).symm

theorem surfaceArrivalIncrement (test : HeldLabel → Bool) (surface : List HeldLabel) (c : HeldLabel)
 (selected : test c=true) : count test (c::surface)=count test surface+1 := by
 change (if test c then count test surface+1 else count test surface)=count test surface+1
 rw [selected]; rfl

theorem bulkArrivalDecrement (test : HeldLabel → Bool) (rest : List HeldLabel) (c : HeldLabel)
 (selected : test c=true) : count test (c::rest)=count test rest+1 := surfaceArrivalIncrement _ _ _ selected

theorem countAppend (test : HeldLabel → Bool) (left right : List HeldLabel) :
 count test (left++right)=count test left+count test right := by
 induction left with
 | nil => exact (Nat.zero_add _).symm
 | cons c rest ih =>
   change (if test c then count test (rest++right)+1 else count test (rest++right))=
    (if test c then count test rest+1 else count test rest)+count test right
   rw [ih]
   cases h : test c
   · rfl
   · exact Nat.add_right_comm _ _ _

theorem insertedCount (test : HeldLabel → Bool) (left right : List HeldLabel) (c : HeldLabel) :
 count test (left++c::right)=count test (left++right)+(if test c then 1 else 0) := by
 rw [countAppend,countAppend]
 change count test left+(if test c then count test right+1 else count test right)=
  (count test left+count test right)+(if test c then 1 else 0)
 cases h : test c
 · exact (Nat.add_zero _).symm
 · exact (Nat.add_assoc _ _ _).symm

theorem arbitraryTransferConserves (test : HeldLabel → Bool)
 (surfaceBefore surfaceAfter bulkBefore bulkAfter : List HeldLabel) (c : HeldLabel) :
 total test ⟨surfaceBefore++surfaceAfter,bulkBefore++c::bulkAfter⟩=
 total test ⟨surfaceBefore++c::surfaceAfter,bulkBefore++bulkAfter⟩ := by
 unfold total
 rw [insertedCount,insertedCount]
 exact (Nat.add_assoc _ _ _).symm.trans (Nat.add_right_comm _ _ _)

inductive Change : State → State → Type where
 | arrival (surface rest : List HeldLabel) (c : HeldLabel) : Change ⟨surface,c::rest⟩ ⟨c::surface,rest⟩
 | departure (rest bulk : List HeldLabel) (c : HeldLabel) : Change ⟨c::rest,bulk⟩ ⟨rest,c::bulk⟩
 | arrivalAt (sb sa bb ba : List HeldLabel) (c : HeldLabel) :
   Change ⟨sb++sa,bb++c::ba⟩ ⟨sb++c::sa,bb++ba⟩
 | departureAt (sb sa bb ba : List HeldLabel) (c : HeldLabel) :
   Change ⟨sb++c::sa,bb++ba⟩ ⟨sb++sa,bb++c::ba⟩
 | residence (s : State) : Change s s

def reverse {before after : State} : Change before after → Change after before
 | .arrival surface rest c => .departure surface rest c
 | .departure rest bulk c => .arrival rest bulk c
 | .arrivalAt sb sa bb ba c => .departureAt sb sa bb ba c
 | .departureAt sb sa bb ba c => .arrivalAt sb sa bb ba c
 | .residence s => .residence s

theorem changeConserves {before after : State} (event : Change before after) (test : HeldLabel → Bool) :
 total test before=total test after := by
 cases event with
 | arrival surface rest c => exact arrivalPreservesEveryCarrier _ _ _ _
 | departure rest bulk c => exact departurePreservesEveryCarrier _ _ _ _
 | arrivalAt sb sa bb ba c => exact arbitraryTransferConserves _ _ _ _ _ _
 | departureAt sb sa bb ba c => exact (arbitraryTransferConserves _ _ _ _ _ _).symm
 | residence => rfl

inductive History : State → State → Type where
 | base (s : State) : History s s
 | next {initial before after : State} (prior : History initial before) (event : Change before after) : History initial after

theorem fullHistoryConserves {initial final : State} (history : History initial final) (test : HeldLabel → Bool) :
 total test initial=total test final := by
 induction history with
 | base => rfl
 | next prior event ih => exact ih.trans (changeConserves event test)

theorem countAll (word : List HeldLabel) : count (fun _ => true) word=word.length := by
 induction word with
 | nil => rfl
 | cons c rest ih => exact congrArg (fun n => n+1) ih

theorem positiveCountHasSupport (test : HeldLabel → Bool) (word : List HeldLabel)
 (positive : 0<count test word) : 0<word.length := by
 cases word with
 | nil => exact False.elim (Nat.lt_irrefl _ positive)
 | cons c rest => exact Nat.zero_lt_succ _

inductive Concentration where
 | empty
 | positive (selected support : PositiveCount)

def concentration (test : HeldLabel → Bool) (word : List HeldLabel) : Concentration :=
 if selected : 0<count test word then
  if support : 0<word.length then .positive ⟨count test word,selected⟩ ⟨word.length,support⟩ else .empty
 else .empty

def sameConcentration : Concentration → Concentration → Bool
 | .empty,.empty => true
 | .positive a x,.positive b y => decide (a.value*y.value=b.value*x.value)
 | .empty,.positive _ _ | .positive _ _,.empty => false

def distinguished (b : Boundary) (s : State) :=
 !sameConcentration (concentration (fun c => decide (c=b.adsorbate)) s.surface)
  (concentration (fun c => decide (c=b.adsorbate)) s.bulk)

theorem positiveConcentrationExact (test : HeldLabel → Bool) (word : List HeldLabel)
 (selected : 0<count test word) (support : 0<word.length) :
 concentration test word=.positive ⟨count test word,selected⟩ ⟨word.length,support⟩ := by
 unfold concentration
 rw [dif_pos selected,dif_pos support]

theorem twoPositiveConcentrationsDiffer (a x b y : PositiveCount)
 (different : a.value*y.value≠b.value*x.value) :
 sameConcentration (.positive a x) (.positive b y)=false := decide_eq_false different

theorem emptyAndPresentDiffer (a x : PositiveCount) :
 sameConcentration .empty (.positive a x)=false ∧ sameConcentration (.positive a x) .empty=false := ⟨rfl,rfl⟩

structure Record where
 boundary : Boundary
 initial : State
 current : State
 history : History initial current
 completeCarrierSupport : initial.surface.length+initial.bulk.length=boundary.raw.carriers.value
 localized : boundary.adsorbate∈current.surface
 concentrationDistinguished : distinguished boundary current=true

def sourceTrace (r : Record) :=
 (r.boundary.raw,r.boundary.adsorbate,r.boundary.adsorbent,r.boundary.conditions,
 r.boundary.sourceRecord,r.initial,r.current,r.history)

theorem currentCarrierSupport (r : Record) :
 r.current.surface.length+r.current.bulk.length=r.boundary.raw.carriers.value := by
 have h := fullHistoryConserves r.history (fun _ => true)
 unfold total at h
 rw [countAll,countAll,countAll,countAll] at h
 exact h.symm.trans r.completeCarrierSupport

theorem observedSurfaceResidence (r : Record) : r.boundary.adsorbate∈r.current.surface := r.localized

theorem sourceCountRecurs (r : Record) (test : HeldLabel → Bool) : total test r.initial=total test r.current :=
 fullHistoryConserves r.history test

def extendedHistory (r : Record) {after : State} (event : Change r.current after) : History r.initial after :=
 .next r.history event

theorem successorSourceCount (r : Record) {after : State} (event : Change r.current after) (test : HeldLabel → Bool) :
 total test r.initial=total test after := fullHistoryConserves (extendedHistory r event) test

end SFT.Chemistry.SurfaceAdsorption
