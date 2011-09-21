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

            IEnumerator itr = list.GetEnumerator();
            LinkedListEnumerator<int> listItr = (LinkedListEnumerator<int>)itr;

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

        }

    }
}
