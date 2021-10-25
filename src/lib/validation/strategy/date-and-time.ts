import { Field, Type } from '../../model';
import { IValidationStrategy } from './validation-strategy';

export class DateTimeValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.DATETIME) {
      multipleValidation(fieldName, modelName, field.allowedValues, 'TRY_TO_TIMESTAMP', 'DATETIME');
    }
    return undefined;
  }
}

export class DateValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.DATE) {
      return multipleValidation(fieldName, modelName, field.allowedValues, 'TRY_TO_DATE', 'DATE');
    }
    return undefined;
  }
}

export class TimeValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.TIME) {
      return multipleValidation(fieldName, modelName, field.allowedValues, 'TRY_TO_TIME', 'TIME');
    }
    return undefined;
  }
}

export class DurationValidation implements IValidationStrategy {
  getSqlValidationRule(field: Field, modelName: string): string | undefined {
    const fieldName = field.name.toUpperCase();
    if (field.type == Type.DURATION) {
      return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::string REGEXP '${field.allowedPattern.replace(
        /\\/g,
        '\\\\',
      )}', null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_ALLOWED_PATTERN')))`;
    }
    return undefined;
  }
}

export function multipleValidation(
  fieldName: string,
  modelName: string,
  allowedValues: string[],
  func: string,
  type: string,
): string {
  let validationString = `IFF(${fieldName}[0] is null, null, `;
  for (const index in allowedValues) {
    const allowedValue = allowedValues[index];
    validationString += `\n      IFF(${func}(${fieldName}[0]::string, '${allowedValue}') is not null, null, `;
  }
  validationString += `OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_${type}'))`;
  allowedValues.forEach((f) => (validationString += ')'));
  return validationString;
}
