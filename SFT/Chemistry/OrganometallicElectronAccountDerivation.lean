import SFT.Chemistry.OrganometallicElectronAccount
namespace SFT.Chemistry.OrganometallicElectronAccountDerivation
open SFT.Physics.CapabilityValues OrganometallicElectronAccount
theorem capacityFromWidths : forcedCapacity.value=(2+6)+10 := rfl
theorem structuralAbsence (entity a b : String) : forced entity (.empty a) (.empty b)=.ok (.empty "empty-One") := rfl
theorem accountRetains (entity : HeldLabel) (nb bd : PairSupport) (n cap : PositiveCount)
 (rel mag : HeldLabel) (out : Account) (h : account entity nb bd n cap rel mag=.ok out) :
 out=⟨entity,nb,bd,n,cap,rel,mag⟩ := by
 unfold account at h
 dsimp only at h
 repeat first | split at h | (cases h) | rfl
theorem forceRetains (entity : String) (nb bd : PairSupport) (out : Account)
 (h : forcePositive entity nb bd=.ok out) :
 out.nonbonded=nb ∧ out.bond=bd ∧ out.electronCount.value=(supportRows nb++supportRows bd).flatten.length ∧ out.capacity.value=18 ∧ out.magneticClass.label="diamagnetic" := by
 unfold forcePositive at h
 cases hn : count ((supportRows nb++supportRows bd).flatten.length) with
 | error e => rw [hn] at h; cases h
 | ok n =>
  rw [hn] at h
  cases he : heldLabel "organometallic-entity" entity with
  | error e => rw [he] at h; cases h
  | ok e =>
   rw [he] at h
   change (do
    let rel ← heldLabel "capacity-relation" (if n.value==forcedCapacity.value then "capacity-complete" else "capacity-incomplete")
    account e nb bd n forcedCapacity rel ⟨"magnetic-class","diamagnetic",rfl,rfl⟩)=.ok out at h
   cases hr : heldLabel "capacity-relation" (if n.value==forcedCapacity.value then "capacity-complete" else "capacity-incomplete") with
   | error x => rw [hr] at h; cases h
   | ok rel =>
    rw [hr] at h
    have kept := accountRetains e nb bd n forcedCapacity rel ⟨"magnetic-class","diamagnetic",rfl,rfl⟩ out h
    cases kept
    have counted : n.value=(supportRows nb++supportRows bd).flatten.length := by
     unfold count at hn
     split at hn
     · cases hn; rfl
     · cases hn
    exact ⟨rfl,rfl,counted,rfl,rfl⟩
theorem forceEntity (entity : String) (nb bd : PairSupport) (out : Account)
 (h : forcePositive entity nb bd=.ok out) : out.entity.label=entity := by
 unfold forcePositive at h
 cases hn : count ((supportRows nb++supportRows bd).flatten.length) with
 | error e => rw [hn] at h; cases h
 | ok n =>
  rw [hn] at h
  cases he : heldLabel "organometallic-entity" entity with
  | error e => rw [he] at h; cases h
  | ok e =>
   rw [he] at h
   change (do
    let rel ← heldLabel "capacity-relation" (if n.value==forcedCapacity.value then "capacity-complete" else "capacity-incomplete")
    account e nb bd n forcedCapacity rel ⟨"magnetic-class","diamagnetic",rfl,rfl⟩)=.ok out at h
   cases hr : heldLabel "capacity-relation" (if n.value==forcedCapacity.value then "capacity-complete" else "capacity-incomplete") with
   | error x => rw [hr] at h; cases h
   | ok rel =>
    rw [hr] at h
    have kept := accountRetains e nb bd n forcedCapacity rel ⟨"magnetic-class","diamagnetic",rfl,rfl⟩ out h
    cases kept
    unfold heldLabel at he
    split at he
    · split at he
      · cases he; rfl
      · cases he
    · cases he
theorem capacityHalt (a : Account) (destination : String) (full : (a.electronCount.value==a.capacity.value)=true) :
 appendPair a destination=.error "capacity-complete account rejects an additional pair" := by
 unfold appendPair
 rw [full]
 rfl
def electrons (nb bd : PairSupport) : List HeldLabel := (supportRows nb++supportRows bd).flatten
theorem pairExtensionCount (before : List (List HeldLabel)) (a b : HeldLabel) :
 (before++[[a,b]]).flatten.length=before.flatten.length+2 := by
 induction before with
 | nil => rfl
 | cons row rest ih =>
  change (row++(rest++[[a,b]]).flatten).length=(row++rest.flatten).length+2
  rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,ih]
  exact (Nat.add_assoc _ _ _).symm
theorem bondExtensionRetains (entity : String) (nb bd : PairSupport) (a b : HeldLabel) (out : Account)
 (h : forcePositive entity nb (.rows (supportRows bd++[[a,b]]))=.ok out) :
 out.nonbonded=nb ∧ out.bond=.rows (supportRows bd++[[a,b]]) ∧ out.entity.label=entity ∧ out.magneticClass.label="diamagnetic" :=
 ⟨(forceRetains entity nb _ out h).1,(forceRetains entity nb _ out h).2.1,forceEntity entity nb _ out h,(forceRetains entity nb _ out h).2.2.2.2⟩
theorem bondExtensionCount (entity : String) (nb bd : PairSupport) (a b : HeldLabel) (out : Account)
 (h : forcePositive entity nb (.rows (supportRows bd++[[a,b]]))=.ok out) :
 out.electronCount.value=(electrons nb bd).length+2 := by
 have counted := (forceRetains entity nb _ out h).2.2.1
 change out.electronCount.value=(supportRows nb++(supportRows bd++[[a,b]])).flatten.length at counted
 have assoc : ∀ xs ys zs : List (List HeldLabel), (xs++ys)++zs=xs++(ys++zs) := by
  intro xs ys zs
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons x) ih
 rw [← assoc] at counted
 exact counted.trans (pairExtensionCount _ a b)
def pairedRows : List (List HeldLabel) → Prop
 | [] => True
 | p::ps => p.length=2 ∧ pairedRows ps
theorem generatedPairShape (stem : String) (n : PositiveCount) (pairs : List (List HeldLabel))
 (generated : completePairs stem n=.ok pairs) : pairedRows pairs ∧ pairs.length=n.value := by
 let f := fun i => do
  let base := SFT.Host.Text.intercalate "-" [stem,toString (i+1)]
  let a ← heldLabel "held-electron-occurrence" (SFT.Host.Text.append base "-fibre-a")
  let b ← heldLabel "held-electron-occurrence" (SFT.Host.Text.append base "-fibre-b")
  (pure [a,b] : Except String (List HeldLabel))
 have single : ∀ i p, f i=.ok p → p.length=2 := by
  intro i p h
  dsimp [f] at h
  cases ha : heldLabel "held-electron-occurrence" (SFT.Host.Text.append (SFT.Host.Text.intercalate "-" [stem,toString (i+1)]) "-fibre-a") with
  | error e => rw [ha] at h; cases h
  | ok a =>
   rw [ha] at h
   cases hb : heldLabel "held-electron-occurrence" (SFT.Host.Text.append (SFT.Host.Text.intercalate "-" [stem,toString (i+1)]) "-fibre-b") with
   | error e => rw [hb] at h; cases h
   | ok b => rw [hb] at h; cases h; rfl
 have rev : ∀ (xs acc : List (List HeldLabel)), pairedRows xs → pairedRows acc →
   pairedRows (xs.reverseAux acc) ∧ (xs.reverseAux acc).length=xs.length+acc.length := by
  intro xs
  induction xs with
  | nil => intro acc hx ha; exact ⟨ha,(Nat.zero_add _).symm⟩
  | cons x xs ih =>
   intro acc hx ha
   have z := ih (x::acc) hx.2 ⟨hx.1,ha⟩
   exact ⟨z.1,z.2.trans (Nat.add_right_comm xs.length acc.length 1)⟩
 have loop : ∀ (xs : List Nat) (acc result : List (List HeldLabel)), pairedRows acc →
  List.mapM.loop f xs acc=.ok result → pairedRows result ∧ result.length=xs.length+acc.length := by
  intro xs
  induction xs with
  | nil =>
   intro acc result ha h
   change Except.ok acc.reverse=Except.ok result at h
   cases h
   have z := rev acc [] ha True.intro
   exact ⟨z.1,z.2.trans (Nat.zero_add acc.length).symm⟩
  | cons x xs ih =>
   intro acc result ha h
   unfold List.mapM.loop at h
   cases hf : f x with
   | error e => rw [hf] at h; cases h
   | ok p =>
    rw [hf] at h
    have z := ih (p::acc) result ⟨single x p hf,ha⟩ h
    exact ⟨z.1,z.2.trans (Nat.add_right_comm xs.length acc.length 1)⟩
 have rangeLen : ∀ k (acc : List Nat), (List.range.loop k acc).length=k+acc.length := by
  intro k
  induction k with
  | zero => intro acc; exact (Nat.zero_add _).symm
  | succ k ih => intro acc; exact (ih (k::acc)).trans (Nat.add_right_comm k acc.length 1)
 have z := loop (List.range n.value) [] pairs True.intro generated
 exact ⟨z.1,z.2.trans (rangeLen n.value [])⟩
theorem generatedLastPair (stem : String) (n : PositiveCount) (pairs : List (List HeldLabel))
 (generated : completePairs stem n=.ok pairs) : (pairs.getLastD []).length=2 := by
 have z := generatedPairShape stem n pairs generated
 have last : ∀ (xs : List (List HeldLabel)) (fallback : List HeldLabel), pairedRows xs → fallback.length=2 → (xs.getLastD fallback).length=2 := by
  intro xs
  induction xs with
  | nil => intro fallback hs hf; exact hf
  | cons x xs ih => intro fallback hs hf; rw [List.getLastD_cons]; exact ih x hs.2 hs.1
 cases pairs with
 | nil => have bad : 0<n.value := n.positive; rw [← z.2] at bad; cases bad
 | cons x xs => rw [List.getLastD_cons]; exact last xs x z.1.2 z.1.1

theorem partitionElectronCount (xs ys : List (List HeldLabel)) :
 (xs++ys).flatten.length=xs.flatten.length+ys.flatten.length := by
 induction xs with
 | nil => exact (Nat.zero_add _).symm
 | cons x xs ih =>
  change (x++(xs++ys).flatten).length=(x++xs.flatten).length+ys.flatten.length
  rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,ih]
  exact (Nat.add_assoc _ _ _).symm
theorem appendBondDerivation (a out : Account) (h : appendPair a "bond"=.ok out) :
 ∃ pair : List HeldLabel, pair.length=2 ∧ out.nonbonded=a.nonbonded ∧
 out.bond=.rows (supportRows a.bond++[pair]) ∧ out.entity.label=a.entity.label ∧
 out.electronCount.value=(electrons a.nonbonded a.bond).length+2 ∧ out.magneticClass.label="diamagnetic" := by
 unfold appendPair at h
 dsimp only at h
 split at h
 · cases h
 · change (do
    let generated ← completePairs "bond" ⟨(supportRows a.bond).length+1,Nat.zero_lt_succ _⟩
    forcePositive a.entity.label a.nonbonded (.rows (supportRows a.bond++[generated.getLastD []])))=.ok out at h
   cases hg : completePairs "bond" ⟨(supportRows a.bond).length+1,Nat.zero_lt_succ _⟩ with
   | error e => rw [hg] at h; cases h
   | ok generated =>
    rw [hg] at h
    have size := generatedLastPair "bond" _ generated hg
    have kept := forceRetains a.entity.label a.nonbonded (.rows (supportRows a.bond++[generated.getLastD []])) out h
    have counted := kept.2.2.1
    change out.electronCount.value=(supportRows a.nonbonded++(supportRows a.bond++[generated.getLastD []])).flatten.length at counted
    rw [partitionElectronCount,partitionElectronCount] at counted
    have singleLen : ([generated.getLastD []] : List (List HeldLabel)).flatten.length=2 := by
     change (generated.getLastD []++[]).length=2
     rw [SFT.Foundation.CommonRefinement.appendLength]
     exact size
    rw [singleLen] at counted
    have finalCount : out.electronCount.value=(electrons a.nonbonded a.bond).length+2 := by
     unfold electrons
     rw [partitionElectronCount]
     exact counted.trans (Nat.add_assoc _ _ _).symm
    exact ⟨generated.getLastD [],size,kept.1,kept.2.1,forceEntity _ _ _ out h,finalCount,kept.2.2.2.2⟩
theorem appendNonbondedDerivation (a out : Account) (h : appendPair a "nonbonded"=.ok out) :
 ∃ pair : List HeldLabel, pair.length=2 ∧ out.nonbonded=.rows (supportRows a.nonbonded++[pair]) ∧
 out.bond=a.bond ∧ out.entity.label=a.entity.label ∧
 out.electronCount.value=(electrons a.nonbonded a.bond).length+2 ∧ out.magneticClass.label="diamagnetic" := by
 unfold appendPair at h
 dsimp only at h
 split at h
 · cases h
 · change (do
    let generated ← completePairs "nonbonded" ⟨(supportRows a.nonbonded).length+1,Nat.zero_lt_succ _⟩
    forcePositive a.entity.label (.rows (supportRows a.nonbonded++[generated.getLastD []])) a.bond)=.ok out at h
   cases hg : completePairs "nonbonded" ⟨(supportRows a.nonbonded).length+1,Nat.zero_lt_succ _⟩ with
   | error e => rw [hg] at h; cases h
   | ok generated =>
    rw [hg] at h
    have size := generatedLastPair "nonbonded" _ generated hg
    have kept := forceRetains a.entity.label (.rows (supportRows a.nonbonded++[generated.getLastD []])) a.bond out h
    have counted := kept.2.2.1
    change out.electronCount.value=((supportRows a.nonbonded++[generated.getLastD []])++supportRows a.bond).flatten.length at counted
    rw [partitionElectronCount,partitionElectronCount] at counted
    have singleLen : ([generated.getLastD []] : List (List HeldLabel)).flatten.length=2 := by
     change (generated.getLastD []++[]).length=2
     rw [SFT.Foundation.CommonRefinement.appendLength]
     exact size
    rw [singleLen] at counted
    have finalCount : out.electronCount.value=(electrons a.nonbonded a.bond).length+2 := by
     unfold electrons
     rw [partitionElectronCount]
     exact counted.trans (Nat.add_right_comm _ _ _)
    exact ⟨generated.getLastD [],size,kept.1,kept.2.1,forceEntity _ _ _ out h,finalCount,kept.2.2.2.2⟩

end SFT.Chemistry.OrganometallicElectronAccountDerivation
