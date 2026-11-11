import SFT.Physics.InverseSquareIntervalSource
import SFT.Physics.InverseSquareIntervalValidation
namespace SFT.Physics.InverseSquareIntervalExternal
open InverseSquareIntervalSource

def validate (record : Record) (bytes : ByteArray) (sealedHash host implementation : String)
 (before after : InverseSquareIntervalValidation.Snapshot) :=
 validateWith record (fun _ => InverseSquareIntervalValidation.validate bytes sealedHash host implementation before after)

theorem originalDelegates (bytes : ByteArray) (sealedHash host implementation : String)
 (before after : InverseSquareIntervalValidation.Snapshot) :
 validate registered bytes sealedHash host implementation before after =
 InverseSquareIntervalValidation.validate bytes sealedHash host implementation before after := registeredDelegates _

theorem invalidRecordRejected (record : Record) (bytes : ByteArray) (sealedHash host implementation message : String)
 (before after : InverseSquareIntervalValidation.Snapshot)
 (failed : precheck record = .error message) :
 validate record bytes sealedHash host implementation before after = .error message :=
 failedRecordStops record _ message failed
end SFT.Physics.InverseSquareIntervalExternal
