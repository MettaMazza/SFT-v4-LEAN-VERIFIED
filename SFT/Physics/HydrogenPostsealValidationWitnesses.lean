import SFT.Physics.AtomicPostsealMeasurement
namespace SFT.Physics.HydrogenPostsealValidationWitnesses
open AtomicPostsealMeasurement
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"sealed-lyman-ratio","The sealed first gap remains exactly three-quarters.",lymanRatioCheck⟩,⟨"sealed-balmer-ratio","The sealed second gap remains exactly five-thirty-sixths.",balmerRatioCheck⟩,⟨"lyman-interval","The target-inaccessible exact Lyman prediction lies inside the full NIST interval.",lymanIntervalCheck⟩,⟨"balmer-interval","The target-inaccessible exact Balmer prediction lies inside the full NIST interval.",balmerIntervalCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (lymanRatioCheck && balmerRatioCheck && lymanIntervalCheck && balmerIntervalCheck && true)=true
 rw [lymanRatioCheckPassed,balmerRatioCheckPassed,lymanIntervalCheckPassed,balmerIntervalCheckPassed]
 rfl
end SFT.Physics.HydrogenPostsealValidationWitnesses
