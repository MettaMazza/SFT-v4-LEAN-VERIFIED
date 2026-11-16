import SFT.Physics.KoideComparison
import SFT.Physics.KoideValidationV2Validation
namespace SFT.Physics.KoideValidationV2External
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def validate (text : String) (sealedHash host implementation : String)
 (before after : KoideValidationV2Validation.Snapshot) :=
 KoideComparison.validateWith (LeptonSource.lines (SFT.Host.Text.chars text))
  (fun _ => KoideValidationV2Validation.validate text.toUTF8 sealedHash host implementation before after)

theorem invalidRecordRejected (text sealedHash host implementation message : String)
 (before after : KoideValidationV2Validation.Snapshot)
 (failed : KoideComparison.precheckRows (LeptonSource.lines (SFT.Host.Text.chars text))=.error message) :
 validate text sealedHash host implementation before after=.error message :=
 KoideComparison.failedRecordStops _ _ _ failed

theorem acceptedRecordDelegates (text sealedHash host implementation : String)
 (before after : KoideValidationV2Validation.Snapshot)
 (accepted : KoideComparison.precheckRows (LeptonSource.lines (SFT.Host.Text.chars text))=.ok ()) :
 validate text sealedHash host implementation before after=
 KoideValidationV2Validation.validate text.toUTF8 sealedHash host implementation before after := by
 unfold validate KoideComparison.validateWith
 rw [accepted]
 rfl

end SFT.Physics.KoideValidationV2External
