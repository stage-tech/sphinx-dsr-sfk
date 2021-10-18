import { IGenerator } from '../interfaces';
import { Model } from '../model';
import { TypeConverter } from '../type-converters';

export interface Props {
  model: Model;
  viewSchemaName: string;
  viewName: string;
  srcObjectName: string;
  srcSchemaName: string;
}

export class TypedView implements IGenerator {
  constructor(private props: Props) {}

  outputPath = `/typed/view-${this.props.viewName}.sql`;
  generate(): string {
    const props = this.props;

    if (!props.model.fields) {
      return '';
    }
    const model = this.props.model;

    const fields = model.fields.map((field) => field.name.toUpperCase());
    const values = model.fields.map((field) => TypeConverter.getConversionExpression(field));

    const viewSql = `
CREATE OR REPLACE VIEW ${this.props.viewSchemaName}.${this.props.viewName} (
  ASSET_ID,\n  LINE_INDEX,\n  ${fields.join(',\n  ')}
) AS SELECT
  ASSET_ID,\n  LINE_INDEX,
  ${values.join(',\n  ')}
from ${props.srcSchemaName}.${props.srcObjectName};`;

    return viewSql;
  }
}
