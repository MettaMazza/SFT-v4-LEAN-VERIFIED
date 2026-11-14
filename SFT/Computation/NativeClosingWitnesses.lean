import SFT.Computation.NativeClosing
namespace SFT.Computation.NativeClosingWitnesses
open NativeClosing
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem maximum1 : nativeBusyBeaver 1=1 := nativeBusyBeaverValue 1 (by decide)
theorem maximum2 : nativeBusyBeaver 2=2 := nativeBusyBeaverValue 2 (by decide)
theorem maximum3 : nativeBusyBeaver 3=3 := nativeBusyBeaverValue 3 (by decide)
theorem maximum4 : nativeBusyBeaver 4=4 := nativeBusyBeaverValue 4 (by decide)
theorem maximum5 : nativeBusyBeaver 5=5 := nativeBusyBeaverValue 5 (by decide)
theorem maximum6 : nativeBusyBeaver 6=6 := nativeBusyBeaverValue 6 (by decide)
theorem maximum7 : nativeBusyBeaver 7=7 := nativeBusyBeaverValue 7 (by decide)
theorem maximum8 : nativeBusyBeaver 8=8 := nativeBusyBeaverValue 8 (by decide)
theorem maximum9 : nativeBusyBeaver 9=9 := nativeBusyBeaverValue 9 (by decide)
theorem maximum10 : nativeBusyBeaver 10=10 := nativeBusyBeaverValue 10 (by decide)
theorem maximum11 : nativeBusyBeaver 11=11 := nativeBusyBeaverValue 11 (by decide)
theorem maximum12 : nativeBusyBeaver 12=12 := nativeBusyBeaverValue 12 (by decide)
theorem maximum13 : nativeBusyBeaver 13=13 := nativeBusyBeaverValue 13 (by decide)
theorem maximum14 : nativeBusyBeaver 14=14 := nativeBusyBeaverValue 14 (by decide)
def depthWitness : Bool := (List.range 14).all (fun i => nativeBusyBeaver (i+1)==i+1)
theorem everyDepthWitness (depths : List Nat) :
 depths.all (fun i => nativeBusyBeaver (i+1)==i+1)=true := by
 induction depths with
 | nil => rfl
 | cons n ns ih =>
   rw [List.all_cons,nativeBusyBeaverValue (n+1) (Nat.zero_lt_succ n),ih]
   have eq : (n+1==n+1)=true := by
     induction n with
     | zero => rfl
     | succ n ih => exact ih
   rw [eq]; rfl
theorem depthWitnessPassed : depthWitness=true := everyDepthWitness (List.range 14)
end SFT.Computation.NativeClosingWitnesses
