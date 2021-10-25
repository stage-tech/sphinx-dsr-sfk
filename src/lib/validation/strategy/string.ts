import { Field, Type } from '../../model';
import { IValidationStrategy } from './validation-strategy';

export class StringPatternValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.STRING) {
      if (field.allowedPattern) {
        return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '${field.allowedPattern.replace(
          /\\/g,
          '\\\\',
        )}', null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_ALLOWED_PATTERN')))`;
      }
    }

    return undefined;
  }
}

export class StringAllowedValuedValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.STRING) {
      if (field.allowedValues && field.allowedValues.length > 0) {
        return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string IN ('${field.allowedValues.join(
          ',',
        )}'), null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_ALLOWED_VALUE')))`;
      }
    }

    return undefined;
  }
}
