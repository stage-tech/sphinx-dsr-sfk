import { IGenerator } from '../../interfaces';
import { Definition } from '../../model';
import { Naming } from '../../utility/naming';
import { ExecutionType, StoredProcedureWrapper } from '../proc-wrapper';

export class LoadRecords implements IGenerator {
  constructor(private def: Definition, private rawDbName?: string) {}

  outputPath = 'procs/load-records.sql';
  generate(): string {
    const def = this.def;

    const commands: string[] = [];

    Object.keys(def.models).forEach((modelName) => {
      const model = def.models[modelName];
      const rawDBQualifier = this.rawDbName ? `${this.rawDbName}.` : '';
      const destinationFields = model.fields.map((f) => f.name.toUpperCase()).join(',');
      const sourceFields = def.models[modelName].fields.map((f) => `ARRAY_COMPACT(src.f_${f.position})`).join(',');
      const recordSelectionClause = model.recordSelector
        ? `AND src.f_${model.recordSelector.position}[0] IN ('${model.recordSelector.values.join(',')}') `
        : '';
      const cmd = ` INSERT INTO ${Naming.untypedSchemaName(def)}.${Naming.getTableName(modelName)} (
              ASSET_ID,
              LINE_INDEX,
              ${destinationFields}
        )
      SELECT
          src.ASSET_ID,
          src.LINE_INDEX,
          ${sourceFields}
          from ${rawDBQualifier}${Naming.untypedSchemaName(def)}.${Naming.delimitedTableName(def)} src 
          where src.ASSET_ID = (:1)  ${recordSelectionClause}  ;`;
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
      Name: `${Naming.untypedSchemaName(def)}.LOAD_RECORDS`,
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
