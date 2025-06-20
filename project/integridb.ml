(* === Types === *)
type 'a hash = string
type 'a range = 'a * 'a

type ('a, 'b) ait_node =
  | Leaf of 'a * 'b * 'b hash
  | Node of 'a range * 'b hash * ('a, 'b) ait_node * ('a, 'b) ait_node

(* === Lib (Helpers + AIT logic) === *)
open Digestif.BLAKE2B

let hash_str s = digest_string s |> to_hex
let hash_pair h1 h2 = hash_str (h1 ^ h2)

let rec list_take n lst =
  if n = 0 then [] else match lst with
    | [] -> []
    | x::xs -> x :: list_take (n - 1) xs

let rec list_drop n lst =
  if n = 0 then lst else match lst with
    | [] -> []
    | _::xs -> list_drop (n - 1) xs

let rec build_ait lst =
  match lst with
  | [] -> failwith "Empty list"
  | [ (key, name) ] ->
      let h = hash_str name in
      Leaf (key, name, h)
  | _ ->
      let len = List.length lst / 2 in
      let left = build_ait (list_take len lst) in
      let right = build_ait (list_drop len lst) in
      let min_key = match left with Leaf (k, _, _) | Node ((k, _), _, _, _) -> k in
      let max_key = match right with Leaf (k, _, _) | Node ((_, k), _, _, _) -> k in
      let h1 = match left with Leaf (_, _, h) | Node (_, h, _, _) -> h in
      let h2 = match right with Leaf (_, _, h) | Node (_, h, _, _) -> h in
      let h = hash_pair h1 h2 in
      Node ((min_key, max_key), h, left, right)

let rec search_range tree (lo, hi) =
  match tree with
  | Leaf (key, name, hash) ->
      if key >= lo && key <= hi then Some [(key, name, hash)]
      else None
  | Node ((min_k, max_k), _, left, right) ->
      if hi < min_k then search_range left (lo, hi)
      else if lo > max_k then search_range right (lo, hi)
      else
        let lres = search_range left (lo, hi) in
        let rres = search_range right (lo, hi) in
        match (lres, rres) with
        | (Some l, Some r) -> Some (l @ r)
        | (Some l, None) -> Some l
        | (None, Some r) -> Some r
        | _ -> None

(* === Main === *)
let employee_data = [
  (50000, "Alice");
  (80000, "Bob");
  (120000, "Charlie");
  (150000, "Daisy");
  (200000, "Ethan");
  (250000, "Fiona");
]

let () =
  let tree = build_ait employee_data in

  (* Prompt the user for input *)
  Printf.printf "Enter lower bound of salary range: ";
  let lo = read_int () in

  Printf.printf "Enter upper bound of salary range: ";
  let hi = read_int () in

  (* Perform search *)
  match search_range tree (lo, hi) with
  | Some results ->
      Printf.printf " Employees with salary in range [%d, %d]:\n" lo hi;
      List.iter (fun (_, name, _) -> Printf.printf "- %s\n" name) results
  | None ->
      Printf.printf " No employees found in range [%d, %d]\n" lo hi

