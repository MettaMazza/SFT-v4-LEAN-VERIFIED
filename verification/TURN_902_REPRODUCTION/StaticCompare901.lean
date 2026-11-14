import SFT.Physics.StaticFoldClock
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showResult (x : Except String StaticFoldClock.Result) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok .horizon => .object [("metric_square",.array []),("clock_record",.array []),("class",.text "horizon-boundary")]
 | .ok (.accessible metric folded) => .object [("metric_square",fraction metric),("folded_metric",fraction folded),("class",.text "accessible")]
def main : IO Unit := do
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨1,8,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨7,16,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨1,1,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨1,2,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨1,4,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨3,4,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨1,3,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨2,3,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨0,1,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨-1,1,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock (.fraction ⟨2,1,by decide,by decide⟩))))
 IO.println (render (showResult (StaticFoldClock.staticClock .nonFraction)))
 match StaticFoldClock.exactClockRate with
 | .error message => IO.println (render (.object [("error",.text message)]))
 | .ok rate => IO.println (render (fraction rate))
