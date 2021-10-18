import { IGenerator } from '../interfaces';
import { Model } from '../model';
import { SFTypeMapper } from '../type-converters/type-mapper';

export interface Props {
  model: Model;
  schemaName: string;
  tableName: string;
}

export class TypedTable implements IGenerator {
  constructor(private props: Props) {}

  outputPath = `/typed/typed-tables-${this.props.tableName}.sql`;
  generate(): string {
    const props = this.props;

    if (!props.model.fields) {
      return '';
    }

    const tableColumns = props.model.fields
      .map((f) => {
        const value = SFTypeMapper.getSfDataType(f);
        return `${f.name.toUpperCase()} ${value}`;
      })
      .join(',\n  ');

    const tableSql = `
      CREATE OR REPLACE TABLE ${props.schemaName}.${props.tableName} (
        ASSET_ID  VARCHAR,
        LINE_INDEX VARCHAR,
        ${tableColumns}
      );`;

    return tableSql;
  }
}
