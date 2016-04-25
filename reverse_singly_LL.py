"""
 Reverse a linked list
 head could be None as well for empty list
 Node is defined as
 
 class Node(object):
 
   def __init__(self, data=None, next_node=None):
       self.data = data
       self.next = next_node

 return back the head of the linked list in the below method.
"""

def reverse_helper(head, prev_node):
    if head.next:
        new_head = reverse_helper(head.next, head)
    else:
        new_head = head
    head.next = prev_node
    return new_head

def Reverse(head):
    if head:
        if head.next:
            new_head = reverse_helper(head.next, head)
            head.next = None
            return new_head
        return head
