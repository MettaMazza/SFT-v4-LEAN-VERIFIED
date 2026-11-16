import SFT.Mathematics.CalculatorBrowserTransport
namespace SFT.Mathematics.CalculatorBrowserLaunch
open SFT.Host SFT.Mathematics CalculatorBrowserTransport
structure Arguments where
 noBrowser : Bool := false
 privateMode : Bool := false
 port : Int := 8765
 places : Int := 18
 limit : Int := 10000
def mainArguments (a : Arguments) : Canonical.Value := .object [
 ("start_port",.integer a.port),("places",.integer a.places),("operation_limit",.integer a.limit),("open_browser",.boolean (!a.noBrowser)),("share",.boolean (!a.privateMode))]
def requestShutdown (hasServer : Bool) : List Canonical.Value :=
 if hasServer then [.array [.text "Thread",.text "server.shutdown",.text "sft-calculator-shutdown",.boolean true],.array [.text "start"]] else []
-- Probe and name-resolution results are original socket-library outcomes, not scientific inputs.
def resolveAddress (probe : Except String String) (dns : Except String String) (close : Except String Unit) : List String × Except String String :=
 let (trace,result) : List String × Except String String := match probe with
  | .ok address => (["socket(AF_INET,SOCK_DGRAM)","connect(1.1.1.1,80)","getsockname"],.ok address)
  | .error _ => (["socket(AF_INET,SOCK_DGRAM)","probe OSError","gethostname","gethostbyname"],dns)
 let trace := trace ++ ["close"]
 match close with
 | .error e => (trace,.error e)
 | .ok _ => (trace,result.bind localAddress)
inductive ServeResult where
 | returned
 | keyboardInterrupt
 | failed : String → ServeResult
structure HostResults where
 bind : Except String Int
 address : Except String String := .ok ""
 browser : Except String Unit := .ok ()
 serve : ServeResult := .returned
 close : Except String Unit := .ok ()
def event (name : String) (args : List Canonical.Value := []) : Canonical.Value := .array (.text name::args)
def launch (a : Arguments) (host : HostResults) : List Canonical.Value × Except String Unit :=
 let trace := [event "CalculatorWebApplication" [.integer a.places,.integer a.limit,.boolean (!a.privateMode)],event "bind" [.integer a.port]]
 match host.bind with
 | .error e => (trace,.error e)
 | .ok port =>
  let trace := trace ++ [event "print" [.text (Text.append "Smithian Fold Scientific Calculator: " (localUrl port)),.boolean true]]
  let network : Except String (List Canonical.Value) := if a.privateMode then .ok [] else do
   let address ← host.address
   pure [event "set network_url" [.text (networkUrl address port)],event "print" [.text (Text.append "Phone or local-network address: " (networkUrl address port)),.boolean true],event "print" [.text "Devices on the same local network can open that address.",.boolean true]]
  match network with
  | .error e => (trace ++ [event "_local_network_address"],.error e)
  | .ok networkEvents =>
   let trace := trace ++ (if a.privateMode then [] else [event "_local_network_address"]) ++ networkEvents ++ [event "print" [.text "Use the Close button in the calculator when finished.",.boolean true]]
   let (trace,opened) := if a.noBrowser then (trace,.ok ()) else (trace ++ [event "webbrowser.open" [.text (localUrl port),.integer 1,.boolean true]],host.browser)
   match opened with
   | .error e => (trace,.error e)
   | .ok _ =>
    let trace := trace ++ [event "serve_forever" [.text "0.2"],event "server_close"]
    match host.close with
    | .error e => (trace,.error e)
    | .ok _ => match host.serve with
     | .returned => (trace,.ok ())
     | .keyboardInterrupt => (trace,.ok ())
     | .failed e => (trace,.error e)
end SFT.Mathematics.CalculatorBrowserLaunch
