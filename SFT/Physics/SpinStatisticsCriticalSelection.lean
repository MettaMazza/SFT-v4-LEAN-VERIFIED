import SFT.Physics.SpinStatisticsCriticalExecution
namespace SFT.Physics.SpinStatisticsCriticalSelection
open SpinStatisticsCondensation SpinStatisticsCriticalExecution
open LeptonIntervals
open SFT.Foundation.Count.TraceDerivation
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
private theorem priorLastRejected (prior : List (Nat×Rat×Rat)) (threshold : Rat)
 (rejected : ∀ row∈prior,row.2.1.blt threshold=true) :
 (match prior.getLast? with | none => true | some (_,previous,_) => previous.blt threshold)=true := by
 induction prior with
 | nil => rfl
 | cons row rest ih =>
   cases rest with
   | nil => exact rejected row (.head [])
   | cons next tail => exact ih (fun x hx => rejected x (.tail row hx))
-- Every returned record is the first crossing in the exact supplied depth sequence.
theorem originalSelectedCertificate (particles levels factor : Nat) (threshold : Rat)
 (depths : List Nat) (prior : List (Nat×Rat×Rat)) (certificate : Condensation)
 (rejected : ∀ row∈prior,row.2.1.blt threshold=true)
 (run : firstCrossing particles levels factor threshold depths prior=.ok certificate) :
 certificate.particles=particles ∧ certificate.levels=levels ∧ certificate.factor=factor ∧
 certificate.lockShare=threshold ∧ certificate.ground=groundWord particles levels ∧
 certificate.groundShare.blt threshold=false ∧ certificate.priorBelow=true ∧
 groundShare (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat certificate.criticalDepth))=.ok certificate.groundShare ∧
 canonicalMeanThrow (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat certificate.criticalDepth))=.ok certificate.criticalMean ∧
 ∃ before after,depths=before++certificate.criticalDepth::after ∧
   ∀ d∈before,∃ share,
   groundShare (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat d))=.ok share ∧ share.blt threshold=true := by
 induction depths generalizing prior certificate with
 | nil => cases run
 | cons depth rest ih =>
   unfold firstCrossing at run
   cases shareEq : groundShare (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat depth)) with
   | error error => rw [shareEq] at run;cases run
   | ok share =>
     rw [shareEq] at run
     cases meanEq : canonicalMeanThrow (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat depth)) with
     | error error => rw [meanEq] at run;cases run
     | ok mean =>
       rw [meanEq] at run
       dsimp only [Except.bind,Bind.bind] at run
       cases decision : share.blt threshold with
       | false =>
         rw [decision] at run
         have same := Except.ok.inj run
         cases same
         exact ⟨rfl,rfl,rfl,rfl,rfl,decision,priorLastRejected prior threshold rejected,shareEq,meanEq,
           [],rest,rfl,fun _ h => by cases h⟩
       | true =>
         rw [decision] at run
         have nextRejected : ∀ row∈prior++[(depth,share,mean)],row.2.1.blt threshold=true := by
           intro row held
           cases memAppendCases row prior [(depth,share,mean)] held with
           | inl h => exact rejected row h
           | inr h => cases h with
             | head => exact decision
             | tail _ impossible => cases impossible
         obtain ⟨particlesEq,levelsEq,factorEq,lockEq,groundEq,passed,priorPassed,shareHeld,meanHeld,before,after,order,earlier⟩ :=
           ih (prior++[(depth,share,mean)]) certificate nextRejected run
         refine ⟨particlesEq,levelsEq,factorEq,lockEq,groundEq,passed,priorPassed,shareHeld,meanHeld,
           depth::before,after,congrArg (List.cons depth) order,?_⟩
         intro d held
         cases held with
         | head => exact ⟨share,shareEq,decision⟩
         | tail _ h => exact earlier d h
theorem originalEveryCriticalFirstCrossing (p l m : Nat) :
 ∃ certificate,
 criticalCondensationCertificate (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) (.integer (.ofNat (m+2)))=.ok certificate ∧
 certificate.priorBelow=true ∧
 certificate.groundShare.blt (VacuumLedgerProofs.natRatio (m+1) (m+2) (Nat.zero_lt_succ _))=false ∧
 canonicalMeanThrow (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat certificate.criticalDepth))=.ok certificate.criticalMean ∧
 ∃ before after,
 ((List.range (SpinStatisticsColdThreshold.sufficientDepth (p+1) l (m+1)+1)).map (fun n => n+1))=
 before++certificate.criticalDepth::after ∧
 ∀ d∈before,∃ share,
 groundShare (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat d))=.ok share ∧
 share.blt (VacuumLedgerProofs.natRatio (m+1) (m+2) (Nat.zero_lt_succ _))=true := by
 obtain ⟨certificate,run⟩ := originalEveryCriticalCertificateReturns p l m
 have native := run
 rw [originalCriticalOperation] at native
 have selected := originalSelectedCertificate (p+1) (l+2) (m+2) _ _ [] certificate (fun _ h => by cases h) native
 exact ⟨certificate,run,selected.2.2.2.2.2.2.1,selected.2.2.2.2.2.1,selected.2.2.2.2.2.2.2.2.1,
   selected.2.2.2.2.2.2.2.2.2⟩
end SFT.Physics.SpinStatisticsCriticalSelection
