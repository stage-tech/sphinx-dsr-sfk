import { IGenerator } from '../interfaces';
import { Definition, Type } from '../model';
import { Naming } from '../utility/naming';
import {
  dateTimeValidation,
  dateValidation,
  maxSizeValidation,
  minSizeValidation,
  timeValidation,
} from '../utility/validation-view';

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

      const violations = [];
      for (const fieldIndex in model.fields) {
        const field = model.fields[fieldIndex];
        const fieldName = field.name.toUpperCase();
        if (field.required) {
          violations.push(
            `IFF(${fieldName} is not null AND ARRAY_SIZE(${fieldName}) >= 1, null, '${fieldName}_REQUIRED')`,
          );
        }
        if (field.type != Type.ARRAY) {
          violations.push(
            `IFF(${fieldName} is null OR ARRAY_SIZE(${fieldName}) <= 1, null, '${fieldName}_HAS_MULTIPLE_ITEMS')`,
          );
        }
        switch (field.type) {
          case Type.INTEGER:
            violations.push(
              `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '\\\\d+', null, '${fieldName}_NOT_INTEGER'))`,
            );
            if (field.minSize) {
              violations.push(minSizeValidation(fieldName, field.minSize));
            }
            if (field.maxSize) {
              violations.push(maxSizeValidation(fieldName, field.maxSize));
            }
            break;
          case Type.DECIMAL:
            violations.push(
              `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '\\\\d+(\\.\\\\d+)?', null, '${fieldName}_NOT_DECIMAL'))`,
            );
            if (field.minSize) {
              violations.push(minSizeValidation(fieldName, field.minSize));
            }
            if (field.maxSize) {
              violations.push(maxSizeValidation(fieldName, field.maxSize));
            }
            break;
          case Type.BOOLEAN:
            violations.push(
              `IFF(${fieldName}[0] is null, null, IFF(RLIKE(${fieldName}[0]::string, '(true|false|yes|no|y|n|0|1)', 'i'), null, '${fieldName}_NOT_BOOLEAN'))`,
            );
            break;
          case Type.DURATION:
            violations.push(
              `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '${field.allowedPattern}', null, '${fieldName}_NOT_ALLOWED_PATTERN'))`,
            );
            break;
          case Type.DATETIME:
            violations.push(dateTimeValidation(fieldName, field.allowedValues));
            break;
          case Type.DATE:
            violations.push(dateValidation(fieldName, field.allowedValues));
            break;
          case Type.TIME:
            violations.push(timeValidation(fieldName, field.allowedValues));
            break;
          case Type.ENUM:
            violations.push(
              `IFF(${fieldName}[0] is null, null, IFF(is_${field?.typeRef}(${fieldName}[0]::string), null, '${fieldName}_NOT_ALLOWED_VALUE'))`,
            );
            break;
          case Type.STRING:
            if (field.allowedPattern) {
              violations.push(
                `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '${field.allowedPattern}', null, '${fieldName}_NOT_ALLOWED_PATTERN'))`,
              );
            }
            if (field.allowedValues && field.allowedValues.length > 0) {
              violations.push(
                `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string IN ('${field.allowedValues.join(
                  ',',
                )}'), null, '${fieldName}_NOT_ALLOWED_VALUE'))`,
              );
            }
            break;
          case Type.ARRAY:
            if (field.minSize) {
              `IFF(${fieldName} is null, null, IFF(ARRAY_SIZE(${fieldName}) >= ${field.minSize}, null, '${fieldName}_LESS_THAN_MIN_SIZE'))`;
            }
            if (field.maxSize) {
              `IFF(${fieldName} is null, null, IFF(ARRAY_SIZE(${fieldName}) <= ${field.maxSize}, null, '${fieldName}_GREATER_THAN_MAX_SIZE'))`;
            }
            break;
        }
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
