import { Field, Type } from '../../model';
import { IValidationStrategy } from './validation-strategy';

export class RequiredFieldValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.required) {
      return `IFF(${fieldName} is not null AND ARRAY_SIZE(${fieldName}) >= 1, null, '${fieldName}_REQUIRED')`;
    }

    return undefined;
  }
}
