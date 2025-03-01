# migrationdbtools

Proc Call
This version includes: 
✅ thread_id parameter – allows different threads to run in parallel
✅ Customizable batch_size – controls how much data is copied per run
✅ Thread-safe data fetching – prevents overlap between running threads

CALL CloneTableBatchedParallel('admin_secrets', 'admin_secrets_clone', 100000, 1, 4);
CALL CloneTableBatchedParallel('admin_secrets', 'admin_secrets_clone', 100000, 2, 4);
CALL CloneTableBatchedParallel('admin_secrets', 'admin_secrets_clone', 100000, 3, 4);
CALL CloneTableBatchedParallel('admin_secrets', 'admin_secrets_clone', 100000, 4, 4);
✅ This runs 4 parallel threads.
✅ Each thread processes non-overlapping batches for efficiency.
✅ Adjust total_threads as needed (e.g., 4, 8, or more).
