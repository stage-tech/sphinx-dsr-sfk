import { IGenerator } from '../interfaces';
import { Definition } from '../model';
import { Naming } from '../utility/naming';
import { TypedTable } from './typed-table';

export interface Props {
  schemaName: string;
  def: Definition;
}
export class TypedRecordTables implements IGenerator {
  constructor(private props: Props) {}

  outputPath = '/typed/typed-tables.sql';
  generate(): string {
    const def = this.props.def;
    let tableSql = ``;

    for (const modelName in def.models) {
      const model = def.models[modelName];
      tableSql += new TypedTable({
        model,
        schemaName: this.props.schemaName,
        tableName: Naming.getTableName(modelName),
      }).generate();
    }

    return tableSql;
  }
}
