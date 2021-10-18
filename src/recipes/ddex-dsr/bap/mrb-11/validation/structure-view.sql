use schema %ENV%_DDEX_DSR.VALIDATION_BAP_MRB_11;

CREATE OR REPLACE VIEW STRUCTURE_VALIDATION (
  ASSET_ID,
  VIOLATIONS
) AS
with
block_boundary_pre1 as (
  select
    asset_id,
    block_id,
    start_index > lag(end_index, 1, 0) over (partition by asset_id order by start_index, end_index) as after_previous,
    end_index < lead(start_index, 1, end_index+1) over (partition by asset_id order by start_index, end_index) as before_next
  from block_boundary
),
block_boundary_violation as (
  select
    ASSET_ID,
    'BLOCK_BOUNDARY_OVERLAP' violation
  from block_boundary_pre1
  where after_previous = false or before_next = false
  group by ASSET_ID
  having count(1) > 0
),
grouped_structure_pre1 as (
  select asset_id, block_id, array_agg(record_type) within group (order by line_index asc) block_structure
  from record_structure
  group by asset_id, block_id
),
block_structure_pre1 as (
  select asset_id, block_id, block_structure,
  array_to_string(block_structure, '') regexp '((RE01)((AS01(MW01)*)|AS02.01)+(RE02)*|((AS01(MW01)*)|AS02.01))((SU01|SU02))+' pass
  from grouped_structure_pre1
  where block_id is not null
),
block_structure_violation as (
  select
    ASSET_ID,
    'INVALID_BLOCK_STRUCTURE' violation
  from block_structure_pre1
  where pass = false
  group by ASSET_ID
  having count(1) > 0
),
header_summary_structure_pre1 as (
  select asset_id, block_id, block_structure,
  array_to_string(block_structure, '') regexp 'HEAD(SY01|SY02.01|SY04|SY05)+FOOT' pass
  from block_structure_pre1
  where block_id is null
),
header_summary_structure_violation as (
  select
    ASSET_ID,
    'INVALID_HEADER_SUMMARY_STRUCTURE' violation
  from header_summary_structure_pre1
  where pass = false
  group by ASSET_ID
  having count(1) > 0
),
block_record_count_pre1 as (
  select asset_id, block_id, substr(record_type, 1, 2) base_record_type, count(1) record_count
  from record_structure
  where block_id is not null
  group by asset_id, block_id, substr(record_type, 1, 2)
),
block_record_count_pre2 as (
  select asset_id, block_id, base_record_type,
  case
    when base_record_type = 'RE' then record_count in (0,1)
    when base_record_type = 'AS' then record_count >= 1
    when base_record_type = 'SU' then record_count >= 1
    else false
  end pass
  from block_record_count_pre1
),
block_record_count_violation as (
  select
    ASSET_ID,
    'INVALID_BLOCK_RECORD_COUNT' violation
  from block_record_count_pre2
  where pass = false
  group by ASSET_ID
  having count(1) > 0
),
mergeViolations as (
  select asset_id, violation from block_boundary_violation
  union all
  select asset_id, violation from block_structure_violation
  union all
  select asset_id, violation from header_summary_structure_violation
  union all
  select asset_id, violation from block_record_count_violation
)
select asset_id, array_agg(violation) within group (order by violation asc) violations
from mergeViolations
group by asset_id;
