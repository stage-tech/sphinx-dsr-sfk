import { IGenerator } from '../../interfaces';
import { Definition } from '../../model';
import { Naming } from '../../utility/naming';
import { ExecutionType, StoredProcedureWrapper } from '../proc-wrapper';

export class DeleteRecords implements IGenerator {
  constructor(private def: Definition) {}
  outputPath = 'procs/delete-records.sql';
  generate(): string {
    const def = this.def;

    const deleteCommands: string[] = Object.keys(def.models).map((modelName) => {
      return `DELETE FROM ${Naming.untypedSchemaName(def)}.${Naming.getTableName(modelName)} WHERE ASSET_ID = :1; `;
    });

    const procedureBody = `
    var commands = ${JSON.stringify(deleteCommands)}
    commands.map( cmd => {
      var stmt = snowflake.createStatement({sqlText: cmd,binds: [ASSET_ID]});
      var result = stmt.execute();
    });
 
 `;

    const storedProcSql = new StoredProcedureWrapper().wrap({
      executionType: ExecutionType.ERROR_BUBBLING,
      Name: `${Naming.untypedSchemaName(def)}.DELETE_RECORDS`,
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
