import { IGenerator } from '../interfaces';
import { Definition } from '../model';
import { Naming } from '../utility/naming';
import { ValidationStrategies } from './strategy/validation-strategy';

export class ValidationView implements IGenerator {
  constructor(private def: Definition, private sourceDb: string) {}
  outputPath = 'validation/validation-view.sql';
  generate(): string {
    const def = this.def;
    const sourceDb = this.sourceDb;
    const untypedSchemaName = Naming.untypedSchemaName(def);
    const validationSchemaName = Naming.validationSchemaName(def);

    let sqlText = '';

    sqlText += `use schema ${validationSchemaName};\n`;

    for (const enumName in def.enums) {
      const enumSql = `create or replace function is_${enumName}(value varchar)
      returns boolean
      as
      $$
        value in (
          '${def.enums[enumName].values.join("','")}'
        )
      $$
      ;`;
      sqlText += enumSql;
      sqlText += '\n';
    }

    const validationTables: string[] = [];
    for (const modelName in def.models) {
      const ddlModelName = modelName.replace(/[^A-Za-z0-9_$]/g, (letter) => '_');
      const model = def.models[modelName];

      const violations: any = [];
      for (const fieldIndex in model.fields) {
        const field = model.fields[fieldIndex];
        const validationStrategies = ValidationStrategies;

        validationStrategies.forEach((strategy) => {
          const validationRule = strategy.getSqlValidationRule(field);
          if (validationRule) {
            violations.push(validationRule);
          }
        });
      }

      validationTables.push(`${ddlModelName}_VALIDATION`);
      const viewSql = `CREATE OR REPLACE VIEW ${ddlModelName}_VALIDATION (
      ASSET_ID,\n  LINE_INDEX,\n  RECORD_TYPE,\n  VIOLATIONS\n) AS SELECT
      ASSET_ID,\n  LINE_INDEX,\n  '${modelName}',
      ARRAY_CONSTRUCT_COMPACT(
        ${violations.join(',\n    ')}
      )
    from ${sourceDb}.${untypedSchemaName}.${ddlModelName};`;

      sqlText += viewSql;
      sqlText += '\n';
    }

    const validationSelects = validationTables.map(
      (t) => `SELECT ASSET_ID, LINE_INDEX, RECORD_TYPE, VIOLATIONS FROM ${t} WHERE ARRAY_SIZE(VIOLATIONS) > 0`,
    );
    const validationSql = `CREATE OR REPLACE VIEW RECORD_VALIDATION (
      ASSET_ID,\n  LINE_INDEX,\n  RECORD_TYPE,\n  VIOLATIONS\n) AS
    ${validationSelects.join('\nUNION\n')};`;

    sqlText += validationSql;
    sqlText += '\n';

    return sqlText;
  }
}
