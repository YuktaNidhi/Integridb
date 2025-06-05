open Mirage_crypto_pk
open Mirage_crypto_rng

(* Algorithm Init: generate a keypair *)
let init () =
  (* Generate 2048-bit RSA key pair *)
  let key = Rsa.generate ~bits:2048 () in
  let sk = key in
  let pk = Rsa.pub_of_priv key in
  (sk, pk)

let () =
  Mirage_crypto_rng_unix.initialize ();

  let (sk, pk) = init () in

  (* Convert keys to PEM strings for storage or transmission *)
  let sk_pem = Cstruct.to_string (Rsa.priv_to_pem sk) in
  let pk_pem = Cstruct.to_string (Rsa.pub_to_pem pk) in

  Printf.printf "Private Key (PEM):\n%s\n" sk_pem;
  Printf.printf "Public Key (PEM):\n%s\n" pk_pem;
