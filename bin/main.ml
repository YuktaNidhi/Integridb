open Integridb
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

  (* Extract root hash for comparison *)
  let root_hash = match tree with
    | Leaf (_, _, h) -> h
    | Node (_, h, _, _) -> h
  in

  (* Prompt the user for input *)
  Printf.printf "Enter lower bound of salary range: ";
  let lo = read_int () in

  Printf.printf "Enter upper bound of salary range: ";
  let hi = read_int () in

  (* Perform search with proof *)
  let (result_opt, recomputed_hash) = search_range_with_proof tree (lo, hi) in

  (* Verify hash match *)
  if recomputed_hash = root_hash then (
    match result_opt with
    | Some results ->
        Printf.printf "✅ Verified! Employees with salary in range [%d, %d]:\n" lo hi;
        List.iter (fun (_, name, _) -> Printf.printf "- %s\n" name) results
    | None ->
        Printf.printf "✅ Verified! ❌ No employees found in range [%d, %d]\n" lo hi
  ) else
    Printf.printf "❌ Verification failed! Tampered data or incorrect proof.\n"

