open Printf

let match_fn = "mx"

let match_sig = "int (long long, int)"

let fpath pth j =
  match Yojson.Basic.Util.path pth j with
  | None -> failwith "???"
  | Some x -> x
;;

let get_se =
  let json = Yojson.Basic.from_file "cpp_files/prog.json" in
  let open Yojson.Basic.Util in
  let toplevel_fns =
    json |> member "inner" |> to_list
    |> filter_map (fun j ->
           match filter_member "kind" [j] with
           | [] -> None
           | [x] ->
               if to_string x = "FunctionDecl" then
                 Some j
               else
                 None
           | _ -> failwith "oh no" )
  in
  let find_fn j =
    match filter_member "kind" [j] with
    | [] -> None
    | [x] ->
        if to_string x = "FunctionDecl" then
          if
            to_string
              (let y = path ["type"; "qualType"] j in
               match y with
               | None -> failwith "idk"
               | Some z -> z )
            = match_sig
            && to_string (member "name" j) = match_fn
          then
            Some j
          else
            None
        else
          None
    | _ -> failwith "oh no"
  in
  let found_fns = filter_map find_fn toplevel_fns in
  if List.length found_fns <> 1 then
    failwith "noo!"
  else
    let fnc = List.hd found_fns in
    let sl = to_int (fpath ["loc"; "line"] fnc) in
    let el = to_int (fpath ["range"; "end"; "line"] fnc) in
    (sl, el)
;;

let read_file f =
  let ic = open_in f in
  let lines = ref [] in
  try
    while true do
      lines := input_line ic :: !lines
    done;
    !lines
  with End_of_file -> close_in ic; List.rev !lines
;;

let () =
  let a, b = get_se in
  let z = read_file "cpp_files/prog.cpp" in
  let fn = List.filteri (fun i _ -> i + 1 >= a && i + 1 <= b) z in
  List.iter (printf "%s\n") fn
;;
