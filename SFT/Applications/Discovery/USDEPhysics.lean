import SFT.Applications.Discovery.USDESweep
namespace SFT.Applications.Discovery.USDEPhysics
open SFT.Applications.Discovery
open SFT.Applications.Discovery.USDEMatching
open SFT.Host.Text

structure ParticleQueries where
 available : Bool := false
 values : List (String × Except String (Option Float)) := []
structure PhysicsAlignment where
 name : String
 sector : Int
 calculated : Float
 measured : Float
 deviationPct : Float
structure PhysicsResult where
 alignments : List PhysicsAlignment
 warning : Option String

abbrev MatchM := EStateM String (List PhysicsAlignment)
def liftResult {α : Type} (x : Except String α) : MatchM α :=
 match x with | .error e => EStateM.throw e | .ok value => pure value

def query (source : ParticleQueries) (name : String) : Except String (Option Float) :=
 ((source.values.find? (fun pair => SFT.Host.Text.equal pair.1 name)).map Prod.snd).getD (.error (append "Particle not found: " name))

def divideMass (a b : Option Float) : Except String Float :=
 match a with
 | none => match b with
   | none => .error "unsupported operand type(s) for /: 'NoneType' and 'NoneType'"
   | some _ => .error "unsupported operand type(s) for /: 'NoneType' and 'float'"
 | some x => match b with
   | none => .error "unsupported operand type(s) for /: 'float' and 'NoneType'"
   | some y => if y == 0.0 then .error "float division by zero" else .ok (x/y)

def emit (sector : Int) (name : String) (calculated measured tolerance : Float) : MatchM Unit := do
 if measured == 0.0 then EStateM.throw "float division by zero"
 else
  let dev := Float.abs (calculated-measured)/measured
  if dev < tolerance then
   let out ← EStateM.get
   EStateM.set (out++[{name,sector,calculated,measured,deviationPct := dev*100.0}])
  else pure ()

def pairStage (sector : Int) (first second third : Option Float) (r1 r2 : Float) (nameStart name1 name2 : String) : MatchM Unit := do
 let ref1 ← liftResult (divideMass second first)
 let ref2 ← liftResult (divideMass third second)
 emit sector (append nameStart name1) r1 ref1 (5.0/100.0)
 emit sector (append nameStart name2) r2 ref2 (5.0/100.0)

def constantStage (sector : Int) (r1 r2 reference : Float) (nameStart : String) : MatchM Unit := do
 emit sector (append nameStart "r1") r1 reference (5.0/100.0)
 emit sector (append nameStart "r2") r2 reference (5.0/100.0)

def performComparisons (source : ParticleQueries) (sector : Int) (eigenvalues : List Float) : MatchM Unit := do
 let me ← liftResult (query source "e-")
 let mmu ← liftResult (query source "mu-")
 let mtau ← liftResult (query source "tau-")
 let mu ← liftResult (query source "u")
 let mc ← liftResult (query source "c")
 let mt ← liftResult (query source "t")
 let md ← liftResult (query source "d")
 let ms ← liftResult (query source "s")
 let mb ← liftResult (query source "b")
 let mw ← liftResult (query source "W+")
 let mz ← liftResult (query source "Z0")
 let values := eigenvalues.toArray
 if values.size < 3 then EStateM.throw "list index out of range" else
 let r1 ← liftResult (divideMass (some (values.getD 1 0)) (some (values.getD 0 0)))
 let r2 ← liftResult (divideMass (some (values.getD 2 0)) (some (values.getD 1 0)))
 pairStage sector me mmu mtau r1 r2 "Lepton Mass Ratio " "mu/e" "tau/mu"
 pairStage sector mu mc mt r1 r2 "Up Quark Mass Ratio " "c/u" "t/c"
 pairStage sector md ms mb r1 r2 "Down Quark Mass Ratio " "s/d" "b/s"
 let refBoson ← liftResult (divideMass mw mz)
 if sector > 2 then
  let calculated := Float.pow (Float.ofInt (sector-2)/Float.ofInt (sector-1)) (1.0/2.0)
  emit sector "W/Z Gauge Boson Mass Ratio" calculated refBoson (5.0/100.0)
 let targets := fundamentalDatabase.targets.toArray
 let value := fun index => (targets.getD index {value := 0,description := ""}).value
 constantStage sector r1 r2 (value 0) "Inverse Fine-Structure Constant "
 constantStage sector r1 r2 (value 1) "Fine-Structure Constant "
 constantStage sector r1 r2 (value 3) "Dark-to-Baryon Mass Density Ratio "
 constantStage sector r1 r2 (value 2) "Weak Mixing Angle "
 if sector > 1 then emit sector "Weak Mixing Angle from Sector Division" (1.0/Float.ofInt (sector-1)) (value 2) (1.0/10.0)
 constantStage sector r1 r2 (value 6) "Neutrino Mass Splitting Ratio "
 constantStage sector r1 r2 (value 4) "Muon g-2 Anomaly "
 constantStage sector r1 r2 (value 5) "Proton Charge Radius "

def crossReferencePhysics (source : ParticleQueries) (sector : Int) (eigenvalues : List Float) : PhysicsResult :=
 if !source.available || eigenvalues.isEmpty then ⟨[],none⟩ else
 match (performComparisons source sector eigenvalues).run [] with
 | .ok _ out => ⟨out,none⟩
 | .error error out => ⟨out,some (join ["WARNING: cross_reference_physics aborted early; matches may be incomplete: ",error])⟩
end SFT.Applications.Discovery.USDEPhysics
