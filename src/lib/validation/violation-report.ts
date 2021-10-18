import { IGenerator } from '../interfaces';
import { Definition } from '../model';
import { Naming } from '../utility/naming';
import { ValidationStrategies } from './strategy/validation-strategy';
export class ViolationsReport implements IGenerator {
  constructor(private def: Definition) {}

  outputPath = 'validation/views.sql';

  generate(): string {
    const def = this.def;
    let sqlBuffer = '';
    const validationSchemaName = Naming.validationSchemaName(def);
    for (const modelName in def.models) {
      const model = def.models[modelName];

      const validationRules: string[] = [];
      model.fields.forEach((field) => {
        const sqlRules = ValidationStrategies.map((s) => {
          return s.getSqlValidationRule(field, def);
        }).filter((sqlRule) => sqlRule != undefined) as string[];
        validationRules.push(...sqlRules);
      });

      const validatedTableName = Naming.getTableName(modelName);
      const viewSql = `
      CREATE OR REPLACE VIEW ${validationSchemaName}.${validatedTableName} (
      ASSET_ID,\n  LINE_INDEX,\n  RECORD_TYPE,\n  VIOLATIONS\n) AS SELECT
      ASSET_ID,\n  LINE_INDEX,\n  '${modelName}',
      ARRAY_CONSTRUCT_COMPACT(
        ${validationRules.join(',\n\t')}
      )
     from ${Naming.untypedSchemaName(def)}.${validatedTableName};`;

      sqlBuffer += '\n' + viewSql;
    }

    return sqlBuffer;
  }
}
