import SFT.Physics.KoideComparison
import SFT.Physics.KoideIntervalValidation
namespace SFT.Physics.KoideIntervalExternal
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def validate (text : String) (sealedHash host implementation : String)
 (before after : KoideIntervalValidation.Snapshot) :=
 KoideComparison.validateWith (LeptonSource.lines (SFT.Host.Text.chars text))
  (fun _ => KoideIntervalValidation.validate text.toUTF8 sealedHash host implementation before after)

theorem invalidRecordRejected (text sealedHash host implementation message : String)
 (before after : KoideIntervalValidation.Snapshot)
 (failed : KoideComparison.precheckRows (LeptonSource.lines (SFT.Host.Text.chars text))=.error message) :
 validate text sealedHash host implementation before after=.error message :=
 KoideComparison.failedRecordStops _ _ _ failed

theorem acceptedRecordDelegates (text sealedHash host implementation : String)
 (before after : KoideIntervalValidation.Snapshot)
 (accepted : KoideComparison.precheckRows (LeptonSource.lines (SFT.Host.Text.chars text))=.ok ()) :
 validate text sealedHash host implementation before after=
 KoideIntervalValidation.validate text.toUTF8 sealedHash host implementation before after := by
 unfold validate KoideComparison.validateWith
 rw [accepted]
 rfl

end SFT.Physics.KoideIntervalExternal
