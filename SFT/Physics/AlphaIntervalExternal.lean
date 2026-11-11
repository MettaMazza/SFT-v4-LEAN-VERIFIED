import SFT.Physics.AlphaInterval
import SFT.Physics.AlphaIntervalValidation
namespace SFT.Physics.AlphaIntervalExternal
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def validate (text : String) (sealedHash host implementation : String)
 (before after : AlphaIntervalValidation.Snapshot) :=
 AlphaInterval.validateWith (LeptonSource.lines (SFT.Host.Text.chars text))
  (fun _ => AlphaIntervalValidation.validate text.toUTF8 sealedHash host implementation before after)

theorem invalidRecordRejected (text sealedHash host implementation message : String)
 (before after : AlphaIntervalValidation.Snapshot)
 (failed : AlphaInterval.precheckRows (LeptonSource.lines (SFT.Host.Text.chars text))=.error message) :
 validate text sealedHash host implementation before after=.error message :=
 AlphaInterval.failedRecordStops _ _ _ failed

theorem acceptedRecordDelegates (text sealedHash host implementation : String)
 (before after : AlphaIntervalValidation.Snapshot)
 (accepted : AlphaInterval.precheckRows (LeptonSource.lines (SFT.Host.Text.chars text))=.ok ()) :
 validate text sealedHash host implementation before after=
 AlphaIntervalValidation.validate text.toUTF8 sealedHash host implementation before after := by
 unfold validate AlphaInterval.validateWith
 rw [accepted]
 rfl

end SFT.Physics.AlphaIntervalExternal
