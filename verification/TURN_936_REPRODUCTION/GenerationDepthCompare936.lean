import SFT.Physics.GenerationDepth
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.GenerationDepth SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let r ← IO.ofExcept generationDepth
 IO.println (render (.object [("sites",.array (r.sites.map fraction)),("shared_waypoint",.array (r.sharedWaypoint.map fraction)),("home",.array (r.home.map fraction)),("generator_steps",.integer (.ofNat r.generatorSteps))]))
