import SFT.Physics.NuclearBindingCensusSize
import SFT.Physics.NuclearBindingSeparation1
import SFT.Physics.NuclearBindingSeparation2
import SFT.Physics.NuclearBindingSeparation4
import SFT.Physics.NuclearBindingSeparation8
import SFT.Physics.NuclearBindingPeakAssembly
namespace SFT.Physics.NuclearBindingPeakClosure
open NuclearBindingPeak NuclearBindingPeakAssembly LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def originalCertificate : Certificate := ⟨62,28,34,normalize 9080439588063887159 9809818781286064340 (by decide),normalize 1515016807116167539 1636583784834496420 (by decide),normalize 7773977012907656069 8398424104442482780 (by decide),8,4094,25303,4096,true⟩
def originalSeparation : Separation := ⟨NuclearBindingSeparation8.winner,NuclearBindingSeparation8.upper,8⟩
theorem originalSeparationRun : separateWithin NuclearBindingGatherClosure.candidates0 4 1 = .ok (some originalSeparation) :=
 continuedStep _ 3 1 _ NuclearBindingSeparation1.separated
 (continuedStep _ 2 2 _ NuclearBindingSeparation2.separated
 (continuedStep _ 1 4 _ NuclearBindingSeparation4.separated
 (acceptedStep _ 0 8 _ NuclearBindingSeparation8.separated)))
theorem certificateBySize (candidates : List (Nat × Nat)) : completeCertificate candidates originalSeparation = .ok {originalCertificate with possibleMaximizerCount := candidates.length} := rfl
theorem certificateAssembly : completeCertificate NuclearBindingGatherClosure.candidates0 originalSeparation = .ok originalCertificate :=
 (certificateBySize NuclearBindingGatherClosure.candidates0).trans
 (congrArg (fun n => Except.ok {originalCertificate with possibleMaximizerCount := n}) NuclearBindingCensusSize.suffix0)
theorem completePeak : bindingPeakWithin 7 4 = .ok (some originalCertificate) :=
 peakFromEvaluations 7 4 NuclearBindingGatherClosure.candidates0 originalSeparation originalCertificate
 NuclearBindingGatherClosure.completeCensus originalSeparationRun certificateAssembly
end SFT.Physics.NuclearBindingPeakClosure
