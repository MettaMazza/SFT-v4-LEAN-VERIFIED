import SFT.Computation.ResourceRecord
namespace SFT.Computation.RecognitionDomain
open SFT.Mathematics.DiscreteObjects

def enumerateRows (next : Nat) : List String → List (String × String)
 | [] => []
 | description :: rest => (SFT.Host.Text.append "position-" (toString next),description) :: enumerateRows (next+1) rest

def completeEnumeration (descriptions : List String) : Except String (List (String × String)) :=
  if !distinct descriptions then .error "ValueError: descriptions must contain unique generated identities"
  else if descriptions.isEmpty then .error "ValueError: enumeration requires generated descriptions"
  else .ok (enumerateRows 1 descriptions)

def selfNegatingBoundary (verdict : String) : Except String String :=
  if verdict = "accept" then .ok "reject"
  else if verdict = "reject" then .ok "accept"
  else .error "ValueError: verdict is not a generated held label"

theorem enumerationRetains (descriptions : List String) (next : Nat) :
    (enumerateRows next descriptions).map Prod.snd = descriptions := by
  induction descriptions generalizing next with
  | nil => rfl
  | cons description rest ih => exact congrArg (List.cons description) (ih (next+1))

theorem enumerationLength (descriptions : List String) (next : Nat) :
    (enumerateRows next descriptions).length = descriptions.length := by
  induction descriptions generalizing next with
  | nil => rfl
  | cons description rest ih => exact congrArg Nat.succ (ih (next+1))

theorem enumerationMeaning (descriptions : List String) (rows : List (String × String)) :
    completeEnumeration descriptions = .ok rows ↔ distinct descriptions = true ∧
      descriptions.isEmpty = false ∧ rows = enumerateRows 1 descriptions := by
  unfold completeEnumeration
  cases hd : distinct descriptions <;> cases he : descriptions.isEmpty
  all_goals try { constructor; intro h; cases h; intro h; cases h.1 }
  all_goals try { constructor; intro h; cases h; intro h; cases h.2.1 }
  constructor
  · intro h; exact ⟨rfl,rfl,(Except.ok.inj h).symm⟩
  · intro h; rw [h.2.2]; rfl

theorem domainReconstructed (descriptions : List String) (rows : List (String × String))
    (passed : completeEnumeration descriptions = .ok rows) :
    rows.map Prod.snd = descriptions ∧ rows.length = descriptions.length := by
  rw [(enumerationMeaning _ _).mp passed |>.2.2]
  exact ⟨enumerationRetains _ _,enumerationLength _ _⟩

theorem complementAccept : selfNegatingBoundary "accept" = .ok "reject" := rfl
 theorem complementReject : selfNegatingBoundary "reject" = .ok "accept" := rfl

theorem complementBoundary (verdict : String) (first : verdict ≠ "accept") (second : verdict ≠ "reject") :
    selfNegatingBoundary verdict = .error "ValueError: verdict is not a generated held label" := by
  unfold selfNegatingBoundary
  rw [ite_eq_right first,ite_eq_right second]

end SFT.Computation.RecognitionDomain
