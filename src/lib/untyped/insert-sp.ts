import { IGenerator } from '../interfaces';
import { Definition } from '../model';
import { Naming } from '../utility/naming';

export class UntypedInsertSp implements IGenerator {
  constructor(private def: Definition, private sourceDb: string) {}

  outputPath = '/untyped/untyped-insert-sp.sql';

  generate(): string {
    const def = this.def;
    const targetSchema = Naming.untypedSchemaName(def);
    const sourceDb = this.sourceDb;
    let sqlText = ``;

    sqlText += `create or replace procedure insert_assets(STAGING_TABLE VARCHAR, ASSET_IDS ARRAY)
    returns boolean
    language javascript
    EXECUTE AS CALLER
    as
    $$

    var assets = "'" + ASSET_IDS.join("','") + "'";

    `;

    for (const modelName in def.models) {
      const ddlModelName = modelName.replace(/[^A-Za-z0-9_$]/g, (letter) => '_');
      const model = def.models[modelName];

      const fields: string[] = [];
      const fieldsLookup: string[] = [];
      let lastPosition = 0;
      for (const fieldIndex in model.fields) {
        const field = model.fields[fieldIndex];
        fields.push(field.name.toUpperCase());
        fieldsLookup.push(`FIELDS[${field.position - 1}]::array`);
        lastPosition = lastPosition < field.position ? field.position : lastPosition;
      }

      const viewSql = `var ${ddlModelName} = snowflake.execute({sqlText: \`INSERT INTO ${sourceDb}.${targetSchema}.${ddlModelName} (
    ASSET_ID,\n  LINE_INDEX,\n  ${fields.join(',\n  ')})\nSELECT\n  ASSET_ID,\n  LINE_INDEX,
    ${fieldsLookup.join(',\n  ')}
    from \${STAGING_TABLE} DF
    where FIELDS[0][0] = '${modelName}'
    and ASSET_ID in (\${assets})\`});`;
      sqlText += viewSql;
      sqlText += '\n';
    }
    sqlText += `  $$
    ;
    `;

    return sqlText;
  }
}
