import { IGenerator } from '../interfaces';
import { Definition } from '../model';
import { Naming } from '../utility/naming';
import { UntypedTable } from './untyped-table';

export interface Props {
  schemaName: string;
  def: Definition;
}
export class UntypedRecordTables implements IGenerator {
  constructor(private props: Props) {}

  outputPath = '/untyped/untyped-tables.sql';
  generate(): string {
    const def = this.props.def;
    let tableSql = ``;

    for (const modelName in def.models) {
      const model = def.models[modelName];
      tableSql += new UntypedTable({
        model,
        schemaName: this.props.schemaName,
        tableName: Naming.getTableName(modelName),
      }).generate();
    }

    return tableSql;
  }
}
