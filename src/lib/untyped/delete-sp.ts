import { IGenerator } from '../interfaces';
import { Definition } from '../model';
import { Naming } from '../utility/naming';

export class UntypedDeleteSp implements IGenerator {
  constructor(private def: Definition, private sourceDb: string) {}

  outputPath = '/untyped/untyped-delete-sp.sql';

  generate(): string {
    const def = this.def;
    const sourceDb = this.sourceDb;
    const targetSchema = Naming.untypedSchemaName(def);
    let sqlText = ``;

    sqlText += `USE ${sourceDb}.${targetSchema};\n`;

    sqlText += `create or replace procedure delete_assets(ASSET_IDS ARRAY)
  returns boolean
  language javascript
  EXECUTE AS CALLER
  as     
  $$
  
var assets = "'" + ASSET_IDS.join("','") + "'";
`;

    for (const modelName in def.models) {
      const ddlModelName = modelName.replace(/[^A-Za-z0-9_$]/g, (letter) => '_');
      const viewSql = `var ${ddlModelName} = snowflake.execute({sqlText: \`DELETE FROM ${sourceDb}.${targetSchema}.${ddlModelName} WHERE ASSET_ID in (\${assets})\`});`;
      sqlText += `${viewSql}\n`;
    }
    sqlText += `  $$
  ;
`;

    return sqlText;
  }
}
