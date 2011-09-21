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

        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // Use TestInitialize to run code before running each test 
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // Use TestCleanup to run code after each test has run
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

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
            Assert.IsTrue("10 9 8 7 6 1 2 3 4 5".Equals(list.ToString())
        }
    }
}
