import { Field, Type } from '../../model';
import { IValidationStrategy } from './validation-strategy';

export class EnumValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.ENUM) {
      return `IFF(${fieldName}[0] is null, null, IFF(is_${field?.typeRef}(${fieldName}[0]::string), null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_ALLOWED_VALUE')))`;
    }

    return undefined;
  }
}
