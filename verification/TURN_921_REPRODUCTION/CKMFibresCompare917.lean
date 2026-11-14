import SFT.Physics.CKMFibres
#eval match SFT.Physics.CKMFibres.ckmFibres with
 | .error e => IO.println e
 | .ok f => IO.println (reprStr (f.massBasis.map (fun (r : Rat) => (r.num,r.den)), f.channelBasis.map (fun (r : Rat) => (r.num,r.den)), f.matrix.map (fun (row : List Rat) => row.map (fun (r : Rat) => (r.num,r.den)))))
