using System;
using System.Linq;
using System.Text;
using System.Collections;

namespace LinkedList
{

   /// <summary>
   /// This class creates a simple, generic, doublely-linked, circular linked list.
   /// This class utilizes a private inner class for Node objects.
   /// 
   /// Author: Richard Easterling
   /// Date: 9/2/2011
   /// </summary>
   /// <typeparam name="T">Generic Type T</typeparam>
   public class LinkedList<T>:IEnumerable
    {
       internal Node<T> Head{internal get; private set;}
       internal Node<T> Tail{internal get; private set;}

       /// <summary>
       /// Default constructor for the linked list class.  This constructor initializes
       /// an empty LinkedList by simply initializing the head and tail Nodes.
       /// </summary>
       public LinkedList()
       {
           Head = new Node<T>();
           Tail = new Node<T>(default(T), Head, Head);
           Head.Prev = Tail;
           Head.Next = Tail;

       }

       /// <summary>
       /// This method returns true if the list is currently empty and false
       /// if the list is not empty.  A list is defined as empty if the head
       /// and tail nodes are the only nodes in the list.
       /// </summary>
       /// <returns></returns>
       public Boolean IsEmpty()
       {
           return Head.Next.Equals(Tail);
       }

       /// <summary>
       /// This simple insert method simply appends a new node
       /// containing the given data to the end of the lsit.
       /// </summary>
       /// <param name="nodeToInsert">The data to add to the list.</param>
       /// <returns>The newly created node containing the data.</returns>
       public Node<T> Insert(T dataToInsert)
       {
           
           Node<T> prev = Tail.Prev;
           Node<T> nodeToInsert = new Node<T>(dataToInsert, prev, Tail);

           prev.Next = nodeToInsert;
           Tail.Prev = nodeToInsert;

           return nodeToInsert;
       }

       /// <summary>
       /// This simple insert method adds a new node containing the given data to the 
       /// front of the list.
       /// </summary>
       /// <param name="dataToInsert">The data to insert into the list.</param>
       /// <returns></returns>
       public Node<T> InsertFirst(T dataToInsert)
       {
           Node<T> next = Head.Next;
           Node<T> nodeToInsert = new Node<T>(dataToInsert, Head, next);

           Head.Next = nodeToInsert;
           next.Prev = nodeToInsert;

           return nodeToInsert;
       }

       /// <summary>
       /// This insert method inserts the given data into a new node that is placed 
       /// immediately after the given node in the list.
       /// </summary>
       /// <param name="dataToInsert"></param>
       /// <param name="prev"></param>
       /// <returns></returns>
       public Node<T> InsertAfter (T dataToInsert, Node<T> prev)
       {
           Node<T> next = prev.Next;
           Node<T> nodeToInsert = new Node<T>(dataToInsert, prev, next);

           prev.Next = nodeToInsert;
           next.Prev = nodeToInsert;

           return nodeToInsert;
       }

       /// <summary>
       /// This method returns a LinkedListEnumerater used to iterate
       /// over instances of this LinkedList class.
       /// </summary>
       /// <returns>An iterator for this class.</returns>
       public IEnumerator GetEnumerator()
       {
           throw new NotImplementedException();
       }
    }

       /// <summary>
       /// Private inner class that creates the Nodes used by the linked list.
       /// Each node contains a reference to a generic data field as well as it's
       /// predecessor and successor in the list.
       /// </summary>
       /// <typeparam name="T">The generic type T</typeparam>
       private class Node<T>
       {

           public T Data { get; set; }            //The data stored by the Node.
           internal Node<T> Prev { get; set; }    //The previous Node in the list.
           internal Node<T> Next { get; set; }    //The next Node in the list.

           /// <summary>
           /// Default constructor for the Node class.  This constructor intitializes
           /// an empty 
           /// </summary>
           public Node()
           {
               Data = default(T);
               Prev = null;
               Next = null;
           }

           /// <summary>
           /// Constructor for the Node class.  This constructor initializes the 
           /// Nodes fields with the given values.
           /// </summary>
           /// <param name="newData">The object for the Node to store.</param>
           /// <param name="newPrev">The previous Node in the list.</param>
           /// <param name="newNext">The next Node in the list.</param>
           public Node(T newData, Node<T> newPrev, Node<T> newNext)
           {
               Data = newData;
               Prev = newPrev;
               Next = newNext;
           }

           /// <summary>
           /// A simple override of the ToString method.  This method returns a string
           /// representation of this node.
           /// </summary>
           /// <returns>A string representation of this node.</returns>
           public override string ToString()
           {
               string className = "Class: Node \r\n";
               string dataPortion = "Data: " + Data.ToString() + "\r\n\r\n";
               return className + dataPortion;
           }
       }

        /// <summary>
        /// This class creates a simple iterator for the LinkedList class.
        /// </summary>
        /// <typeparam name="T">Generic type T.</typeparam>
       class LinkedListEnumerator<T>:IEnumerator
       {
           private Node<T> currentNode;
           private LinkedList<T> list;

           /// <summary>
           /// The Current property is simply the Data property of the
           /// current Node.
           /// </summary>
           public object Current
           {
               get{return currentNode.Data;}
           }

           /// <summary>
           /// Constructor for the LinkedListEnumerator.  This 
           /// constructor initializes the list and currentNode
           /// fields using the given linked list.
           /// </summary>
           /// <param name="newList">The linked list to iterate over.</param>
           public LinkedListEnumerator(LinkedList<T> newList)
           {
               list = newList;
               currentNode = list.Head;
           }

           /// <summary>
           /// This method iterates to the next object in the list.
           /// Do to the circular nature of the list, when we reach
           /// the end of the list, this method iterates back to the
           /// first element of the list.  As a result, this method
           /// always returns true.
           /// </summary>
           /// <returns>True</returns>
           public bool MoveNext()
           {
               Node<T> nextNode = currentNode.Next;

               /**
                * If we are at the end of the list, skip over
                * the head and tail nodes and go straight to
                * the first node in the list.
                * */
               if (nextNode.Equals(list.Tail))
               {
                   currentNode = list.Head.Next;
               }
               else
               {
                   currentNode = nextNode;
               }

               return true;
           }

           /// <summary>
           /// This method iterates to the previous object in the list.
           /// Do to the circular nature of the list, when we reach
           /// the beginning of the list, this method iterates back to the
           /// last element of the list.  As a result, this method
           /// always returns true.
           /// </summary>
           /// <returns>True</returns>
           public bool MovePrevious()
           {
               Node<T> previousNode = currentNode.Prev;

               /**
                * If we are at the beginning of the list,
                * skip over the head and tail nodes and
                * go straight to the last node in the list.
                * */
               if (previousNode.Equals(list.Head))
               {
                   currentNode = list.Tail.Prev;
               }
               else
               {
                   currentNode = previousNode;
               }

               return true;
           }

           /// <summary>
           /// This method returns the currentNode to it's
           /// initial position at the head Node.
           /// </summary>
           public void Reset()
           {
               currentNode = list.Head;
           }
       }
}
