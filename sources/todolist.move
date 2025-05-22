/// Module: todolistcontract
module todolistcontract::toDolist;


// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

// === Imports ===
use std::string::String;


// === Errors ===

// === Constants ===
const E_ITEM_NOT_FOUND: u64 = 0;

// === Structs ===

public struct ToDoItem has store, drop {
  title: String,
  completed: bool,

}

public struct ToDoList has key,store{
  id: UID,
  items: vector<ToDoItem>,
}



// === Public Functions ===

public fun new_list(ctx: &mut TxContext) {
  let list = ToDoList {
    id: object::new(ctx),
    items: vector[],
  };
  transfer::public_share_object(list);
}

public fun add_item(list: &mut ToDoList,title:String){
list.items.push_back(ToDoItem{
  title:title,
  completed:false,
})
}

public fun update_status(list: &mut ToDoList, title:String){
  let mut index = 0;
  let mut found = false;
  while (index < list.items.length()){
    if(list.items[index].title == title){
      list.items[index].completed = true;
      found = true;
      break
    }else{
      index = index + 1;
    }
  };
  assert!(found, E_ITEM_NOT_FOUND);
}

public fun remove_item(list: &mut ToDoList, title:String){
  let mut index = 0;
  let mut found = false;
  while (index < list.items.length()){
    if(list.items[index].title == title){
      list.items.remove(index); 
      found = true;
      break;
    }else{
      index = index + 1;
    }
  };
   assert!(found, E_ITEM_NOT_FOUND);
} 

public fun delete_list(list: ToDoList){
let ToDoList {id, items:_} = list;
id.delete();
}



// === View Functions ===

// === Admin Functions ===

// === Package Functions ===

// === Private Functions ===

// === Test Functions ===


