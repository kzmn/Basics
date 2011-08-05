package kzmn.util.datastructures;

/**
 * This is a basic generic implementation of a Red Black Tree. This tree can
 * insert, remove, and find in O(log n) time.
 *
 * @author Richard Easterling
 * @author version 2011.8.3
 */
public class KZRedBlackTree <T extends Comparable<? super T>>
{
	private RBNode headNode;    // The head of the tree.

	/**
	 * Variables used while traversing the tree.
	 */
	private RBNode currentNode;
	private RBNode parent;
	private RBNode grandParent;
	private RBNode greatGrandParent;
	private RBNode leaf;

	/**
	 * Constants used for node colors.
	 */
	private static final int RED = 0;
	private static final int BLACK = 1;

	/**
	 * Constants used for comparisons.
	 */
	private static final int GREATER = 1;
	private static final int LESS = -1;
	private static final int EQUAL = 0;

	/**
	 * Default constructor for the KZRedBlackTree class.  This constructor
	 * initializes the tree with a header node with a null data field.
	 */
	public KZRedBlackTree()
	{
		leaf = new RBNode(null);
		headNode = leaf;

	}

	/**
	 * This method inserts the given element to the tree.
	 *
	 * This method traverses the tree searching for the appropriate place to
	 * insert a new node containing the given element.  This is accomplished
	 * by comparing the given element to the data field of the current node
	 * in the traversal.
	 *
	 * If the element is deemed LESS than the currentNode's data, the traversal
	 * continues down the left sub-tree.  If the given element is GREATER or
	 * EQUAL to the currentNode's data field, the traversal continues down
	 * the right sub-tree.  When the traversal encounters a null node, a new
	 * node containing the given element is added to the tree at this position.
	 *
	 * @param newElement The data to insert into the tree.
	 */
	public void insert(T newElement)
	{
		currentNode = parent = grandParent = greatGrandParent = headNode;
		RBNode nodeToInsert = new RBNode(newElement);

		/**
		 * If the headNode is null, make the node to insert the new headNode.
		 * Since this is the head node, it will remain black.
		 */
		if(headNode.data == null)
		{
			headNode = nodeToInsert;
			headNode.leftChild = leaf;
			headNode.rightChild = leaf;
			return;
		}

		int compareResult = compareData(newElement, currentNode);

		/**
		 * Continue traversing the tree until we hit a leaf node.  When a leaf
		 * node is reached, replace it with the node to insert.
		 */
		while(currentNode.data != null)
		{
			greatGrandParent = grandParent;
			grandParent = parent;
			parent = currentNode;

			/**
			 * If the result of the comparison returns LESS, we must traverse
			 * the left sub-tree.  Otherwise, if the comparison returns GREATER
			 * we must traverse the right sub-tree.
			 */
			if (compareResult <= LESS)
				currentNode = currentNode.leftChild;
			else
				currentNode = currentNode.rightChild;

			/**
			 * If the current node has two red children, we must reOrient.
			 */
			if(currentNode.leftChild.color == RED &&
			   currentNode.rightChild.color == RED)
			{
				reOrient();
			}

			compareResult = compareData(newElement, currentNode);

		}

		/**
		 * Insert the new node to the parent node.
		 */
		if(compareData(newElement, parent) <= LESS)
			parent.leftChild = nodeToInsert;
		else
			parent.rightChild = nodeToInsert;

		nodeToInsert.leftChild = leaf;
		nodeToInsert.rightChild = leaf;

		/**
		 * If the parent node is black, then the node being inserted must
		 * be red.
		 */
		if(parent.color == BLACK)
			nodeToInsert.color = RED;




	}

	/**
	 * This method makes the tree empty by setting the head node to a leaf.
	 * Garbage collection will then delete all other nodes as they are no
	 * longer accessible.
	 */
	public void makeEmpty()
	{
		headNode = leaf;
		currentNode = parent = grandParent = greatGrandParent = headNode;
	}

	/**
	 * This method returns true if the tree is empty and false if the tree is
	 * not empty.  An KZRedBlackTree is defined as empty if the headNode is also
	 * a leaf node.
	 *
	 * @return True if the tree is empty, false otherwise.
	 */
	public boolean isEmpty()
	{
		return headNode.equals(leaf);
	}

	/**
	 * This method reorients the colors of the nodes in the tree and checks
	 * to see if a rotation is necessary.
	 *
	 * @param nodeToInsert  The node that is being inserted into the tree via the
	 *                      insert method.
	 */
	private void reOrient(RBNode nodeToInsert)
	{
		currentNode.color = RED;
		currentNode.leftChild.color = BLACK;
		currentNode.rightChild.color = BLACK;

		/**
		 * If the parent node's color is red then we need to rotate.
		 */
		if(parent.color == RED)
		{
			grandParent.color = RED;

			/**
			 * Check to see if we need a rotation for the parent node by
			 * comparing the nodeToInsert to both the parent and grandparent.
			 */
			if((nodeToInsert.data.compareTo(grandParent.data) <= LESS) !=
					(nodeToInsert.data.compareTo(parent.data) <= LESS))
			{
				parent = rotate(nodeToInsert, grandParent);
			}

			currentNode = rotate(nodeToInsert, greatGrandParent);
			currentNode.color = BLACK;
		}
	}

	/**
	 * This private helper method compares the given data to the data contained
	 * within the given node.  This method is used during the insertion process
	 * to determine where a new node containing the data should be added.
	 *
	 * @param data  The data to compare.
	 * @param node  The node to compare the data to.
	 *
	 * @return      GREATER, LESS, or EQUAL dependent on the results of the
	 *              comparison.
	 */
	private int compareData(T data, RBNode node)
	{
		/**
		 * If the node is the headNode, automatically return GREATER.
		 */
		if(node == headNode)
		{
			return GREATER;
		}

		/**
		 * Otherwise return the results of the compareTo method using the node's
		 * data field.
		 */
		else
		{
			return data.compareTo(node.data);
		}
	}

	/**
	 * Private helper class that represents the nodes of this RedBlack Tree.
	 * Each node has some generic data as well as a left and a right child
	 * node.
	 */
	private class RBNode
	{
		T data;               // The data stored by the node.
		RBNode leftChild;     // The left child node.
		RBNode rightChild;    // The right child node.
		int color;            // The color of this node, either red or black.



		/**
		 * Constructor for the the RedBlackNode class.  This constructor creates
		 * a new node with the given data and with both child nodes set to null.
		 *
		 * @param newData The data to store in this node.
		 */
		RBNode(T newData)
		{
			this(newData, null, null);
		}

		/**
		 * Constructor for the RedBlackNode class.  This constructor creates a
		 * new node with the given data and child nodes.
		 *
		 * @param newData   The data to store in this node.
		 * @param newLeft   The left child of this node.
		 * @param newRight  The right child of this node.
		 */
		RBNode(T newData, RBNode newLeft, RBNode newRight)
		{
			data = newData;
			leftChild = newLeft;
			rightChild = newRight;
			color = KZRedBlackTree.BLACK;
		}

		/**
		 * Overrides the equal method in java.lang.Object
		 *
		 * This method checks if the paramaterized object is equal to this node.
		 * Two nodes are defined as equal iff:
		 *
		 * 1.)  Both objects are instances of the RBNode class.
		 *
		 * 2.)  The data of each node are determined equal to each other by
		 *      the equals method of the data object's class.
		 *
		 * 3.)  The left and right children of the nodes are considered equal.
		 *
		 *
		 * NOTE:  Since this method will traverse the entire sub-tree headed
		 * by each node in the comparison, it should not be used during regular
		 * operations of a tree.
		 *
		 * @param o     The object to test for equality to this node.
		 * @return      true or false.
		 */
		public boolean equals(Object o)
		{
			/**
			 * First, check to make sure that the given object is an instance
			 * of the RBNode class.
			 */
			if(o instanceof RBNode)
			{
				RBNode otherNode = (RBNode) o;

				/**
				 * Next, check to see if the data, leftChild, and rightChild
				 * fields of this nodes are all equal to the corresponding
				 * field in the other node.
				 *
				 * If these checks all pass, then the nodes are equal, return
				 * true.
				 */
				if( data.equals(otherNode.data)  &&
				    leftChild.equals(otherNode.leftChild) &&
				    rightChild.equals(otherNode.rightChild))
				{
					return true;
				}
			}

			/**
			 * If any of the above checks fail, then the nodes are not equal,
			 * return false.
			 */
			return false;
		}

		/**
		 * Overrides the toString() method of java.lang.Object.
		 *
		 * This simple toString() method returns a string representation of this
		 * node.
		 *
		 * @return  A string representation of the node.
		 */
		public String toString()
		{
			String stringToReturn = "(Class: RBNode, Data: " + data.toString() +
		                            ")";
		}
	}
}
