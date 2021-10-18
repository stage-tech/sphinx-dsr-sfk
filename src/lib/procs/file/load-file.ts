import { IGenerator } from '../../interfaces';
import { ExecutionType, StoredProcedureWrapper } from '../proc-wrapper';

export interface Parameters {
  snowFlakeStageName: string;
  fileWidth: number;
  targetTableName: string;
  targetSchemaName: string;
  fileFormat: string;
}
export class LoadFile implements IGenerator {
  constructor(private props: Parameters) {}

  outputPath = 'procs/load-file.sql';

  generate(): string {
    const props = this.props;
    const fileWidth = props.fileWidth;
    const delimitedFieldParts = [];
    for (let index = 1; index <= fileWidth; index++) {
      delimitedFieldParts.push(index);
    }
    const copyIntoSourceFields = delimitedFieldParts.map((i) => `array_construct(t.$${i})`).join(',');
    const copyIntoDestinationFields = delimitedFieldParts.map((i) => `f_${i}`).join(',');
    const loadCommands = `
    COPY INTO  ${props.targetSchemaName}.${props.targetTableName}(
      ASSET_ID,
      LINE_INDEX,
      ${copyIntoDestinationFields}
      
    ) FROM 
    (
       SELECT (:1) , METADATA$FILE_ROW_NUMBER, 
       ${copyIntoSourceFields}
        FROM @${this.props.snowFlakeStageName} t
    )
    FILE_FORMAT = '${props.fileFormat}'
    FORCE = TRUE
    `;

    const procedureBody = `
      var commands = [
        \`${loadCommands}\`
      ];
     var referenceCopyParts = REFERENCE_COPY_ID.split('/');
     var referenceCopyFileName = referenceCopyParts[referenceCopyParts.length-1];
     commands.map( cmd => {
        cmd += \` Files = ('\${referenceCopyFileName}') ;\`; // files does not accept parameter binding
        var stmt = snowflake.createStatement({sqlText: cmd,binds: [ASSET_ID]});
        var result = stmt.execute();
      });
     `;

    const storedProcSql = new StoredProcedureWrapper().wrap({
      executionType: ExecutionType.ERROR_BUBBLING,
      Name: `${props.targetSchemaName}.LOAD_FILE`,
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
