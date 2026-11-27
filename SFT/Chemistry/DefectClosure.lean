import SFT.Chemistry.DefectDerivation
namespace SFT.Chemistry.DefectClosure
open SFT.Physics.CapabilityValues DefectChemistry
set_option maxHeartbeats 20000000
set_option maxRecDepth 10000

theorem retains (motif : HeldLabel) (rs : List ReferenceSite) (os : List Occupancy) (is : List Interstitial)
 (rf of : List FormulaEntry) (rows : List Reconciliation) (cs : Classes) (org : Value) (out : Defect)
 (h : defect motif rs os is rf of rows cs org=.ok out) :
 out=⟨motif,rs,os,is,rf,of,rows,cs,org⟩ := by
 unfold defect at h
 cases href : primitiveFormula (rs.map (fun r => r.expected.label)) with
 | error err =>
  rw [href] at h
  try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
  repeat' first | split at h | cases h | rfl
 | ok ref =>
  rw [href] at h
  try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
  cases hl : observedLabels os is with
  | error err =>
   rw [hl] at h
   try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
   repeat' first | split at h | cases h | rfl
  | ok labels =>
   rw [hl] at h
   try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
   cases ho : primitiveFormula labels with
   | error err =>
    rw [ho] at h
    try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
    repeat' first | split at h | cases h | rfl
   | ok obs =>
    rw [ho] at h
    try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
    cases hr : reconcile rs os is with
    | error err =>
     rw [hr] at h
     try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
     repeat' first | split at h | cases h | rfl
    | ok exactRows =>
     rw [hr] at h
     try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
     cases hc : classify os is with
     | error err =>
      rw [hc] at h
      try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
      repeat' first | split at h | cases h | rfl
     | ok exactClasses =>
      rw [hc] at h
      try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
      cases hg : origin rs os is with
      | error err =>
       rw [hg] at h
       try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
       repeat' first | split at h | cases h | rfl
      | ok exactOrigin =>
       rw [hg] at h
       try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, MonadExcept.throw, MonadExceptOf.throw, throwThe] at h
       repeat' first | split at h | cases h | rfl
end SFT.Chemistry.DefectClosure
