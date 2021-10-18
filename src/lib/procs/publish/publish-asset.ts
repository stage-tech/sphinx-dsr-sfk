import { IGenerator } from '../../interfaces';
import { Definition } from '../../model';
import { Naming } from '../../utility/naming';
import { ExecutionType, StoredProcedureWrapper } from '../proc-wrapper';

export class PublishAsset implements IGenerator {
  constructor(private def: Definition) {}

  outputPath = 'procs/publish-asset.sql';
  generate(): string {
    const def = this.def;
    const ingestCommands: string[] = [];
    ingestCommands.push(`CALL  ${Naming.publishedSchemaName(def)}.DELETE_PUBLISHED(:1); `);
    ingestCommands.push(`CALL  ${Naming.publishedSchemaName(def)}.LOAD_PUBLISHED(:1); `);

    const procedureBody = `
    var commands = ${JSON.stringify(ingestCommands)};
    commands.map( cmd => {
      var stmt = snowflake.createStatement({sqlText: cmd,binds: [ASSET_ID]});
      var result = stmt.execute();
      result.next();
    });
   `;

    const storedProcSql = new StoredProcedureWrapper().wrap({
      executionType: ExecutionType.ERROR_BUBBLING,
      Name: `${Naming.publishedSchemaName(def)}.PUBLISH_ASSET`,
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
