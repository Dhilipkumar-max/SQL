-- 12. NoSQL – Document-based only (Example: Customer Order)
/*
{
  "order_id": "ORD123",
  "customer": { "name": "Dilip", "email": "dilip@kumar.com" },
  "items": [
    { "id": "P1", "name": "Keyboard", "price": 1200 },
    { "id": "P2", "name": "Monitor", "price": 15000 }
  ],
  "total": 16200
}
*/

-- 13. Firebase – Realtime Test Management System
/*
{
  "test_id": "T001",
  "questions": {
    "Q1": { "text": "What is SQL?", "ans": "Structured Query Language" }
  },
  "results": {
    "User1": { "score": 90 }
  }
}
*/

-- 14. Normalization up to 3rd Normal Form (3NF)
/*
1NF: Remove repeating groups. Each column contains atomic values.
2NF: 1NF + Remove partial dependencies (Non-key attributes must depend on the whole primary key).
3NF: 2NF + Remove transitive dependencies (Non-key attributes should not depend on other non-key attributes).

Example:
Table[StudentID, StudentName, DeptID, DeptName] (Not in 3NF)
-> Student[StudentID, StudentName, DeptID]
-> Department[DeptID, DeptName]
*/
