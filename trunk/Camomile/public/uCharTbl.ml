(** Fast lookup tables for Unicode.  Accessible by constant time. *)
(* Copyright (C) 2002, 2003 Yamagata Yoriyuki. distributed with LGPL *)

(* This library is free software; you can redistribute it and/or *)
(* modify it under the terms of the GNU Lesser General Public License *)
(* as published by the Free Software Foundation; either version 2 of *)
(* the License, or (at your option) any later version. *)

(* As a special exception to the GNU Library General Public License, you *)
(* may link, statically or dynamically, a "work that uses this library" *)
(* with a publicly distributed version of this library to produce an *)
(* executable file containing portions of this library, and distribute *)
(* that executable file under terms of your choice, without any of the *)
(* additional requirements listed in clause 6 of the GNU Library General *)
(* Public License. By "a publicly distributed version of this library", *)
(* we mean either the unmodified Library as distributed by the authors, *)
(* or a modified version of this library that is distributed under the *)
(* conditions defined in clause 3 of the GNU Library General Public *)
(* License. This exception does not however invalidate any other reasons *)
(* why the executable file might be covered by the GNU Library General *)
(* Public License . *)

(* This library is distributed in the hope that it will be useful, *)
(* but WITHOUT ANY WARRANTY; without even the implied warranty of *)
(* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU *)
(* Lesser General Public License for more details. *)

(* You should have received a copy of the GNU Lesser General Public *)
(* License along with this library; if not, write to the Free Software *)
(* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 *)
(* USA *)

(* You can contact the authour by sending email to *)
(* yoriyuki.yamagata@aist.go.jp *)

type 'a tbl = 'a Tbl31.tbl
type 'a t = 'a tbl

let get tbl u = Tbl31.get tbl (UChar.uint_code u)

module type Type = sig
  type elt
  type t = elt tbl
  val get : elt tbl -> UChar.t -> elt
  val of_map : elt -> elt UMap.t -> t
end

module Make (H : Hashtbl.HashedType) = struct
  module T31 = Tbl31.Make (H)

  type elt = T31.elt
  type t = H.t tbl
  let get = get
  let of_map v m = T31.of_map v (UMap.imap_of_umap m)
end

module Bool = struct
  type t = Tbl31.Bool.t
  let get tbl u = Tbl31.Bool.get tbl (UChar.uint_code u)
  let of_set s = Tbl31.Bool.of_set (USet.iset_of_uset s)
end

module Bits = struct
  type t = Tbl31.Bits.t
  let get tbl u = Tbl31.Bits.get tbl (UChar.uint_code u)
  let of_map v m = Tbl31.Bits.of_map v (UMap.imap_of_umap m)
end

module Bytes = struct
  type t = Tbl31.Bytes.t
  let get tbl u = Tbl31.Bytes.get tbl (UChar.uint_code u)
  let of_map v m = Tbl31.Bytes.of_map v (UMap.imap_of_umap m)
end

module Char = struct
  type t = Tbl31.Char.t
  let get tbl u = Tbl31.Char.get tbl (UChar.uint_code u)
  let of_map v m = Tbl31.Char.of_map v (UMap.imap_of_umap m)
end