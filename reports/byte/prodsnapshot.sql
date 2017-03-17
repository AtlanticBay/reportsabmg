-- Production Snapshot
-- Displays all closed retail loans in a given date range
-- VARIABLE: { name: "range", display: "Date Range", type: "daterange", default: { start: "-1 year", end: "today"}}
-- OPTIONS: { database: "byte" }

use whatif; 
prodsnapshot '{{range.start }}', '{{range.end }}';

