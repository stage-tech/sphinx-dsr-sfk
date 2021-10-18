import { IGenerator } from '../../interfaces';
import { Definition } from '../../model';
import { Naming } from '../../utility/naming';
import { ExecutionType, StoredProcedureWrapper } from '../proc-wrapper';

export class LoadPublished implements IGenerator {
  constructor(private def: Definition) {}

  outputPath = 'procs/load-published.sql';
  generate(): string {
    const def = this.def;

    const commands: string[] = [];

    Object.keys(def.models).forEach((modelName) => {
      const model = def.models[modelName];
      const destinationFields = model.fields.map((f) => f.name.toUpperCase()).join(',');
      const sourceFields = model.fields.map((f) => `src.${f.name.toUpperCase()}`).join(',');

      const cmd = ` INSERT INTO ${Naming.publishedSchemaName(def)}.${Naming.getTableName(modelName)} (
              ASSET_ID,
              LINE_INDEX,
              ${destinationFields}
        )
      SELECT
          src.ASSET_ID,
          src.LINE_INDEX,
          ${sourceFields}
          from ${Naming.typedSchemaName(def)}.${Naming.getTableName(modelName)} src 
          where src.ASSET_ID = (:1);`;
      commands.push(JSON.stringify(cmd));
    });

    const procedureBody = `
      var commands = [
        ${commands.join(',\n')}
      ];
      commands.map( cmd => {
        var stmt = snowflake.createStatement({sqlText: cmd,binds: [ASSET_ID]});
        var result = stmt.execute();
      });
`;
    const storedProcSql = new StoredProcedureWrapper().wrap({
      executionType: ExecutionType.ERROR_BUBBLING,
      Name: `${Naming.publishedSchemaName(def)}.LOAD_PUBLISHED`,
      body: procedureBody,
      returnType: 'varchar',
      parameters: [
        {
          name: 'ASSET_ID',
          type: 'varchar',
        },
      ],
    });

    return storedProcSql;
  }
}
