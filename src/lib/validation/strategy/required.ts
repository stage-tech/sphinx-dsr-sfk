import { Field } from '../../model';
import { IValidationStrategy } from './validation-strategy';

export class RequiredFieldValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.required) {
      return `IFF(${fieldName} is not null AND ARRAY_SIZE(${fieldName}) >= 1, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'REQUIRED'))`;
    }

    return undefined;
  }
}
