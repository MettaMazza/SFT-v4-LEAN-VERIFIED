import SFT.Physics.NuclearSequenceSource
import SFT.Physics.NuclearSequenceValidation
namespace SFT.Physics.NuclearSequenceExternal
open NuclearSequenceSource

def validate (record : Record) (bytes : ByteArray) (sealedHash host implementation : String)
 (before after : NuclearSequenceValidation.Snapshot) :=
 validateWith record (fun _ => NuclearSequenceValidation.validate bytes sealedHash host implementation before after)

theorem originalDelegates (bytes : ByteArray) (sealedHash host implementation : String)
 (before after : NuclearSequenceValidation.Snapshot) :
 validate registered bytes sealedHash host implementation before after =
 NuclearSequenceValidation.validate bytes sealedHash host implementation before after := registeredDelegates _

theorem invalidRecordRejected (record : Record) (bytes : ByteArray) (sealedHash host implementation message : String)
 (before after : NuclearSequenceValidation.Snapshot)
 (failed : precheck record = .error message) :
 validate record bytes sealedHash host implementation before after = .error message :=
 failedRecordStops record _ message failed
end SFT.Physics.NuclearSequenceExternal
