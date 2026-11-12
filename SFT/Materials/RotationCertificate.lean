import SFT.Materials.RotationTotient
namespace SFT.Materials.RotationCertificate
open RotationTotient

def candidates : List PositiveCount :=
 [⟨1,by decide⟩,⟨2,by decide⟩,⟨3,by decide⟩,⟨4,by decide⟩,⟨6,by decide⟩]

def allowedCrystallographicOrders : Except String (List PositiveCount) :=
 if candidates.all crystallographicRotationAdmitted then .ok candidates
 else .error "rotation factor certificate failed on an admitted form"

structure Certificate where
 degreeBoundary : PositiveCount
 oddPrimeRule : String
 factorForm : String
 exponentConstraints : List String
 survivors : List Nat
 leastExcluded : PositiveCount
 deriving Repr

def rotationFactorCertificate : Except String Certificate := do
 let allowed ← allowedCrystallographicOrders
 return {
   degreeBoundary := ⟨2,by decide⟩
   oddPrimeRule := "p divides order implies p-1 divides rotation degree; degree<=2 permits only odd prime 3"
   factorForm := "order=2^a*3^b"
   exponentConstraints := ["a<=2", "b<=1", "not(a=2 and b=1)"]
   survivors := allowed.map Subtype.val
   leastExcluded := ⟨5,by decide⟩ }

theorem candidatesExact : candidates.map Subtype.val = [1,2,3,4,6] := rfl

theorem guardedSuccess (passed : candidates.all crystallographicRotationAdmitted = true) :
 allowedCrystallographicOrders = .ok candidates := by
 unfold allowedCrystallographicOrders
 rw [passed]
 rfl

theorem guardedFailure (failed : candidates.all crystallographicRotationAdmitted = false) :
 allowedCrystallographicOrders = .error "rotation factor certificate failed on an admitted form" := by
 unfold allowedCrystallographicOrders
 rw [failed]
 rfl
end SFT.Materials.RotationCertificate
