import SFT.Applications.Discovery.USDEEigenvalues
namespace SFT.Applications.Discovery.USDEMatching
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Display
open SFT.Host.Text

structure Target where
 value : Float
 description : String
structure Database where
 targets : List Target := []
 sigmas : List (Float × Float) := []

def setTarget (db : Database) (value : Float) (description : String) : Database :=
 if db.targets.any (fun t => t.value == value) then
  {db with targets := db.targets.map (fun t => if t.value == value then {value,description} else t)}
 else {db with targets := db.targets++[{value,description}]}
def setSigma (db : Database) (value sigma : Float) : Database :=
 if db.sigmas.any (fun t => t.1 == value) then
  {db with sigmas := db.sigmas.map (fun t => if t.1 == value then (value,sigma) else t)}
 else {db with sigmas := db.sigmas++[(value,sigma)]}
def addMeasured (db : Database) (value : Float) (description : String) (sigma : Float) : Database := setSigma (setTarget db value description) value sigma

def fundamentalDatabase : Database :=
 let million := Float.ofInt (wholePower 5 6*wholePower 2 6)
 let alphaDen := Float.ofInt (137*(wholePower 5 6*wholePower 2 6)+35999)
 let rows : List (Float × String × Float) := [
  (alphaDen/million,"Inverse Fine-Structure Constant (1/alpha)",1.6e-10),
  (million/alphaDen,"Fine-Structure Constant (alpha)",1.6e-10),
  (Float.ofNat 23113/Float.ofInt (wholePower 5 5*wholePower 2 5),"Weak Mixing Angle (sin^2 theta_W)",1.7e-4),
  (27.0/5.0,"Dark-to-Baryon Mass Ratio (Omega_c/Omega_b)",1.3e-2),
  (Float.ofNat 11659/Float.ofInt (wholePower 5 7*wholePower 2 7),"Muon g-2 Anomaly",1.9e-7),
  (21.0/25.0,"Proton Charge Radius (fm)",4.8e-4),
  (33,"Neutrino Mass Splitting Ratio (Delta m_atm^2 / Delta m_sol^2)",3.0e-2)]
 rows.foldl (fun db (value,description,sigma) => addMeasured db value description sigma) {}

structure Particle where
 name : String
 mass : Option Float
 upper : Option Float
 lower : Option Float
structure Mass where
 name : String
 value : Float
 error : Option Float

def targetNames : List String := ["e-","mu-","tau-","u","d","s","c","b","t","W+","Z0","H0","p","n","Lambda","Sigma+","Xi0","Omega-","pi+","pi0","K+","K0","eta","rho(770)+","omega(782)","phi(1020)","J/psi(1S)","Upsilon(1S)","D+","D0","D(s)+","B+","B0","B(s)0"]
def harvestMasses (particles : List Particle) : List Mass :=
 particles.foldl (fun masses p =>
  if !(targetNames.any (fun name => SFT.Host.Text.equal name p.name)) then masses else
  match p.mass with
  | none => masses
  | some value =>
   let mass := {name := p.name,value,error := p.upper.orElse (fun _ => p.lower) : Mass}
   if masses.any (fun m => SFT.Host.Text.equal m.name p.name) then masses.map (fun m => if SFT.Host.Text.equal m.name p.name then mass else m)
   else masses++[mass]) []

def harvestPhysicalDatabase (particles : List Particle := []) : Database :=
 let masses := harvestMasses particles
 masses.zipIdx.foldl (fun db (a,i) =>
  (masses.drop (i+1)).foldl (fun db b =>
   if a.value > 0.0 && b.value > 0.0 then
    let value := if a.value >= b.value then a.value/b.value else b.value/a.value
    let description := if a.value >= b.value then join ["Mass Ratio ",a.name,"/",b.name] else join ["Mass Ratio ",b.name,"/",a.name]
    let db := setTarget db value description
    match a.error with
    | none => db
    | some ea => match b.error with
      | none => db
      | some eb => setSigma db value (Float.pow (Float.pow (ea/a.value) 2 + Float.pow (eb/b.value) 2) (1.0/2.0))
   else db) db) fundamentalDatabase

structure Alignment where
 name : String
 sector : Int
 family : String
 calculated : Float
 measured : Float
 deviationPct : Float
 significance : Float
 sigmaDeviation : Option Float
 withinExperimentalError : Option Bool
structure MatchResult where
 alignments : List Alignment
 comparisons : Nat

def crossReferenceOpenEnded (db : Database) (toleranceSigmas : Float) (sector : Int) (eigenvalues : List Float) (family : String) : Except String MatchResult :=
 if eigenvalues.isEmpty then .ok ⟨[],0⟩ else
 match eigenvalues with
 | [] => .ok ⟨[],0⟩
 | a::rest => match rest with
  | [] => .error "list index out of range"
  | b::rest => match rest with
   | [] => .error "list index out of range"
   | c::_ =>
    if a == 0.0 || b == 0.0 || db.targets.any (fun t => t.value == 0.0) then .error "float division by zero" else
    let result := ([(b/a,"r1"),(c/b,"r2"),(c/a,"r3")]).foldl (fun result (calculatedValue,ratioName) =>
     db.targets.foldl (fun result target =>
      let dev := Float.abs (calculatedValue-target.value)/target.value
      let alignments := if dev < 2.0/100.0 then
       let significance := -Float.log10 (if dev > 1.0/100000.0 then dev else 1.0/100000.0)
       let relativeSigma := (db.sigmas.find? (fun t => t.1 == target.value)).map Prod.snd
       let sigmaDeviation := relativeSigma.bind (fun sigma => if sigma > 1e-15 then some (dev/sigma) else none)
       let withinExperimentalError := sigmaDeviation.map (fun sigma => decide (sigma <= toleranceSigmas))
       result.alignments++[{name := join [target.description," (",ratioName," alignment)"],sector,family,calculated := calculatedValue,measured := target.value,deviationPct := dev*100.0,significance,sigmaDeviation,withinExperimentalError}]
      else result.alignments
      {alignments,comparisons := result.comparisons+1}) result) (⟨[],0⟩ : MatchResult)
    .ok result
end SFT.Applications.Discovery.USDEMatching
