unit uBinaryTree;


interface
  type
    tbinaryTree = ^tnode;

    tnode = RECORD
      info: integer;
      hi, hd : tbinaryTree;
    end;

  

  // Basic methods
  procedure initialize(var a:tbinaryTree);
  function is_empty(a:tbinaryTree): boolean;
  procedure add(var a:tbinaryTree; elem: integer);
  function in_tree(a:tbinaryTree; elem: integer): boolean;

  // Traversal algorithms
  procedure preorder(a: tbinaryTree);
  procedure inorder(a: tbinaryTree);
  procedure postorder(a: tbinaryTree);

  // Other methods
  function get_hi(a:tbinaryTree): tbinaryTree;
  function get_hd(a:tbinaryTree): tbinaryTree;

  // Ejercicios 

  {Ejercicio 1.1}
  procedure inorder_inverse(a: tbinaryTree);
  
  {Ejercicio 1.2}
  function profundidad_max(a:tbinaryTree): integer;

  {Ejercicio 1.3}
  function node_count(a:tbinaryTree): integer;

  {Ejercicio 1.4}
  function leafs_count(a:tbinaryTree): integer;

  {Ejercicio 1.5}
  function internal_nodes_count(a:tbinaryTree): integer;

  {Ejercicio 1.6}
  function is_full(a:tbinaryTree): boolean;

  {Ejercicio 1.7}
  function max_hoja(a:tbinaryTree): integer;

  {Ejercicio 1.8}
  function sum_hoja(a:tbinaryTree): integer;

  {Ejercicio 1.9}
  function num_pares(a:tbinaryTree): integer;

  {Ejercicio 1.10}
  function num_nodos_en_nivel(a:tbinaryTree; nivel:integer): integer;





implementation

uses Math, SysUtils;


procedure initialize(var a:tbinaryTree);
begin
  a:= nil;
end;

function is_empty(a:tbinaryTree): boolean;
begin
  is_empty:= a=nil;
end;

function in_tree(a: tbinaryTree; elem : integer) : boolean;
begin
  if a = NIL then in_tree := FALSE
  else if a^.info = elem then in_tree := TRUE
  else in_tree := (in_tree(a^.hd, elem)) or (in_tree(a^.hi, elem))
end;


{ Este procedimiento de añadir se basa en la propiedad de los árboles binarios de búsqueda:
  el hijo izquierdo es menor que el padre y el hijo derecho es mayor que el padre. }
procedure add(var a :tbinaryTree; elem : integer);
begin
  if a = NIL then begin
    new(a);
    a^.info := elem;
    a^.hi := NIL;
    a^.hd := NIL;
  end
  else if a^.info < elem then add(a^.hd, elem)
  else if a^.info > elem then add(a^.hi, elem)
end;

procedure visit(x:integer);
begin
  writeln(x)
end;

procedure preorder(a: tbinaryTree);
begin
  if (a <> NIL) then begin
    visit(a^.info);
    preorder(a^.hi);
    preorder(a^.hd)
  end
end;

procedure inorder(a: tbinaryTree);
begin
  if (a <> NIL) then begin
    inorder(a^.hi);
    visit(a^.info);
    inorder(a^.hd)
  end
end;

procedure postorder(a: tbinaryTree);
begin
  if (a <> NIL) then begin
    postorder(a^.hi);
    postorder(a^.hd);
    visit(a^.info);
  end
end;


function get_hi(a:tbinaryTree): tbinaryTree;
begin
  if a = nil then get_hi := nil
  else get_hi:= a^.hi;
end;

function get_hd(a:tbinaryTree): tbinaryTree;
begin
  if a = nil then get_hd := nil
  else get_hd:= a^.hd;
end;

{ ---------------Ejercicio 1.1------------------ }
procedure inorder_inverse(a: tbinaryTree);
if a <> nil then begin
    inorder_inverse(a^.hd);
    visit(a^.info);
    inorder_inverse(a^.hi);
  end;
end;

{ ---------------Ejercicio 1.2------------------ }
function profundidad_max(a:tbinaryTree): integer;
begin
 if a = nil then
    profundidad_max := 0
  else
    profundidad_max := 1 + Max(profundidad_max(a^.hi), profundidad_max(a^.hd));
end;

{ ---------------Ejercicio 1.3------------------ }
function node_count(a:tbinaryTree): integer;
begin
if a = nil then
    node_count := 0
  else
    node_count := 1 + node_count(a^.hi) + node_count(a^.hd);
end;

{ ---------------Ejercicio 1.4------------------ }
function leafs_count(a:tbinaryTree): integer;
begin
  if a = nil then
    leafs_count := 0
  else if (a^.hi = nil) and (a^.hd = nil) then
    leafs_count := 1
  else
    leafs_count := leafs_count(a^.hi) + leafs_count(a^.hd);
end;

{ ---------------Ejercicio 1.5------------------ }
function internal_nodes_count(a:tbinaryTree): integer;
begin
    if a = nil then
    internal_nodes_count := 0
  else if (a^.hi <> nil) or (a^.hd <> nil) then
    internal_nodes_count := 1 + internal_nodes_count(a^.hi) + internal_nodes_count(a^.hd)
  else
    internal_nodes_count := 0;
end;

{ ---------------Ejercicio 1.6------------------ }
function is_full(a: tbinaryTree): boolean;
begin
  if a = nil then
    is_full := True
  else if (a^.hi = nil) and (a^.hd = nil) then
    is_full := True
  else if (a^.hi <> nil) and (a^.hd <> nil) then
    is_full := is_full(a^.hi) and is_full(a^.hd)
  else
    is_full := False;
end;

  
  { ---------------Ejercicio 1.7------------------ }
function max_hoja(a:tbinaryTree): integer;
begin
    if a = nil then
    max_hoja := -MaxInt
  else if (a^.hi = nil) and (a^.hd = nil) then
    max_hoja := a^.info
  else
    max_hoja := Max(max_hoja(a^.hi), max_hoja(a^.hd));
end;

  
  { ---------------Ejercicio 1.8------------------ }
function sum_hoja(a:tbinaryTree): integer; 
begin
  if a = nil then
    sum_hoja := 0
  else if (a^.hi = nil) and (a^.hd = nil) then
    sum_hoja := a^.info
  else
    sum_hoja := sum_hoja(a^.hi) + sum_hoja(a^.hd);
    end;
        

  { ---------------Ejercicio 1.9------------------ }
function num_pares(a:tbinaryTree): integer;
begin
    if a = nil then
    num_pares := 0
  else if a^.info mod 2 = 0 then
    num_pares := 1 + num_pares(a^.hi) + num_pares(a^.hd)
  else
    num_pares := num_pares(a^.hi) + num_pares(a^.hd);
end;

  
    { ---------------Ejercicio 1.10------------------ }
function num_nodos_en_nivel(a:tbinaryTree; nivel:integer): integer;
begin
if a = nil then
    num_nodos_en_nivel := 0
  else if nivel = 1 then
    num_nodos_en_nivel := 1
  else
    num_nodos_en_nivel := num_nodos_en_nivel(a^.hi, nivel - 1) + num_nodos_en_nivel(a^.hd, nivel - 1);
    end;


end.
