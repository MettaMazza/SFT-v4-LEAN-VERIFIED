import SFT.Physics.SpinStatisticsCriticalSelection
namespace SFT.Physics.SpinStatisticsGroundRecord
open SpinStatisticsCondensation SpinStatisticsGroundMinimum
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects
open SFT.Foundation.CommonRefinement
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
private theorem minLeft (a b : Nat) : min a b≤a := by
 rw [Nat.min_def]
 split
 · exact Nat.le_refl _
 · rename_i h;exact Nat.le_of_lt (Nat.lt_of_not_ge h)
private theorem minRight (a b : Nat) : min a b≤b := by
 rw [Nat.min_def]
 split
 · assumption
 · exact Nat.le_refl _
private theorem minLower (n a b : Nat) (ha : n≤a) (hb : n≤b) : n≤min a b := by
 rw [Nat.min_def]
 split
 · exact ha
 · exact hb
private theorem foldRetains (forms : List (List Nat)) (acc : Nat) :
 ((forms.map (fun w => (w,totalThrow w))).foldl (fun v row => min v row.2) acc)≤acc := by
 induction forms generalizing acc with
 | nil => exact Nat.le_refl _
 | cons w ws ih => exact Nat.le_trans (ih _) (minLeft _ _)
private theorem foldIncludes (forms : List (List Nat)) (acc : Nat) (target : List Nat) (held : target∈forms) :
 ((forms.map (fun w => (w,totalThrow w))).foldl (fun v row => min v row.2) acc)≤totalThrow target := by
 induction forms generalizing acc with
 | nil => cases held
 | cons w ws ih =>
   cases held with
   | head => exact Nat.le_trans (foldRetains ws _) (minRight _ _)
   | tail _ h => exact ih _ h
private theorem foldLower (forms : List (List Nat)) (n acc : Nat)
 (all : ∀ w∈forms,n≤totalThrow w) (initial : n≤acc) :
 n≤((forms.map (fun w => (w,totalThrow w))).foldl (fun v row => min v row.2) acc) := by
 induction forms generalizing acc with
 | nil => exact initial
 | cons w ws ih => exact ih _ (fun v hv => all v (.tail w hv)) (minLower _ _ _ initial (all w (.head ws)))

theorem originalMinimumFold (particles levels : Nat) :
 (match (walk particles levels [] particles).map (fun w => (w,totalThrow w)) with
 | [] => 0
 | (_,first)::rest => rest.foldl (fun value (row : List Nat × Nat) => min value row.2) first)=particles := by
 have present := originalGroundGenerated particles levels
 have lower : ∀ w∈walk particles levels [] particles,particles≤totalThrow w := by
   intro word held
   have carrier := (SpinStatisticsOccupationBounds.originalPreservingComplete particles levels word).mp held
   rw [←carrier.2]
   exact originalThrowLowerBound word
 cases eq : walk particles levels [] particles with
 | nil => rw [eq] at present;cases present
 | cons word rest =>
   rw [eq] at present lower
   change ((rest.map (fun w => (w,totalThrow w))).foldl (fun v row => min v row.2) (totalThrow word))=particles
   apply Nat.le_antisymm
   · cases present with
     | head =>
       have bound := foldRetains rest (totalThrow (groundWord particles (levels+1)))
       rw [originalGroundAttains] at bound ⊢
       exact bound
     | tail _ h =>
       have bound := foldIncludes rest (totalThrow word) (groundWord particles (levels+1)) h
       rw [originalGroundAttains] at bound
       exact bound
   · exact foldLower rest particles _ (fun v hv => lower v (.tail word hv)) (lower word (.head rest))
private theorem mappedSelection (n : Nat) (forms : List (List Nat)) :
 (((forms.map (fun w => (w,totalThrow w))).filter (fun row => row.2==n)).map Prod.fst)=
 forms.filter (fun w => totalThrow w==n) := by
 induction forms with
 | nil => rfl
 | cons w ws ih =>
   change (((w,totalThrow w)::ws.map (fun w => (w,totalThrow w))).filter (fun row => row.2==n)).map Prod.fst=_
   cases h : totalThrow w==n with
   | false =>
     rw [List.filter_cons_of_neg (p:=fun row : List Nat×Nat => row.2==n) (fun ht => Bool.noConfusion (h.symm.trans ht)),
       List.filter_cons_of_neg (p:=fun w => totalThrow w==n) (fun ht => Bool.noConfusion (h.symm.trans ht))]
     exact ih
   | true =>
     rw [List.filter_cons_of_pos (p:=fun row : List Nat×Nat => row.2==n) h,List.filter_cons_of_pos (p:=fun w => totalThrow w==n) h]
     exact congrArg (List.cons w) ih
private theorem absentSelection (n : Nat) (target : List Nat) (forms : List (List Nat))
 (absent : ¬target∈forms) (accepted : ∀ w∈forms,(totalThrow w==n)=true → w=target) :
 forms.filter (fun w => totalThrow w==n)=[] := by
 induction forms with
 | nil => rfl
 | cons w ws ih =>
   have rejected : ¬(totalThrow w==n)=true := fun h => absent ((accepted w (.head ws) h) ▸ List.Mem.head ws)
   rw [List.filter_cons_of_neg (p:=fun w : List Nat => totalThrow w==n) rejected]
   exact ih (fun h => absent (.tail w h)) (fun v hv => accepted v (.tail w hv))
private theorem uniqueSelection (n : Nat) (target : List Nat) (forms : List (List Nat))
 (unique : distinct forms=true) (held : target∈forms)
 (accepted : ∀ w∈forms,(totalThrow w==n)=true ↔ w=target) : forms.filter (fun w => totalThrow w==n)=[target] := by
 induction forms with
 | nil => cases held
 | cons w ws ih =>
   have parts := (distinctCons _ _).mp unique
   cases decEq w target with
   | isTrue eq =>
     cases eq
     rw [List.filter_cons_of_pos (p:=fun w : List Nat => totalThrow w==n) ((accepted target (.head ws)).mpr rfl)]
     rw [absentSelection n target ws ((absentIff _ _).mp parts.1) (fun v hv => (accepted v (.tail target hv)).mp)]
   | isFalse different =>
     rw [List.filter_cons_of_neg (p:=fun w : List Nat => totalThrow w==n) (fun h => different ((accepted w (.head ws)).mp h))]
     apply ih parts.2
     · cases held with
       | head => exact False.elim (different rfl)
       | tail _ h => exact h
     · exact fun v hv => accepted v (.tail w hv)

theorem originalGroundSurvivorList (particles levels : Nat) :
 ((((walk particles levels [] particles).map (fun w => (w,totalThrow w))).filter (fun row => row.2==particles)).map Prod.fst)=
 [groundWord particles (levels+1)] := by
 rw [mappedSelection]
 apply uniqueSelection _ _ _ (SpinStatisticsOccupationEnumeration.originalWalkUnique _ _ _ _) (originalGroundGenerated particles levels)
 intro word held
 constructor
 · intro accepted
   cases decEq word (groundWord particles (levels+1)) with
   | isTrue eq => exact eq
   | isFalse different =>
     have strict := originalExcitedThrowStrict particles levels word held different
     rw [Nat.eq_of_beq_eq_true accepted] at strict
     exact False.elim (Nat.lt_irrefl _ strict)
 · intro eq
   rw [eq,originalGroundAttains]
   exact naturalEqualityReflexive _
private theorem wordEquality (word : List Nat) : (word==word)=true := by
 induction word with
 | nil => rfl
 | cons c cs ih =>
   change ((c==c)&&(cs==cs))=true
   rw [naturalEqualityReflexive,ih]
   rfl

theorem originalEveryGroundCertificate (p l : Nat) :
 minimalThrowGroundCertificate (.integer (.ofNat (p+1))) (.integer (.ofNat (l+1)))=
 .ok ⟨p+1,[groundWord (p+1) (l+1)],true⟩ := by
 unfold minimalThrowGroundCertificate
 rw [SpinStatisticsOccupationEnumeration.originalPreservingOperation]
 let forms := (walk (p+1) l [] (p+1)).map (fun w => (w,totalThrow w))
 let least : Nat := match forms with
   | [] => 0
   | (_,first)::rest => rest.foldl (fun value (row : List Nat × Nat) => min value row.2) first
 let survivors := (forms.filter (fun (row : List Nat × Nat) => row.2==least)).map Prod.fst
 change Except.ok (⟨least,survivors,survivors==[groundWord (p+1) (l+1)]⟩ : GroundCertificate)=_
 dsimp only [survivors,least,forms]
 rw [originalMinimumFold,originalGroundSurvivorList]
 have equality : ([groundWord (p+1) (l+1)]==[groundWord (p+1) (l+1)])=true := by
   change ((groundWord (p+1) (l+1)==groundWord (p+1) (l+1))&&true)=true
   rw [wordEquality]
   rfl
 rw [equality]
end SFT.Physics.SpinStatisticsGroundRecord
