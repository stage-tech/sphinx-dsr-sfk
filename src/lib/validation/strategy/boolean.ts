import { Field, Type } from '../../model';
import { IValidationStrategy } from './validation-strategy';

export class BooleanValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.BOOLEAN) {
      return `IFF(${fieldName}[0] is null, null, IFF(RLIKE(${fieldName}[0]::string, '(true|false|yes|no|y|n|0|1)', 'i'), null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_BOOLEAN')))`;
    }

    return undefined;
  }
}
