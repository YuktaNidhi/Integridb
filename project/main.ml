open Ait
open Search

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
  let query_range = (100000, 200000) in
  match search_range tree query_range with
  | Some results ->
      List.iter (fun (_, name, _) -> Printf.printf "✅ %s\n" name) results
  | None -> Printf.printf "❌ No employees found in range\n"