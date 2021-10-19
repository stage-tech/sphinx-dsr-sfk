import { IGenerator } from '../interfaces';
import { Definition, Type } from '../model';
import { Naming } from '../utility/naming';
import {
  dateTimeValidation,
  dateValidation,
  maxSizeValidation,
  minSizeValidation,
  timeValidation,
} from '../utility/validation-insert-sp';

export class ValidationInsertSp implements IGenerator {
  constructor(private def: Definition, private sourceDb: string) {}
  outputPath = 'validation/validation-insert-sp.sql';
  generate(): string {
    const def = this.def;
    const sourceDb = this.sourceDb;
    const sourceSchema = Naming.untypedSchemaName(def);
    const targetSchema = Naming.validationSchemaName(def);

    let sqlText = '';

    sqlText += `create or replace procedure insert_violations(ASSET_IDS ARRAY)
  returns boolean
  language javascript
  EXECUTE AS CALLER
  as     
  $$
    
var assets = "'" + ASSET_IDS.join("','") + "'";
var useSchema = snowflake.execute({sqlText: 'use schema ${sourceDb}.${targetSchema}'});

`;

    const validationTables: string[] = [];
    for (const modelName in def.models) {
      const ddlModelName = modelName.replace(/[^A-Za-z0-9_$]/g, (letter) => '_');
      const model = def.models[modelName];

      const violations = [];
      for (const fieldIndex in model.fields) {
        const field = model.fields[fieldIndex];
        const fieldName = field.name.toUpperCase();
        if (field.required) {
          violations.push(
            `IFF(${fieldName} is not null AND ARRAY_SIZE(${fieldName}) >= 1, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'REQUIRED'))`,
          );
        }
        if (field.type != Type.ARRAY) {
          violations.push(
            `IFF(${fieldName} is null OR ARRAY_SIZE(${fieldName}) <= 1, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'HAS_MULTIPLE_ITEMS'))`,
          );
        }
        switch (field.type) {
          case Type.INTEGER:
            violations.push(
              `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '\\\\\\\\d+', null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_INTEGER')))`,
            );
            if (field.minSize) {
              violations.push(minSizeValidation(modelName, fieldName, field.minSize));
            }
            if (field.maxSize) {
              violations.push(maxSizeValidation(modelName, fieldName, field.maxSize));
            }
            break;
          case Type.DECIMAL:
            violations.push(
              `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '\\\\\\\\d+(\\\\.\\\\\\\\d+)?', null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_DECIMAL')))`,
            );
            if (field.minSize) {
              violations.push(minSizeValidation(modelName, fieldName, field.minSize));
            }
            if (field.maxSize) {
              violations.push(maxSizeValidation(modelName, fieldName, field.maxSize));
            }
            break;
          case Type.BOOLEAN:
            violations.push(
              `IFF(${fieldName}[0] is null, null, IFF(RLIKE(${fieldName}[0]::string, '(true|false|yes|no|y|n|0|1)', 'i'), null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_BOOLEAN')))`,
            );
            break;
          case Type.DURATION:
            violations.push(
              `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '${field.allowedPattern.replace(
                /\\/g,
                '\\\\',
              )}', null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_ALLOWED_PATTERN')))`,
            );
            break;
          case Type.DATETIME:
            violations.push(dateTimeValidation(modelName, fieldName, field.allowedValues));
            break;
          case Type.DATE:
            violations.push(dateValidation(modelName, fieldName, field.allowedValues));
            break;
          case Type.TIME:
            violations.push(timeValidation(modelName, fieldName, field.allowedValues));
            break;
          case Type.ENUM:
            violations.push(
              `IFF(${fieldName}[0] is null, null, IFF(is_${field?.typeRef}(${fieldName}[0]::string), null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_ALLOWED_VALUE')))`,
            );
            break;
          case Type.STRING:
            if (field.allowedPattern) {
              violations.push(
                `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '${field.allowedPattern.replace(
                  /\\/g,
                  '\\\\',
                )}', null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_ALLOWED_PATTERN')))`,
              );
            }
            if (field.allowedValues && field.allowedValues.length > 0) {
              violations.push(
                `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string IN ('${field.allowedValues.join(
                  ',',
                )}'), null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_ALLOWED_VALUE')))`,
              );
            }
            break;
          case Type.ARRAY:
            if (field.minSize) {
              `IFF(${fieldName} is null, null, IFF(ARRAY_SIZE(${fieldName}) >= ${field.minSize}, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'LESS_THAN_MIN_SIZE')))`;
            }
            if (field.maxSize) {
              `IFF(${fieldName} is null, null, IFF(ARRAY_SIZE(${fieldName}) <= ${field.maxSize}, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'GREATER_THAN_MAX_SIZE')))`;
            }
            break;
        }
      }

      validationTables.push(`${ddlModelName}_VALIDATION`);
      const viewSql = `var insertViolations_${ddlModelName} = snowflake.execute({sqlText: \`INSERT INTO VIOLATION (
  ASSET_ID,\n  ASSET_PART,\n  VIOLATION,\n  VIOLATION_DETAIL\n) 
WITH
v as (SELECT
  ASSET_ID,\n  LINE_INDEX,\n  '${modelName}' as RECORD_TYPE,
  ARRAY_CONSTRUCT_COMPACT(
    ${violations.join(',\n    ')}
  ) as VIOLATION_DETAILS
from ${sourceDb}.${sourceSchema}.${ddlModelName}
where asset_id in (\${assets}))
select asset_id, line_index::varchar as asset_part, concat_ws('::', RECORD_TYPE, GET_PATH(value, 'FIELD')::varchar, GET_PATH(value, 'VIOLATION_TYPE')::varchar) violation, value as violation_details from v, table(flatten(input => v.VIOLATION_DETAILS));\`});`;

      sqlText += viewSql;
      sqlText += '\n';
    }

    sqlText += `  $$
  ;
`;

    return sqlText;
  }
}
