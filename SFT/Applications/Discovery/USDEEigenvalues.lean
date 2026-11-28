import SFT.Applications.Discovery.USDECore
namespace SFT.Applications.Discovery.USDEEigenvalues
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Display
open SFT.Host.Text

def polynomial (e2 e3 x : Float) : Float := Float.pow x 3 - Float.pow x 2 + e2*x - e3

def bisectLoop (e2 e3 : Float) (signA : Bool) : Nat → Float → Float → Float
 | 0, a, b => (a+b)/2
 | fuel+1, a, b =>
  let c := (a+b)/2
  if (polynomial e2 e3 c > 0) == signA then bisectLoop e2 e3 signA fuel c b
  else bisectLoop e2 e3 signA fuel a c

def bisect (e2 e3 lo hi : Float) : Float := bisectLoop e2 e3 (polynomial e2 e3 lo > 0) 64 lo hi

def solveCoefficients (e2 e3 : Float) : List Float :=
 let discriminant := 1.0-3.0*e2
 -- Negative real discriminants enter the source's complex branch, whose
 -- comparison in bisection raises and is caught by its try/except.
 if discriminant < 0 then [] else
 let det := Float.pow discriminant (1.0/2.0)
 let xMinus := (1.0-det)/3.0
 let xPlus := (1.0+det)/3.0
 let x1 := bisect e2 e3 0 xMinus
 let x2 := bisect e2 e3 xMinus xPlus
 let x3 := bisect e2 e3 xPlus 1.0
 [Float.pow x1 2,Float.pow x2 2,Float.pow x3 2]

def solveEigenvalues (sector : Int) : Except String (List Float) :=
 if sector = 0 then .error "float division by zero"
 else
  let e2 := 1.0 / Float.ofInt (sector*2)
  let e3 := 1.0 / Float.ofInt (2*wholePower sector 5-1)
  .ok (solveCoefficients e2 e3)

structure FamilyResult where
 a : Nat
 b : Nat
 c : Nat
 d : Nat
 power : Nat
 eigenvalues : List Float
 description : String

def familyDescription (a b c d power : Nat) : String :=
 join ["e2=",number (Int.ofNat a),"/(",number (Int.ofNat b),"*m), e3=",number (Int.ofNat c),"/(",number (Int.ofNat d),"*m^",number (Int.ofNat power),"-1)"]

def solveEigenvaluesOpenEnded (sector : Int) : Except String (List FamilyResult) :=
 if sector = 0 then .error "float division by zero"
 else if sector = 1 ∨ sector = -1 then .error "float division by zero"
 else .ok ((List.range 5).flatMap fun ai => (List.range 5).flatMap fun bi =>
  (List.range 5).flatMap fun ci => (List.range 5).flatMap fun di =>
   [3,4,5].filterMap fun power =>
    let a := ai+1
    let b := bi+1
    let c := ci+1
    let d := di+1
    let e2 := Float.ofNat a / Float.ofInt (Int.ofNat b*sector)
    let e3 := Float.ofNat c / Float.ofInt (Int.ofNat d*wholePower sector (Int.ofNat power)-1)
    let eigenvalues := solveCoefficients e2 e3
    if eigenvalues.isEmpty then none else some {a,b,c,d,power,eigenvalues,description := familyDescription a b c d power})
end SFT.Applications.Discovery.USDEEigenvalues
