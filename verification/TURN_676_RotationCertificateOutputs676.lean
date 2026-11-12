import SFT.Materials.RotationCertificate
open SFT.Materials.RotationCertificate
#eval match rotationFactorCertificate with
 | .error message => IO.println ("error\t" ++ message)
 | .ok c => do
   IO.println ("degree_boundary\t" ++ toString c.degreeBoundary.val)
   IO.println ("odd_prime_rule\t" ++ c.oddPrimeRule)
   IO.println ("factor_form\t" ++ c.factorForm)
   IO.println ("exponent_constraints\t" ++ String.intercalate "|" c.exponentConstraints)
   IO.println ("survivors\t" ++ String.intercalate "," (c.survivors.map toString))
   IO.println ("least_excluded\t" ++ toString c.leastExcluded.val)
