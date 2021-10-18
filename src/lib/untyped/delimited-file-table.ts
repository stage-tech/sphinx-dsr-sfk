import { IGenerator } from '../interfaces';

export interface Props {
  fileWidth: number;
  schemaName: string;
  tableName: string;
}
export class FileTable implements IGenerator {
  constructor(private props: Props) {}

  outputPath = '/untyped/delimited-table.sql';
  generatesDDL = true;
  generate(): string {
    const fileWidth = this.props.fileWidth;
    const delimitedFieldPart = [];
    for (let index = 1; index <= fileWidth; index++) {
      delimitedFieldPart.push(`f_${index} ARRAY`);
    }

    const viewSql = `
CREATE OR REPLACE TABLE ${this.props.schemaName}.${this.props.tableName} (
  ASSET_ID  VARCHAR,
  LINE_INDEX VARCHAR,
  ${delimitedFieldPart.join(',\n  ')}
);`;

    return viewSql;
  }
}
