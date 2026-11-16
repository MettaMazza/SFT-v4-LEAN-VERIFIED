import SFT.Chemistry.ConjugatedSupport
namespace SFT.Chemistry.ConjugatedSupportWitnesses
open SFT.Chemistry.ConjugatedSupport

def base := conjugatedSupport "base" ["atom-a","atom-b","atom-c"] ["fold-fibre-one","fold-fibre-two"]
def successor := do let prior ← base; appendOpposedFibre prior "atom-d"
def baseWitness : Bool :=
 match base with
 | .error _ => false
 | .ok support => match incidences support with
   | .error _ => false
   | .ok edges => support.atoms.length==3 && support.supportFibres.length==2 && edges.length==2

def successorWitness : Bool :=
 match base with
 | .error _ => false
 | .ok prior => match successor with
   | .error _ => false
   | .ok next => match incidences prior with
     | .error _ => false
     | .ok before => match incidences next with
       | .error _ => false
       | .ok after =>
        next.atoms.length==4 && next.supportFibres.length==3 && before.length==(after.take 2).length &&
        (before.zip (after.take 2)).all (fun (a,b) =>
         ElectronCountSpin.sameLabel a.1 b.1 && ElectronCountSpin.sameLabel a.2.1 b.2.1 &&
         ElectronCountSpin.sameLabel a.2.2 b.2.2)

def repeatedTrial := conjugatedSupport "repeated" ["atom-a","atom-b","atom-c"] ["fold-fibre-one","fold-fibre-one"]
def incompleteTrial := conjugatedSupport "incomplete" ["atom-a","atom-b","atom-c"] ["fold-fibre-one"]
def duplicateTrial := do let prior ← base; appendOpposedFibre prior "atom-b"
def repetitionWitness : Bool := match repeatedTrial with | .error _ => true | .ok _ => false
def coverageWitness : Bool := match incompleteTrial with | .error _ => true | .ok _ => false
def identityWitness : Bool := match duplicateTrial with | .error _ => true | .ok _ => false

theorem baseSupportPassed : baseWitness = true := rfl
theorem successorPassed : successorWitness = true := rfl
theorem repetitionRejected : repetitionWitness = true := rfl
theorem omittedIncidenceRejected : coverageWitness = true := rfl
theorem duplicateSuccessorRejected : identityWitness = true := rfl
#print axioms base
#print axioms successor
#print axioms baseWitness
#print axioms successorWitness
#print axioms repeatedTrial
#print axioms incompleteTrial
#print axioms duplicateTrial
#print axioms repetitionWitness
#print axioms coverageWitness
#print axioms identityWitness
#print axioms baseSupportPassed
#print axioms successorPassed
#print axioms repetitionRejected
#print axioms omittedIncidenceRejected
#print axioms duplicateSuccessorRejected
end SFT.Chemistry.ConjugatedSupportWitnesses
