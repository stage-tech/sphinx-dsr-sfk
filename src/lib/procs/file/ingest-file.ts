import { IGenerator } from '../../interfaces';
import { ExecutionType, StoredProcedureWrapper } from '../proc-wrapper';

export interface Props {
  schemaName: string;
}
export class IngestFile implements IGenerator {
  constructor(private props: Props) {}

  outputPath = 'procs/ingest-file.sql';
  generate(): string {
    const procedureBody = `
      var deleteStatement = snowflake.createStatement({sqlText: \`CALL  ${this.props.schemaName}.DELETE_FILE(:1); \`,binds: [ASSET_ID]});
      deleteStatement.execute();
      var loadStatement = snowflake.createStatement({sqlText: \`CALL  ${this.props.schemaName}.LOAD_FILE(:1 , :2); \`,binds: [ASSET_ID , REFERENCE_COPY_ID]});
      loadStatement.execute();
   
 `;

    const storedProcSql = new StoredProcedureWrapper().wrap({
      executionType: ExecutionType.ERROR_BUBBLING,
      Name: `${this.props.schemaName}.INGEST_FILE`,
      body: procedureBody,
      returnType: 'varchar',
      parameters: [
        {
          name: 'ASSET_ID',
          type: 'varchar',
        },
        {
          name: 'REFERENCE_COPY_ID',
          type: 'varchar',
        },
      ],
    });
    return storedProcSql;
  }
}
