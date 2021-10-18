import { IGenerator } from '../interfaces';
import { Definition } from '../model';
import { Naming } from '../utility/naming';
import { TypedView } from './typed-view';
export interface Props {
  schemaName: string;
  sourceSchemaName: string;
  def: Definition;
}
export class TypedViews implements IGenerator {
  constructor(private props: Props) {}

  outputPath = '/typed/view.sql';
  generate(): string {
    const def = this.props.def;
    let viewSql = `USE SCHEMA ${Naming.typedSchemaName(def)};`;
    for (const modelName in def.models) {
      const model = def.models[modelName];
      viewSql += new TypedView({
        model,
        srcSchemaName: Naming.untypedSchemaName(def),
        viewSchemaName: Naming.typedSchemaName(def),
        srcObjectName: Naming.getTableName(modelName),
        viewName: Naming.getTableName(modelName),
      }).generate();
    }
    return viewSql;
  }
}
