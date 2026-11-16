import SFT.Mathematics.CalculatorBrowserPage
namespace SFT.Mathematics.CalculatorBrowserTransport
open SFT.Host SFT.Mathematics
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def headers (contentType : String) (length : Nat) : List (String × String) :=
 [("Content-Type",contentType),("Content-Length",CalculatorRoots.digits length),("Cache-Control","no-store"),("X-Content-Type-Options","nosniff"),("Referrer-Policy","no-referrer"),("Content-Security-Policy","default-src 'self'; style-src 'unsafe-inline'; script-src 'unsafe-inline'; connect-src 'self'; img-src 'self' data:; frame-ancestors 'none'")]
def expectedHost (share : Bool) : String := if share then "0.0.0.0" else "127.0.0.1"
def bindingGuard (share : Bool) (host : Option String) (startPort : Int) : Except String String :=
 let selected := host.getD (expectedHost share)
 if !(Text.equal selected (expectedHost share)) then .error "the calculator binding does not match its declared private or local-network mode"
 else if startPort<1024 || startPort>65511 then .error "the local application port is outside its declared boundary"
 else .ok selected
-- The supplied host outcome is true on successful creation and false on the caught OSError.
def tryPorts (available : Int → Bool) (host : String) (port : Int) : Nat → List (String × Int) × Except String Int
 | 0 => ([],.error "no local calculator application port is available")
 | n+1 => if available port then ([(host,port)],.ok port) else
  let (trace,result) := tryPorts available host (port+1) n
  ((host,port)::trace,result)
def bind (share : Bool) (host : Option String) (startPort attempts : Int) (available : Int → Bool) : List (String × Int) × Except String Int :=
 match bindingGuard share host startPort with
 | .error e => ([],.error e)
 | .ok selected => tryPorts available selected startPort attempts.toNat
def localAddress (address : String) : Except String String :=
 if Text.equal (String.ofList ((Text.chars address).take 4)) "127." then .error "a local-network address could not be resolved" else .ok address
def localUrl (port : Int) (entryPath : String := "/") : String :=
 Text.join ["http://127.0.0.1:",String.ofList (if port<0 then '-'::Nat.toDigits 10 port.natAbs else Nat.toDigits 10 port.natAbs),entryPath]
def networkUrl (address : String) (port : Int) (entryPath : String := "/") : String :=
 Text.join ["http://",address,":",String.ofList (if port<0 then '-'::Nat.toDigits 10 port.natAbs else Nat.toDigits 10 port.natAbs),entryPath]
def launchMessages (port : Int) (network : Option String) : List String :=
 [Text.append "Smithian Fold Scientific Calculator: " (localUrl port)] ++
 (match network with | none => [] | some address => [Text.append "Phone or local-network address: " (networkUrl address port),"Devices on the same local network can open that address."]) ++
 ["Use the Close button in the calculator when finished."]
end SFT.Mathematics.CalculatorBrowserTransport
