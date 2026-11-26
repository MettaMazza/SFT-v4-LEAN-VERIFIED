import SFT.Chemistry.InsertionElimination
namespace SFT.Chemistry.InsertionEliminationDerivation
open SFT.Physics.CapabilityValues InsertionElimination
theorem traceRetains (cs : List HeldLabel) (before after removed added : List Edge)
 (cl : HeldLabel) (composition : List HeldLabel) (out : Trace)
 (h : trace cs before after removed added cl composition=.ok out) :
 out=⟨cs,before,after,removed,added,cl,composition⟩ := by
 unfold trace at h
 repeat first | split at h | cases h | rfl
theorem insertionDerivation (x z y : HeldLabel) (out : Trace) (h : insertionHeld x z y=.ok out) :
 out.carriers=[x,z,y] ∧ out.before=[edge x z] ∧ out.after=[edge x y,edge y z] ∧
 out.removed=[edge x z] ∧ out.added=[edge x y,edge y z] ∧ out.composition.map HeldLabel.label=["insertion"] := by
 have kept := traceRetains [x,z,y] [edge x z] [edge x y,edge y z] [edge x z] [edge x y,edge y z]
  ⟨"organometallic-pathway","insertion",rfl,rfl⟩ [⟨"process-component","insertion",rfl,rfl⟩] out h
 cases kept
 exact ⟨rfl,rfl,rfl,rfl,rfl,rfl⟩
theorem migratoryDerivation (m x y : HeldLabel) (out : Trace) (h : migratoryHeld m x y=.ok out) :
 out.carriers=[m,x,y] ∧ out.before=[edge m x,edge m y] ∧ out.after=[edge m y,edge x y] ∧
 out.removed=[edge m x] ∧ out.added=[edge x y] ∧ out.composition.map HeldLabel.label=["migration","insertion"] := by
 have kept := traceRetains [m,x,y] [edge m x,edge m y] [edge m y,edge x y] [edge m x] [edge x y]
  ⟨"organometallic-pathway","migratory-insertion",rfl,rfl⟩
  [⟨"process-component","migration",rfl,rfl⟩,⟨"process-component","insertion",rfl,rfl⟩] out h
 cases kept
 exact ⟨rfl,rfl,rfl,rfl,rfl,rfl⟩
theorem extrusionRetains (t out : Trace) (h : extrusion t=.ok out) :
 out.carriers=t.carriers ∧ out.before=t.after ∧ out.after=t.before ∧
 out.removed=t.added ∧ out.added=t.removed ∧ out.pathwayClass.label="extrusion" ∧
 out.composition.map HeldLabel.label=["reverse-insertion"] := by
 unfold extrusion at h
 split at h
 · cases h
 · have kept := traceRetains t.carriers t.after t.before t.added t.removed
    ⟨"organometallic-pathway","extrusion",rfl,rfl⟩ [⟨"process-component","reverse-insertion",rfl,rfl⟩] out h
   cases kept
   exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
theorem reversedTraceAccepted (cs : List HeldLabel) (before after removed added : List Edge)
 (cl : HeldLabel) (composition : List HeldLabel) (out : Trace)
 (h : trace cs before after removed added cl composition=.ok out) :
 trace cs after before added removed ⟨"organometallic-pathway","extrusion",rfl,rfl⟩
  [⟨"process-component","reverse-insertion",rfl,rfl⟩]=
 .ok ⟨cs,after,before,added,removed,⟨"organometallic-pathway","extrusion",rfl,rfl⟩,
  [⟨"process-component","reverse-insertion",rfl,rfl⟩]⟩ := by
 have anyAppend : ∀ (f : Edge → Bool) (xs ys : List Edge), (xs++ys).any f=(xs.any f || ys.any f) := by
  intro f xs
  induction xs with
  | nil => intro ys; rfl
  | cons x xs ih =>
   intro ys
   change (f x || (xs++ys).any f) = ((f x || xs.any f) || ys.any f)
   rw [ih]
   cases f x <;> rfl
 have swap : ∀ (f : Edge → Bool) (xs ys : List Edge), (xs++ys).any f=(ys++xs).any f := by
  intro f xs ys
  rw [anyAppend,anyAppend]
  cases xs.any f <;> cases ys.any f <;> rfl
 have orSwap : ∀ a b : Bool, (a||b)=(b||a) := by intro a b; cases a <;> cases b <;> rfl
 unfold trace at h ⊢
 rw [swap (fun e => InorganicColour.sameLabel e.1 e.2) after before,
  orSwap (!distinctEdges after) (!distinctEdges before),
  orSwap (!sameSet added (difference after before)) (!sameSet removed (difference before after)),
  swap (fun e => !cs.any (InorganicColour.sameLabel e.1) || !cs.any (InorganicColour.sameLabel e.2)) after before]
 repeat first | split at h | cases h
 rename_i h1 h2 h3 h4 h5 h6
 rw [if_neg h1,if_neg h2,if_neg h3,if_neg h4,if_neg h5]
 rfl
theorem insertionInverseExists (x z y : HeldLabel) (t : Trace) (h : insertionHeld x z y=.ok t) :
 extrusion t=.ok ⟨t.carriers,t.after,t.before,t.added,t.removed,
  ⟨"organometallic-pathway","extrusion",rfl,rfl⟩,[⟨"process-component","reverse-insertion",rfl,rfl⟩]⟩ := by
 have accepted := reversedTraceAccepted [x,z,y] [edge x z] [edge x y,edge y z] [edge x z] [edge x y,edge y z]
  ⟨"organometallic-pathway","insertion",rfl,rfl⟩ [⟨"process-component","insertion",rfl,rfl⟩] t h
 have kept := traceRetains [x,z,y] [edge x z] [edge x y,edge y z] [edge x z] [edge x y,edge y z]
  ⟨"organometallic-pathway","insertion",rfl,rfl⟩ [⟨"process-component","insertion",rfl,rfl⟩] t h
 cases kept
 exact accepted
theorem eliminationDerivation (a b x y : HeldLabel) (out : Trace) (h : eliminationHeld a b x y=.ok out) :
 out.carriers=OxidativeReductive.uniqueLabels [a,b,x,y] ∧
 out.before=uniqueEdges [edge a x,edge b y] ∧ out.removed=out.before ∧ out.after=out.added ∧
 out.added=(if !InorganicColour.sameLabel a b then [edge a b] else [edge x y]) ∧
 out.composition.map HeldLabel.label=["two-eliminand-loss","new-unsaturation-ring-or-carbene-boundary"] := by
 have kept := traceRetains _ _ _ _ _
  ⟨"organometallic-pathway","elimination",rfl,rfl⟩
  [⟨"process-component","two-eliminand-loss",rfl,rfl⟩,⟨"product-class","new-unsaturation-ring-or-carbene-boundary",rfl,rfl⟩] out h
 cases kept
 exact ⟨rfl,rfl,rfl,rfl,rfl,rfl⟩
theorem traceDifferences (cs : List HeldLabel) (before after removed added : List Edge)
 (cl : HeldLabel) (composition : List HeldLabel) (out : Trace)
 (h : trace cs before after removed added cl composition=.ok out) :
 sameSet out.removed (difference out.before out.after)=true ∧ sameSet out.added (difference out.after out.before)=true := by
 unfold trace at h
 repeat first | split at h | cases h
 rename_i h1 h2 h3 h4 h5 h6
 change sameSet removed (difference before after)=true ∧ sameSet added (difference after before)=true
 cases hr : sameSet removed (difference before after) <;> cases ha : sameSet added (difference after before)
 · exact False.elim (h4 (by rw [hr,ha]; rfl))
 · exact False.elim (h4 (by rw [hr,ha]; rfl))
 · exact False.elim (h4 (by rw [hr,ha]; rfl))
 · exact ⟨rfl,rfl⟩
theorem matchedTraceExtension (previous out : Trace) (after removed added : List Edge)
 (cl : HeldLabel) (composition : List HeldLabel)
 (h : trace previous.carriers previous.after after removed added cl composition=.ok out) :
 out.carriers=previous.carriers ∧ out.before=previous.after ∧ out.after=after ∧
 sameSet out.removed (difference out.before out.after)=true ∧ sameSet out.added (difference out.after out.before)=true := by
 have diffs := traceDifferences _ _ _ _ _ _ _ out h
 have kept := traceRetains _ _ _ _ _ _ _ out h
 cases kept
 exact ⟨rfl,rfl,rfl,diffs⟩
end SFT.Chemistry.InsertionEliminationDerivation
