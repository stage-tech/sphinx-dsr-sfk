import { IGenerator } from '../interfaces';
import { Definition } from '../model';
import { Naming } from '../utility/naming';
import { ValidationStrategies } from './strategy/validation-strategy';

export class ValidationInsertSp implements IGenerator {
  constructor(private def: Definition, private sourceDb: string) {}
  outputPath = 'validation/validation-insert-sp.sql';
  generate(): string {
    const def = this.def;
    const sourceDb = this.sourceDb;
    const sourceSchema = Naming.untypedSchemaName(def);
    const targetSchema = Naming.validationSchemaName(def);

    let sqlText = '';

    sqlText += `create or replace procedure insert_violations(VIOLATION_TABLE VARCHAR, ASSET_IDS ARRAY)
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

      const violations: any = [];
      for (const fieldIndex in model.fields) {
        const field = model.fields[fieldIndex];

        const validationStrategies = ValidationStrategies;

        validationStrategies.forEach((strategy) => {
          const validationRule = strategy.getSqlValidationRule(field, modelName);
          if (validationRule) {
            violations.push(validationRule);
          }
        });
      }

      validationTables.push(`${ddlModelName}_VALIDATION`);
      const viewSql = `var insertViolations_${ddlModelName} = snowflake.execute({sqlText: \`INSERT INTO \${VIOLATION_TABLE} (
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
