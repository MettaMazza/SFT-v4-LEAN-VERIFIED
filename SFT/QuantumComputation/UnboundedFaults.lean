import SFT.QuantumComputation.ReversibleCorrection
import SFT.InformationScience.CompressionSupport
import SFT.Foundation.FractionReduction
import SFT.Mathematics.OrbitLoopCompletion
import SFT.InformationScience.QuantityPairs
namespace SFT.QuantumComputation.UnboundedFaults
open SFT.Mathematics.DiscreteObjects
open ReversibleFaults

def forcedWidth (trace : List String) : Except String Nat :=
 if trace.isEmpty || !distinct trace then .error "fault order must be a nonempty generated trace"
 else .ok (2*trace.length+1)

def decode (word : List String) : Except String String :=
 if word.isEmpty || word.any (fun label => !has ["held","returned"] label) then
  .error "word contains an unregistered label"
 else
  let held := labelCount "held" word
  let returned := labelCount "returned" word
  if held=returned then .ok "no-strict-majority"
  else if returned<held then .ok "held" else .ok "returned"

def checkMasks (label opposite : String) (width : Nat) : List (List Nat) → Except String Bool
 | [] => .ok true
 | mask::rest =>
  match decode (changeFrom mask opposite 0 (List.replicate width label)) with
  | .error e => .error e
  | .ok recovered => if recovered=label then checkMasks label opposite width rest else .ok false

def exhaustiveSmallFaultCensus (label : String) (trace : List String) : Except String Bool :=
 match forcedWidth trace with
 | .error e => .error e
 | .ok width => checkMasks label (if label="held" then "returned" else "held") width (faultMasks width trace.length)

def predecessorWord (width : Nat) : List String :=
 (List.range width).map (fun position => if position<(width+1)/2 then "returned" else "held")

def shorterWidthsFail (trace : List String) : Bool :=
 (List.range (2*trace.length)).all (fun i =>
  let width := i+1
  (width+1)/2≤trace.length &&
   match decode (predecessorWord width) with
   | .ok recovered => recovered != "held"
   | .error _ => false)

def worstMaskWord (label : String) (allowance width : Nat) : List String :=
 (List.range width).map (fun position =>
  if position<allowance then (if label="held" then "returned" else "held") else label)

def recoverWord (source : List String) (allowance width : Nat) : Except String (List String) :=
 match source with
 | [] => .ok []
 | label::rest =>
  match decode (worstMaskWord label allowance width) with
  | .error e => .error e
  | .ok recovered =>
   match recoverWord rest allowance width with
   | .error e => .error e
   | .ok tail => .ok (recovered::tail)

def checkSources (allowance width : Nat) : List (List String) → Except String Bool
 | [] => .ok true
 | source::rest =>
  match recoverWord source allowance width with
  | .error e => .error e
  | .ok recovered => if recovered=source then checkSources allowance width rest else .ok false

def depthSevenRoundTrip (trace : List String) : Except String Bool :=
 match forcedWidth trace with
 | .error e => .error e
 | .ok width => checkSources trace.length width (SFT.InformationScience.QuantitySupport.words ["held","returned"] 7)

theorem admittedWidth (trace : List String) (nonempty : trace.isEmpty=false)
 (generated : distinct trace=true) : forcedWidth trace=.ok (2*trace.length+1) := by
 rw [forcedWidth,nonempty,generated]; rfl

theorem widthSuccessor (t : Nat) : 2*(t+1)+1=(2*t+1)+2 := by
 rw [Nat.mul_add]

theorem redundancy (t : Nat) : (2*t+1)-1=2*t := rfl

theorem oldSuccessfulDecoder (word : List String) (label : String)
 (accepted : ReversibleFaults.decode word=.ok label) : decode word=.ok label := by
 unfold ReversibleFaults.decode at accepted
 unfold decode
 split at accepted
 · cases accepted
 · rename_i guard
   rw [ite_eq_right guard]
   dsimp only at accepted ⊢
   split at accepted
   · cases accepted
   · rename_i unequal
     rw [ite_eq_right unequal]
     exact accepted

theorem everyHeldMask (mask : List Nat) (t : Nat) (bounded : mask.length≤t) :
 decode (changeFrom mask "returned" 0 (List.replicate (2*t+1) "held"))=.ok "held" :=
 oldSuccessfulDecoder _ _ (heldCorrection mask t bounded)

theorem everyReturnedMask (mask : List Nat) (t : Nat) (bounded : mask.length≤t) :
 decode (changeFrom mask "held" 0 (List.replicate (2*t+1) "returned"))=.ok "returned" :=
 oldSuccessfulDecoder _ _ (returnedCorrection mask t bounded)
open SFT.Foundation.FractionReduction

theorem predecessorAllowance (w t : Nat) (bounded : w≤2*t) : (w+1)/2≤t := by
 have eq := remainderQuotient (w+1) 2 (by decide)
 have small : 2*((w+1)/2)≤w+1 := by
  calc
   _ ≤ (w+1)%2 + 2*((w+1)/2) := Nat.le_add_left _ _
   _ = w+1 := eq
 cases Nat.le_total ((w+1)/2) t with
 | inl h => exact h
 | inr h =>
  by_cases same : (w+1)/2=t
  · exact Nat.le_of_eq same
  · have strict := Nat.lt_of_le_of_ne h (Ne.symm same)
    have large := Nat.mul_le_mul_left 2 strict
    rw [Nat.mul_succ] at large
    have impossible := Nat.le_trans large (Nat.le_trans small (Nat.succ_le_succ bounded))
    exact False.elim (Nat.not_succ_le_self (2*t+1) impossible)

theorem predecessorTwiceCover (w : Nat) : w≤2*((w+1)/2) := by
 have eq := remainderQuotient (w+1) 2 (by decide)
 have rem := Nat.le_of_lt_succ (Nat.mod_lt (w+1) (by decide : 0<2))
 have h := Nat.add_le_add_right rem (2*((w+1)/2))
 rw [eq,Nat.add_comm 1] at h
 exact Nat.le_of_succ_le_succ h

theorem predecessorNoMajority (w : Nat) : w-(w+1)/2≤(w+1)/2 := by
 have h := Nat.sub_le_sub_right (predecessorTwiceCover w) ((w+1)/2)
 rw [Nat.two_mul,SFT.Foundation.ExactCast.addSubtract] at h
 exact h

theorem retainedMajority (t wrong : Nat) (bounded : wrong≤t) : t+1≤(2*t+1)-wrong := by
 have small : wrong≤2*t+1 := by
  rw [Nat.two_mul]
  exact Nat.le_trans bounded (Nat.le_trans (Nat.le_add_right t t) (Nat.le_succ _))
 have eq := subtractAdd (2*t+1) wrong small
 cases Nat.le_total (t+1) ((2*t+1)-wrong) with
 | inl h => exact h
 | inr h =>
  by_cases same : (2*t+1)-wrong=t+1
  · exact Nat.le_of_eq same.symm
  · have strict := Nat.lt_of_le_of_ne h same
    have bound := Nat.le_trans (Nat.add_le_add (Nat.le_of_lt_succ strict) bounded) (Nat.le_refl _)
    rw [eq,← Nat.two_mul] at bound
    exact False.elim (Nat.not_succ_le_self _ bound)

theorem countAppend (label : String) (left right : List String) :
 labelCount label (left++right)=labelCount label left+labelCount label right := by
 induction left with
 | nil => exact (Nat.zero_add _).symm
 | cons first rest ih =>
  change labelCount label (first::(rest++right))=_
  rw [labelCount,labelCount]
  split
  · rw [ih,Nat.add_right_comm]
  · exact ih

theorem minimumRight (a b : Nat) (h : b≤a) : min a b=b := by
 by_cases left : a≤b
 · rw [Nat.min_eq_left left]; exact Nat.le_antisymm left h
 · exact ite_eq_right left

theorem predecessorReturnedCount (width cut : Nat) :
 labelCount "returned" ((List.range width).map (fun i => if i<cut then "returned" else "held"))=min cut width := by
 induction width with
 | zero => rw [minimumRight cut 0 (Nat.zero_le _)]; rfl
 | succ width ih =>
  rw [SFT.Mathematics.OrbitLoopCompletion.rangeSuccessor,SFT.InformationScience.QuantityPairs.mapAppend,countAppend,ih]
  change min cut width + labelCount "returned" [if width<cut then "returned" else "held"]=min cut (width+1)
  by_cases h : width<cut
  · rw [ite_eq_left h]; rw [minimumRight _ _ (Nat.le_of_lt h),minimumRight _ _ h]; rfl
  · rw [ite_eq_right h]; rw [Nat.min_eq_left (Nat.le_of_not_gt h),Nat.min_eq_left (Nat.le_trans (Nat.le_of_not_gt h) (Nat.le_succ _))]; rfl

theorem predecessorHeldCount (width cut : Nat) :
 labelCount "held" ((List.range width).map (fun i => if i<cut then "returned" else "held"))=width-min cut width := by
 induction width with
 | zero => rw [minimumRight cut 0 (Nat.zero_le _)]; rfl
 | succ width ih =>
  rw [SFT.Mathematics.OrbitLoopCompletion.rangeSuccessor,SFT.InformationScience.QuantityPairs.mapAppend,countAppend,ih]
  change width-min cut width + labelCount "held" [if width<cut then "returned" else "held"]=(width+1)-min cut (width+1)
  by_cases h : width<cut
  · rw [ite_eq_left h]; rw [minimumRight _ _ (Nat.le_of_lt h),minimumRight _ _ h,Nat.sub_self,Nat.sub_self]; rfl
  · rw [ite_eq_right h]; rw [Nat.min_eq_left (Nat.le_of_not_gt h),Nat.min_eq_left (Nat.le_trans (Nat.le_of_not_gt h) (Nat.le_succ _))]
    have eq := subtractAdd width cut (Nat.le_of_not_gt h)
    have sum : width+1=(width-cut+1)+cut := by rw [Nat.add_right_comm,eq]
    rw [sum,SFT.Foundation.ExactCast.addSubtract]; rfl

theorem everyPredecessorDefeatsHeld (width : Nat) : decode (predecessorWord width)≠.ok "held" := by
 unfold decode predecessorWord
 intro accepted
 split at accepted
 · cases accepted
 · dsimp only at accepted
   rw [predecessorReturnedCount,predecessorHeldCount] at accepted
   have bound : width-min ((width+1)/2) width≤min ((width+1)/2) width := by
    cases Nat.le_total ((width+1)/2) width with
    | inl h => rw [Nat.min_eq_left h]; exact predecessorNoMajority width
    | inr h => rw [minimumRight _ _ h,Nat.sub_self]; exact Nat.zero_le _
   split at accepted
   · exact (by decide : "no-strict-majority" ≠ "held") (Except.ok.inj accepted)
   · rw [ite_eq_right (Nat.not_lt_of_ge bound)] at accepted
     exact (by decide : "returned" ≠ "held") (Except.ok.inj accepted)

theorem reverseHeldCount (width cut : Nat) :
 labelCount "held" ((List.range width).map (fun i => if i<cut then "held" else "returned"))=min cut width := by
 induction width with
 | zero => rw [minimumRight cut 0 (Nat.zero_le _)]; rfl
 | succ width ih =>
  rw [SFT.Mathematics.OrbitLoopCompletion.rangeSuccessor,SFT.InformationScience.QuantityPairs.mapAppend,countAppend,ih]
  change min cut width + labelCount "held" [if width<cut then "held" else "returned"]=min cut (width+1)
  by_cases h : width<cut
  · rw [ite_eq_left h]; rw [minimumRight _ _ (Nat.le_of_lt h),minimumRight _ _ h]; rfl
  · rw [ite_eq_right h]; rw [Nat.min_eq_left (Nat.le_of_not_gt h),Nat.min_eq_left (Nat.le_trans (Nat.le_of_not_gt h) (Nat.le_succ _))]; rfl

theorem reverseReturnedCount (width cut : Nat) :
 labelCount "returned" ((List.range width).map (fun i => if i<cut then "held" else "returned"))=width-min cut width := by
 induction width with
 | zero => rw [minimumRight cut 0 (Nat.zero_le _)]; rfl
 | succ width ih =>
  rw [SFT.Mathematics.OrbitLoopCompletion.rangeSuccessor,SFT.InformationScience.QuantityPairs.mapAppend,countAppend,ih]
  change width-min cut width + labelCount "returned" [if width<cut then "held" else "returned"]=(width+1)-min cut (width+1)
  by_cases h : width<cut
  · rw [ite_eq_left h]; rw [minimumRight _ _ (Nat.le_of_lt h),minimumRight _ _ h,Nat.sub_self,Nat.sub_self]; rfl
  · rw [ite_eq_right h]; rw [Nat.min_eq_left (Nat.le_of_not_gt h),Nat.min_eq_left (Nat.le_trans (Nat.le_of_not_gt h) (Nat.le_succ _))]
    have eq := subtractAdd width cut (Nat.le_of_not_gt h)
    have sum : width+1=(width-cut+1)+cut := by rw [Nat.add_right_comm,eq]
    rw [sum,SFT.Foundation.ExactCast.addSubtract]; rfl

theorem prefixExternalGuard (items : List Nat) (cut : Nat) (original opposite : String)
 (good : has ["held","returned"] original=true) (other : has ["held","returned"] opposite=true) :
 ((items.map (fun i => if i<cut then opposite else original)).any
  (fun label => !has ["held","returned"] label))=false := by
 induction items with
 | nil => rfl
 | cons i rest ih =>
  change (!has ["held","returned"] (if i<cut then opposite else original) || _)=false
  by_cases h : i<cut
  · rw [ite_eq_left h,other,ih]; rfl
  · rw [ite_eq_right h,good,ih]; rfl

theorem prefixNonempty (width cut : Nat) (original opposite : String) :
 ((List.range (width+1)).map (fun i => if i<cut then opposite else original)).isEmpty=false := by
 rw [SFT.Mathematics.OrbitLoopCompletion.rangeSuccessor,SFT.InformationScience.QuantityPairs.mapAppend]
 cases (List.range width).map (fun i => if i<cut then opposite else original) <;> rfl

theorem worstHeldRecovers (t : Nat) : decode (worstMaskWord "held" t (2*t+1))=.ok "held" := by
 change decode ((List.range (2*t+1)).map (fun i => if i<t then "returned" else "held"))=.ok "held"
 unfold decode
 have guard := prefixExternalGuard (List.range (2*t+1)) t "held" "returned" rfl rfl
 have nonempty := prefixNonempty (2*t) t "held" "returned"
 rw [guard,nonempty]
 change (if _=_ then _ else if _<_ then _ else _)=_
 rw [predecessorReturnedCount,predecessorHeldCount]
 have bound : t≤2*t+1 := by rw [Nat.two_mul]; exact Nat.le_trans (Nat.le_add_right t t) (Nat.le_succ _)
 rw [Nat.min_eq_left bound]
 have sub : (2*t+1)-t=t+1 := by rw [Nat.two_mul,Nat.add_right_comm,SFT.Foundation.ExactCast.addSubtract]
 rw [sub,ite_eq_right (Nat.ne_of_gt (Nat.lt_succ_self t)),ite_eq_left (Nat.lt_succ_self t)]

theorem worstReturnedRecovers (t : Nat) : decode (worstMaskWord "returned" t (2*t+1))=.ok "returned" := by
 change decode ((List.range (2*t+1)).map (fun i => if i<t then "held" else "returned"))=.ok "returned"
 unfold decode
 have guard := prefixExternalGuard (List.range (2*t+1)) t "returned" "held" rfl rfl
 have nonempty := prefixNonempty (2*t) t "returned" "held"
 rw [guard,nonempty]
 change (if _=_ then _ else if _<_ then _ else _)=_
 rw [reverseHeldCount,reverseReturnedCount]
 have bound : t≤2*t+1 := by rw [Nat.two_mul]; exact Nat.le_trans (Nat.le_add_right t t) (Nat.le_succ _)
 rw [Nat.min_eq_left bound]
 have sub : (2*t+1)-t=t+1 := by rw [Nat.two_mul,Nat.add_right_comm,SFT.Foundation.ExactCast.addSubtract]
 rw [sub,ite_eq_right (Nat.ne_of_lt (Nat.lt_succ_self t)),ite_eq_right (Nat.not_lt_of_ge (Nat.le_succ t))]

theorem everySourceWordRecovers (source : List String) (t : Nat)
 (generated : ∀ label,label∈source → label="held" ∨ label="returned") :
 recoverWord source t (2*t+1)=.ok source := by
 induction source with
 | nil => rfl
 | cons label rest ih =>
  rw [recoverWord]
  cases generated label (.head _) with
  | inl same =>
   cases same
   rw [worstHeldRecovers]
   change (match recoverWord rest t (2*t+1) with
    | .error e => .error e
    | .ok tail => .ok ("held"::tail) : Except String (List String))=.ok ("held"::rest)
   rw [ih (fun x h => generated x (.tail _ h))]
  | inr same =>
   cases same
   rw [worstReturnedRecovers]
   change (match recoverWord rest t (2*t+1) with
    | .error e => .error e
    | .ok tail => .ok ("returned"::tail) : Except String (List String))=.ok ("returned"::rest)
   rw [ih (fun x h => generated x (.tail _ h))]

end SFT.QuantumComputation.UnboundedFaults
