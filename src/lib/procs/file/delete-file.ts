import { IGenerator } from '../../interfaces';
import { ExecutionType, StoredProcedureWrapper } from '../proc-wrapper';
export interface Props {
  schemaName: string;
  fileTableName: string;
}
export class DeleteFile implements IGenerator {
  constructor(private props: Props) {}
  outputPath = 'procs/delete-file.sql';
  generate(): string {
    const procedureBody = `
    var commands = [
      'DELETE FROM ${this.props.schemaName}.${this.props.fileTableName} WHERE ASSET_ID = :1;'
    ];
   commands.map( cmd => {
      var stmt = snowflake.createStatement({sqlText: cmd,binds: [ASSET_ID]});
      var result = stmt.execute();
    });
    `;
    const storedProcSql = new StoredProcedureWrapper().wrap({
      executionType: ExecutionType.ERROR_BUBBLING,
      Name: `${this.props.schemaName}.DELETE_FILE`,
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
