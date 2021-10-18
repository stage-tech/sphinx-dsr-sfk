import { IGenerator } from '../interfaces';
import { Model } from '../model';

export interface Props {
  model: Model;
  schemaName: string;
  tableName: string;
}

export class UntypedTable implements IGenerator {
  constructor(private props: Props) {}

  outputPath = `/untyped/untyped-tables-${this.props.tableName}.sql`;
  generate(): string {
    const props = this.props;

    if (!props.model.fields) {
      return '';
    }
    const tableColumns = props.model.fields.map((f) => `${f.name.toUpperCase()} ARRAY`).join(',\n  ');
    const tableSql = `
CREATE OR REPLACE TABLE ${props.schemaName}.${props.tableName} (
  ASSET_ID  VARCHAR,
  LINE_INDEX VARCHAR,
  ${tableColumns}
);`;

    return tableSql;
  }
}
