using System;
using System.Text;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LinkedList;
using System.Collections;

namespace TestProject1
{
    /// <summary>
    /// This class tests the functionality of LinkedList.cs.
    /// </summary>
    [TestClass]
    public class LinkedListTest
    {

        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        [TestMethod]
        public void TestInsert()
        {
            LinkedList<int> list = new LinkedList<int>();
            Assert.IsTrue(list.IsEmpty());
            list.Insert(1);
            Assert.IsFalse(list.IsEmpty());
            // Test Insert() method.
            list.Insert(2);
            list.Insert(3);
            list.Insert(4);
            list.Insert(5);

            // Test InsertFirst() method.
            list.InsertFirst(6);
            list.InsertFirst(7);
            list.InsertFirst(8);
            list.InsertFirst(9);
            list.InsertFirst(10);

            // Confirm that all nodes were added to the list and added in the correct order.
            Assert.IsTrue("10 9 8 7 6 1 2 3 4 5".Equals(list.ToString()));
        }

        [TestMethod]
        public void TestEnumerator()
        {
            LinkedList<int> list = new LinkedList<int>();
            list.Insert(1);
            list.Insert(2);
            list.Insert(3);
            list.Insert(4);
            list.Insert(5);

            IEnumerator temp = list.GetEnumerator();
            LinkedListEnumerator<int> itr = (LinkedListEnumerator<int>)temp;

            Assert.IsNull(itr.Current);
            Assert.IsTrue(itr.currentNode.Equals(list.Head));

            // Perform a full forward iteration, circling back to the first
            // element in the list.
            itr.MoveNext();
            Assert.IsTrue(itr.Current.Equals(1));
            itr.MoveNext();
            Assert.IsTrue(itr.Current.Equals(2));
            itr.MoveNext();
            Assert.IsTrue(itr.Current.Equals(3));
            itr.MoveNext();
            Assert.IsTrue(itr.Current.Equals(4));
            itr.MoveNext();
            Assert.IsTrue(itr.Current.Equals(5));
            itr.MoveNext();
            Assert.IsTrue(itr.Current.Equals(1));

            // Now a backwards iteration.
            itr.MovePrevious();
            Assert.IsTrue(itr.Current.Equals(5));
            itr.MovePrevious();
            Assert.IsTrue(itr.Current.Equals(4));
            itr.MovePrevious();
            Assert.IsTrue(itr.Current.Equals(3));
            itr.MovePrevious();
            Assert.IsTrue(itr.Current.Equals(2));
            itr.MovePrevious();
            Assert.IsTrue(itr.Current.Equals(1));

            // TestinsertAfterCurrent
            itr.InsertAfterCurrent(7);
            itr.MoveNext();
            Assert.IsTrue(itr.Current.Equals(7));
            itr.MoveNext();
            Assert.IsTrue(itr.Current.Equals(2));
            itr.MovePrevious();
            Assert.IsTrue(itr.Current.Equals(7));
            itr.MovePrevious();
            Assert.IsTrue(itr.Current.Equals(1));

            // Test RemoveCurrent.
            itr.RemoveCurrent();
            Assert.IsTrue(itr.Current.Equals(5));
            itr.MoveNext();
            Assert.IsTrue(itr.Current.Equals(7));

            // Test Reset method.
            itr.Reset();
            Assert.IsTrue(itr.currentNode.Equals(list.Head));

        }

        [TestMethod]
        public void TestFind()
        {
            LinkedList<int> list = new LinkedList<int>();
            list.Insert(1);
            list.Insert(2);
            list.Insert(3);
            list.Insert(4);
            list.Insert(5);
            list.Insert(4);

            // Test that Contains returns true for
            // all elements in the list.
            Assert.IsTrue(list.Contains(1));
            Assert.IsTrue(list.Contains(2));
            Assert.IsTrue(list.Contains(3));
            Assert.IsTrue(list.Contains(4));
            Assert.IsTrue(list.Contains(5));

            // Test that Contains() returns false for 
            // an element not in the list.
            Assert.IsFalse(list.Contains(7));

            // Test that FindItem returns the first
            // matching node in the list.
            // The no matching nodes condition for
            // this method is tested by the contains
            // tests above.
            Node<int> node4 = list.FindItem(4);
            Assert.IsTrue(node4.Data.Equals(4));
            Assert.IsTrue(node4.Next.Data.Equals(5));
            Assert.IsTrue(node4.Prev.Data.Equals(3));
        }

        [TestMethod]
        public void TestRemove()
        {
            LinkedList<int> list = new LinkedList<int>();
            list.Insert(1);
            list.Insert(2);
            list.Insert(3);
            list.Insert(4);
            list.Insert(5);
            list.Insert(4);

            list.Remove(0);
            Assert.IsTrue("1 2 3 4 5 4".Equals(list.ToString()));

            list.Remove(2);
            Assert.IsTrue("1 3 4 5 4".Equals(list.ToString()));

            int noInstances = list.RemoveAllInstancesOf(2);
            int oneInstance = list.RemoveAllInstancesOf(3);
            int twoInstances = list.RemoveAllInstancesOf(4);

            Assert.IsTrue(noInstances.Equals(0));
            Assert.IsTrue(oneInstance.Equals(1));
            Assert.IsTrue(twoInstances.Equals(2));

            Assert.IsTrue("1 5".Equals(list.ToString()));

        }
    }
}
