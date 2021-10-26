import { Definition } from '../model';

export class Naming {
  static typedSchemaName(def: Definition) {
    const sanitizedDefinitionId = def.id.replace(/[^A-Za-z0-9_$]/g, () => '_').toUpperCase();
    return `TYPED_${sanitizedDefinitionId}`;
  }

  static untypedSchemaName(def: Definition) {
    const sanitizedDefinitionId = def.id.replace(/[^A-Za-z0-9_$]/g, () => '_').toUpperCase();
    return `UNTYPED_${sanitizedDefinitionId}`;
  }

  static validationSchemaName(def: Definition) {
    const sanitizedDefinitionId = def.id.replace(/[^A-Za-z0-9_$]/g, () => '_').toUpperCase();
    return `VALIDATION_${sanitizedDefinitionId}`;
  }

  static publishedSchemaName(def: Definition) {
    const sanitizedDefinitionId = def.id.replace(/[^A-Za-z0-9_$]/g, () => '_').toUpperCase();
    return `${sanitizedDefinitionId}_PUBLISHED`;
  }

  static delimitedTableName(_def: Definition): string {
    return `DELIMITED_FILE`;
  }

  static getTableName(modelName: string): string {
    return modelName.replace(/[^A-Za-z0-9_$]/g, (_letter) => '_');
  }
}
