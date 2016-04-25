"""
 Insert Node at the end of a linked list
 head input could be None as well for empty list
 Node is defined as
 
 class Node(object):
 
   def __init__(self, data=None, next_node=None):
       self.data = data
       self.next = next_node

 return back the head of the linked list in the below method. 
"""
def InsertNth(head, data, position):
    if head == None:
        return Node(data)
    else:
        if position == 0:
            return Node(data, head)
        else:
            orig_head = head
            prev = None
            for i in range(position):
                prev = head
                head = head.next
            new_node = Node(data, head)
            prev.next = new_node
            return orig_head
