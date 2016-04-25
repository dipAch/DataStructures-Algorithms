"""
 Reverse a doubly linked list
 head could be None as well for empty list
 Node is defined as
 
 class Node(object):
 
   def __init__(self, data=None, next_node=None, prev_node = None):
       self.data = data
       self.next = next_node
       self.prev = prev_node

 return the head node of the updated list 
"""
def Reverse(head):
    if head:
        if head.next:
            prev_node = head.prev
            while head.next:
                head.prev = head.next
                head.next = prev_node
                head = head.prev
                prev_node = head.prev
            head.prev = head.next
            head.next = prev_node
            return head
        return head
