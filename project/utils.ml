open Digestif.BLAKE2B

let hash_str s = digest_string s |> to_hex
let hash_pair h1 h2 = hash_str (h1 ^ h2)

(* Add these two list helper functions *)
let rec list_take n lst =
  if n = 0 then [] else match lst with
    | [] -> []
    | x::xs -> x :: list_take (n - 1) xs

let rec list_drop n lst =
  if n = 0 then lst else match lst with
    | [] -> []
    | _::xs -> list_drop (n - 1) xs
